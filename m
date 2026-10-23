Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781927;
	b=ikYo6jM/qSCKMWALZOa5Tb7d+7YLyxs27ohu19aWVRBvOoh2OJy3oa9n55R20jvAGFGi
	 jDQ7K1tD7GFxrNGLVL0VL7vOL+KXtp/p6hhi2SLadhFNVtzy/+V1eKVIbFONyBAxQ+Ag8
	 KIzDOZIB7XSO4rmz+sBBIlmbaK9m7G7Om3c29Huv/OLz4u0NsF7xHbF4Ixldw00VIM1Hx
	 K583/c+MR10WmiU0NJLnMNl+pBe1iDz6c+S7pKmngZ/IT8ULSVy2rUDe2lOswJsW/IA0d
	 wEAAVSEg/YfiapmvZdoM9kTy2Q2z8rCulBGNd25g1ffZKgSCWouy758ku4ZcQkSDBVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ftXpdhFkATxo6/EXtNI+J/Xc17Me9Qm6sS2VkoCB1jU=;
	b=SavEj6FL/8Z5O+wqGe7YeXiPe6g+vqfYyYnbhheROBP3x5rnpklN5Po/GisKsietL5e3
	 i3LsreDj/6MJNm930SrGSwkICH976gEBiIQCA/Fs+HtE4bSm0krenFz3MstIG5Y5lAZVk
	 2bDf3u6paJ390bH6PjYEU/7WwmA4HxP46HHVAgjGoQg0coEREP6JqdmlAdcB8T4esN1+y
	 x5Djk+ExbiSpT0SZqxP5JWCxPLALcAE6HMsL3KY2+DzHJyYi3nOq4dJbXFBTAEuBWgRUW
	 MI26NGXhbsbRKAockTlytlb4MqPr+/ebzPAtYoE3BUh4Wo7acwu/2iH/wdqQ3IBtBwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nCBeIUFB;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482A606A31A
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 18:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4482A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nCBeIUFB
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35f1f76ea84so1961763eec.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792781925; x=1793386725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ftXpdhFkATxo6/EXtNI+J/Xc17Me9Qm6sS2VkoCB1jU=;
        b=nCBeIUFBM1c7udx6zt5cAvDNlfFtHhQDHrzljfxQkfDhVpyI6UuFLccKICERzDDpJf
         HHuG7cX/UpfMu8zIJ/LJeIVgpo/tcFMY81fpUl++GjL8PQFLlyf0HEINM1FOIxnUGoy2
         yButetyN3TcBxNoN6oG730YbmnEgobO/oszIuQp+xaHfbkvpp4/Utpkt9z3ihvuIjau7
         HBiu9vCZHZdftERVXqMu0obF3mXbGBzNyJoW7ZAoy2Kv0cd1iRg33Z5TNkhnAdqRoUN8
         izWapom+DQRJh7Phyb45y8TCelmg2aYDKyjDnrHPg05eMSefRDTFtQP9edflFj2IkTOf
         5+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792781925; x=1793386725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftXpdhFkATxo6/EXtNI+J/Xc17Me9Qm6sS2VkoCB1jU=;
        b=hNAJ9cuGfsDN2vLTvX4wzKFYmkzILez7SUso3lep5utXi/2NFdcK3VclPZrkwb5op0
         SBNQMdox7D3h12DPs7UszpdVzn4IRUeJX8t23AgZ8UV/wHD4Lq5T4Wz0AJKVkZ+Vq5gj
         d8HkU6jLKAWbWf2cKAs014SFnKqD6fStXZBqEQ5RGtVVlapFBDaz3D+MbznRMk40riVT
         vxk/BE1yuXssoWef1Mj6VONLdK8RrUowNHt1omDslx/auXc0UhnHeLGbQgmuVrVqyla9
         LSIwzWieQTXHbHhaPCXqhgVGHxHIdmmk5hrKw1lMtxHIqIVCubd2jxFEo36CAYd2kuvf
         638g==
