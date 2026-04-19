Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9232BE621
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776620317; cv=none; b=pmaf5yDhgNaDYK2emMD1y21vb/7dBC3246MZ84w68NaNmoCEjEq2pOxWBagITyfgtzrefclL+5ijIPQrfJjD4Z3m5fVZrJEi58EtL9J7DbhkzLx9iLmXbrQm50kJD903fw/EEi7eKFrpK/mA5NNDTj1RUL8zMbd8LThA2RIgisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776620317; c=relaxed/simple;
	bh=M4mfZCn7gG9R+iPUYZohSjdnClSIA2jYN+n//g0oTKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2RIBjHHh/6gC37sV9EfTSf8c4TvFXqvcoSZkhE8WjY67Z0geBBHuRrcwo9DoxbejNDgai+0rOy9oBZVbcwbqZSGFo3+cCUVeE2a0/ImXMKL3GaWCxKFk6XN4ZC4vAbCKBHzs2XfGnAQ3/sM5q6unHjTk1HajYKjk4XX07jD030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpZ0Gb14; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpZ0Gb14"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f69a286dbso1789877b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776620315; x=1777225115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6njRl5ekiKUvWfvYHnr1mDhPwUIgo7rYzrXqRJ2Lqo=;
        b=NpZ0Gb14S71vDjSTZQThq8Ou/ocC+K7mId9vnZ+CJcLY0hC1dngiJSreMuTZMog8Ld
         gfp5Ju46O7jN1jH2Ax2edWvUgKcd1Vt5cKhMZ85KWg4Nf6XEXsRq+RuAXF4TmvF8YUuZ
         Q1R4MA1L3bHPV9dSV8+GqNy81sK0DPfcung1ig3y39rPg8b6vsn62WkVWFrIKm+rB6bw
         kFjbZWE/0BxsBP9ZHOGKXdHgqFnVopa1jkNdXkerk3A0aOV5b6jzgzegDchSJ1L37w98
         BV9PWHHgF13wWNJuMk4C75A8/YID4F1cRYf0CyjULQhxA6YS6r6VANzaPy0rohDuY7N2
         FsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776620315; x=1777225115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b6njRl5ekiKUvWfvYHnr1mDhPwUIgo7rYzrXqRJ2Lqo=;
        b=etTLDeb7bZ+Uox2pxC6SNiAhCOCRhXnSa1f62W8LeG0XOmIS01LbTDo3m2Yt2IYeCb
         FQyMtqrihBtx9f7rJcslGB7FXVi9S91gjs4tz714Lv9MsnKpS/0cOEQblBfJByaekILo
         0/fkj2Kb/A2Oq5je6A+8OKVa6TjkgAbWoyzPzAT3Qh9Vq7VFlH+ilQeX5hBi0D9hoH2S
         N+G7G0gW6nsUxlI0q75y2FQ74PAVFtfEQZkRgbe1x6zQ059L94ljM7RuR/iimyIAaKAg
         96/6ZqTHmVM/NhZT//fAcPTcu9/qV3aHq2tGMASuVYBbYFLPzEFYigcfy4WfrWt35kaK
         yj4g==
X-Gm-Message-State: AOJu0Yx8z0yStipNP6EQ3L5fTmDmibq4jl7uojeB8L+mJFrJNDpAv5yE
	hTG4L0O58fDdMiSKWjWgXWt4PoEW2jgwwLhgACblxHDnt6t/Sy9kBwUS
X-Gm-Gg: AeBDievcQM7CQ0VHVR82pneCwxa91ANiOmzNLYlMQOkZLsw+aE4VtRRxOZjj+HDgkO5
	uYKiwm8C8H3nPViDpH02g/9pdLSB0SEwlUeV3CjfBSQAM4RpWDHzwyhvH1ZaqqD/khn7ojOpOMT
	vsmAkSpJ7NrNZlHskJ7ZMK+xaC6NdKBiG94Fo+OJTG/AnDcMIWUuGa+ynE2IFEF/q2J5MhqMi8+
	tXZ/oVqoeJfsH87HtUq5umpGFGUuAAmAv0xEDDqsjFnUDKCdB34b8z7jG2UXw2IDNojXCcuV7xd
	xNO2wgk7Zy2S/aZAshqa2xdmVwK1e7zZZiHAUqZKSpnycW1s1+MqNGZlC8cJEZ+yx2yYheZ1pwt
	Pe1gHd2Woef6rbKi2xLVRCOXkyzGlNsFOG7EB2Fc0JD6dLccTMLHav41+d+2h9SjrzxESYmxTNk
	+9cvFdbVEWtUXqM0vv0TVVn6MH25DXu0JTvugzvY/XbKBRSVrE8FCLECTukWM=
X-Received: by 2002:a05:6a21:e081:b0:399:196:1430 with SMTP id adf61e73a8af0-3a08d74fc7cmr10070886637.20.1776620315278;
        Sun, 19 Apr 2026 10:38:35 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703059fsm6051069a12.24.2026.04.19.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 10:38:34 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org,
	demonsingur@gmail.co,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: Update maintainer for iio driver(s)
Date: Sun, 19 Apr 2026 23:08:30 +0530
Message-Id: <20260419173830.2802263-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260419122338.29911625@jic23-huawei>
References: <20260419122338.29911625@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The listed maintainer analog domain email for Cosmin Tanislav is no
longer valid, and he would no longer maintain this driver(s).

Cosmin suggested adding Nuno from Analog Devices for further handling
this driver(s). Add Nuno as maintainer.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c981cbdff500..f86a398d1a35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c.c
 F:	drivers/iio/accel/adxl355_spi.c
 
 ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1461,7 +1461,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
 F:	drivers/iio/adc/ad4080.c
 
 ANALOG DEVICES INC AD4130 DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1549,7 +1549,7 @@ F:	Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
 F:	drivers/iio/dac/ad7293.c
 
 ANALOG DEVICES INC AD74115 DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1557,7 +1557,7 @@ F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
 F:	drivers/iio/addac/ad74115.c
 
 ANALOG DEVICES INC AD74413R DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
-- 
2.34.1

