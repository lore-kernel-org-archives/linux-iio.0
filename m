Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD3D3451C1
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807331; cv=none; b=nhfA86EydYPLAJ3xPVWXFWQ9/Vi+oNXe7ZTbbr5+Kjfo0AVzLrhL/1b0Qhdbk3PGXIz3MfrW5xjYfzFQiOmaTswaxo9mGOUj5ncSOj++HbOoz1ye1AxlnsJWKsHS10YXVT4ykuUOIpi6tvoHpb/EKgMDSYaSMw28Ndd0a/JWuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807331; c=relaxed/simple;
	bh=WcnMgkTwubSUYPL0bAFmSn32Kovx1WQmZtEidXSBYr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onpz0cWWEUOepGNYGoNcK3i3TrzXCbcsLeelyv1RFht3Es65DrIRN4x8COIqMBu0BYnnE+1reyr62RLghVCo3FNAyC7R/PIQxBrsN/H3XV16FsNV4pI41yyVL0lyebbC/8wj5LGK0KnhSQVECQIQDkVbihyRb7IHP3xUVqk0Rhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUaRYWyf; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUaRYWyf"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479dc6d26e3so1102693b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776807328; x=1777412128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1RYiMKdVCtnLRX+oAV6sUFHniC4KxMLT/Z7RuQ1nlrM=;
        b=aUaRYWyfGjoVC7hkNGTxeV3XnMfrV0ysGhWhEgCsqo65a2UmCStBp4lKsUiQ2sUkep
         enV9b76twF9I31E6cW5qZpB5gPssb1YnKapc/LsQreyc3tp/reylxJzqgu3eiDqFKo+e
         YyaRcX6JbPhOdAWxg/SKnQNKnWMPqbjqO4Si33ctBzTV98g9iBRr4MQ29QHfVPmgGPRo
         8xNOqgyqSqcJ2+vjvrRdaSDseqELb6fSC6wzqMefsr8SWq414hotJ/4YwYOk44PUf+HH
         nBAAGcEGPy9kz7khfO18SpO3Sp+rrrHIzZ/slDTXNhusQVRynK/X2yGLeoIeh5WPnufD
         rAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776807328; x=1777412128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RYiMKdVCtnLRX+oAV6sUFHniC4KxMLT/Z7RuQ1nlrM=;
        b=kdSNQc/60xkJzyINALmW7OSP4LxhiYleT20MX7lSrdOcHcwU7C9LSr+iFekH68rQaB
         MbS4kJmw+XQT5bbR//N4XqyF7OXWgepU2UyONvCtiqhNT7rJhi8bgYtF6w10uIxiILQv
         Oh2GidZb4E1MyAINjt5AeZcMW2mx3X219zAtIu7Gg8DnGuI2IsJGS/oFSgGsAhuGJJlK
         h5DFd9j54F5YmguTrXRmxTcl1+8M/5SCH2UtPBOneu9TFmSsJ+YPDXVTRsWc6jj+6Z7y
         88qC3NIttCkkX/r9OvAVuHXyrGLGyFDmCApn2E4xTSNvaejIc9zCgzuLdM9cV/Znyn2Z
         hK3A==
X-Forwarded-Encrypted: i=1; AFNElJ+w7rSu9eczEeIBcJBKz56J9MomceIjMD483N/jkpj0j6ULEJ+9OfLlA+sqDYcTs4tZB7nk5EBoLIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNHAg9FNYn8GNO4CkdW/Yldm3bwGm2zrspQoBTuD7+xXcp1PXk
	J695vGfewhSxdeqJQH78dZn7b5Mq3a35n/J3RFLxLUYu+Q260+8MXwK8
X-Gm-Gg: AeBDiesI2EXZzJl+DFpINqKQP4D0oGkSx6UE52H9AC9UW/3hKML6rcmgSoKMDEPqyYZ
	0GQALAIUln/kY1rZ39/b24BqkamnF0A/kGSUT8FbDkSRRRKFptcxP+RS5ntiox9UahXan+HAxgt
	3XcImYd2ogVY5roKWsNQe5n81QJKnVFLwL0Ufh+1eDlSy76muWtORtRf7nCVw6MYAHImBEI446X
	qxyIgsRO1xYF8VntnM+Xuk5iHsx0y4EC8of53oXcLsUaBImlpTq9lvRhTF8R/gOHICrrM5QUv8B
	thIiD8QbZgPmIe+R+2kAXB/1VyXuwrE0ao0yYQGXHpSASjHfUOi6DJ5Tfx+U0rFkNAPk44q09sf
	/fYkq/peLdD7gnXvO0T2J7hAets4JTK74WjH26Jvi3+GpuxTMelDHOtA7j8q8i7uzZ5XZQE9e0x
	72ywmX4V/9EgXOX5uw2b4OIbRBdO4ZgM/t+7hIrHl+PFyQJM6d8fvfdEPU0kPv6QDMfasm
X-Received: by 2002:a05:6808:6f8f:b0:45c:881c:e0c0 with SMTP id 5614622812f47-4799ca846fbmr11327084b6e.47.1776807327902;
        Tue, 21 Apr 2026 14:35:27 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479f3cf40d1sm1551771b6e.12.2026.04.21.14.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 14:35:27 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] iio: proximity: srf08: Replace sprintf() with sysfs_emit()
Date: Tue, 21 Apr 2026 16:35:26 -0500
Message-ID: <20260421213526.14867-1-m32285159@gmail.com>
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

 drivers/iio/proximity/srf08.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index d7e4cc48cfbf..78b67fbca825 100644
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
@@ -238,8 +238,7 @@ static ssize_t srf08_show_range_mm(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct srf08_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d.%03d\n", data->range_mm / 1000,
-						data->range_mm % 1000);
+	return sysfs_emit(buf, "%d.%03d\n", data->range_mm / 1000, data->range_mm % 1000);
 }
 
 /*
@@ -316,10 +315,10 @@ static ssize_t srf08_show_sensitivity_available(struct device *dev,
 
 	for (i = 0; i < data->chip_info->num_sensitivity_avail; i++)
 		if (data->chip_info->sensitivity_avail[i])
-			len += sprintf(buf + len, "%d ",
+			len += sysfs_emit_at(buf, len, "%d ",
 				data->chip_info->sensitivity_avail[i]);
 
-	len += sprintf(buf + len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 
 	return len;
 }
@@ -332,11 +331,8 @@ static ssize_t srf08_show_sensitivity(struct device *dev,
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

