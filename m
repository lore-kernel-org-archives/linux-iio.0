Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0C3CF026
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087763; cv=none; b=QCmXLujd6bWdwCZQ7K2Ua/OjgqVHMRFnU4YMj0pAhmxGCEjbCxTdcK+r02WNX/ISY/y0Cr0un4tWf0gyzFIO3jjxSNFT7VDvfVnQ72TtX/jAahbDix2DThNNlxyBSufx2iOQi3BcmbnGPVB5wTCyOZzrlXJDauJ8VkqEpJj5rCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087763; c=relaxed/simple;
	bh=V018UC6RvQnzOr67j00yt8ULcwHH1vT54eBatzKYdZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sEE0SgawpIzVw7tN5p7NA4/bm+09MHd+RX+Hu3DHOQyKmxkV8XmVI34m5p+GVunNRWDtP/PNh/io2vWGPqZe/pcQM2gZCpjLSKXEbZ+3TRdJLL6+E19nSd4N+u3oS3SApf1l3SCRd3MuPQw/cswDXbOQ0SkG1ik7314oCHLYuu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCCrHEiL; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCCrHEiL"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35691a231a7so2883418a91.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087758; x=1776692558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ett37kiQwChYDjE13kndETMDntDtdyneUpYaCss1fOs=;
        b=MCCrHEiLyV+L1em1HbZclvPwuK8yS/NkdWgtOoWBtBZHr9vt+YQc3Ku9KNhIafLSUB
         hKvSd5RxiL9DdXljSQ0cq+esnOQv1JawMBZZvLmOKptM2RD76+Oz7B/HmEJ3QXogkufX
         nkgtCpbF6n9x+2/oa1frpoYez91I0Oha3k6QSlV7jtLwCiNAKqJzbH+KtxXc4tXtf5YO
         LDFbaj7lf4tu09AsegVwR9Sdkc6HaJ6FV5cDd2hCJ17c0eiNf9AMD81SPGyI9ZQj3ahf
         MumQfR/qR7G1k3EjpJ6EM4qCyLEyCZkvEr6Y1JMBKS5Ev9VfeA9ADymoovBHQ8t6rzHH
         hGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087758; x=1776692558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ett37kiQwChYDjE13kndETMDntDtdyneUpYaCss1fOs=;
        b=R9xSqPPCFgZmwsgOOAIsdomjNDH88qDo9mVRmnkeSHzd+rpBY3rTtuP43f+8g7Ervv
         3BHipt3ILnjSJtGJU/FaflmyIq5EK7vKNe5DMSiMiRMtSjzdYtjhiNtTuVjROgzKn8dD
         eN2uXIPGNRcDagIeYtw9jFFZshSgAao+ZPhSbQmqjPNcDb38Ix0EzbZsaJFtR4AR3zB8
         JHbOS6Ln1EKSh32OPudEx8vK3pqBlAizLSofugNQYHdwEm7wV4E//Am4gQyr3ejlSt32
         +Gw5SInJRxUpOwVUmqf6bHI0paU7yFNEJXIau8ygoHse5YBnUHPmoQPLUzHryDom9nxe
         KXuA==
X-Forwarded-Encrypted: i=1; AFNElJ/t+VpsGU1L5BcaD+Tqpvw2oAwDMbMz45L+MCseruYdAyxyfyUTU/fbU86n+ixxtHT+0eeCUtDmuOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz48iLQ+Fdsv2QF+ClQZLKQ1Iz8pxo4GhMmuRYGWVfb997BRq/0
	bUmobhzOcBwRYgqi9zcBJw5Q1titHElA3RKf5HxcGAio3Lj3JYFYXi6X
X-Gm-Gg: AeBDievko8W07qdwtZ34I8yc+A76QuRjCIrgnv2K1ERw0GZYoL16+x37iYEig2NHDLS
	TEf6NQ7LNpf+oymMREvFT0ShqsMKioSsVFUhgJDOgUi2958GEcyLxDJfs3lSdFdEaVK4XBr49Y0
	fw1hHZ6X5vbQJ4mm4uhNHb3J7fbXkfaXUtucCwnX+93WsKaYx/HXnr+XJVeKk0mNV8eqxxGQQ16
	a4rxXTJ3tBJjFSQqeF/7Vf3CwLvUGrqCBG2Ys/GtS2Gt4O0Fer872Ckj/Jb3gfT9NSFT1MoJibB
	1kiKnr2WpNEeqb8la3acgIOzvHjP69eZ1w5F5U2KmcfOiRgZcTpYy96X8hYbsCGt0/EahPQueJd
	3eYLZLMoA5nlPXa5lQFGyexpFjvnsW+JkGBD7HW5YD6VRFZMX7wjPHtEDB91eWWcnMnF41wYgyT
	bFCWH8saPKCyS4wfN97EugQgJAYKrJG6uHeKKzupiB2PMEhcR9
X-Received: by 2002:a17:90b:17c4:b0:35d:9c43:57fe with SMTP id 98e67ed59e1d1-35e4280cc70mr13693688a91.13.1776087758466;
        Mon, 13 Apr 2026 06:42:38 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fb0dbd953sm1832186a91.12.2026.04.13.06.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:42:38 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: adc: ad7173: cleanup codestyle check and spell correct
Date: Mon, 13 Apr 2026 19:12:23 +0530
Message-Id: <20260413134223.2331911-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413134223.2331911-1-sanjayembedded@gmail.com>
References: <20260413134223.2331911-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/adc/ad7173.c

CHECK: Avoid CamelCase: <AD7173_TEMP_SENSIIVITY_uV_per_C>

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/adc/ad7173.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index b9c563947e2e..2bb12dddc532 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -137,7 +137,7 @@
 #define AD7173_SETUP_REF_SEL_EXT_REF2	0x1
 #define AD7173_SETUP_REF_SEL_EXT_REF	0x0
 #define AD7173_VOLTAGE_INT_REF_uV	2500000
-#define AD7173_TEMP_SENSIIVITY_uV_per_C	477
+#define AD7173_TEMP_SENSITIVITY_UV_PER_C	477
 #define AD7177_ODR_START_VALUE		0x07
 #define AD4111_SHUNT_RESISTOR_OHM	50
 #define AD4111_DIVIDER_RATIO		10
@@ -1275,7 +1275,7 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_TEMP:
 			temp = AD7173_VOLTAGE_INT_REF_uV * MILLI;
-			temp /= AD7173_TEMP_SENSIIVITY_uV_per_C;
+			temp /= AD7173_TEMP_SENSITIVITY_UV_PER_C;
 			*val = temp;
 			*val2 = chan->scan_type.realbits;
 			return IIO_VAL_FRACTIONAL_LOG2;
@@ -1300,7 +1300,7 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 		case IIO_TEMP:
 			/* 0 Kelvin -> raw sample */
 			temp   = -ABSOLUTE_ZERO_MILLICELSIUS;
-			temp  *= AD7173_TEMP_SENSIIVITY_uV_per_C;
+			temp  *= AD7173_TEMP_SENSITIVITY_UV_PER_C;
 			temp <<= chan->scan_type.realbits;
 			temp   = DIV_U64_ROUND_CLOSEST(temp,
 						       AD7173_VOLTAGE_INT_REF_uV *
-- 
2.34.1

