Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D8847CC99
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866866; cv=none; b=Gmw1O/OQFQRP/coo/eDIhfVAQyzkCjTHeF64dsHdnafo70A4gKDwC85nfZuT7qW4zAem55NY+hRL+mqmxKTA7nDcouVEjBv/wD5x07P3TDRm9zrDpfU237Uvuz0Jr6K9DO9Qg6SfzVm8JT+QXY6XqvSUnsr+XpXZcWFlDUByr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866866; c=relaxed/simple;
	bh=uSuA/aq+O3Tb5ToGC82xOWMuSAsrdYEFRBOSaXRb3SE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djiY/lUo9b3l2kstvPTxCedKea4PdZoHI63XEhCmNijstnvIQsH96V2/09KmFUFlBn+92h8uBn8zFOZvIjo46LANKs5gKpoT1DiFv1xcltZqj+6HeBWro43NILj/fqblRmdAaFgyM3PzEx4JOyxVTJaDU37n/Vg8M0fp+a/zw4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JI4ORN7Z; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI4ORN7Z"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82748257f5fso873002b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866864; x=1779471664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1EmbB9yn/ziU4+rXTkis0g6M2ccv54s7vfcqmIwSMw=;
        b=JI4ORN7ZTdfwDCQZxQd7bTFB8st32rtMcjRODlJOSaNl4RpsU2zqp6Lb2Ret0yIGs7
         WNS9LeEVPRHZH0q3GjhBWfknE2p5yrIxz7lmOwGMGuBg8uPriHUPGp32cdF04dhCMMBM
         La9kknQy434r30JB+lVXokHqLSu4nOiIlTIWSbBlYKuh7vW8UwoQz24oeBcGPt4AGyHl
         YxewfA804sYcUsxq7strIWNG33w6yawz04jdnEpJ3PyDKuq+dcSJNch5RB2ggq1Syn51
         U9dEjPA/G2UDhCOvrzo2EMig9/1vI3zWoJNj5HrPTN66JjJDnIVBfZFbNhad44j98fFL
         eO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866864; x=1779471664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W1EmbB9yn/ziU4+rXTkis0g6M2ccv54s7vfcqmIwSMw=;
        b=tW0ZtgKNeLxrTYn/z3zalHa4q63CPG83wxdfbcgoaqPHxDeFFd0PWwXMeaudUfLPix
         J8YdDcvXZpgDpgL3Hk8gAvKnY0eq/trLXAy2lQzIMAVEtAL6fu7Wu5vQqyPwLQE6ZBj4
         pomBj3ZHbxWolDGDkAWL9dh6b2cu3Vw9oc+q2szkc0aegAb1SYASQzvfA7L0ZuF/rFMS
         yZ9sC9HY5UWlzY7fLwUTNKlKzoSn8idV2DfayNN8Ii5FAapBCeF6C6Qa1SOiWJEBVl0P
         lQqPafexr3BvHkKLswjfiKe9czSsVz20QhZkWkpvP6yK/sJaIpjlfAk5JyeLJ+BpclgS
         xDkw==
X-Forwarded-Encrypted: i=1; AFNElJ+zDmiLDXf/8uRSZAtP9zK1loFv4aruieHk3Bo0VcBtMgxKglUgFwNdsq4/j3ZLdYcF19A1L5rGpIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8grApPtl42GWa6Xqf+GE5FN7zcAY2pqW3NtCM2I4LqRNQRiCv
	ZbeloPwQ9xyG1rUn/gyPpOdtI5Aer/TbwS+C1pZecx0X3QfZJWeHmaZt+EJPQA==
X-Gm-Gg: Acq92OEuzgLgLIeVBhbsmhSNPR30x3fSZ7BlDPGyaDgL/MBdYuyztLQhZejY7AjlXG+
	n9SvnBJSCJ6Z5afAV9z7y4pBgZzj7GYRykbcdKltm6PURBZ7PaSSgb/x4uWQqMAzBTa48TBfNOQ
	KT98UENClYzH0m2ArMSvs1VoDLNrVn3Cx0YHRqWD9AGJ3wNZYQN9hIp3HX9wCns1/pUHVVtIOVI
	Gyp/sSi/78PLMuDNuK7zaitXxvY8J6bl00Bll7z/icvwAm1lXur4hmyIuY9QQnpR8NStOasPYbM
	e7Bo268sDK7yyp4HtABgO+/0N50LdruEJu5iBxAEV29Y0y57a/zlxWRQfc1/gaQuC9XjIW5R6dU
	xP32LALbfclabiWgbFgMEMdq8sjEadzJvdWb+QEr03TiJQp1IKrXqAW5Y7XgkUci5GQKUnCRbb+
	qk/EGgox9q9Vo/EEhee9PsfOxE/k+ye51ZdZt7Z9nU6KMsFgog
