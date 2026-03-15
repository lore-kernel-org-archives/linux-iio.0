Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6F3612C9
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773579320; cv=none; b=Ii917Dj0UKqskhKBHzH1Lwi8AwWLR9oFktMZ4Hmdby28PnMqweYFDB9/FilfIWUJB1wTGCflPqOm14+K8+6cu6zM6KutUqJdTUvjsttF4oX1Ozgs1IeaC6JeK97hO9pzw9GN7vMg5BD1VSwdh+vbELq2ZPIkwVsuymgbuum04R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773579320; c=relaxed/simple;
	bh=3WIdw0h3pg9FZq0IKUhtfsTSwjcxqvQJIay/X4ecUas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5MqGGyosoWUvzoZO4frr9hdXAE4ER5JdcGCNo5iAN+0Xh6ctJr1nWde1tiqB2TpFQ9AXlc27va3yM/0hj9UORlwBX7rhnXAHTnNjKpD7tJ8DKNjA2EHJhlvrcqes+jpyY85i24uaT+S1fyJELmNYnWtzCe+efg99Gpst55/Hak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=af7BsNsq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af7BsNsq"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad4d639db3so17250725ad.0
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773579318; x=1774184118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuALGFM1dkmjL3yoaur9WlxMxVFFTalIvqYZT+766K4=;
        b=af7BsNsqL9L7gw2CTXNZp0tnCP78MYsC7C4HRYo3cbxJz88seCRteYhNGK0q2HJzWq
         92lzo/tbJaMeTvTHZwvrsKCiDyPsfXUBWjbN4RWv0DVtu8amzGjEWeUs/MSOgNSlkxKi
         loLUJ8h8TV59mGsGwvd/sfHdf8volgQcN8BIYkuoU7+HGZP1FXFIzCcupp+H/eQZezkh
         MvkRlcbT+zLhIJ5bmDxkrTiLonKUKGSb+wGyeXwgp+yDwPz/orGo7Nh341G6wQr7ESaI
         pcag1a2hE2SYu8t7V0o+/NN8XESmnJxZ7cxLCsGjQkD3LL6UMBta+lFtnBltsceOi2BC
         yC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773579318; x=1774184118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nuALGFM1dkmjL3yoaur9WlxMxVFFTalIvqYZT+766K4=;
        b=rcK/kh8od6fvSKxux6AgI5FTqtMfhwTMvcz6kYj0cM4NDhPzkwFSApqi5JyPc2vIxp
         lUdrFuvJvvGEPZ1dsEz6GzFP+JBQWH5Bne69P1Qq5ifNHqUvKyTtp6Lue7Gs9BsqPFv2
         7vnJJG8JhC/9BjeMsA+CSOyQe5/aQfTo+50MjdzmwxodDzGXEemtX8ogG6XQxOwQV2RK
         6YtpK9Icx1za7nKKhrE4efkDRjDnzzZPyN5LkjdRO7Gy9rt0mjTTw4uhmyCFLV7GItb4
         tX8yGMJUStfYwY2uqA2MVc3riszK4eL/DoxmioDFQzG2jbxyB0TqE48begeCwVMuhL8R
         jYOg==
X-Forwarded-Encrypted: i=1; AJvYcCW14hTXICXvdUvGuMv9KLkwWH3wmmpWa8opTykjRELIHxrweTtU/fx3N5FVqGsxoN+Y1PSUeUBtPMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgvGpjuIsVZRyWK1/YFZqZ9cKmemV7SkMq90nLoFrDVeIGwOnK
	bYD3iRtR0Q9aM/fdY7jCzOTXoTg+8xZxFnUq9ymGykyF9MNWk9VqzmnWeWXI9A==
