Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C0370D5F
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374230; cv=none; b=p3YtHGKAXmtreXRVKDJslmwkAaH2EUHY81jr1QebA3p54MPbt9ZVYbgq7d4b4XuB17EeHncqBBzEJQ4rh+AvqgOAN9Sld399h07Tmw3116u/aY7eQBX/iPVXnKdD+fSv/luU+bl+Mqe6kMNuycmccjTaRnf1hlCASFGkElR6bXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374230; c=relaxed/simple;
	bh=jrQQ8GnLLyFlIpkEBixWwjrWF4yIInytWUnjjZBuoN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VPr25KSvNviCR9C7dTYFlb4jSnZ8CcEKX3V3VCJzO3u15V/2rcaE4q4I6SAsvF6wWGDNOMtAl+KT1PLmfAvv0gSmRTUtwFt6YusUi2sboBF6CL5m4jvBAZnZhKDkYjZZL/dnGRmMVtvd1/rRuGJ2jCMIHYI1dW0MQmKHJGPDTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=f2WitWS8; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="f2WitWS8"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2de831d2b20so4730392eec.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776374227; x=1776979027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrWUHBWPGk7xz7aVqNg/zcaSXhJR2KOUk9wGxT0fGqA=;
        b=f2WitWS8anMPUH46kpzPHp0F1EzhS8GNuf62u2UAugDhnYUKHkoKMhu34IGKc1Iugc
         LSTam4vaMGEKAWV4jCt6LOVBhfw0YHOqThKyymbBYQL4sKB9zyTAQ9T4a8MnxWzqDGjn
         lkUBqmcc7mbMwVqqAr33MW6r3EHo74+u/SYu43ZTgCEJUe5qFTw+F1myRR+WrB1EMaop
         3IItiURQYMpeBTnFnt0Y3uCVI3DskcExtOHC0BQh2dpvnm1i79FMhBuZqKeH9okO1JiO
         bu3SiDFjfzrv5cViRpdkm2D03VSFcYf6P3LEvIKmB+kdWuk98Mn5tLjMCjCb1Sa+dXJz
         LtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776374227; x=1776979027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrWUHBWPGk7xz7aVqNg/zcaSXhJR2KOUk9wGxT0fGqA=;
        b=PYi+RAb5UV8o2HhMcO9NmxrzDk0+Sqe+NrQAH7giVG7pDTvAlBVgk3xesOmZymDfwv
         4br9VyfTPySPSCNm9jOhX8ngXhrVpov8kegOaRVxEC8zgIns9onQST1qRT3ZopY3HVCi
         BP/Kfh47wWMqTKYm0Ap7zluHV7HlRXWi9FUW2LXJomlXu9fvAtLiixTcjPft1LNDM3rE
         zWB3SEBcOgRBnHl0/BRmzJXx/pZs3FOpNT64ngRLksKDauzjNlzEWovLlQOd2W9QAfGK
         U1M1pHklBz/asL35qZEFviFIkQi5fhpQWvoa9jUEPmyuPSSa8iqv+gMfztxPhnT1vO0j
         1BOg==
X-Forwarded-Encrypted: i=1; AFNElJ+10ACmOJudjjMYT2cvg2DFEOXAKZkZUS2Ctei8DQp+PTIoHP8fFcjENZmep+SsYeXERb4vaOlu4Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDtUOGNwaCwK5dyx0beYlmwVu6QYeFrNqCJYsksQvOwCfXQTvB
	jweVy3tmszVIGcBRYgrHWcxg7RbEWM8sxeWf8wXnEuMpVAR51hQktOQqcCPgY/aQte8=
