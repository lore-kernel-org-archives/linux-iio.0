Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB8647DD49
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576016; cv=none; b=qEFG9RclnsbgPy+2tIdZaCPjE8BS6f9qKLFxL7cIkBRVVK5k3gy1gUzZtnbFLCezwW2Vm+SwbP7eemi4Ho6hpr2P/u+JT3O+4udV/P9bxDHzrtI4x9zfbH7kTJlR3r7GjKT7M3oURdXLOjFYniXFUmQC+502y5HbLgS7u1YmFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576016; c=relaxed/simple;
	bh=fONQONiVeE2exppkI2A7FEJa0I0FFpzW0GY6mBzxbTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyKZMUWLpoJCSzK98as8WgVNxKKuQdMRZ1BxSZeSeu1vcjjlVm8TAt8T9S9QMroIAwFLuNk8vdq74lIfIh8yLvIcsrp2l5YO2rVIsnGLOgChXuXh6Uj7gDF/jSMHlaVQSuCm/AUyf050OiO7GD1rUlpc+PZy7SvDvQoQl8KI+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjSD8A5K; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjSD8A5K"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-364e5d895e3so306212a91.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777576014; x=1778180814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blZ1b523xuqnbOdOod/xHAgiCiGwmPfopg5jytU9ERo=;
        b=sjSD8A5KnQt4q62Hct4IiZy7Bddp+zNVtzcPC6j0I6OKXQcGvRp8zCPNFHkR1LATr6
         vV9mpYYxPsYFvXMCBVRxDTMOJ6EY5KutKoh21nBsA9Pz7tDi3tn6EMKfAJZfjdFdRWiY
         IanNfgsooQSGO0czaWPqMLpMMisc4C8beNT4VphllLJol0YvSNh/ivEeGugdb0n1kCsL
         ob5yNFHPyos2WYeoOvOScB/fQmhkV3ZP4aDywgy3T1Ee7/hxp9MpyPnT55qMghswPNrd
         qee19w2rCe76W5T99jiRn6fMiMjT90LOgSLciOt+7pmLGd9BnjBUpGQnSp+/dQpXLpfh
         3/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576014; x=1778180814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=blZ1b523xuqnbOdOod/xHAgiCiGwmPfopg5jytU9ERo=;
        b=lgXJ322I5ioKyD2p5rpNR7lSRl0rK70LZrRcgRo+ZzTeUaI8F23yP5GdMHIcoH5DoR
         kVxv3PK31qsnOCh3TqSengcdCPgr1nm1BwrafAvVUs7jabTe6AhTQNZH4SogfcthHMrQ
         A8XKQmarcyKztjnCGhqSRWdsqvt+l7000LemzsGSI0u4vWtqZ7OBnfRhyWLrLP8/AoGW
         lfPB091CIEJotWHF5OD3WCVai1OFcQdhVLBDC/RD8P9ksW7ybYeXW6TijYvHkcYypjr3
         7QsfnjqXMLi5Iuyl5mI30OH0Deg/qCT9IuvKnJXja7cJIMNyW6Nnkmc7oBLgNct0kMI+
         Yqow==
X-Forwarded-Encrypted: i=1; AFNElJ8vt3JOkR9fSrYXBjPIi5HT6fZiXyiezJSe3lgn8KujEF5UFhgynJvSHEzxG/R0ufXSAPt83Qqo5pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvhPAFLPxMOC/gqxhS2oPT7TQ7laZ7H7a+ZHXlNne5qMxmD37U
	Ie/DCGkF6WDBwYt7Fm7uAQoV20CA1UE7ZxPQbaoUJIttl4NFE98aBnJX
