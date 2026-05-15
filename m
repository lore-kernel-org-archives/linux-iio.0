Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF33B3F8EA8
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866852; cv=none; b=Po0QJ53jKe9t8zzkekUj25A9d67juHSuJ+/D1uPuKjE4aUPzRP2VMpOVQowpVbOmLyqJodv2Ikj0WjKf7gRg+5/geXRy+YWMwvNP5e2etMJU9ggMO0EIRnDZWFJson8XqHZV1lDx+x9LAf5wOF1EX074/ox19J2gBsoFdkMhfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866852; c=relaxed/simple;
	bh=upDmu/wUadyn7EkK4pxxtaTje+RL6foxGGvrGCWVzw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKN/07VT0USHtPHX4d3cwRK58p4zogcM1LAyM1j3hfk4SkPe/mSOhPt8HARZtj9QYoYdgJY5njzWIKo+jlBC25wfYqEPfz/GwrENbzjenhTW1jqVbFY4NNw4CT29wuyyVHv/VsxV4DitXtO/wt5kcbVV0lRaUHDlfCqypbyvqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gm1g4beq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm1g4beq"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83d31ac4017so51999b3a.3
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866851; x=1779471651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=282Ldj8nwArLBdvCOtPNg09aNYay2lAqdtbMbUdvaTA=;
        b=Gm1g4beq7j88XosZnxydKG7VhRcMvNAqeJ3G8y0gjVU7wCkDpwKx7IwJYIvDq37I2O
         waLOoDc3vhYAxlgvfvGS9/SYbgAzfobhPv/0y6hFxMNKsm/yWTvjUPMLaUEj0OjYJTRK
         nIzu3u03YBn68XK5lR43o5sOv/zbTOr6tC+jPbQs7WIfMLXwooS2Jw1kfX4qjKifireQ
         lNGBLefdApQQiYIVJ8eLZerTPGUnsHIrU4d50YftH+HZCiiBMtDVM8+ofFTXSnksYHOk
         Xp+xPZ4ssy99mCRW7+lF6rStf66MtSp4IcxTSqXL6diLpVoiv0vFSSp+vV7vlG+W/vaQ
         MACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866851; x=1779471651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=282Ldj8nwArLBdvCOtPNg09aNYay2lAqdtbMbUdvaTA=;
        b=kb7tfYZMnMcahpTh7QcFEmeQKntHpcJc9756lovoDdIlmno95T5nx+WMHb8zQBoOY0
         LYJ5k+FcPsXfI/rdSVH9tdrwX9iDDTPfUIm4FE3+9xodrRscAiPwKCtRNvsL1w95HhIW
         jUikKEY7TduQL3HLq8pY0YOSIz9IE8UT27gU3VEmttxkWTK0J8/dWU9xjfy95Dw6BnIa
         /z6PR6fsnLQZMxfHJJBt0RKqwknkUD1ydRsDOPVt/XlpgMWw2ySv39wUjalVbbMw2nmv
         jyrMsIVWEKpQfrMBvBxeJrmSdLXhh4aSq2+nT7G02JR9xLDUR0DdqZOKqTcwwwmOB1W4
         Hrhw==
X-Forwarded-Encrypted: i=1; AFNElJ85H+4E/KJ3NhzizgG3C12cP81jAMpkJ3Ps6l6M3WV5qR2MCrW8K1J5/pyDzs8sh2RD0EdM8hf+a2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzol9Cl8zUdjLglliqRzs55zy8/A1ddcR+dw5OWa+B3kqGFxl49
	69jtPgdWgJWWsM8dMTkPUOsVKpDsxaviVc2I1WTAWyOU/9CJZKbyqcz2
X-Gm-Gg: Acq92OEwCDKQ14FCSps98mssNkx1uGYBMvJJ/9GjQIcBB6I4/X9tc8rZdnNyMbH1ouS
	n79nIAKkUUAVyr8IeifpS40sMjPJKZW+G0OT6z8ANsVBL7frWRLvr8MhnqeR5bCKoLAYsH+y0Ru
	74eVQKZHzTEsJc/vg8TvVeCe2WasGyteVQUmqbrSltLfY69GfMhG2XwzngmnE5Byi5DuZ1oCOmF
	eKWX1G90Pvyx4FL2nqgsfFncRsJL4JUkviVN8VdQLQqtuwE81ALZcWPt8TJjPi38RuI671wpxde
	tbMQsI/jFFN6UEbbX/Nssp4PvcRwr4VJ8BOc7hrHpTffPzyrKzwzJ6gMlBrTLR1nvxxMVFjbn+W
	+dpx+Qb0/LeIdoozj78FdNhUJSZk3KxeAuZpSKg58IY2j/voCP/cySLi/yn8wQcYm8Lqb++PsQo
	/zurWjP6/GQYUiAnRgXplftUa0pRhLTAegjD91AUT1lskijn1+ijgaa2U1bzM=
X-Received: by 2002:a05:6a00:3d54:b0:824:afe1:f7e3 with SMTP id d2e1a72fcca58-83f33cc0b04mr5789896b3a.15.1778866850954;
        Fri, 15 May 2026 10:40:50 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:40:50 -0700 (PDT)
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
Subject: [PATCH v8 06/12] iio: ssp_sensors: fix variable type and declaration order in probe()
Date: Fri, 15 May 2026 23:10:11 +0530
Message-Id: <20260515174017.3962168-7-sanjayembedded@gmail.com>
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

The ssp_probe() function declares both loop index and return code
in a single statement. The loop index is unsigned and split declarations
to follow common kernel coding style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index a652bb56c61f..f3ad2b38cc12 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -488,8 +488,9 @@ EXPORT_SYMBOL_NS(ssp_register_consumer, "IIO_SSP_SENSORS");
 static int ssp_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
-	int ret, i;
 	struct ssp_data *data;
+	unsigned int i;
+	int ret;
 
 	data = ssp_parse_dt(dev);
 	if (!data) {
-- 
2.34.1

