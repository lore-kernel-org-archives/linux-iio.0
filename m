Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1E44CAD7
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576025; cv=none; b=sLRKw5gsoPhz+7Y75UApVXcsPH69oIfnhuk3A9BnT3yBrb6ic6GCbiR/jAFqiJFSEWHSusP02Wf1zmaDyY64fDeu2gRC+9hxUZ+fnFGvRZ3iaazAqU06zUHlkSqcfPbEziElWNMwOlGd+sXdRWvSUCr53gFhQcI302z8tViggns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576025; c=relaxed/simple;
	bh=zrdk3y9A2kBGtL2LBRRjcdAHHcYP/XttZu6iPbXQisQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRppzCSNEu5wYyONmHGWvjU3nuhafi35RFZuf2ffvQHtNZJmBMn8WH4Ql54eHhhHKQwXgcmi4j/ococzo6V/LXbt2AD9SEXxKWEXcVPzTa3Emfh6rJYHuYdigpbtabsM/7ddXGH8NXy+fM9mOCEMVrI7IHYGZzJbPeLbhOfsG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPCHB7YC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPCHB7YC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b24fdac394so10189645ad.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777576023; x=1778180823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7XMezwxNPOIY9bQmuCEQBx6z6J3b/pGHkI91dtLXsI=;
        b=iPCHB7YC/wiSNV47pKbPwv8F1LVs3IT6iBslY/DU/wMb/U9CnLQdI4w4/8CuwSnrXv
         /I+2lJvJxx84HkOA6ZT7fDGtglQyHkKW/H/a/zTKrDKAuslbqYWmdUj3dK/mZgiJy87I
         0BiFc2nVpLAdsREHnacqi/1f7m8UguqwsL+xVFAafmq2nvIVgoUD5xCsqtVgYXS73wa8
         Ip4LD3mkqnT+YSUi8iTwAM8CgqjfCxUW78fS5C3HBN/aTtbjg3eIZF63SHbcfd5oiXvC
         rW73AfO/6oDw8e+fOoFHGp9pj2UeDM3n5pM/la5Vc850W9rCGdoa5zJmJhAOXb4CnY86
         lVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576024; x=1778180824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7XMezwxNPOIY9bQmuCEQBx6z6J3b/pGHkI91dtLXsI=;
        b=ZGP4K1SRRuz/F5+vzaBpBBxW4ItGlYWEsqpAb1l+QOgODrfsaAKIQlIo1SL+hLlsML
         bFxSKnW5ufEbNFr/KmUBC7KyuNyhwtiYqAK1AW8uNT2Skrcp8wITfOuymwZGMQ/llqLn
         1P2guzCCxwXwOgNP7Gaa/vcLL3ZVSoTtO6R9arLRVzWj9j2cSgKy6FtcOfGCntoonC9z
         VsIyxnARpf+3iT9rVLJ3TYK+9E1xMGV/rqCPUnDzaTGE1kmwoyrzh+aV/LZpiRspIGwz
         bWGA3nNjIP/7PW6XcGnNnvkFbVrsgjI3avx7t16OZHDggYKShkmvFx/Tu4mWTmkC+yGT
         JhPw==
X-Forwarded-Encrypted: i=1; AFNElJ/y1EOVL8n3T8qlu4EKugn/x10Nxsd5GtqeJcuN+vPhiIN7renEfyn/ZzbrmkbRTaJVoVfSrZUuboU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+oPPazo9BRnmr7ji9WOmfJQ+57Ns1yvRcVxaA+KzkLIARQq9
	pDkAG3pPMajeGCNmCUCeRFEhOW6+lN0mfydp/RS2zUNiMXbah1ckgQRc
