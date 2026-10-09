Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417050AC3E
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571302; cv=none; b=gU2nV5utA0xLyHDOohArA+ccRe3mTcuDO1yALHQrxd4HUIwblnW67lkmLLE7mjfEorJvjCNxSgDDPfPn2cIEMHfAAbhu67dMNFoxzLxB4P21v27EjizL0v2ElLXTY1YIqVqYkgGf7CinfWF19urk/pmZDioaHes1c6zgruDtCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571302; c=relaxed/simple;
	bh=VZ9MFlUOyfdQk5w4IWgVhdMOncD+otSh5cbz9FDpze8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVAggbipRX1qTr3o/YAGQJq3/AeF/mbMyhStVxPGIA6GvsPDZIZvRp+AVA8rbfLXzRLDln/ukHa9MsxYPBXH3t5aAxqOgSz69aa0+vV0Hfgw2JUiikRRmR+8Hr5eWOdXrtcHyl8HvlqLtmcNBbQCCwOEj2ist6uRs9/Zg7y8pLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4puQm4+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4puQm4+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so1087255e9.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 11:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791571292; x=1792176092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQ/rPgu28+IKGXoI2cnUBCzKXJ/3423PKk5SsfjhJXA=;
        b=h4puQm4+0NQ5ch9J7j1VaIKCWI4rnFkCQR+e4eV+ebKIs0UstTfUctK2DEdmcU4JlV
         CxIBw6t64yqa8zbv3D93GCP2qa6I3tLXwV2QLvlQ6vNPaG5dLGu6slwBGCz91WYYlDxP
         SbCfU3GvcRWd0Yxp2VxVnTsYOX6dhNaAl5fjd6Iybs4f7y2oJzt+ma7/pt/Cf7BTyDtW
         aVuRTe1z5O0Avl95hKqd+wot9r0vT6cxTZ0t1P7mBXeMaf4FPbhG6YjvvMl2L7EDlMXg
         GvOm//RqBQtO+13mDP/XEp/XwFA22FjOPfsFTehR5t8xWU/9RDI9m6D6y0CZbPmlyeta
         xreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571292; x=1792176092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQ/rPgu28+IKGXoI2cnUBCzKXJ/3423PKk5SsfjhJXA=;
        b=YdupMmRvk35znSH+pUCNIj2Humc0wy00qIdMKcHRoYLIBR6U7GzN4aR6pGDzE8Hrxx
         gPwdct7C4tQrUtVQvK5ghwvNw87BIeUtOIvfSUYwIknfX6xEQVgwysjJz/mOKq+agtx2
         JAvxeoCr0tjWA+Rk9sryyrf68tFtYHcxHz2cKX5Y3kzRE3kF/MZQ7wmBpwEK0cEnsJrg
         mnqKWeGSUQbC2YR6i4f1PN9O/2iKJe3ivDSsBTEPacjkrVjlgQBcmgO8nqwY948oSlhV
         lFd689AnfeDXwzUDdUYbLrb99cDU5TjpmAKVc8IVkewb8h9CtMKK9biwiCco3NnqIwrY
         b3/A==
X-Gm-Message-State: AFuF++m7QPlYk0JQNPLRp5p2e3WRtvozYKaAiQs4fpW9PtNjKZXDV/vc
	UNR1KRJrJezxVcTOCPz2YHnh8F54YCG0M4vsHFPwGoKbLW40pSxe6lFX
