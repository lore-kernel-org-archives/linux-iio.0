Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FFC3E834C
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866839; cv=none; b=jQDSJd4fU57S7vGTBh6BZwBbEeeokpHdVl0BoEeRC4jm6oQHhhO/38CPDJKOtU4UAi7zzGmJsvpVZC2uou3l6gVVh0aV2TpqHmHxwncG34dVPqdkNZ2qHvsN22I5qGy72QkPyq1ib9Vezsbj0W5A18S6qDQmGr+eRwbOfei1eLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866839; c=relaxed/simple;
	bh=vUNSUQJ2vSW/5TNiCAc3VZ2D/GxuOb+QHqUWQE4SluI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DvMnwjKOA2SX+vjFCkW7C28wPbwDiRXN0UrHXYgh3kEuEnIzUhZgPFFn8seJEZ4NrFRd66ZBbxkMSir96BurqDMR3ZeBEsuez6bHXnKmtkzxY6BqSYOS4OMBDnj0RxfivxnBeSreZx1/XWBUqzu/fIDsPjLRhc2NcxLajqOtsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB16fdow; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB16fdow"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82748257f5fso872796b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866837; x=1779471637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD4ghlSzEM0XpzQLkuHFPVSH8xE4TvBhIbAIWqVBMCw=;
        b=dB16fdowP5S8zvRHJO/bOZdlfhcc0jYXycbFrUt8MuzaTZRc8Escv3p4eQZA+o/lQc
         kV02zMXRMOW+E6Y/Q5nTOM1tUWM7csU+mqqIM3QedzmF8XVPn3DX6jFsY+/PQu4RHJJ2
         7BEx2pCOT76mIoLtga5wSApk+6iBzkvG94H1PXuFUowhkYf9wz84WrV+DV2d8BA90UWl
         IJtE8bbD78mP7GDH6YCk7xJWyEXpwKNcaJBj7IK3TWvv54yyNn1CXI5Fi4Fy5IZVASEB
         O19Di4zq5AHgfohoevHT0HlBeWY9P0sYjBH8R1JsHvfLIAO4YoaFTQ2mWqAlgbxrm7ZG
         YI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866837; x=1779471637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oD4ghlSzEM0XpzQLkuHFPVSH8xE4TvBhIbAIWqVBMCw=;
        b=pLjFD4RkG7xYhnMEf4Epon9O7LYCzM14fbHPD1Pz7HkIHyCrC3Akhv4JXz5NTXeiKk
         krpHNFwvzdxZ9hEJqm0c+nAZQB1RGTSQQVB+Ui/LsoxE4FOQ664ZG209s5PxzPoaie7J
         ycD/RFLgvrqn52WqEjKV4yHG6Nm2DVSiSdWY2wYCoIfL9eKydA4iRmWd2Zt5F75Q6SUY
         jca50wZgaGYDb3Hz6gNK95Y3PPqVLVW3cofw8hR3ht44Q932O3cGmXYsCur0k5fu73sg
         RLnsu45aqBBBHWTh8DByY/LjftulrmHsOLAXNF+2TtmghiEpJMsCO3l0cvUPHV5/BxiD
         ihXA==
X-Forwarded-Encrypted: i=1; AFNElJ8GtMYku8eUjM7veUALxrXTQiaWG1FMFCUt4KiBVnbI2wR6DhNR1HlzRjbW/T04ARAotoj4GdEDOmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHXzTxb0U0GTMpowrkf4Rbhs4gvOtUg8rFF0lIABNlJg3SKdPB
	4nOf/IkaLIwqoQBRxyzV2Zxqd1F+Hdjo0eNQcWOx+cfs1wmpYbDHWx28