X-Gm-Gg: AeBDievh3xFXqc0QMGMygDMVIhQAjJ6T3wLEjUW3eiXLaRJ4dEMgF1JWtDsnudEM9S6
	G5DhowLdWsPqTCuRvp1Q2vBxOGDTcu4Vks5PwoL9thBZ+9iYiTSqDgGoPLYwbkBkYNuuRjD2wxH
	qVIlsgRQ/4syss/dXDobmiG7sosPP2uB5kuomPs8K4gt3IpIhPSplRRmJ1owLnB5pGy7xarv/Cx
	5fUuOtaNMdBtvmiEpw4MtoGVdyfGnjvssm8DjNDgvzIh1WQb/R7j/c+qc5WgKQaFeVMHtSCfbCr
	MZfUcm/fGyIem3nu3Wosj3fswEn7ihhD5K/mqw8NvyP4c+m5M3md6NQk0enq1D/64BGAL86q+x5
	Rie5Du9bZYc5qj7UYh47baNyh0egHeHEamAsktlFttq/MxglA4SgJPsuRM8FNwjGsKOUOD9Sg0j
	Cc3L0+Acrl69vdedAmlGdMwRi1FhTmSRpqI7jDPOk=
X-Received: by 2002:a05:7300:b58b:b0:2c5:220c:5673 with SMTP id 5a478bee46e88-2e2e348a3cdmr579394eec.5.1776374226711;
        Thu, 16 Apr 2026 14:17:06 -0700 (PDT)
Received: from yukhui.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c90cd7esm11241697eec.13.2026.04.16.14.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 14:17:06 -0700 (PDT)
From: Raffael Raiel Trindade <raffaelraiel@usp.br>
X-Google-Original-From: Raffael Raiel Trindade
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Raffael Raiel Trindade <raffaelraiel@usp.br>,
	Kim Carvalho <kim.ca@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: vcnl4000: use lock guard()
Date: Thu, 16 Apr 2026 18:16:48 -0300
Message-ID: <20260416211651.9625-1-raffaelraiel@usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raffael Raiel Trindade <raffaelraiel@usp.br>

Use guard() for handling mutex lock instead of manually locking and
unlocking. Remove gotos in error handling logic. This prevents forgotten
locks on early exits.

Signed-off-by: Raffael Raiel Trindade <raffaelraiel@usp.br>
Co-developed-by: Kim Carvalho <kim.ca@usp.br>
Signed-off-by: Kim Carvalho <kim.ca@usp.br>
---
 drivers/iio/light/vcnl4000.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 9650dbc41f2b..0201dd1cc957 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -288,11 +289,11 @@ static ssize_t vcnl4000_write_als_enable(struct vcnl4000_data *data, bool en)
 {
 	int ret;
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (en)
 		ret &= ~VCNL4040_ALS_CONF_ALS_SHUTDOWN;
@@ -301,9 +302,6 @@ static ssize_t vcnl4000_write_als_enable(struct vcnl4000_data *data, bool en)
 
 	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, ret);
 
-out:
-	mutex_unlock(&data->vcnl4000_lock);
-
 	return ret;
 }
 
@@ -311,11 +309,11 @@ static ssize_t vcnl4000_write_ps_enable(struct vcnl4000_data *data, bool en)
 {
 	int ret;
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (en)
 		ret &= ~VCNL4040_PS_CONF1_PS_SHUTDOWN;
@@ -324,9 +322,6 @@ static ssize_t vcnl4000_write_ps_enable(struct vcnl4000_data *data, bool en)
 
 	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, ret);
 
-out:
-	mutex_unlock(&data->vcnl4000_lock);
-
 	return ret;
 }
 
@@ -680,19 +675,17 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 
 	data->vcnl4200_ps.sampling_rate = ktime_set(0, val * 60 * NSEC_PER_USEC);
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	regval = (ret & ~VCNL4040_PS_CONF2_PS_IT) |
 	    FIELD_PREP(VCNL4040_PS_CONF2_PS_IT, index);
 	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
 					regval);
 
-out:
-	mutex_unlock(&data->vcnl4000_lock);
 	return ret;
 }
 
@@ -1500,13 +1493,13 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 	u16 val, mask;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	switch (chan->type) {
 	case IIO_LIGHT:
 		ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		mask = VCNL4040_ALS_CONF_INT_EN;
 		if (state)
@@ -1521,7 +1514,7 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 	case IIO_PROXIMITY:
 		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		if (dir == IIO_EV_DIR_RISING)
 			mask = VCNL4040_PS_IF_AWAY;
@@ -1538,9 +1531,6 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 		break;
 	}
 
-out:
-	mutex_unlock(&data->vcnl4000_lock);
-
 	return ret;
 }
 
-- 
2.51.0

