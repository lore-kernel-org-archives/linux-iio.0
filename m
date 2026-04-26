Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A0A2ED154
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195058; cv=none; b=QLJode7xfeh+sCu8JVc409OjLip4pM/q//h+iiKXY9HKw7lZN3RBV/s7ToLiwlkMoBiK1c30LQ9bTkVXb+V3x/IgvEeY5S4aWrbDd+ddbfH29C17MLdzweCg4xexDHEpJe7FPK72/lBGIDcIF+3indAe6d/vqktgyLaMPU69KWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195058; c=relaxed/simple;
	bh=HYFO3q2SHnIUuJR4G1fUpiIKbR8QehUSCeo3bEHEw4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JzNypO8bcbrOwirVLZgn33N6qPRYnjHD1YDjhnNW2MICXUDbsUJ2E9e4EashRZC0PF8N2q502qjUNi72Omy5PXH7yXDljhR7fyBIy0CYmR9t3Yjlj60fGr82lzWN7CvT/SQayq+EXnBl7VYEpjSQ8ZnHkukqwKexlezQ6Ss1zVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoClfhvm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoClfhvm"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f351ca23cso4698361b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 02:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777195056; x=1777799856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPVUT9kkozPdUSfyhgYJgQvI4BlLLR/1iVKaOJX4Zfg=;
        b=aoClfhvmflMAQW8tYFVjYVKHVT1rjDzXW4RjHloZXZx6erOgDJTSryVrFYYsbvCdbz
         VarKTJgFb027aG3j89oHgO1bSuD8sCC+q9TVpCXmSJuzWyGdgiB3Q9DsIrbxDZxjiJ1T
         Vzlu7/cYklMxTXPTPKcHh6VMhfUd9YSrU9DP63BCdZQRaUtwc7K90g4svaYNm/NPczXF
         HAphkEMIXxcJcPpCCt6Jf+KKqmElugmILUEIuslPoD1sYLakvTFSeawCB0wvOvIEbdlF
         Avkmszeka38/+bxJ3CPC7wJ//rNRPhBlPTlqq1kSMTABrtb1ma5xTK6wl1K15JjOVW18
         0ZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195056; x=1777799856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HPVUT9kkozPdUSfyhgYJgQvI4BlLLR/1iVKaOJX4Zfg=;
        b=NByEN1t7MBgtxAKZZc3p2rcRClZtXx4Sfsjb7rpaslz6m1EN8sOLC/y9e4/KsZDum+
         LQSpcMpDb7+G/VnOvZ4Sc76dvzfOwRyfgtwlsDLDOb6rX2du+Olgc38eBoiDnW6dHrYC
         Yk21sV2/hWpA9VoJptAyvJlCMFgMNJ3CYUyqgN0hyJ48OG+SWCt/4LTwfAhN0JNIYMSC
         ae8VYWegmyk9MV98VjIHYK4hQUBgFu1HL7V4XRkWbQQou3/cq4eF+5o/fmP9OEkBEh45
         5llKnNQBJjLFJHwRgwSTQhhgWe1BYnBHIsp8Q3o8GNsgzx5puzh5a+hPU4OsbAuqC8vk
         HZrw==
X-Forwarded-Encrypted: i=1; AFNElJ+Aw832Jw4JgBhZJjucl8IVwg7ODsh1UCoyX97QVINakUWmRnN/kwGX0bLZbnQAsAdfXi63i/z+3TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH48/ExgYS0/QqimrQgwpZ88/rhqE/cURjKuIch/33N6LUjJU7
	YJEIrE1IpxwgL7jMW9m94jSawGYUkPolX8Elouv/D0I37xO8CgkmZ4VN
X-Gm-Gg: AeBDiett5U0aw0DM4Mivi0UfHENTzVcfMclR2tKg0flnvJaIa8QyMRwYu4GdXTIITp7
	NnqMdePPbnivV4IWxlqb+MsgokdADyuEl6yG2RBvplq1zknWNfo/ovYinlDZo/1FMtkjnq+Odvx
	NXcdH7jijMuy7bdj2UCJXtoR88MzlMUN0/uFGF17QyWApzDTPCdLjKHH9m5NQ4VZEEI9+Z/Os6q
	KKwSEU7ACy6WjGmoTDSuRxnjfMhEUzG4d8HzBNUJJRn2RSoG3wNMJkD91muTVkkPB7tkm6NUhDT
	W5tHcL0qdP5Pef7mQS8WNJk4E7TrjbXdjj/j+V5QGgQBbnoKcldjedurlccq+1DckSUGkx/jF7q
	YFE8KBKAjoJYrmkZTAEMPQpsqKJJTw4FnNW7T3NEZXc+BNT02F6V/kvP/F+g2Xg3gaaSJf/NKBJ
	bo2tAQqB8IpQcbMUzmLcZG8wGKXjaCeyv9QTATOSCseQPPGXlbgd0DSrO1YjM=
X-Received: by 2002:a05:6a00:2d81:b0:82f:24e:6a48 with SMTP id d2e1a72fcca58-82f8c83059dmr41549420b3a.5.1777195056256;
        Sun, 26 Apr 2026 02:17:36 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e982fd3sm36145226b3a.10.2026.04.26.02.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:17:35 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	mingo@kernel.org,
	christophe.jaillet@wanadoo.fr,
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	kyungmin.park@samsung.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/9] iio: ssp_sensors: factor out mcu enable/disable helper(s)
Date: Sun, 26 Apr 2026 14:47:05 +0530
Message-Id: <20260426091710.3722035-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426091710.3722035-1-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Re-factor the enable and disable MCU logic into small helper functions
this simplify transfer flow to follow.

No functional change intended.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 51730dae5871..9b8642193176 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -89,7 +89,7 @@ static void ssp_sync_available_sensors(struct ssp_data *data)
 			"SSP_MSG2SSP_AP_MCU_SET_DUMPMODE failed\n");
 }
 
-static void ssp_enable_mcu(struct ssp_data *data, bool enable)
+static void ssp_set_mcu(struct ssp_data *data, bool enable)
 {
 	dev_info(&data->spi->dev, "current shutdown = %d, old = %d\n", enable,
 		 data->shut_down);
@@ -108,6 +108,16 @@ static void ssp_enable_mcu(struct ssp_data *data, bool enable)
 	}
 }
 
+static inline void ssp_enable_mcu(struct ssp_data *data)
+{
+	ssp_set_mcu(data, true);
+}
+
+static inline void ssp_disable_mcu(struct ssp_data *data)
+{
+	ssp_set_mcu(data, false);
+}
+
 /*
  * This function is the first one which communicates with the mcu so it is
  * possible that the first attempt will fail
@@ -146,10 +156,10 @@ static int ssp_check_fwbl(struct ssp_data *data)
 
 static void ssp_reset_mcu(struct ssp_data *data)
 {
-	ssp_enable_mcu(data, false);
+	ssp_disable_mcu(data);
 	ssp_clean_pending_list(data);
 	ssp_toggle_mcu_reset_gpio(data);
-	ssp_enable_mcu(data, true);
+	ssp_enable_mcu(data);
 }
 
 static void ssp_wdt_work_func(struct work_struct *work)
@@ -584,7 +594,7 @@ static void ssp_remove(struct spi_device *spi)
 		dev_err(&data->spi->dev,
 			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
 
-	ssp_enable_mcu(data, false);
+	ssp_disable_mcu(data);
 	ssp_disable_wdt_timer(data);
 
 	ssp_clean_pending_list(data);
-- 
2.34.1