X-Received: by 2002:a05:6a00:179b:b0:7e8:3fcb:9b03 with SMTP id d2e1a72fcca58-83f18eb0cbdmr8651952b3a.25.1778866864548;
        Fri, 15 May 2026 10:41:04 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:41:04 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/12] iio: ssp_sensors: use guard() to release mutexes
Date: Fri, 15 May 2026 23:10:14 +0530
Message-Id: <20260515174017.3962168-10-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515174017.3962168-1-sanjayembedded@gmail.com>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
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
 drivers/iio/common/ssp_sensors/ssp_spi.c | 47 ++++++++++--------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index ebcda6de56c4..29bc3d48c42f 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -4,6 +4,7 @@
  */
 
 #include "ssp.h"
+#include <linux/cleanup.h>
 
 #define SSP_DEV (&data->spi->dev)
 #define SSP_GET_MESSAGE_TYPE(data) ((data) & (3 << SSP_RW))
@@ -180,9 +181,8 @@ static inline void ssp_pending_add(struct ssp_data *data, struct ssp_msg *msg,
 	if (no_irq)
 		return;
 
-	mutex_lock(&data->pending_lock);
+	guard(mutex)(&data->pending_lock);
 	list_add_tail(&msg->list, &data->pending_list);
-	mutex_unlock(&data->pending_lock);
 }
 
 static inline void ssp_pending_del(struct ssp_data *data, struct ssp_msg *msg,
@@ -191,9 +191,8 @@ static inline void ssp_pending_del(struct ssp_data *data, struct ssp_msg *msg,
 	if (no_irq)
 		return;
 
-	mutex_lock(&data->pending_lock);
+	guard(mutex)(&data->pending_lock);
 	list_del(&msg->list);
-	mutex_unlock(&data->pending_lock);
 }
 
 static int __ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
@@ -204,17 +203,20 @@ static int __ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 	/* msg->done must be initialized by caller */
 	WARN_ON(!msg->done);
 
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
 
 	ssp_pending_add(data, msg, no_irq);
@@ -222,16 +224,11 @@ static int __ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 	status = ssp_check_lines(data, true);
 	if (status < 0) {
 		ssp_pending_del(data, msg, no_irq);
-		goto _error_locked;
+		data->timeout_cnt++;
+		return status;
 	}
 
-	mutex_unlock(&data->comm_lock);
 	return 0;
-
-_error_locked:
-	mutex_unlock(&data->comm_lock);
-	data->timeout_cnt++;
-	return status;
 }
 
 static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
@@ -379,12 +376,12 @@ int ssp_irq_msg(struct ssp_data *data)
 
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
@@ -400,10 +397,8 @@ int ssp_irq_msg(struct ssp_data *data)
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
@@ -415,7 +410,7 @@ int ssp_irq_msg(struct ssp_data *data)
 			dev_err(SSP_DEV, "No match error %x\n",
 				msg_options);
 
-			goto _unlock;
+			break;
 		}
 
 		if (msg_type == SSP_AP2HUB_READ)
@@ -433,16 +428,15 @@ int ssp_irq_msg(struct ssp_data *data)
 				msg->length = 1;
 
 				list_add_tail(&msg->list, &data->pending_list);
-				goto _unlock;
+				break;
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
@@ -472,7 +466,7 @@ void ssp_clean_pending_list(struct ssp_data *data)
 {
 	struct ssp_msg *msg, *n;
 
-	mutex_lock(&data->pending_lock);
+	guard(mutex)(&data->pending_lock);
 	list_for_each_entry_safe(msg, n, &data->pending_list, list) {
 		list_del(&msg->list);
 
@@ -480,7 +474,6 @@ void ssp_clean_pending_list(struct ssp_data *data)
 			if (!completion_done(msg->done))
 				complete(msg->done);
 	}
-	mutex_unlock(&data->pending_lock);
 }
 
 int ssp_command(struct ssp_data *data, char command, int arg)
-- 
2.34.1

