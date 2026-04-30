Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C54478E53
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576019; cv=none; b=JPWEbx4Bh3XOdAeyO7nsCgJOdQSJslXYLtPpaxQzJ6cokLx8HSyCE/z2WWxTo1HU1DlpFatU9lkI+YDj/KI2os2gBi5JTpFzsVSSe+HoOLy0w74SmRx5e6tGdCgs1vXqQI4MLl9emker0HAuI8p5ugNZb+VdhGXOHVvdFWk8gJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576019; c=relaxed/simple;
	bh=ovAwrmCxjWxmch+GO+JiYZ4l94BwbF3H4vaoi+2+I9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNySgpTy0WKez31gMsZPvgF+CqGnrzxBFPw6xhUqoicLeeVXr5rWOSaZSi4OtFLXni2Ip0ma1Q8X658T2DrZhnzTyw2xEARaERKyK+7/qaEXCsGgaGMCZTZNGOkBlxW0jnzlcY+UhKWO68fNdlCOY3EewdZzw9VDq1t2/omdShw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eej9I5D2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eej9I5D2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2503753efso12997335ad.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777576017; x=1778180817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX4r9+lsA4c9mfy9bgJpJ0w8IAhnIaAAh1dRphz4AOo=;
        b=Eej9I5D2Fp0x1GxTxRSNnXJ8f8ccBE0bjjZxZtb2f3LcDaI2BFW4TLi/gp5e8bG/tp
         S7/QO394+dMCKrZ3bd327DEQl0/3V4jrVJXRewYaBYsFiH4htZL0qLG5YAL0luBZhHXk
         89DsrVyC88N8zFz4hCje3ZunxxYlPZIC3R+/5jCwAOLm2KgVf2iAioMh00JJETY0x2b0
         /uzjBfTcvlxnrGphz1CGVn440zYUrmwo/AfVhA3IpA8pFV4i26zPz1Ws4f3A/F1l8wip
         HIjZzHqnPLtuMxjnbPXTyecPo2phwA7r8LxEybjm+rxlWp4SijuBm6iToI6QJm/He6XZ
         618g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576017; x=1778180817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IX4r9+lsA4c9mfy9bgJpJ0w8IAhnIaAAh1dRphz4AOo=;
        b=BzB/qswO6p5ysCtDMv1PV483c0PhqgP7n/8Ua+F30xb7gcPSVwOisMxL1yKXCRWese
         NhWd4dSVf/F/yn4c8YHA7niwvTg44TC9JjtEn1PvlSMtHMvHdMORPo+27Lwjff0jG07/
         GnZZYHuZQTG7OEuIdr7hWRW1GrSPgBC2T7JPK90Lbye7t4pvKL/n9rGBewtLedExVRWt
         pE45SyWOEMbXaR21gL90xwmjZDCf0EO00cm9TUkNWwUM/9jp2tIG59I9QaG/k5CbdcbS
         aqY6kasX5CRH0z4IzmL+YfWjTqL3acAvyogpM9OFbjjbWHMqKkc0mjK/gUJNDuxAiIKG
         bzEg==
X-Forwarded-Encrypted: i=1; AFNElJ/DbegdEonI79+QM+UhuoOO7bAngwywhorlBD4ITZNFKJQmnZ3BLC+IWC9vzYVc8WDBvJxjyU6wiS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkqWAEouSjLZPVWU7/mYNxCLl2v3/0sZX8FB1mL7LEz226qIg
	wBqp6Wiyad3kRVNNdZGkv+b+S5RpyjQYw0SeAjxk/205/0cysyzsbs8D
X-Gm-Gg: AeBDieshQikFG3i2QuOMArFMs+dbrIHLCz7r7ZkhfeFkQg0jal0NDB05PuLaotGBkSz
	Pt6aei9EgIRX+2Dxk0tchkhsNegYAIwfW3mjcnALojtPAcenA4Zle0iBqfVIZH3Z6eVvpVXtOz3
	SHZTrScR9SYj//VXbAPDxYUny+PduMqI3favtN0jyRP5wQH3LmWuhuBoVn0P0ycuL35Fs8Y5gst
	6UaUaSkFA1fVfPrgklEGuNkAsXQMf24y+aTmgR9/D30s4l5dUJ5kfMDtIsiGZ2J7QpwHuS6Sjo0
	mWbtXqM9pKXiPe0jMH+7kNbb5/aqv9O2CDh24MjgbO9FDSxVNe9hC57QbrozqbB+OoIqfqUNEIM
	V1Dgafgyawq5GZ85ZdwLt2I23Eipib9N6BFsVrqcEDdIe7TEeacAQ9o7S75NUc72NUPHJXp2hkj
	EB0Js110jNZPJjbs4mTuBXBvoyCVOyh8HyCVhrlYHJcZuy3XKyYPwIwKoZkJ8=
