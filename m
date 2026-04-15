Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A0C3563CD
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 05:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229702; cv=none; b=l7mFiRNc7WnDOlam5FPMyIzyP4t8EgtwC7GS1hD+Kh3dQNRAYv9I2UAKMzPSrWl0VrEzd1iLUNCuE2SjER4b3dUN6SpDJZQrT95gBcGiVNos0Kmjy7AJLfPmCrtYO7z1rWMvJulomPFzW/ejXtf7fRQtROgoll++fXv/903BPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229702; c=relaxed/simple;
	bh=C43gMMdvLSzgY8/Agso8t9GZKdH3sdzxcjuZfOzVocI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+0LMFLtsjRXXzmXVxO2N1vyP5sq+b6fVVPNFCETZkHO9Bj4l+gXKc8uAMKb2FEhFZud/U4Qx+4Y4ykdqX2Jw9xzo27BGwB1nwJYFnqMlrKl/+u/B+vmBimUM5x1hSdRIz37xocw6YW1LM09T9B5GWCP3wAqxmDXLqMlOg6S38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNlNn0+U; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNlNn0+U"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82748257f5fso3648451b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 22:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776229701; x=1776834501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lascn9Ko8D6lhEGfJWA6dLDbySL0NyjNnUVHhjd2+8g=;
        b=gNlNn0+UX2TJeUn+GtX4zTdeCYr5Bmz/4fLrZ/lw/gfEECa4oUhMq2kS9xCBsYK1Gj
         0Wecv4qPZeZjDoSdMBPa5qMkjSv18VCSygEQfxlcW0L35DAbhbYhWaCFsct52ISUu0SG
         b5w1zNlpRch1ZWL/cP/bmusDFNJQwWJtB+9IJHbXluoupDKt7URIXEIuj9mGqXE5ZyvK
         kSsZAViFfxVEbXTzT9QRFrYy/ZrScf9TIO9Mc8Z+NKxA4RFmZCtPmsPN8SV/2Ehi2jd7
         FxGR3wGWkas1TOm0L5NkQCXxyDRya9B9kfFww2d8iWMNbOxFl76x62fWmISeNyPPP7JB
         4FzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229701; x=1776834501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lascn9Ko8D6lhEGfJWA6dLDbySL0NyjNnUVHhjd2+8g=;
        b=BpkwVsmHABqKIp1Qh9m7um8oU+08YaMfIAASwKTKrjSW2ociW9JzTEr3f9FJ4YXr/R
         FPtSV6BmiDPBtGol0WGjwW9kxhPgjHJ6XaJ9ViI8UsUS705abfjhjzRQJjOF3R5ohQHh
         aM0Ty+sv/EvkYQ8QU9IGK+9BO6AyIBY1U4buXdElecZU/gAv0CNFGkB4Ef45gAdYB4E0
         gtQ9W3gUiJu4dohU1BNc5hNLl8e8MvpgeOUPqKkTIWAXaawFE/Ygwuz/FfKtPLDDMZZz
         d3S8P4xujI/jUACQj29ctPq9kvtXfS3A5D/QnLXh7qQb5lt2Zb2xhKHzOb51IeVMeCuZ
         ++zw==
X-Forwarded-Encrypted: i=1; AFNElJ/isiY0vx3EaQTA3FUpSptqtHWSqm54/IF0nNctK0IPl81oXEfZ5NVwbtnDLtwXzU0j0Hoj4XkAU4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5M44OEW9DnudyqvtJ+fuL1tGxWFfiCV+qfJJzH89d/nhUD1qX
	uGKQRZ0aTFiyENjhh4jlCixK3KIboqd1x5orjBXWrguZ5Vo7ofmgMj1E
X-Gm-Gg: AeBDievKviLUvwOvYTBryJf9DmGUEVxZTObG6ixfvSHqFozCkKJcnhnyNt9wKEnSB7C
	g/JLGREHpxeEztb0wsb79mFTAOEWtbW+f1FaicYapaeuRmfElko2jitrPU7axg5bvSCUk/0tcxx
	fnUrFfUwH11EzxZ6J8aR+e0ox96s0RnIVH/UMAM0ll8A7ciUhl/ec6ZQHj10NVGZZ/NvxUhyYLs
	5JYritRfAOiB1AlXjKWWaMFHCYsgGUnhVVwZkdm4MYQmhn9Jf9wfjoPoQ4Xoff9uY90nPbtbGmc
	2GMXEZHgftkaMfdy5fLQi3kjbrorBqvnnXeQ5apP4+aE/r+SoSyJcZwUMmtFfdHcRsQrXGd9xfy
	6LUGx6bpND+qHzykhPefB6Lk5+1P63p+9NYr9FnBAg/Q7UdF9J3uMoNx2F4yvd9UU79LeFOjg4Y
	psou1GLn1Pf39JSnSsgA/4jMDcnP0wcOt8Z2oq4Kxdkv1Nx/AKPcm8q2iXgrY=
X-Received: by 2002:a05:6a00:4fcf:b0:82c:9c4e:66ca with SMTP id d2e1a72fcca58-82f0d0d190dmr15585101b3a.2.1776229700850;
        Tue, 14 Apr 2026 22:08:20 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67469dc3sm763706b3a.58.2026.04.14.22.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:08:20 -0700 (PDT)
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
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/7] iio: ssp_sensors: Use dev_err_probe
Date: Wed, 15 Apr 2026 10:37:48 +0530
Message-Id: <20260415050749.3858046-7-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415050749.3858046-1-sanjayembedded@gmail.com>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
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
 drivers/iio/common/ssp_sensors/ssp_dev.c | 36 ++++++++++--------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 94ecc794f926..0a00ead3195d 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -496,25 +496,21 @@ static int ssp_probe(struct spi_device *spi)
 	struct ssp_data *data;
 
 	data = ssp_parse_dt(&spi->dev);
-	if (!data) {
-		dev_err(&spi->dev, "Failed to find platform data\n");
-		return -ENODEV;
-	}
+	if (!data)
+		return dev_err_probe(&spi->dev, -ENODEV,
+				     "Failed to find platform data\n");
 
 	ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
 				   sensorhub_sensor_devs,
-				   ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
-	if (ret < 0) {
-		dev_err(&spi->dev, "mfd add devices fail\n");
-		return ret;
-	}
+				   ARRAY_SIZE(sensorhub_sensor_devs),
+				   NULL, 0, NULL);
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret, "mfd add devices fail\n");
 
 	spi->mode = SPI_MODE_1;
 	ret = spi_setup(spi);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to setup spi\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret, "Failed to setup spi\n");
 
 	data->fw_dl_state = SSP_FW_DL_STATE_NONE;
 	data->spi = spi;
@@ -573,14 +569,12 @@ static int ssp_probe(struct spi_device *spi)
 	data->fw_dl_state = ssp_check_fwbl(data);
 	if (data->fw_dl_state == SSP_FW_DL_STATE_NONE) {
 		ret = ssp_initialize_mcu(data);
-		if (ret < 0) {
-			dev_err(&spi->dev, "Initialize_mcu failed\n");
-			return ret;
-		}
-	} else {
-		dev_err(&spi->dev, "Firmware version not supported\n");
-		return -EPERM;
-	}
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Initialize_mcu failed\n");
+	} else
+		return dev_err_probe(&spi->dev, -EPERM,
+				     "Firmware version not supported\n");
 
 	return 0;
 }
-- 
2.34.1