X-Gm-Gg: AeBDieuhpsufS1UVes0ME8vAg1ZE3cQnODVdnoMTegH2hz2A3zPJg52uXng1sNncbBQ
	EiylF5g/xy8mkmGoPajaQjpwZHy1xv58feAQIuMf1uxV/O5IDe0S0JuOQ2/+YpmVzTl6gW5/hRr
	BDHhEPQFDUv1c0cGNYoGSw4f5cl1iolcwrGcnKX2SyHBJjfsv2CrXVFIZt2R4J3i+d7YB2nrKVp
	que/FNwnWUUAt8SqdPetImytk+VJUxXAEkkSLEjPmKY2UL+tbWpmbhiB/v20B33kQULT5DBLkEl
	l8Oj2Yc8m13quceJbYtC0ZBd/f8KcTHRED4Qls3+840o7wHZWNjqzEFcYrc/i2VJn2yVRrEqguG
	PdrYjntBrA9kzI6zaLWHWqjRDKG0u/Tk3Wn3Xw1Hp1DEvRuK9oXJRgdek86P+bYv49QIprDrc6d
	QU5tK8qE1XfRMyAi1S5Gp16XAezHxUIF8IFpUuME5WlWpE6MJYcQzej1AefUo=
X-Received: by 2002:a17:903:1b2b:b0:2b2:eaec:c810 with SMTP id d9443c01a7336-2b9a230548emr48716355ad.8.1777576023463;
        Thu, 30 Apr 2026 12:07:03 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16067sm3332185ad.40.2026.04.30.12.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:07:03 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	lars@metafoo.de,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] MAINTAINERS: iio: adi: consolidate entries
Date: Fri,  1 May 2026 00:36:42 +0530
Message-Id: <20260430190642.3434650-6-sanjayembedded@gmail.com>
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
under ANALOG DEVICES INC IIO DRIVERS.

Keep entries where specific maintainers exist.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 MAINTAINERS | 85 -----------------------------------------------------
 1 file changed, 85 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe50ca0c24d3..27325ec8603e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1353,23 +1353,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 F:	drivers/iio/adc/ad7292.c
 
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
@@ -1390,15 +1373,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
-ANALOG DEVICES INC AD8366 DRIVER
-M:	Michael Hennerich <Michael.Hennerich@analog.com>
-M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
-F:	drivers/iio/amplifiers/ad8366.c
-
 ANALOG DEVICES INC MAX22007 DRIVER
 M:	Janani Sunil <janani.sunil@analog.com>
 L:	linux-iio@vger.kernel.org
@@ -1407,14 +1381,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
 F:	drivers/iio/dac/max22007.c
 
-ANALOG DEVICES INC ADA4250 DRIVER
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
-F:	drivers/iio/amplifiers/ada4250.c
-
 ANALOG DEVICES INC ADGS1408 DRIVER
 M:	Mircea Caprioru <mircea.caprioru@analog.com>
 S:	Supported
@@ -1429,49 +1395,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/net/adi,adin.yaml
 F:	drivers/net/phy/adin.c
 
-ANALOG DEVICES INC ADIS DRIVER LIBRARY
-M:	Nuno Sa <nuno.sa@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-F:	drivers/iio/imu/adis.c
-F:	drivers/iio/imu/adis_buffer.c
-F:	drivers/iio/imu/adis_trigger.c
-F:	include/linux/iio/imu/adis.h
-
-ANALOG DEVICES INC ADIS16460 DRIVER
-M:	Dragos Bogdan <dragos.bogdan@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
-F:	drivers/iio/imu/adis16460.c
-
-ANALOG DEVICES INC ADIS16475 DRIVER
-M:	Nuno Sa <nuno.sa@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
-F:	drivers/iio/imu/adis16475.c
-
-ANALOG DEVICES INC ADIS16550 DRIVER
-M:	Nuno Sa <nuno.sa@analog.com>
-M:	Ramona Gradinariu <ramona.gradinariu@analog.com>
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-M:	Robert Budai <robert.budai@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
-
-ANALOG DEVICES INC ADL8113 DRIVER
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
-F:	drivers/iio/amplifiers/adl8113.c
-
 ANALOG DEVICES INC ADM1177 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-hwmon@vger.kernel.org
@@ -1480,14 +1403,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
 F:	drivers/hwmon/adm1177.c
 
-ANALOG DEVICES INC ADMV8818 DRIVER
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
-F:	drivers/iio/filter/admv8818.c
-
 ANALOG DEVICES INC ADP5055 DRIVER
 M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
 S:	Supported
-- 
2.34.1

