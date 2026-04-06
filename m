Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1830AD0C
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462946; cv=none; b=DuIzkEcaogLDTeofjwE3TUUWFn0Op5O9FMpdQNECGrDQaeEPMVq3GNx0SOrtCOZMws1/+Kz/dUvR71uT1joPnJmRGXamqHIQiM1b2GqpHy+CNE2rBmnoAR3OGl2QFtYzhS0N+nNk3U44xN329ylLb4mhOQIpxyBem8YOkLGyjVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462946; c=relaxed/simple;
	bh=IrfAI15OeYSzF7o8VJ7lq6QuUQJ761yxN1y3FeGgJ6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PePgsOpcq0srz1HHSK7f753KGV6diu00TrMlBHYSQiLW5Z8J9M3RTcgIXEZooHTVaePLYUD/+QjT8THZB29w8aYCAymPoMnelqyIJWQ2RuxtR/S152vfW4s8VtpVLzylZEDI7lxtFAJ6TdT4m+LHWjlT5euzABlkHy2BBDm3xaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OK3ympHU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK3ympHU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2adff872068so16152295ad.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 01:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775462945; x=1776067745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWDKafWykqmCst/+PGgYmIJsGhpBN8tnTlfr4qxhHLk=;
        b=OK3ympHUf9UZlzVGFjUoVAsjM5Uk7vmb7KZ8dqXPP8pTcxtQQmbEGNSYs5RVpJoUF1
         mFGXONhWnvjIbxZH747WprioR7c8N4q0VHZFbIpOJRoOOVdjaef9TvrqP+WxNJA/2rgH
         oZ83lyJNGBZESF6NjhSlwldhfEsGnqZqrgRVw7QUvepQ6RVmvJISjoE4zWOD0UbsfXId
         KM0I2pRuHnO0n3NwHsyEvf7qSzO8jnJIoxydC7fwstrVGBjL8rkFDcYE6/tS2YlNL48H
         Ecg3TtL4aN9sAmq8Cq+FHsRZDZOJC5zDfNLN+7lGhWG/EKBz6YSONL38uzj/fGSA24Jz
         GA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775462945; x=1776067745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWDKafWykqmCst/+PGgYmIJsGhpBN8tnTlfr4qxhHLk=;
        b=HoVLs0J2t+BEzcPDZQg1Z2djl7IG9V05fI1wbysFXUqEPuatogjkJkshzsvzzd9F9c
         MLtylR4+9upA14cJVNt/NhzjPD/mEbjDtAvoNWtpkcWbZjVzMUDm5YuvYMqhkNAR6+fq
         Crd/2tURgcaIOLdZeIJChXNCbUGcFhhCE8fWgC9Cq05tpiIPDiy8+SN0lzIr6PxtRXV8
         E/i01aEmglf9ALDF3vYwToaBGu2yoWPA7XR9r3mu4SKA7JSSXovnd2M6EQt0DV/Ml6YH
         xDCctz25WPQ00oaM5DuF6MVVEgsCa281layTMD8s7l8xzTTq6s/vH5RtF8pqHkcDhVAD
         Qliw==
X-Forwarded-Encrypted: i=1; AJvYcCWbJp7i9M0vV15UGTNXNZrNVYNVNGm7YxNZUL09l6vL5aoki+uKY5VSDrWiLdQkkMwkqNwPijwRwVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhNSOwGJmwCODntAAsQbvAJgVkeq05R6RtsbXGpZe7afKuK3z
	gTHNjoAnITkqmQiipmTNsWdKThnIfn5aWWBZ6mIK78qT0r+sJwLAkT2X
X-Gm-Gg: AeBDietgR2pcy+5p1DF3RYcN4UWdei7Nmc2DexljSjIgtebZqp+cFLh+BT0W9UDdu8a
	kfkTHQyqersuhbfEJ8dhv/kJBSO223jfPyVtUhByw9l0nccJusQAzXCzCSxXqHXazk998qmSlof
	kjulPJznVP7lMbbZWn4h/oX28jrezHPY+A3rBdnx9l0SNV+tb7HrI57VTAtUBdppvmPX/YUaGSf
	NX5FOjVPojadjrYG1V3llNWPCnj/qtjdU/z04TSA24wxYrFrUDYPmZ3xD319OE7NlFLO7R7ZAXT
	d4ww//kn8Vm7/wOm2AoLGPJt23IpjcztEjcUctOlQQLzWJZYOLjzOtLUdAWATSVU0Q5KbB9MZkr
	lfeOtYhMUFPmZKlGCPpJRX+GGTtRfyemvWWj20j/GarhmA+VGESvXrRm/70n82ThtyZ2fIHWzLB
	MUpbh3B7LM2+VCoBjGASgFmACpNQMtT91eAri9cGCLA2lhs9QU
X-Received: by 2002:a17:903:32ca:b0:2b2:501c:bb8 with SMTP id d9443c01a7336-2b2818de2f2mr118441625ad.38.1775462944612;
        Mon, 06 Apr 2026 01:09:04 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af19sm127961835ad.50.2026.04.06.01.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 01:09:04 -0700 (PDT)
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
Subject: [PATCH v5 2/5] iio: ssp_sensors: cleanup codestyle check
Date: Mon,  6 Apr 2026 13:38:49 +0530
Message-Id: <20260406080852.2727453-3-sanjayembedded@gmail.com>
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

Reported by checkpatch:
FILE: drivers/iio/common/ssp_sensors/ssp_spi.c

CHECK: Macro argument '...' may be better as '(...)'
to avoid precedence issues

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 8c1e15d61db7..08ed92859be0 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -6,7 +6,7 @@
 #include "ssp.h"
 
 #define SSP_DEV (&data->spi->dev)
-#define SSP_GET_MESSAGE_TYPE(data) (data & (3 << SSP_RW))
+#define SSP_GET_MESSAGE_TYPE(data) ((data) & (3 << SSP_RW))
 
 /*
  * SSP -> AP Instruction
@@ -119,9 +119,9 @@ static inline void ssp_get_buffer(struct ssp_msg *m, unsigned int offset,
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

