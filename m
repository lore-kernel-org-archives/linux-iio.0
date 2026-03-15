Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55A3612D7
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773579326; cv=none; b=MbhQHaRoBevrTTB6GaCg3bblNkAbfSEu+leBbvTQnoEOqfZT/b6jwcvyZXZkGxyNrtaUQT9Rfzb91MdQ+Yq1VsRX/2hRN4zt3oQGef4cOgXikpI5dqEsPlZwX9ClXeOz2FTgQjA1lmflZXwl9E0+dW/iqY/VsCFx/GZtZlWt5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773579326; c=relaxed/simple;
	bh=K4N10Qq1mjbRUweIr+G8jDzUZCjkS4GakESqPiIk4Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsVgOLmj73acd7LJVQSIQ68MB94N0Hg5EpQCI7dMn8h1LVt9LgEt/TexDZpvxR0wYb9jLzBVtvOv5m8J0KHkxA+PG4j3zJxX5zDQPS3s5c+1J8ylA4+BLGYbApQt7Tk0o/+EHnoYCGxbSkpqVSR4qmBFofW3OKwAX5BE5ucQIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAf3L0Lq; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAf3L0Lq"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c73f107789cso338921a12.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773579325; x=1774184125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCJUzv9jhddUmc/S9aCxqgSkfPPiNhG3doSB3b0Nsfk=;
        b=TAf3L0LqwW2vUSbka4heJGq8ha4ibB7Kbzp/CNCybNuXzuXPRUB3WQiqIwmwcrLWK2
         Nv5LaVwD8TK0XWut2JgbHuAG5RgvEzTnR4eiqNVQljswy6mOLYQAB9iJ4nA6l0MYsbHg
         O6iS8AVzWo+vDpjfKPQILzeLQUGcZwNj6nGsjZYPT7cDXSKVWFukJKlBRDx45eIzsUKH
         9juxkWPbx24jKk8YHeTEDtGQHjZ2OuWpInaw0dDtHXL/AFklVBLCNwJWFZ+VFoI1pjgK
         6bFIaOWHJKSjHgQ57e3NuVmNJj38KgMfRbAQA1QRekCoN3HgJgte3Vo/j+VMKFLfA80g
         UBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773579325; x=1774184125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hCJUzv9jhddUmc/S9aCxqgSkfPPiNhG3doSB3b0Nsfk=;
        b=eOLORUyo2n0m82H/QHDNqq47YIdaSbEYi7X3Z1Obq5dNojuoxWRtqoZfFqqreU8NaY
         AT2BEN7wYpB9t1lLcY8HEK9F9RC0RTMJYxXLyYvDOJfBYrGKJMRxVNFRnrlr+ea7F9Dn
         aBd6lNdoFJyTxSMYp3KlGvBD36M2rsAyYu1oo09V8LGv9tfEdifQVLf/ZTrAE6GSbS0B
         cWLPTL+pnZxt1Pbc5CZBJEwvyByfcdti12bJLu7diorGkYgaiVt2n9wzjrE2WRFonHRF
         zbJM2bXIizkTszl8HIr6eH3omSNdfDTJBHeAb2wnYGbMj2e0ydPNaDsc4XwhL7u+dHR0
         5POA==
X-Forwarded-Encrypted: i=1; AJvYcCVGPzVxtb/nVErpMmrumDT8hHafqO59g6FBvapC+sptcyqqRuHAeP9suMMeXfdY6d8N0ScLlw7xLrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3l8/M6ejaKiWK26gSu2EgK7TweaZyPcAi+0jcYQkFqwK+ygO
	Cv2Z0141KOaGLYhNtbCBrGT5vu/itz6XMCGfmNyNuvwNVbGAy9zpsvKm
X-Gm-Gg: ATEYQzzJnrHp4iANs8/GxUwTyFTR+bsUqna5OFQ3kFsp1RT/V+mvoBj+ux7joJtA2yr
	a23N3RDiRgOpsk4T7Ep24Xn2offv7eHHcg4Y2AxT3neZbUFjqgBjw+iNKjsrb8MJhhHssqP2AvW
	6NixtqQ0VZtmL/MxLGjdb3lhCWGgmZn+jE5NER6NXJ8sV/vgIekwXoWrC9s+EF5MkpU42ahbi8E
	HyCR+4ZGKyu3Pok4RJAACZKF0AQjKxA06+zl54FT7eqvsZrcsQzDzKyMp+7Igt1Zb/3fpuxyX3d
	HUU+c+Phu/R6ouxnawsYIGIyB9zuE/3XlXaTuLctR4CcJn6Bn7yf56E9lg9e44U6BhkVT92mEIm
	3O2CvDMynZIFJIfrl0TZu36FVj262pZcYGtkMNW7ZkHIkTKb3ktft51m6CVplHxreiqNKW7y5Sj
	5B5TVRwEs7KRiUukIeVd19Ltgkwpa8juwRkzU33mTL1zmGpssq
X-Received: by 2002:a17:903:240b:b0:2ae:4fc8:3f59 with SMTP id d9443c01a7336-2aecac9d416mr101003085ad.49.1773579324696;
        Sun, 15 Mar 2026 05:55:24 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece594b4fsm72931565ad.20.2026.03.15.05.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 05:55:24 -0700 (PDT)
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
Subject: [PATCH v3 3/3] iio: ssp_sensors: cleanup codestyle warning
Date: Sun, 15 Mar 2026 18:25:09 +0530
Message-Id: <20260315125509.857195-4-sanjayembedded@gmail.com>
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

Reported by checkpatch:
FILE: drivers/iio/common/ssp_sensors/ssp_spi.c

WARNING: Prefer __packed over __attribute__((__packed__))
+} __attribute__((__packed__));

CHECK: Macro argument '...' may be better as '(...)'
to avoid precedence issues

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 9df94bd02e3a..8a52bfb0e39c 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -7,7 +7,7 @@
 #include "ssp.h"
 
 #define SSP_DEV (&data->spi->dev)
-#define SSP_GET_MESSAGE_TYPE(data) (data & (3 << SSP_RW))
+#define SSP_GET_MESSAGE_TYPE(data) ((data) & (3 << SSP_RW))
 
 /*
  * SSP -> AP Instruction
@@ -30,7 +30,7 @@ struct ssp_msg_header {
 	__le16 length;
 	__le16 options;
 	__le32 data;
-} __attribute__((__packed__));
+} __packed;
 
 struct ssp_msg {
 	u16 length;
@@ -120,9 +120,9 @@ static inline void ssp_get_buffer(struct ssp_msg *m, unsigned int offset,
 }
 
 #define SSP_GET_BUFFER_AT_INDEX(m, index) \
-	(m->buffer[SSP_HEADER_SIZE_ALIGNED + index])
+	((m)->buffer[SSP_HEADER_SIZE_ALIGNED + (index)])
 #define SSP_SET_BUFFER_AT_INDEX(m, index, val) \
-	(m->buffer[SSP_HEADER_SIZE_ALIGNED + index] = val)
+	((m)->buffer[SSP_HEADER_SIZE_ALIGNED + (index)] = val)
 
 static void ssp_clean_msg(struct ssp_msg *m)
 {
-- 
2.34.1