X-Gm-Gg: ATEYQzxWC1YrD2zSZ9Y4z61Ph4NklL8Mr8gRWDFKgGF8bQyZ5/AiKTypsoBmIbQUvCO
	VhEZVxqNRs2Y6OCbPmyjLs2QG7os7RI1xEt623DzMyKttgaWUx+mtuqNy6QVxyiaO4CocGc5801
	/W+f0yDrE31Jb1BuPqmnmiH5Ig6vXcxmflX0KI9If9ZRVgtVDif9K9U7HRXXM9ldCANeHyvBSJi
	6iXmZnLBHBjd5GqmSX6KJjKARU5mb06tRVgQ2Rw8ntgCtqVE+9ILokko0NxLawjlZn7wLTh9K4w
	IXPjIbcBBJSyHs+3cOhtIczDAnoXJzM4A3aC/3iBaAHg/cBqWy3oG5mRBAgsUyOuytyN86sdN1S
	SLG2J6PsQqjRzP/Wi2175wNEDRSMr2gLn2PFbAV9/rEfnZOvmeG8XGShO9myqK+0QljEh4EI4jd
	oMJBu2M+o1uynFJ3cfk6WRQPOD2k1V5aV1iz1E2IUbNMODgV1ChIzv9lg1ceU=
X-Received: by 2002:a17:902:da8f:b0:2ae:504c:ae8a with SMTP id d9443c01a7336-2aeca936252mr100903295ad.16.1773579318173;
        Sun, 15 Mar 2026 05:55:18 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece594b4fsm72931565ad.20.2026.03.15.05.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 05:55:17 -0700 (PDT)
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
Subject: [PATCH v3 1/3] iio: ssp_sensors: ssp_spi: use guard() to release mutexes
Date: Sun, 15 Mar 2026 18:25:07 +0530
Message-Id: <20260315125509.857195-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315125509.857195-1-sanjayembedded@gmail.com>
References: <20260315125509.857195-1-sanjayembedded@gmail.com>
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
 drivers/iio/common/ssp_sensors/ssp_spi.c | 54 ++++++++++--------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 6c81c0385fb5..87a38002b218 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -2,6 +2,7 @@
 /*
  *  Copyright (C) 2014, Samsung Electronics Co. Ltd. All Rights Reserved.
  */
+#include <linux/cleanup.h>
 
 #include "ssp.h"
 
@@ -189,55 +190,49 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 
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
-		list_add_tail(&msg->list, &data->pending_list);
-		mutex_unlock(&data->pending_lock);
+		scoped_guard(mutex, &data->pending_lock)
+			list_add_tail(&msg->list, &data->pending_list);
 	}
 
 	status = ssp_check_lines(data, true);
 	if (status < 0) {
 		if (!use_no_irq) {
-			mutex_lock(&data->pending_lock);
-			list_del(&msg->list);
-			mutex_unlock(&data->pending_lock);
+			scoped_guard(mutex, &data->pending_lock)
+				list_add_tail(&msg->list, &data->pending_list);
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
-			list_del(&msg->list);
-			mutex_unlock(&data->pending_lock);
+			scoped_guard(mutex, &data->pending_lock)
+				list_add_tail(&msg->list, &data->pending_list);
 
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
@@ -360,7 +355,7 @@ int ssp_irq_msg(struct ssp_data *data)
 		 * this is a small list, a few elements - the packets can be
 		 * received with no order
 		 */
-		mutex_lock(&data->pending_lock);
+		guard(mutex)(&data->pending_lock);
 		list_for_each_entry_safe(iter, n, &data->pending_list, list) {
 			if (iter->options == msg_options) {
 				list_del(&iter->list);
@@ -376,10 +371,8 @@ int ssp_irq_msg(struct ssp_data *data)
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
@@ -391,7 +384,7 @@ int ssp_irq_msg(struct ssp_data *data)
 			dev_err(SSP_DEV, "No match error %x\n",
 				msg_options);
 
-			goto _unlock;
+			return ret;
 		}
 
 		if (msg_type == SSP_AP2HUB_READ)
@@ -409,15 +402,13 @@ int ssp_irq_msg(struct ssp_data *data)
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
 	case SSP_HUB2AP_WRITE:
 		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
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

