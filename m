Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39584CA27C
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866871; cv=none; b=CRIdV/h4NB9SVnu+p7M0K7s1y1GDp909N9sSMSoeGLGQDyDtb1inilBa11/m4OgUhu0imUsEJSIH/JnGxs11eU2KpVmOTziPPd2i9scVT+HaKubZvY2LTbcKeOAUJGJTVBLQ7i0OoqqfIFYRdO9qMEVt2TRYeD6CGi7kOkzmkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866871; c=relaxed/simple;
	bh=U1lxI/c9+STExeefINEuJhoclYlDv4h72phtQFTNdqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=erTKu4zn2JOl4RBj3ZXXveLNymNtDLXVbeyvOzAwCT8DI95rjkh/oOy37yr3ySaRSJjZ/iryM+U2dxMGqmNCLdVEwmjjpXbUM7epZrQLex50PO/EWfm+ITDOYX5UIecAa2QFCMMlo15VaySC8P46J8rysuuGXsLnWG0aKdmCtXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l05kwG8g; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l05kwG8g"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so89645b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866869; x=1779471669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxlDQD1lMIcbSSKqgMoxstclmI/pLX6xnq0yZXUOyeY=;
        b=l05kwG8gY+mw8m3HJSJuSHMgN+6yxQcYDCQcPWYVzkQ4LC+EXRIm89drpwjrewboQm
         D3tqM9yLkeLsNIs1xRODQRbqMO0Sa5lqUFivH36YQlWEMxtMC1YtUSDtwgpdT+cYC7Bs
         Kf1A5kmzNxDSbb1Ku2qGGngPv64/NqgVNFdIUD2WcM8DXNyDPC1GSZJPJMz3nEfriNY5
         u45gdYcH1vrKNohvFuh5aQKne40kFIanuGBGZ8d4P35sqdRyfKayLG6uPZclB/Nn5SAH
         sZfuAWa/zlGtnQBa5KC4MyEn61IlXNj4jo4PcIyHbpzNsXjDCYD6sYMtPW9TvTLmL+qO
         ASYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866869; x=1779471669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cxlDQD1lMIcbSSKqgMoxstclmI/pLX6xnq0yZXUOyeY=;
        b=A8y7WzlfY2/lpq2ILZVq4IOecdgakkRf/pE8vkCbTxsxn76mGAalofggh43wrgvz0b
         3/uwEouah1MzkUoqju3tekSMe9ykH0sU+ayhPdLhTIm1+lUoAP6H5rVDMOl8ZgDO51Ep
         ddrb8iyS0v5BGIZQWWn0cK1IyYw5qptiwX9yiDAZgiI0xN16o4V3cLFLLXYsnLTnXpWV
         cSK59JZ3aiWxKrDFCT9ZS5VEMrmbFg6krQ8PjoQxlsTPEX52RgqD2u87rnFT4Si91oGc
         KcPD56xUvCBQ7/FADY66Q4Y0I7zC4bF62ICmkRuR7eibALrRLbg7rPOusxLEzt7j3SW9
         IJsA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ia+8wHa2f4IDTYYUGsuFx/V2Z/6sxRPyG0N3H5C7G2k1NW+gyJBYVm7ktqJ5b5FtA8JmD1AVrAyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8u3+MCI92zorsgntKnXRH6CsJ8ln1ItQmVXERuKpyu1G1hO3
	CzONprIuosqOGeyQgLEKH3sklYACQu4OFZ0y1F2UeYkP7bcNCPBNuia0
X-Gm-Gg: Acq92OHnBIVIUA6ZhhAlzqi55Szs61N3AWdfho5GGGl0bPLf16qc5K2X+McqthMI6E+
	57fZe0OPXb5XAMlLcm+Xr/I16UQH1+1VJl43JW/YZbXKNSNuTrH6U5PJ6H/VilJM0kZh/UmHvMY
	Gb2q/+UTt5EhK23evhs27M+MFVTxhw/lid+okjFzZLEVm0fAKn9DgqoH1sNbhK7t9tq3TQMU68q
	/2PQEFg08Rvn3kTjMRUGJjORi2Rzgv2f/5jtrtvBSmqPfo6Pl+xUVggWlkmPJKZKDI5fC7xjsHj
	9tgTgIJeMJ4dDal8eIbDZPpnI5KN/yUf4LI0Z0QcT6has1yJmVNscm9kXWnezwuRl09+lR4XGSk
	vfuXxPhC6ex+fP2romad4oJOXCnAlDXKDVv2fKrykKZnWss4IAa8mVz1WuwRdekKxSgCyJi5thY
	+fWZc0tWASFiT/3QQ3zhVFNfxWwTAqc9cwGpRGu3wtKICaavEX
X-Received: by 2002:a05:6a00:4c0b:b0:827:3d52:5d1a with SMTP id d2e1a72fcca58-83f338d20c9mr5623462b3a.0.1778866869056;
        Fri, 15 May 2026 10:41:09 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:41:08 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/12] iio: ssp_sensors: Use dev_err_probe()
Date: Fri, 15 May 2026 23:10:15 +0530
Message-Id: <20260515174017.3962168-11-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515174017.3962168-1-sanjayembedded@gmail.com>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

dev_err_probe() makes error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
changes in v8:
- Address coding style comment based on input from Andy
- v7 change: https://lore.kernel.org/all/20260426091710.3722035-9-sanjayembedded@gmail.com/
changes in v7:
- Drop redundant else with refactor as guided by Andy
- Add new change in series for local dev variable with input from Andy
- v6 change: https://lore.kernel.org/all/20260415050749.3858046-7-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 34 +++++++++---------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 441416c612a4..2cd06c85ffe1 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -513,24 +513,18 @@ static int ssp_probe(struct spi_device *spi)
 	int ret;
 
 	data = ssp_parse_dt(dev);
-	if (!data) {
-		dev_err(dev, "Failed to find platform data\n");
-		return -ENODEV;
-	}
+	if (!data)
+		return dev_err_probe(dev, -ENODEV, "Failed to find platform data\n");
 
 	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, sensorhub_sensor_devs,
 				   ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
-	if (ret < 0) {
-		dev_err(dev, "mfd add devices fail\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "mfd add devices fail\n");
 
 	spi->mode = SPI_MODE_1;
 	ret = spi_setup(spi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to setup spi\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to setup spi\n");
 
 	data->fw_dl_state = SSP_FW_DL_STATE_NONE;
 	data->spi = spi;
@@ -588,16 +582,12 @@ static int ssp_probe(struct spi_device *spi)
 	enable_irq_wake(data->spi->irq);
 
 	data->fw_dl_state = ssp_check_fwbl(data);
-	if (data->fw_dl_state == SSP_FW_DL_STATE_NONE) {
-		ret = ssp_initialize_mcu(data);
-		if (ret < 0) {
-			dev_err(dev, "Initialize_mcu failed\n");
-			return ret;
-		}
-	} else {
-		dev_err(dev, "Firmware version not supported\n");
-		return -EPERM;
-	}
+	if (data->fw_dl_state != SSP_FW_DL_STATE_NONE)
+		return dev_err_probe(dev, -EPERM, "Firmware version not supported\n");
+
+	ret = ssp_initialize_mcu(data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Initialize_mcu failed\n");
 
 	/*
 	 * Managed shutdown action for the SSP device lifecycle.
-- 
2.34.1

