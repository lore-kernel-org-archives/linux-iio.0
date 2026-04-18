Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B33175A67
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776473546; cv=none; b=Uz2LCFVmKRUok+WeNYsKLheXZXNYPy47wE1qUYC5Ndp0EgCAO5gD8olP6q6uU+ZbUufOKytmrANrtBuEHtdn9WKQOb51QjJDkAJb6hhbosxu1borlu78CB6Dl3JXccz+vhROrFY//Un61yZaylpgY0jC8PC2Mh1c2m7t7PIQuXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776473546; c=relaxed/simple;
	bh=IgvV76mhiepFn41sPiCCpHE+hyFnJxWxzclBRIbikpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXnSCnRPvIYJctAYqMatbR+uE8nY8MjRbDQncMtge1xw7gGf8K9FN+JyOkfEKw7NTISk2HQHCqs5+1mvIEImh0XGXnRtW2PCcC014HVDqyJu8qX62KJoWcNqUjXclTUANJFQPdhb/aBWFISpNp5e0DjR8VqX+MAV3Vq/ozmBkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWKRWMne; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWKRWMne"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dbccb6ae20so716622a34.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 17:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776473544; x=1777078344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrWZOkSGwAlRRgBDBv1Jzc41071sReDN2QLXfPsn6jY=;
        b=IWKRWMneBPWk1swNZTZyt5NDenMFx0pIUvnHyiLjfJZUNjG4gAdaQw4xsAssQ0+yoW
         kVthZNGtda6nootuJhb1M91Qjz1mAmNHs5i5xCG8cm6wEbmbfp2jg4v+RzBqFGQZp060
         HBqbGvSRnv/TRLMJeZk1WfKnxi55GgV51Rx76FnGRK2+Ncr92UGK2CeQbBTumQ8f1Jfx
         5dW9hXfjIkTGqiSe1BVBYgwYB8l0D7NE2cNLhMvyXhsi/rjX6Zg0OVAOtByN9/FeD4pu
         h2tFh0SNj7QnXgHJt8mMgVFnTDzo3gM+VDsP/i3DtpgjD8kz8guYYOXoqGLfSwDCGLsV
         EWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776473544; x=1777078344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrWZOkSGwAlRRgBDBv1Jzc41071sReDN2QLXfPsn6jY=;
        b=SjJRx19yrbAomkXuXYHC+SsXfdVWLOYzA2fA1ttR9NUIC4YrPfbSp2mulgApL1AcR6
         as2YvcX2bu/KdeKoiiomFrpRrFdCuT47ua358wBS857GLXKmQsDNyEGATXyV4t8kgz9W
         AnO+B1UQraR9F7jlQ+i3ldUpA/rZl+f1bkQO0YG2f63QLu+OkuugQnRvTBUEno+efapQ
         k0PH6tr/CsjRUh9AUmUyDb7SzaPz2yXWSxQdrvRjuB2ZMpgUYB7aefmGUX6iB+NHKKg2
         tzyD4U+d8Ql2psDHxcCzKjHsCPVbDgBl5jlVXuCya1s8N1QoC7nLSTJGDIXjJ4CER7ZT
         hjPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/btbMgwHm0IcYtCEUrjr0MYXZeOaHA1XDNbJixnbfPU4NTjlJ6/Qhl69nEq1z7sufnbV8E6JccopA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOsPIj+XCHl95Sild59htbb/983+9fFZU2MNkjCs1opl/BTH/
	JG9cvR1YfWDcr4kWMdW/jUSBNX6xcqpjiiv+P1U380om345fbJY8KWF7
X-Gm-Gg: AeBDieucrdPsdyXWsQgnkcWBnWMZR8+zV5AzjZc+LjH34M+KpWoHKEq2Mi/WG5MzVRe
	d2/h92kyV6WE+y900xGPDR3zb4fAkxq99DKGM/9VwqqVqlqsGb+9Kbl/vKhU4oLNw/+UuX1Bvuc
	EKPNnkDpUadVaZuH8zARZx8x4XnXGc34INkJLdW8ptexAE7oZsaeVeCzj3+146wKs8IwK+/phlb
	YmoL3PtN7zoZeKXArD/FuIdGp0kEmx6Txkf/ShgBF7T8oqZK3yuyKVWlBxIKVG3Fram6vAze+OM
	/HXTgppFferIqtgn9Y65P1yrLmS9W36iNnELpl+cNwH2hQFxYPUBsx/sVycCwx/jA9zVLp/vCJj
	xGsZz0nhYHYLmBVdv6haFNLqeX0zX9gHTomF/FZ0FjZEhhxHrqYzT5U/uOFoyl5EtM7JrLd9AeI
	BdkoVL0Di+VxhZZOv+RCpV6H2QeZLbnZQoXdIHithF+/qCCB4lGE9vLwMILFW6Gl0qeLmG
X-Received: by 2002:a05:6830:67f9:b0:7d7:d0d5:5bf6 with SMTP id 46e09a7af769-7dc9521e6d5mr3103694a34.21.1776473544492;
        Fri, 17 Apr 2026 17:52:24 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dca6f589d0sm159665a34.27.2026.04.17.17.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:52:24 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: proximity: srf08: replace sprintf with sysfs_emit
Date: Fri, 17 Apr 2026 19:52:04 -0500
Message-ID: <20260418005203.85696-2-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces sprintf function calls with sysfs_emit and
sysfs_emit_at. This removes unsafe functions and makes the driver more
stable and modern, by ensuring that boundary checks take place.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/proximity/srf08.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index d7e4cc48cfbf..6d38a894ecd3 100644
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
@@ -238,7 +238,7 @@ static ssize_t srf08_show_range_mm(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct srf08_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d.%03d\n", data->range_mm / 1000,
+	return sysfs_emit(buf, "%d.%03d\n", data->range_mm / 1000,
 						data->range_mm % 1000);
 }
 
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
@@ -334,7 +334,7 @@ static ssize_t srf08_show_sensitivity(struct device *dev,
 	struct srf08_data *data = iio_priv(indio_dev);
 	int len;
 
-	len = sprintf(buf, "%d\n", data->sensitivity);
+	len = sysfs_emit(buf, "%d\n", data->sensitivity);
 
 	return len;
 }
-- 
2.53.0