X-Forwarded-Encrypted: i=1; AKwUvBw+LrPVWZYso5NGM3nyLy97WbQRPI0/yLD+x671HEvBJuy/KQ1CeciG6mqEmpJEP+KIkcPLYs/U/po=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxIdZs5ilsCCsY/feO0R2imgPt2W64DGRqvZ0h9r36KUM93YxJ
	z4sPBh9cD5tueuIgpWTjo6YI2/0zwLx+Tb2Sovb2SeQACJeYIDYkI6U4
X-Gm-Gg: AYBFou3aFRzJJcVlFbrnC9+86AjIVv+t9o/QSHX2KCEgwHuEgLFSQprTRb9KN7rinMo
	B4nR4wR1iRA02ACULmitlqhesFvbCR6keGy1qk/863lmK+aD8y0NI6BfHmr+uLXVu9FAsdJez4D
	5pgDiUJ7GrSttAbHw5QxjZklgQP0EDJvlVp9/bToVUcy5jDW0/Pc1FRb5J1J1/ovgakJ3Cy+v1d
	XlgcEB4V6XAQfkoEva0itpvCoqsHF30jaA1+tjEGrstv+xSGBPmlzBAd8oTvBlR/yn88Uc/LpWw
	FRUOtO713C9WasyFAgOR0XnRX2DcWVJGO2FnRPWwRO6eMtJAhN2YrQsDKqhA/U5cYtLl11XTMon
	O9dR8zmcfGiXSR4s/L+VKdLLewYWZO1/Hh2eKF9urajuDI2meYw+WQIwDGq30wmt1cG+JA7F7Pg
	3dmC6w7FLDJYqMXkuTuBkU0BgGYP8dMadBZMEx3e63FkHd0FME40H1VJw99YxbmHk0jc6uPUaIZ
	5P+S1e7/TV3vUCk8/cFtAyxq3lSgdMJg7T/8YP2fMCpkejCVIw62GUeJ3cpBpbyVH3GXkPKMSA8
	Wnmd6LsYXMYGo/x18fkqVFXmQig/Cbwaz2CjsHMzMixWlpLSKzof0GulcK2cGN1+lJQdHAnSkCt
	4JZSi2/J37EQ/z+6RnJonZf9OYZWeIYKV
X-Received: by 2002:a05:701b:2902:b0:186:5b49:90d8 with SMTP id a92af1059eb24-197c556c9c0mr1066617c88.4.1792781924931;
        Fri, 23 Oct 2026 11:58:44 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2a5937dsm366635c88.20.2026.10.23.11.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:58:44 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2] iio: adc: mcp3564: reject devices without match data
Date: Sat, 24 Oct 2026 00:28:34 +0530
Message-ID: <20261023185837.195943-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the chip can't be identified from its ID registers, the driver
falls back to spi_get_device_match_data() and dereferences the result
unconditionally. That returns NULL for a device bound through
driver_override whose name isn't in the id table, causing an oops.

Return -ENODATA in that case.

Fixes: 33ec3e5fc1ea ("iio: adc: adding support for MCP3564 ADC")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Changes in v2:
- Shorten the commit message (Andy)
- Add Fixes tag
- Collect Andy's Reviewed-by
- Rebase on fixes-togreg

v1: https://lore.kernel.org/all/20261021225431.627718-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have MCP3564 hardware.

 drivers/iio/adc/mcp3564.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index 259ac4ebdedf..91796a47e412 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -1204,6 +1204,9 @@ static int mcp3564_config(struct iio_dev *indio_dev, bool *use_internal_vref_att
 		 * try using fallback compatible in device tree to deal with some newer part number.
 		 */
 		adc->chip_info = spi_get_device_match_data(adc->spi);
+		if (!adc->chip_info)
+			return -ENODATA;
+
 		adc->have_vref = adc->chip_info->have_vref;
 	} else {
 		adc->chip_info = &mcp3564_chip_infos_tbl[ids];

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

