Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D733093BB
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462951; cv=none; b=Lfk6FDBL7I23eVRCnT1szNywly6xE/mxkaxnrzIZkq5WPIoG8b0hkIxB5bc4p6dUDAOYwa9Bqas40uSrXXpGjoBfZ/T4hD3LS40GLEqDpbIRvKzhX6+OPLdKpgIKnqat2Eomgen64nkjtrXLZEAzG/AvsX8n4CYnoAPDx1qw/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462951; c=relaxed/simple;
	bh=rU4vsCbZPCGD0vFrs6ml6LjfFL+wePC5vj6ZFMlpsQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdMSljMGABIUxrtlBVEMPRRpNouMYG1TH1NuKST09FBMzf/wqq7+qY1iy6FjzY1hdHTsfEPD3YjSE6uGTQe4nn1HOWyTJe67r/aP1kMI4BI/Hg2n5pdWsAlJSZPS7OaGz+FFBc0/EYQwiUyBJ/9LAFUbRkEFjUprGd5Oumh5c1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3qkXJKn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3qkXJKn"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2429f98d0so23338225ad.2
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775462948; x=1776067748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpWKQRsVyCaZj6hI3lvjcls06PN5HybDlwyeC4uCUJE=;
        b=j3qkXJKnAbjC26YtbkUPEysEyKSZslNNyGOBEdvmlohcUhJDLuVqM/7EqmOX9IWplb
         C1T6KKJTf9RZOmKf0FL+CF97POI8po0DiGy7J/i8JTqhuKGZPgPwLAxkmlsS4AGcJq3g
         /0aGNLVqpCBxuac0J9jpFf89FBtLimIxiTG2dCRXp+ReoDRhVpfFdfhYuch6MULrT7fo
         yNNk6QMyJy2gGNxFtDCvsmR6eyvvO4S6BeAlridTWFCp3cSGN1aCr0GlRZUyTr6Fw80f
         R2dX/8e/sUrg+NTiWhyOJMqHVbfA458AQWwBs5de4RnES2eUNWQsObXYbJCIqBF8OuEh
         HGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775462948; x=1776067748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hpWKQRsVyCaZj6hI3lvjcls06PN5HybDlwyeC4uCUJE=;
        b=d2R49mMzrusD+I60KqPfer7YRKNH9B81HTr++THxf/dmV386c2PwHyegwaOpp4jXeX
         cREbXTqVHsaiX4aPKZBj36INxJ9zTZWzgv0qQpmhpsd9yYAW4G/wbLdMBQqSRh/WRHRy
         jAJJxsM4oBnUThdZC9+KZ5LX9R3R7nkCOiL8z2imB8hVuEbi7XrzPju0LXCgcGqaB8lU
         FCmaiDGUaO3bKp80k+IDVLfpmAZvOlQGbnaf/n6My67E1vlNjnpd8GX/l4XsFKK+bOuU
         mgwGn7MoDbIGZznPYKmI7BHLwXgTg8mGh9Jm9nsB/2m8vASaef8LeC8ZzoSYRtNXpo4y
         vyCA==
X-Forwarded-Encrypted: i=1; AJvYcCU/2pdV4YyFpxj00zwtPNKJY5JtsFPjADdMfDOUn54pNuQEEr1/8VWNv6LLyNQ+COKKlifde7CC3Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAyFAJ1NperroOpUyEB5nL9jNmH31LL31VzCF6hTydUmM2GVr
	YNmswVjjOkxhbZ6WrUItux4Bc/X5Rd2lu4IU6OlDCxLy5zOKZuD1uTGO
X-Gm-Gg: AeBDieu/B3gDzqe0cR+DUUWB+mAHwfYCFaoUi73RWgJnEvbVJ8hRnwjCuSKt6f5lLpw
	MwML1ATgBJB1w+mBWsKEqcIFvPzgVVXRKhBp4W37ochMIsDU8ncpKWa17RxPiwIailKUuegMch9
	4VQwUv+09k7nOeT0XsuTEKlSPtA6XoVhnQYECTuSlWSlLLaP3u4JTDGlW0OTiyhjJbkul+x1G/Z
	I+D+egiowEdC3PNudC2faEgNTV/nTnTlIhcwjr+JN8YDxHgRym3rcWI9uohov4A8FacMCGWt2e5
	lGvFPed1LG9KNEgjgGMMo56ZX1XaE9c5YnukZipLIk/HkqjeErwaD6O7MYRKjHX8eNrznpRMhHN
	NDUxz7C3whYbfQ/qkoLIDvEeyXOuJvXFi/qsn3shGuXW7THuVWJheP1RS8EwG6FyaFRKg2d54nQ
	ukaHuTe5dRmOCRk6ExZWfdW+5qdFiSosSiJtp6V1KZg9zBfHhG
X-Received: by 2002:a17:903:3b8f:b0:2ae:cb0e:fd59 with SMTP id d9443c01a7336-2b28164cfebmr125528785ad.8.1775462947787;
        Mon, 06 Apr 2026 01:09:07 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af19sm127961835ad.50.2026.04.06.01.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 01:09:07 -0700 (PDT)
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
Subject: [PATCH v5 3/5] iio: ssp_sensors: factor out pending list add/remove helpers
Date: Mon,  6 Apr 2026 13:38:50 +0530
Message-Id: <20260406080852.2727453-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406080852.2727453-1-sanjayembedded@gmail.com>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The SSP SPI transfer path manipulates the pending message list in
multiple places, each time open-coding the same locking and list
operations.

Re-factor the pending list add and delete logic into small helper
functions to avoid duplication and simplify transfer flow to follow.

No functional change intended.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 34 +++++++++++++++---------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 08ed92859be0..7c1780e15acf 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -174,6 +174,22 @@ static int ssp_check_lines(struct ssp_data *data, bool state)
 	return 0;
 }
 
+static inline void ssp_pending_add(struct ssp_data *data,
+				   struct ssp_msg *msg)
+{
+	mutex_lock(&data->pending_lock);
+	list_add_tail(&msg->list, &data->pending_list);
+	mutex_unlock(&data->pending_lock);
+}
+
+static inline void ssp_pending_del(struct ssp_data *data,
+				   struct ssp_msg *msg)
+{
+	mutex_lock(&data->pending_lock);
+	list_del(&msg->list);
+	mutex_unlock(&data->pending_lock);
+}
+
 static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 			   struct completion *done, int timeout)
 {
@@ -202,19 +218,13 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 		goto _error_locked;
 	}
 
-	if (!use_no_irq) {
-		mutex_lock(&data->pending_lock);
-		list_add_tail(&msg->list, &data->pending_list);
-		mutex_unlock(&data->pending_lock);
-	}
+	if (!use_no_irq)
+		ssp_pending_add(data, msg);
 
 	status = ssp_check_lines(data, true);
 	if (status < 0) {
-		if (!use_no_irq) {
-			mutex_lock(&data->pending_lock);
-			list_del(&msg->list);
-			mutex_unlock(&data->pending_lock);
-		}
+		if (!use_no_irq)
+			ssp_pending_del(data, msg);
 		goto _error_locked;
 	}
 
@@ -224,9 +234,7 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 		if (wait_for_completion_timeout(done,
 						msecs_to_jiffies(timeout)) ==
 		    0) {
-			mutex_lock(&data->pending_lock);
-			list_del(&msg->list);
-			mutex_unlock(&data->pending_lock);
+			ssp_pending_del(data, msg);
 
 			data->timeout_cnt++;
 			return -ETIMEDOUT;
-- 
2.34.1

