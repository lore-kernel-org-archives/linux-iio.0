Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6733DFC8F
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861909; cv=none; b=FaPp11Trt0WmH0fF/V3SpIUe9kwmRIZlyKkAIRsNsHc/UtETYF0vKPgEm7sBWCqBfCFCsT7uwBGfJrfus84l+/6hhMCZVv5c2zvGmo+9ZXuzhxfQ7ThXVOnff87PDlhOU6PSyqD2amOs09SXc4Ni39BRGDL5c6K6p8KHkk6Hnn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861909; c=relaxed/simple;
	bh=abwAGso4IiQU00hdcSS+SAtlT/zYejjti4A59eyq1UI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKCTy84OMQkxCm+BTZncOLKlpZTcbAbbWAqdAHxv1wT2Sv9wTLj5ht5D1hVTViMyTpE/wLIKtua33euIxtc496E/Redoyk0Nws/89UHUXttfxy308V0rBHUIRTP2mJf7lvZ1jWDTGUYOQ6yN5kHs86YbFSnTS8TnjnYyseLb/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9ws12bH; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9ws12bH"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40946982a78so1901654fac.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 05:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776861907; x=1777466707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aO/SkChTK7D2rhqoVdEAZ0StdNdQJ4w+MbMIUQvwbhs=;
        b=U9ws12bHwzB/fgplgspcGgW2hEIrgLMvbJvNyq9j1xWDokGlx1xUugxRXWcrZ6UxAh
         1K8l9AV1EA6K/CNq2kRg9B614Uyk10uHnrQwEdaeQHSFJ6wQ2tmYMzKlBhYwtMFyGKbx
         XGhRxX2ZjowsHMQXwN2OSTxozrsNNaDlmp4jAZLJeiHPBwSb0YTorx0hOwhDjFeBEG6H
         MuFNGWITxFyx6SUgb6MHIQ/xjXLc3xAR1YRLnNyemczp0XiZTvQd92z4LM2tt4OSqD+6
         j/dvbzoKGSwoMm44h2phKZRtu/RWU2jLJT4516o4W+FnMaPi8atlzE3YxnVYc7D9Qq0b
         trLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776861907; x=1777466707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO/SkChTK7D2rhqoVdEAZ0StdNdQJ4w+MbMIUQvwbhs=;
        b=g8TQK9IC2o4DE0Urn3Hmy5TWsEAWIQ5U3aGBQh0f5GTkxS5oCA0zgAqbhmO7QSORat
         EfUwnMdfMOrxblTsmmVk6sit3wkgp/Am+jY44FEcNLl82AWoMPHWji4ztshd8Vifnah3
         sWMm2ed1r9ftwJ8vjQe18qj/3inIT01zEKj2gWZe9LEGEgRUKnDN92LODt7o9cTEqP9z
         WVqF8PcUi1FZQ4z84Ioc/yr+9ihfKgrm1gSYnH54szA822YyMFhhSz7GVJrZM1hWGtSC
         jk7NJKKw3HxkQYd1QklrLCKeP25WqHpgAdnsUxM2hi1USvzR6HcrUtxJKWiL9onMMjQZ
         W08g==
X-Forwarded-Encrypted: i=1; AFNElJ9J/tVMe85GVHdCoW+18O6DMra54XRoxqZ/Yp/iW/uhyqD+kJ7Wk8hBCj1xZrjfy3naj6su5GNxHQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1n6VbNVkj3Wvsz5J6+EYZmkkwQRcmDmj1hZy/GjBm5T2Mp3KO
	3zMOEzuELtHv/d1uXLn78e9vF+DGCati77f4nfuPkuaHILuLxaMmb/FkPwSOOA==
