Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DDD33439A
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776726497; cv=none; b=JE2xGcD8vs50t4QoQn1m2wLDO8DkWYdQX2g31MKRRYMpOuKwsrK+mlxCh6c1oYqrmqYs41SQppRHZkQLF3nyQNLEUPiR1pYhyxYkYPC3gPAyy2PhT5vCGi2dbfK0VycQJxXXX316HVWv+QqBlyLyDfXQdo1YzpwwuSYGijk0pvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776726497; c=relaxed/simple;
	bh=cA0LWRksjJ9hjtNI7G/hEtsIrYp8IoJuEp3bz3y1PFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3FcYSarrWPP5Tu6GGknEMgJSheCa3pZZZXKWV1S5y4rTU5Ia+04yPk+sb4As1vIF4/ZloW9Fctk+d6ASBesSpo+8FPSJPlE3vjXZXJzGAf0wQfMB7WAhMVAIcETvVdfVx4zWmbIHZVVGm0tqjNCY0lE0djls/3zbd0ofRqg3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxH4hDqV; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxH4hDqV"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d1872504cbso2993422a34.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776726495; x=1777331295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNd2sp+2VZA2XnmnP1dQMi0oHHycc71KBg7plu2ryTA=;
        b=TxH4hDqVP5sn2v/31v/9pbmXqSblfpMEZm/f8jxMmHW6mmOaKA/QzE1ldovgTJMpMp
         D7okAZaywXX2E/0dMCKZHpWVcZU0+nPw+MMegXOGf07Y3HLmICd2ukxibisj80tPIx+p
         Dg+KQpCZ/0WPC5DrP3jUDyRUIOCN8SQhDdjGi/HJd60XZGFJSznFE1UcO8VkLsWJ2bE6
         AuTf/tIkZgLkBEmq8yDzKuWDEtIQbeuLCh03WgCzF0JrYAsSHIUh09/1wgHd564Qn2OW
         0us5rMQP8zko+P4yogpWnKKK45qf9eiXEtRtH1+gj1aZosmlb6aSU06wnKC17fbcTQz+
         BoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776726495; x=1777331295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNd2sp+2VZA2XnmnP1dQMi0oHHycc71KBg7plu2ryTA=;
        b=LgdwG5qvB/mtQTzvBi4/cENwWrI40lP+TtZ1QmycAvjU1bEo/ydO2o9P+eh5tyobm2
         p0Vf9+Z1W2u9DK3rJ2MRdrbSBSFdB1X7WbOF89i1mQJgQG4YLuhCZemdr8syGQdqttZ9
         E90eXdss+Ecp7ziNS/TDVUcjuBcyjfZs3BQJQVeSxKbyN2pwpN0Jdl/h68IIwrFpOSnK
         Cd6laUZGBlc0540OBsMp0I7X2jp4DBdWQ66hp7LdfnGdjRXyLwacO57aupSxBm7okA62
         OVh4NDapReHmE1dgqQNvmJKPkT7myYbO9ccIuYtgRzbuj3Tr/cWGZvGDvoYBPxQ1+C8H
         /hRw==
X-Forwarded-Encrypted: i=1; AFNElJ91iBQbRVHDyEK9m/r9wXmlhiVG6Osj3BO+YMXQF5H1eGIDGcfRwHvdGxLqLW9sLgPaow1TeChRLdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcd8sFy69L1+CRmcWgE7Qoles/Zrk4LPKxX+o+rpFQHrNQ2ia
	W+iZeAV+qYcbKixe0UXHMWz4J3yiKeDL2iLdPrR3SzvC9I7O18GIR2Lck+xVXw==
X-Gm-Gg: AeBDieuGBlR5uQpZLUmp5hVqGrwRL/VLBCQm7V/EbE+Di7vGCRLAurPyUimHeKsE2fz
	Zldlqg3/uhuIsc6DPyiFn8uV0iI1HjfRBYsgr6uOciBCQix4MagMcNA4A3/GauEb1cJf+mzr6xh
	QAdyBlBQK/QpDnWtQdNiurC83UhnrZqeKrCOg8TAwM0k/tuEdnrFiPgWuzvoUa9sP/NwL/ao8k7
	u4nr76ao7jYBQsoawSt7MiePyYv+aSX/R7KytuU7Ve5iOe/qSmjXzhhUemLLMgsrYxudiaCjuTg
	0os9pid/HC9eZ4gF2kTSi9x85eCiKjkPMa2ZU4dSbVngviDkLtIIQLcM3eCEUkJyQpGXQXf85vZ
	QcOX89UIyuXp8DY+tpgGP5GOmU6uBb9mBNS4mGf+ju3oGefFrlkG+lSOCmLC7Az+Y49ViiJMqvT
	nGfsHbLR2G3kiiA9RAi+5pwt2IC6gjADDD21I+PxH7HPBCGfmUjBNjKSm+NqFB/dbfGdnx
X-Received: by 2002:a05:6830:6e29:b0:7dc:d7b8:aa80 with SMTP id 46e09a7af769-7dcd7b8b412mr421099a34.17.1776726494980;
        Mon, 20 Apr 2026 16:08:14 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd63e4780sm802294a34.14.2026.04.20.16.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 16:08:14 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: proximity: srf08: replace sprintf() with sysfs_emit()
Date: Mon, 20 Apr 2026 18:08:13 -0500
Message-ID: <20260420230813.25985-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces sprintf() function calls with sysfs_emit() and
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

 drivers/iio/proximity/srf08.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index d7e4cc48cfbf..e92526459dcf 100644
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
+			data->range_mm / 1000, data->range_mm % 1000);
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