X-Gm-Gg: Acq92OFK2sTYjSUHGmTISaRXgF5kD1RRgiSVMNj6aX3ElMZY96Q0U9kBx2hhhS1LTuf
	Uuqp3XFjCuUUxqWRRluI5SOIhi29tHT0djszUR57S4JQyoT1bq1OeMSXftgiZWFa8JAoV79jAhl
	ArhwRrjL8OOvbZGDwtt2qavkexXmvZQnfDpPmXUsdZs7tZjAegDVraIGTCzTPfTVduRslOYuegu
	DoQQi5/mOL/IY/8TaEt23GZSIEU8stLA+6A7sMHup0XL/8mJm09QRKeLmsWHNQTdwZsF7bysjN0
	1cdUch5GDto3QZ7kwrG1a/LN3GeFwM6NN+xbqkIvnzFP9TkVG8jrEk/T8u6cjrRuiECmt0GgChv
	Sg8yGknH8NUmPxMD0MwXpfAtLOne1E4gal4Xem0YHCS21bjo1G5cnIYsRCzpTEZrqceaPvZ5PVk
	+cXtcafIUf8sbi/e30s1CinXsj2fOsyuZ4nsghvr92oHiUwisv
X-Received: by 2002:a05:6a00:ace:b0:829:6f7d:3086 with SMTP id d2e1a72fcca58-83f33b62df1mr4199988b3a.11.1778866837486;
        Fri, 15 May 2026 10:40:37 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:40:37 -0700 (PDT)
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
Subject: [PATCH v8 03/12] iio: ssp_sensors: refactor transfer logic into helper
Date: Fri, 15 May 2026 23:10:08 +0530
Message-Id: <20260515174017.3962168-4-sanjayembedded@gmail.com>
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

Extract the core transfer logic under comm_lock into a new
__ssp_do_transfer() helper. The change is preparatory for converting
mutex usage to guard() helpers in subsequent patches.

This restructuring simplifies ssp_do_transfer() and makes the
transfer flow easier to follow.

No functional change intended.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 50 +++++++++++++++---------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 3d377a482161..ebcda6de56c4 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -196,20 +196,13 @@ static inline void ssp_pending_del(struct ssp_data *data, struct ssp_msg *msg,
 	mutex_unlock(&data->pending_lock);
 }
 
-static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
-			   struct completion *done, int timeout)
+static int __ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
+			     bool no_irq)
 {
 	int status;
-	/*
-	 * check if this is a short one way message or the whole transfer has
-	 * second part after an interrupt
-	 */
-	const bool use_no_irq = msg->length == 0;
 
-	if (data->shut_down)
-		return -EPERM;
-
-	msg->done = done;
+	/* msg->done must be initialized by caller */
+	WARN_ON(!msg->done);
 
 	mutex_lock(&data->comm_lock);
 
@@ -224,15 +217,41 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 		goto _error_locked;
 	}
 
-	ssp_pending_add(data, msg, use_no_irq);
+	ssp_pending_add(data, msg, no_irq);
 
 	status = ssp_check_lines(data, true);
 	if (status < 0) {
-		ssp_pending_del(data, msg, use_no_irq);
+		ssp_pending_del(data, msg, no_irq);
 		goto _error_locked;
 	}
 
 	mutex_unlock(&data->comm_lock);
+	return 0;
+
+_error_locked:
+	mutex_unlock(&data->comm_lock);
+	data->timeout_cnt++;
+	return status;
+}
+
+static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
+			   struct completion *done, int timeout)
+{
+	int status;
+	/*
+	 * check if this is a short one way message or the whole transfer has
+	 * second part after an interrupt
+	 */
+	const bool use_no_irq = msg->length == 0;
+
+	if (data->shut_down)
+		return -EPERM;
+
+	msg->done = done;
+
+	status = __ssp_do_transfer(data, msg, use_no_irq);
+	if (status < 0)
+		return status;
 
 	if (!use_no_irq && done &&
 	    !wait_for_completion_timeout(done, msecs_to_jiffies(timeout))) {
@@ -243,11 +262,6 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 	}
 
 	return 0;
-
-_error_locked:
-	mutex_unlock(&data->comm_lock);
-	data->timeout_cnt++;
-	return status;
 }
 
 static inline int ssp_spi_sync_command(struct ssp_data *data,
-- 
2.34.1