X-Gm-Gg: AeBDieuKCsqKWh8OUhmMj6m5m++8wsHgA6pPJN9FvhRtSG1/vMnjuKthJKRQYUbyCcO
	3goFjsv1ULSQLCB0uakzHsQ/RWmzs6iomAefxvFS81SLbQChxJMyQa2GuMY9WxWxAiEaRHCQne6
	cuIQS+SqPyB+RvClq95LHOnY6P8VH6c+gqq0e91efwi0o0gqFqMkKrhUNNVHIqmFsZlkqpoHmDI
	3hiWhiP1bmATJPSDd7oG6KWzDQB7WZXsuks7QZOv049jiapNh+CMsVNoPrdhgyBTG/6NJ9/ToaR
	o4QFqT0/0vopZ6+6Us1RT/0pcuo8cU2h2WgSvHwCnaRz6QLkzr+AKOkdaL/rLbDT3YV9IjGqgqe
	RT06SDWiX9jBCgPMFLAvZqwja1kEHHcoUuORg3N0XR0auk6KFsUVi3M+eY32BwFZmLbBDqYYszX
	2snM/GWtLg4bFTjsMnakBaVHvKwvZUjoEojEBO9BDRywkkApD4OtJumgC6fcjR+oNagqOj
X-Received: by 2002:a05:6871:e40f:b0:408:9c83:5b1a with SMTP id 586e51a60fabf-42abf254393mr14081749fac.4.1776861906740;
        Wed, 22 Apr 2026 05:45:06 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b8fe2c52bsm14478373fac.0.2026.04.22.05.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:45:06 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] iio: proximity: srf08: Replace sprintf() with sysfs_emit()
Date: Wed, 22 Apr 2026 07:45:05 -0500
Message-ID: <20260422124505.8875-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() function calls with sysfs_emit() and
sysfs_emit_at(). While the current code is fine, sysfs_emit() is
preferred over sprintf(), and will help modernize the driver.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
  v2:
 - Fixed indenting of sysfs_emit call in function srf08_show_range_mm.
 - Optimized return sequence in function srf08_show_sensitivity by
   directly returning instead of modifying a variable and then
   returning.

 v3:
 - Changed indenting of sysfs_emit() call in function
   srf08_show_range_mm() per Andy Shevchenko's request.
 - Clarified commit message details.

 v4:
 - Changed sysfs_emit() call in function srf08_show_range()
   to be on one line to resolve issues around indentation
   alignment.
 - Clarified commit message details again.

 v5:
 - Reversed decision to put sysfs_emit() call on one line per Jonathan
   Cameron's request.
 - Fixed some of my editor's tab-spacing issues


 drivers/iio/proximity/srf08.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index d7e4cc48cfbf..2ec8d0732763 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -226,7 +226,7 @@ static int srf08_read_raw(struct iio_dev *indio_dev,
 static ssize_t srf08_show_range_mm_available(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "[0.043 0.043 11.008]\n");
+	return sysfs_emit(buf, "[0.043 0.043 11.008]\n");
 }
 
 static IIO_DEVICE_ATTR(sensor_max_range_available, S_IRUGO,
@@ -238,8 +238,8 @@ static ssize_t srf08_show_range_mm(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct srf08_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d.%03d\n", data->range_mm / 1000,
-						data->range_mm % 1000);
+	return sysfs_emit(buf, "%d.%03d\n",
+			  data->range_mm / 1000, data->range_mm % 1000);
 }
 
 /*
@@ -316,10 +316,10 @@ static ssize_t srf08_show_sensitivity_available(struct device *dev,
 
 	for (i = 0; i < data->chip_info->num_sensitivity_avail; i++)
 		if (data->chip_info->sensitivity_avail[i])
-			len += sprintf(buf + len, "%d ",
+			len += sysfs_emit_at(buf, len, "%d ",
 				data->chip_info->sensitivity_avail[i]);
 
-	len += sprintf(buf + len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 
 	return len;
 }
@@ -332,11 +332,8 @@ static ssize_t srf08_show_sensitivity(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct srf08_data *data = iio_priv(indio_dev);
-	int len;
 
-	len = sprintf(buf, "%d\n", data->sensitivity);
-
-	return len;
+	return sysfs_emit(buf, "%d\n", data->sensitivity);
 }
 
 static ssize_t srf08_write_sensitivity(struct srf08_data *data,
-- 
2.53.0

