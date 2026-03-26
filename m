Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166A3B6363
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513113; cv=none; b=LJbCizxM3yWjzAskVGAzvkAXWS1E2X7RxmE+EwKOjiASX+DyCiQdJYWVJ6lDQJO2LLsmM2L5ch62lImG5txaMnIYfONsEo9pMdAya3L2HvlvVJVrggSu36+hArUFZeoTWwQQSqCdbkEA3GE0BKjtzZn28F21ik7Isj2MoAcgfDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513113; c=relaxed/simple;
	bh=VuTAHHFI+jyiGmHc9+R6vTChQAN82qse0bKmbCb3qO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+M2o8VWeeWh+cFPEs7yU+6rANJSdUtDuwTkrIPDccFyCJ+8M91ke+1iygiY7NMOtnoQLglAi/icmvnJxERDlFT/XAF47o28dpFIFhuqKmS8bunx8C41xzHmBQkQfkU4E2GXhTezEomQ0lsbqRT5kp0XwG1KcfzG/b5ipzIOmas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnOuM9O0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnOuM9O0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aae4816912so4525055ad.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774513111; x=1775117911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hW+MdHuk6SjYOPjp4FIdn/7nxTOhIxHKoo7bSolADB0=;
        b=LnOuM9O0XUGYM29jPfIi+YESXOqFH2C0xRs8NXFGWBT8VQWg4QoVg9XHW5UqZcXnhk
         anP4/bk9g+TRpzichchPdGaTgts0cTk+62HZ5cpwnIcYIe7IHA71fuNBhbk0jmN7o3RG
         8jpDvGxH4CqWqq4EYVtVSIMZfZEgTs7SqhsfPxd6teGs+JCeekda1y662p7TutSsFCRq
         iLrutTNA1zQAN18rtQdhrC4zKMAGBpPFDdu5fxfDadNeJWpbDcTcc3ZRGxSNd3XlR3+z
         ecc8Ou4ZQbjLhcdKoyWqfY4V1T9vHm7/vrCazRnLkxvb91s4XMuKExaYtcbo9dOkaCT6
         jYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774513111; x=1775117911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hW+MdHuk6SjYOPjp4FIdn/7nxTOhIxHKoo7bSolADB0=;
        b=pHPkJiydsxHFEHDfq2PVxAA+6DihWVEgToTX5naMu+duSiUEn838sYXiNgpNe4xiIF
         dvNHaThAe65v89/9TfklLgbKYNAdXfVKQ1hpgYvo1J6AAct5DwafYCilAFbkdLUne4BZ
         0e7iKFMeS8UGuIYlf1ZigPYwSI3hT3rWS026XaIjfphpJKT7LSpUkvFLWxkDyu+PMMar
         xSADOnvOxzPaXIbAZ1ayHTG5o++NK0vtlk2/WuHj5zFmdimFf8Lb1X8d8vGJtIeDO/mu
         MwAlvlxDUXHjSuj2zlZ+4LduLg4gMOi7HPh8AmWMYPPsVPftQpU2BZzMYFr5Xn5yWfG0
         N3Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUx6Fj32CD3gXeuGmSCPNy3HLWrugcoNqbUAmU0JxsTdPtUGKdVKy/ZlCa1ToF1H+EusDUC4VXoZGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyANq2Tays9mEzg52N+i+vZAGAxKv0z/uvKfWBuKZ9eMTHJiZNU
	r2npXfDHnYks9gScUmkhA7psZoaP58ZfHgPMiHL2NE16a5Xlw6dupK2jl4OjSA==
X-Gm-Gg: ATEYQzymlTfx4vc9T3Ogal+0gTF35+pHjT210Xu8dVhV6Py7MNGVU16J41gODs29N72
	jI+NVHPPEjnIVVKLh7yUwX96CrywiIdnt12C5DCmaz1W3too1hM/slaqAX8QX+4pLO0v8v4w1yW
	zNrs1l1+ALE4L8bWjxW2uokujfb+UU69cpamGBixIC5hM7hXPW9hIBfQQbc4SJqTiHtWIKLaXgR
	4PI7opuA4t3t92fLVjhnlzJmOSe1I6z8ZXsWGUFCmUsYSj1equq56RSZqjVoMSnJVCAYkIEH3XG
	7xZTkKjEC4CFwMU2kIN8bSrvWVHxnObmkf8yHUX7kK+zHfdMEFLT6PWji9ya/5WrW9IImrZBeEv
	q5k16eHAvdkXhg+xMqbQ7Mj9ogGi5jGlywn7lZagA9BU5FVhmBCqZhClO6T9MD7oyyXLb7Ji7DW
	I/lN9kfvThg86wfwxUe1bWBLDWKBS3P+qDZ+jg/G6MNyqcaPAZ
X-Received: by 2002:a17:903:3890:b0:2ae:66c9:494f with SMTP id d9443c01a7336-2b0b09a7b3cmr71052695ad.2.1774513111268;
        Thu, 26 Mar 2026 01:18:31 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e6cfsm21855535ad.39.2026.03.26.01.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 01:18:30 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sanjayembeddedse@gmail.com