X-Received: by 2002:a17:903:8cc:b0:2b2:5857:601c with SMTP id d9443c01a7336-2b9a234f8b5mr43878005ad.18.1777576017369;
        Thu, 30 Apr 2026 12:06:57 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16067sm3332185ad.40.2026.04.30.12.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:06:56 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	lars@metafoo.de,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] MAINTAINERS: iio: adi: consolidate entries
Date: Fri,  1 May 2026 00:36:40 +0530
Message-Id: <20260430190642.3434650-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430190642.3434650-1-sanjayembedded@gmail.com>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Remove redundant per-driver entries already covered by wildcard paths
under ANALOG DEVICES INC IIO DRIVERS for drivers/iio/dac/ad* driver(s).

Keep entries where specific maintainers exist.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 MAINTAINERS | 70 -----------------------------------------------------
 1 file changed, 70 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd14e15f04c9..9f07175ef8fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -432,18 +432,6 @@ W:	http://wiki.analog.com/AD5398
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/regulator/ad5398.c
 
-AD5446	ANALOG DEVICES INC AD5446 DAC DRIVER
-M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Nuno Sá <nuno.sa@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
-F:	drivers/iio/dac/ad5446-i2c.c
-F:	drivers/iio/dac/ad5446-spi.c
-F:	drivers/iio/dac/ad5446.c
-F:	drivers/iio/dac/ad5446.h
-
 AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
@@ -1377,23 +1365,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
 F:	drivers/net/amt.c
 
-ANALOG DEVICES INC AD3530R DRIVER
-M:	Kim Seer Paller <kimseer.paller@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
-F:	drivers/iio/dac/ad3530r.c
-
-ANALOG DEVICES INC AD3552R DRIVER
-M:	Nuno Sá <nuno.sa@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
-F:	Documentation/iio/ad3552r.rst
-F:	drivers/iio/dac/ad3552r.c
-
 AD4030 ADC DRIVER (AD4030-24/AD4630-16/AD4630-24/AD4632-16/AD4632-24)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Nuno Sá <nuno.sa@analog.com>
@@ -1405,14 +1376,6 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
 F:	Documentation/iio/ad4030.rst
 F:	drivers/iio/adc/ad4030.c
 
-ANALOG DEVICES INC AD5706R DRIVER
-M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
-F:	drivers/iio/dac/ad5706r.c
-
 ANALOG DEVICES INC AD7292 DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
 L:	linux-iio@vger.kernel.org
@@ -1421,14 +1384,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 F:	drivers/iio/adc/ad7292.c
 
-ANALOG DEVICES INC AD7293 DRIVER
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
-F:	drivers/iio/dac/ad7293.c
-
 ANALOG DEVICES INC AD74115 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
@@ -1475,23 +1430,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
 F:	drivers/iio/amplifiers/ad8366.c
 
-ANALOG DEVICES INC AD8460 DRIVER
-M:	Mariel Tinaco <Mariel.Tinaco@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
-F:	drivers/iio/dac/ad8460.c
-
-ANALOG DEVICES INC AD9739a DRIVER
-M:	Nuno Sa <nuno.sa@analog.com>
-M:	Dragos Bogdan <dragos.bogdan@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
-F:	drivers/iio/dac/ad9739a.c
-
 ANALOG DEVICES INC MAX22007 DRIVER
 M:	Janani Sunil <janani.sunil@analog.com>
 L:	linux-iio@vger.kernel.org
@@ -1692,14 +1630,6 @@ F:	sound/soc/codecs/adav*
 F:	sound/soc/codecs/sigmadsp.*
 F:	sound/soc/codecs/ssm*
 
-ANALOG DEVICES INC AXI DAC DRIVER
-M:	Nuno Sa <nuno.sa@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
-F:	drivers/iio/dac/adi-axi-dac.c
-
 ANALOG DEVICES INC DMA DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 S:	Supported
-- 
2.34.1

