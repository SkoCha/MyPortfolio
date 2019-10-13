package net.mypofol.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;
import net.mypofol.mapper.UploadMapper;
import net.mypofol.model.UploadVO;

@Component
@Log4j
public class UploadFileCheck {

	@Autowired
	private UploadMapper uploadmapper;
	
	// 매일 오전 2시에 스케쥴 실행
	@Scheduled(cron="0 0 2 * * *")
	public void fileCheck() throws Exception{
		
		log.warn("###########File Checking Scheduler Start Run###########");
		log.warn(new Date());
		
		// t_upload 테이블에서 전날 파일들의 튜플들을 불러와서 리스트에 저장
		List<UploadVO> fileList = uploadmapper.getOldFiles();
		
		List<Path> fileListPaths = fileList.stream()
				.map(upload -> 
				Paths.get("C:\\upload", upload.getUploadPath(), upload.getUuid() + "_" + upload.getFileName()))
				.collect(Collectors.toList());
		
		fileList.stream().filter(upload ->	upload.isFileType() == true)
						.map(upload -> Paths.get("C:\\upload", upload.getUploadPath(), "s_" + upload.getUuid() + "_" + upload.getFileName()))
						.forEach(result -> fileListPaths.add(result));
		log.warn("########################################################");
		
		fileListPaths.forEach(path -> log.warn(path));
		
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
}