Subject: [PATCH v4 3/4] iio: ssp_sensors: ssp_spi: use guard() to release mutexes
Date: Thu, 26 Mar 2026 13:48:14 +0530
Message-Id: <20260326081815.925373-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326081815.925373-1-sanjayembedded@gmail.com>
References: <20260326081815.925373-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
for cleaner and safer mutex handling.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v4:
- Use guard() instead of scoped_guard() to avoid additional indentation
  as scope is same for both APIs and add scope in switch case
- Link to v3: https://lore.kernel.org/all/20260315125509.857195-2-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 50 ++++++++++--------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 08ed92859be0..61a4e978d9b2 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -189,55 +189,49 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 
 	msg->done = done;
 
-	mutex_lock(&data->comm_lock);
+	guard(mutex)(&data->comm_lock);
 
 	status = ssp_check_lines(data, false);
-	if (status < 0)
-		goto _error_locked;
+	if (status < 0) {
+		data->timeout_cnt++;
+		return status;
+	}
 
 	status = spi_write(data->spi, msg->buffer, SSP_HEADER_SIZE);
 	if (status < 0) {
 		gpiod_set_value_cansleep(data->ap_mcu_gpiod, 1);
 		dev_err(SSP_DEV, "%s spi_write fail\n", __func__);
-		goto _error_locked;
+		data->timeout_cnt++;
+		return status;
 	}
 
 	if (!use_no_irq) {
-		mutex_lock(&data->pending_lock);
+		guard(mutex)(&data->pending_lock);
 		list_add_tail(&msg->list, &data->pending_list);
-		mutex_unlock(&data->pending_lock);
 	}
 
 	status = ssp_check_lines(data, true);
 	if (status < 0) {
 		if (!use_no_irq) {
-			mutex_lock(&data->pending_lock);
+			guard(mutex)(&data->pending_lock);
 			list_del(&msg->list);
-			mutex_unlock(&data->pending_lock);
 		}
-		goto _error_locked;
+		data->timeout_cnt++;
+		return status;
 	}
 
-	mutex_unlock(&data->comm_lock);
-
 	if (!use_no_irq && done)
 		if (wait_for_completion_timeout(done,
 						msecs_to_jiffies(timeout)) ==
 		    0) {
-			mutex_lock(&data->pending_lock);
+			guard(mutex)(&data->pending_lock);
 			list_del(&msg->list);
-			mutex_unlock(&data->pending_lock);
 
 			data->timeout_cnt++;
 			return -ETIMEDOUT;
 		}
 
 	return 0;
-
-_error_locked:
-	mutex_unlock(&data->comm_lock);
-	data->timeout_cnt++;
-	return status;
 }
 
 static inline int ssp_spi_sync_command(struct ssp_data *data,
@@ -355,12 +349,12 @@ int ssp_irq_msg(struct ssp_data *data)
 
 	switch (msg_type) {
 	case SSP_AP2HUB_READ:
-	case SSP_AP2HUB_WRITE:
+	case SSP_AP2HUB_WRITE: {
 		/*
 		 * this is a small list, a few elements - the packets can be
 		 * received with no order
 		 */
-		mutex_lock(&data->pending_lock);
+		guard(mutex)(&data->pending_lock);
 		list_for_each_entry_safe(iter, n, &data->pending_list, list) {
 			if (iter->options == msg_options) {
 				list_del(&iter->list);
@@ -376,10 +370,8 @@ int ssp_irq_msg(struct ssp_data *data)
 			 * check but let's handle this
 			 */
 			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
-			if (!buffer) {
-				ret = -ENOMEM;
-				goto _unlock;
-			}
+			if (!buffer)
+				return -ENOMEM;
 
 			/* got dead packet so it is always an error */
 			ret = spi_read(data->spi, buffer, length);
@@ -391,7 +383,7 @@ int ssp_irq_msg(struct ssp_data *data)
 			dev_err(SSP_DEV, "No match error %x\n",
 				msg_options);
 
-			goto _unlock;
+			return ret;
 		}
 
 		if (msg_type == SSP_AP2HUB_READ)
@@ -409,16 +401,15 @@ int ssp_irq_msg(struct ssp_data *data)
 				msg->length = 1;
 
 				list_add_tail(&msg->list, &data->pending_list);
-				goto _unlock;
+				return ret;
 			}
 		}
 
 		if (msg->done)
 			if (!completion_done(msg->done))
 				complete(msg->done);
-_unlock:
-		mutex_unlock(&data->pending_lock);
 		break;
+	}
 	case SSP_HUB2AP_WRITE:
 		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
 		if (!buffer)
@@ -448,7 +439,7 @@ void ssp_clean_pending_list(struct ssp_data *data)
 {
 	struct ssp_msg *msg, *n;
 
-	mutex_lock(&data->pending_lock);
+	guard(mutex)(&data->pending_lock);
 	list_for_each_entry_safe(msg, n, &data->pending_list, list) {
 		list_del(&msg->list);
 
@@ -456,7 +447,6 @@ void ssp_clean_pending_list(struct ssp_data *data)
 			if (!completion_done(msg->done))
 				complete(msg->done);
 	}
-	mutex_unlock(&data->pending_lock);
 }
 
 int ssp_command(struct ssp_data *data, char command, int arg)
-- 
2.34.1

