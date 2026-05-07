Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058444E02A
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176306; cv=none; b=HcQYWlZA/zOgvnPemolEbc1/atiq/Vf7VfbwgPE+r1HHbGY1wtgNxJ3FVaF6j6bV9V9n8yFNMEBwP2CwX9cktIz7HE+mxpioAuJpcEwkF6N0/oFxXUqfEP6T0J2Q73Wdhw58XvAE/ffwefdB4BFpSnq4L5c8IB5udyHcDE8zpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176306; c=relaxed/simple;
	bh=yW4n7G6WJ7uMbqLMnXiTrbuf3Psu7XkpbiaNbVO6xRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOx/KJ2wtTFyf5wbKG51TY+9tKD224rYLl4XhRLGDlgi7fYWP5Wo1g+FryBfJWBzNK4gk3uILjjizaOmbkA4FIZDm5ckmvPNiO9C6Tvn2HTywcEHUPHdZnukieYwKImYtEHR/aDUWcvOwM17fYTbjk+B3y7nOJJejL96TXBYjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTiiIlTI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTiiIlTI"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b45cb89f7eso7998205ad.0
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778176305; x=1778781105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep09rOUZ5SxSZfKrq+I8goOMTi0lZjLR4DtPsA7xWO4=;
        b=HTiiIlTIVSeEjq4NKlusxVsnUShZnGdoBZIEqcWa3fNpGKg/sXSOKkIw7cVbu3+SDI
         8wmus1zqApSuSJpzfqj/xp/3iUevtCVTJIoH5/jtWfYnZepWh3oEQRkEdAGXfm/W6iEM
         LgqMFhF43Ov/0f1quSjUjbByO9wz67CbhDBuiXVvI6W2h60x7fOpaMHhiE2hiag8A4CS
         lRBX/fvNj1jzqxJ/EMkCT+nphNZRKh/El2MAdsq7B5TGB1ynXwY9EF8um4+2hIjkVRyK
         m0fzrAVtMC8nhXzZU6lULV33hdCErelN9zD2cX1+dPODfZC4eNa2icdRqF5dA+kTqyKC
         cY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778176305; x=1778781105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ep09rOUZ5SxSZfKrq+I8goOMTi0lZjLR4DtPsA7xWO4=;
        b=OohwnfB9JPDwK13g5jSr2LHS5Bs9XvAxD87my/0MkWCc3g0Zmiyt6d3rMKLqmioE2V
         G5LhKrsnH2mvbgW0KUBVACQETycYFgNFWPk2ZFcWCuAHOveTn6vVwqTUob5dEKPtUJtU
         2I/ozJc9fyzpo8WIYuUluIbPqB8VSBWmexPJ36ET3ocAjibExOzPH7uClTdSnJimFg4r
         Hv6UCKiOjcKSL8JJmen31weODR0+Rt9UhQu+Y+vi738KSku5r8FTpQxns6/5Pn/xMjiM
         4rwwvHypyvzuTgUUGwmXPb6lfwGmbgjk/o6hX0AFsVaDFE8Hh3v3nnAatLgdNF63ANXH
         1yMg==
X-Forwarded-Encrypted: i=1; AFNElJ/pylWm1S3394HBCfnPovK1itU4wGCAjgNpgA4+k8m8M02hAAZc72IFhnsxe3T1ZBRVhzeamaFtZeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAVahN/jMHCm2ajIbhHajJoY0tDEmIZRrPRGfVgYguXUOArU/Q
	gENwfwJCiQCc238KIVM6pWOCG7aQ0fe2AWmYoQGZnW/SCEg99736qU4J
X-Gm-Gg: AeBDieu2ZQZdy4lZzEepI1oXucXPO64U2pzfViBmW0B4oW8YrTYODA3d4AzBezBW6qt
	Noj4swj1hcvdFbotiMzLykFQ4VMaqcDVfOvTUtrlk7LxiKVC8oJmunR2rSPnr2+g2WTgWWjnpsN
	s8Lw3KF0+GO60yAXfloBwJUhYYpncd0lQRZRKnEguW77UCMF86DnU80Dh2ObXHzQ99qPtIc68GV
	H7Gyc+D3CI5q+IYMlomVDOq90r1zQW8LW678kwuAKfpVecteMexuQdA5fU4NI+cSDIJ8hxbWtSB
	mFL1D7+4Y98dKmAJN8IW7BSJm+blRSISFWpLJ5PjKsjvcZIDfdRSahjQ7UwQ+Kjm/F/krkGGipR
	Ah95y47LcUlHvEwBcC1cLnR+CKaWIT4Yj4gV9Kc0t+ZUEM0rCdRvgYKBkivxF61qqLXBBBqS5uk
	7KCQPoes/vgW9n9C4ODgU3HhC3KGArpfnxmbzwPymzujhc44SzDZxbwDTYWe0=
X-Received: by 2002:a17:903:2844:b0:2b7:ca38:975f with SMTP id d9443c01a7336-2ba792877bdmr66140695ad.23.1778176304626;
        Thu, 07 May 2026 10:51:44 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bae7871fabsm3153525ad.71.2026.05.07.10.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:51:44 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	linux-iio@vger.kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] MAINTAINERS: remove unmaintained ADI IIO entries
Date: Thu,  7 May 2026 23:21:32 +0530
Message-Id: <20260507175132.3063161-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507175132.3063161-1-sanjayembedded@gmail.com>
References: <20260507175132.3063161-1-sanjayembedded@gmail.com>
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

Drop affected driver entries that no longer have an active maintainer
or reviewer. The existing "ANALOG DEVICES INC IIO DRIVERS" entry
already covers the corresponding files, so no coverage is lost.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 MAINTAINERS | 35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86b2520d18fc..6f8b61d66f6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -632,14 +632,6 @@ F:	drivers/iio/accel/adxl355_core.c
 F:	drivers/iio/accel/adxl355_i2c.c
 F:	drivers/iio/accel/adxl355_spi.c
 
-ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
-F:	drivers/iio/accel/adxl367*
-
 ADXL371/ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
@@ -1451,15 +1443,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
 F:	drivers/iio/adc/ad4080.c
 
-ANALOG DEVICES INC AD4130 DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
-F:	drivers/iio/adc/ad4130.c
-
 ANALOG DEVICES INC AD4134 DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org
@@ -1556,23 +1539,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
 F:	drivers/iio/dac/ad7293.c
 
-ANALOG DEVICES INC AD74115 DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
-F:	drivers/iio/addac/ad74115.c
-
-ANALOG DEVICES INC AD74413R DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
-F:	drivers/iio/addac/ad74413r.c
-F:	include/dt-bindings/iio/addac/adi,ad74413r.h
-
 ANALOG DEVICES INC AD7625 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Nuno Sá <nuno.sa@analog.com>
@@ -1877,6 +1843,7 @@ F:	drivers/iio/*/ad*
 F:	drivers/iio/adc/ltc249*
 F:	drivers/iio/amplifiers/hmc425a.c
 F:	drivers/staging/iio/*/ad*
+F:	include/dt-bindings/iio/*/adi,*
 X:	drivers/iio/*/adjd*
 
 ANALOGBITS PLL LIBRARIES
-- 
2.34.1