X-Gm-Gg: AYBFou1D+qtteYS+PWNJKl4eWmHgbwF7hOiC6vJqDMlz+zl17PFINueySwloxFhRAAz
	1OOdRRtqrgDvzZFZOJ3YhSGsaa3SWfmkekOkv/+7wQ0eGq502exgXByrFi2i6JWCKIJUuIOyECw
	htBtGBDfHge2CQ4987JQl+3BRC/PEOHWH9x8UPlB10ipzYO3iXOpPsiXRDwpE9NwpMBRTYbLRSE
	u6wtkiB9Zy9A/Kys2LTjX+yrn23qUIaIdKDRzEC5Fujj+B1nP0GSzwrNh9srzbbZbPuJ0I1lDhJ
	CcXd78Y6Loi5C23u2sepkIq5SdGeDl2upzKCb/sVdxvTqNBXkd6bKvOH99eGGzxgJuVLskI13s7
	ctj8xLrZcTFFJm+lR4PZEVUgOYciFy2068OtHMm8HgAq02Z/4cbwgh8daeXxvGV+A254TwZicUf
	9rtpwcBrJc3tRzOEFqxOImIp8ZQPepJH0sWrMO4DRiBNd62Zo5t6LURkDfISTnLso0BN6YMpR4c
	RHN5dGe4c1ZIm9HGwNea8objCteeetcZXfMHnCvCBQ/KsAPWMVNGX5gOUf++40o9Mlm7GMnoSfd
	etHL7r7fVBYrPkaS3A==
X-Received: by 2002:a05:600c:3b1a:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-4a18e4b91f8mr52099645e9.20.1791571292496;
        Fri, 09 Oct 2026 11:41:32 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:e93d:161b:5ff8:cb57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4225f4sm91761705e9.0.2026.10.09.11.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:41:32 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 4/8] iio: adc: rzt2h: Add optional reset support
Date: Fri,  9 Oct 2026 19:41:18 +0100
Message-ID: <20261009184122.1378797-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Prepare the driver for RZ/V2H(P), where the ADC has a module reset line
that is not present on RZ/T2H.

Assert the optional reset when the ADC is runtime-suspended and deassert it
on runtime resume before performing calibration. Assert the reset again if
calibration fails.

Use a shared reset control to support SoCs such as RZ/V2N where the reset
line is shared between multiple ADC instances.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- No change
---
 drivers/iio/adc/rzt2h_adc.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 58e33fd0249c..62120d218515 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/reset.h>
 #include <linux/time64.h>
 
 #define RZT2H_ADCSR_REG			0x00
@@ -91,6 +92,7 @@ struct rzt2h_adc {
 	void __iomem *base;
 	struct device *dev;
 	const struct rzt2h_adc_chip_info *chip_info;
+	struct reset_control *rstc;
 
 	phys_addr_t phys_base;
 	struct rzt2h_adc_dma dma;
@@ -710,6 +712,10 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, adc);
 
+	adc->rstc = devm_reset_control_get_optional_shared(dev, NULL);
+	if (IS_ERR(adc->rstc))
+		return PTR_ERR(adc->rstc);
+
 	ret = rzt2h_adc_parse_properties(adc);
 	if (ret)
 		return ret;
@@ -771,10 +777,22 @@ static const struct of_device_id rzt2h_adc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rzt2h_adc_match);
 
+static int rzt2h_adc_pm_runtime_suspend(struct device *dev)
+{
+	struct rzt2h_adc *adc = dev_get_drvdata(dev);
+
+	return reset_control_assert(adc->rstc);
+}
+
 static int rzt2h_adc_pm_runtime_resume(struct device *dev)
 {
 	struct rzt2h_adc *adc = dev_get_drvdata(dev);
 	const struct rzt2h_adc_chip_info *chip_info = adc->chip_info;
+	int ret;
+
+	ret = reset_control_deassert(adc->rstc);
+	if (ret)
+		return ret;
 
 	if (!(chip_info->features & RZT2H_ADC_FEATURE_CALIBRATION))
 		return 0;
@@ -786,11 +804,15 @@ static int rzt2h_adc_pm_runtime_resume(struct device *dev)
 	 */
 	fsleep(1);
 
-	return rzt2h_adc_calibrate(adc);
+	ret = rzt2h_adc_calibrate(adc);
+	if (ret)
+		reset_control_assert(adc->rstc);
+
+	return ret;
 }
 
 static const struct dev_pm_ops rzt2h_adc_pm_ops = {
-	RUNTIME_PM_OPS(NULL, rzt2h_adc_pm_runtime_resume, NULL)
+	RUNTIME_PM_OPS(rzt2h_adc_pm_runtime_suspend, rzt2h_adc_pm_runtime_resume, NULL)
 };
 
 static struct platform_driver rzt2h_adc_driver = {
-- 
2.55.0