X-Gm-Gg: AeBDieuNzn71jqLKjqA0ARddxxmu0Jzc0KrfPDSeDAsEdHhty49MYglaFoyCBj14tZO
	VNuk/2qQCbx3jhA6N7Xn3AaLDk6T1vPmlu1+ZdXW+qmemQnwbmdT+O6JTFdU6CkyEwK0bgnTQcS
	3T/rpXlmP9hRnTwhqR/toyfwZ/hD9QLgPJkMfdcJ1ixdab8e/FgEDKBk/CDmFuZvIg/Wh5IZjzS
	CUL6hp0mG/gwtfJJ0pawPGrEjPJNXXIVSD5tejuND4m4lTh2l3Gy/hI1hZ2hwwmZ+0XTfNq5CZb
	M3U6wJcDvIVuyO+0fiwQFDJqqDMiWqCqP1fU9GG5ggBHJPnncyD2rNamhtRC5EN9+/LmM24vGvG
	BXK2dlRPBqd9lLjH4lOhwqODvGbt0TAXuDGHfRbp3+jJwGFQ7OjWwjf+0vupscjxmP1QO4433ZN
	nuhnNkt7ozbTn7Fe5PmLiCXr6sZ2UjZ9NJV85kfOvj5Rl0SiD9P6G8+ewH+80=
X-Received: by 2002:a17:90b:4b86:b0:359:fd9a:c50c with SMTP id 98e67ed59e1d1-364c31715abmr4672406a91.22.1777576014249;
        Thu, 30 Apr 2026 12:06:54 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16067sm3332185ad.40.2026.04.30.12.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:06:53 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	lars@metafoo.de,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] MAINTAINERS: iio: adi: consolidate entries
Date: Fri,  1 May 2026 00:36:39 +0530
Message-Id: <20260430190642.3434650-3-sanjayembedded@gmail.com>
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
under ANALOG DEVICES INC IIO DRIVERS for drivers/iio/adc/ad* drivers.

Keep entries where specific maintainers exist.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 MAINTAINERS | 158 +---------------------------------------------------
 1 file changed, 3 insertions(+), 155 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 34b67d010e87..bd14e15f04c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -451,17 +451,6 @@ W:	http://wiki.analog.com/AD7142
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/input/misc/ad714x.c
 
-AD738X ADC DRIVER (AD7380/1/2/4)
-M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Nuno Sá <nuno.sa@analog.com>
-R:	David Lechner <dlechner@baylibre.com>
-S:	Supported
-W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad738x
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
-F:	Documentation/iio/ad7380.rst
-F:	drivers/iio/adc/ad7380.c
-
 AD7476 ADC DRIVER FOR VARIOUS SIMPLE 1-CHANNEL SPI ADCs
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Maintained
@@ -481,16 +470,6 @@ W:	http://wiki.analog.com/AD7879
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/input/touchscreen/ad7879.c
 
-AD7944 ADC DRIVER (AD7944/AD7985/AD7986)
-M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Nuno Sá <nuno.sa@analog.com>
-R:	David Lechner <dlechner@baylibre.com>
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
-F:	Documentation/iio/ad7944.rst
-F:	drivers/iio/adc/ad7944.c
-
 ADAFRUIT MINI I2C GAMEPAD
 M:	Anshul Dalal <anshulusr@gmail.com>
 L:	linux-input@vger.kernel.org
@@ -1415,15 +1394,6 @@ F:	Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
 F:	Documentation/iio/ad3552r.rst
 F:	drivers/iio/dac/ad3552r.c
 
-ANALOG DEVICES INC AD4000 DRIVER
-M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
-F:	Documentation/iio/ad4000.rst
-F:	drivers/iio/adc/ad4000.c
-
 AD4030 ADC DRIVER (AD4030-24/AD4630-16/AD4630-24/AD4632-16/AD4632-24)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Nuno Sá <nuno.sa@analog.com>
@@ -1435,78 +1405,6 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
 F:	Documentation/iio/ad4030.rst
 F:	drivers/iio/adc/ad4030.c
 
-ANALOG DEVICES INC AD4062 DRIVER
-M:	Jorge Marques <jorge.marques@analog.com>
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
-F:	Documentation/iio/ad4062.rst
-F:	drivers/iio/adc/ad4062.c
-
-ANALOG DEVICES INC AD4080 DRIVER
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
-F:	drivers/iio/adc/ad4080.c
-
-ANALOG DEVICES INC AD4130 DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
-F:	drivers/iio/adc/ad4130.c
-
-ANALOG DEVICES INC AD4134 DRIVER
-M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
-F:	drivers/iio/adc/ad4134.c
-
-ANALOG DEVICES INC AD4170-4 DRIVER
-M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170-4.yaml
-F:	drivers/iio/adc/ad4170-4.c
-
-ANALOG DEVICES INC AD4691 DRIVER
-M:	Radu Sabau <radu.sabau@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
-F:	drivers/iio/adc/ad4691.c
-F:	drivers/iio/adc/ad4691.rst
-
-ANALOG DEVICES INC AD4695 DRIVER
-M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Nuno Sá <nuno.sa@analog.com>
-R:	David Lechner <dlechner@baylibre.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
-F:	Documentation/iio/ad4695.rst
-F:	drivers/iio/adc/ad4695.c
-F:	include/dt-bindings/iio/adc/adi,ad4695.h
-
-ANALOG DEVICES INC AD4851 DRIVER
-M:	Sergiu Cuciurean <sergiu.cuciurean@analog.com>
-M:	Dragos Bogdan <dragos.bogdan@analog.com>
-R:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
-F:	drivers/iio/adc/ad4851.c
-
 ANALOG DEVICES INC AD5706R DRIVER
 M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
 L:	linux-iio@vger.kernel.org
@@ -1515,31 +1413,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
 F:	drivers/iio/dac/ad5706r.c
 
-ANALOG DEVICES INC AD7091R DRIVER
-M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
-F:	drivers/iio/adc/ad7091r*
-
-ANALOG DEVICES INC AD7191 DRIVER
-M:	Alisa-Dariana Roman <alisa.roman@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
-F:	Documentation/iio/ad7191.rst
-F:	drivers/iio/adc/ad7191.c
-
-ANALOG DEVICES INC AD7192 DRIVER
-M:	Alisa-Dariana Roman <alisa.roman@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
-F:	drivers/iio/adc/ad7192.c
-
 ANALOG DEVICES INC AD7292 DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
 L:	linux-iio@vger.kernel.org
@@ -1584,15 +1457,6 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
 F:	Documentation/iio/ad7625.rst
 F:	drivers/iio/adc/ad7625.c
 
-ANALOG DEVICES INC AD7768-1 DRIVER
-M:	Michael Hennerich <Michael.Hennerich@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
-F:	drivers/iio/adc/ad7768-1.c
-F:	include/dt-bindings/iio/adc/adi,ad7768-1.h
-
 ANALOG DEVICES INC AD7780 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Renato Lui Geh <renatogeh@gmail.com>
@@ -1611,16 +1475,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
 F:	drivers/iio/amplifiers/ad8366.c
 
-ANALOG DEVICES INC AD9467 DRIVER
-M:	Michael Hennerich <Michael.Hennerich@analog.com>
-M:	Nuno Sa <nuno.sa@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/ABI/testing/debugfs-iio-ad9467
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
-F:	drivers/iio/adc/ad9467.c
-
 ANALOG DEVICES INC AD8460 DRIVER
 M:	Mariel Tinaco <Mariel.Tinaco@analog.com>
 L:	linux-iio@vger.kernel.org
@@ -1654,14 +1508,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
 F:	drivers/iio/amplifiers/ada4250.c
 
-ANALOG DEVICES INC ADE9000 DRIVER
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
-F:	drivers/iio/adc/ade9000.c
-
 ANALOG DEVICES INC ADF4377 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
@@ -1866,12 +1712,14 @@ L:	linux@analog.com
 S:	Supported
 W:	http://wiki.analog.com/
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/debugfs-iio-ad9467
+F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
 F:	Documentation/devicetree/bindings/iio/*/adi,*
 F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
 F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
-F:	Documentation/iio/ad7606.rst
+F:	Documentation/iio/ad*.rst
 F:	drivers/iio/*/ad*
 F:	drivers/iio/adc/ltc249*
 F:	drivers/iio/amplifiers/hmc425a.c
-- 
2.34.1

