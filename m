Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778371;
	b=hYlVEILSsCqCwtMEd65PDDSfsmUguumhfh6PSpzB4lZJUxNa1tUCx/04yfesuZp9C9PZ
	 LJh48bBkskTI18jVYOD0J/oZXEAq6i+bZyXXk0CbbzVNvxKQnlnEh+qiZrrEkauO01FB9
	 3bL68FG+QCRcOjOCF+f6387gEmVRevbnrZoHb5bzfV8o6FsEjrrcMlV6aS2G89gUbZGQn
	 M9nu+jI4febms/X0yG6OdLEH/tOHSFzSGM2rFNC+E1Ko+qMLjUksYMid85ObypLRdDOII
	 VsY5DgqnvaszbLErp93t1rpJAwzyBnAH4kXyq517qo1BT9O2sJ+6s7XYKrtj4ETeLeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GVmgd8z0CPb2cc8gY/ciKAfurSnSMglt/JBh+HjasTs=;
	b=vKBnuD8C4Jnwc3G8u9gUrm1u66uFSX5P3znFll4XBRt2pjFbsm+0ugbFiWKk6basI7PO
	 0qly1d3c9QIUQIWM82EjK956LOd2xEi9WbK1M1yrLtG1DXlGUElux8RJUaQQ0br+JWd49
	 SIZHF1bHM22/59guVWWRiEPlLmQIP5w2quC2/riZB6sn+MXsjKQ/4fP+MDtayzn3GhrXr
	 20PnbOxdi3GsVA9l+1bbPHzvMswSxM6wmONOU8gtb/C62ULI9FuU9pzMBC708nAfMq6pW
	 DuZuAw2jj3XYsJqlyB+m2BFN5Hwvs7OCjab27qy3fLjgflEf4TAtZVsk6yBMLuNJtYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RGgWKqKe;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F1D60A2607
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 17:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F1D60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RGgWKqKe
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e00eee27dso764952f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778369; x=1793383169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GVmgd8z0CPb2cc8gY/ciKAfurSnSMglt/JBh+HjasTs=;
        b=RGgWKqKeYbqLW0wSlqk2RC3TVrh9pZb/qBOtmdo1z6Um8DH2YQValyJHCcsrU45xRM
         rqds4snvjM3RElw0tPKlmBnG/ZS59z0VNp5NlNkyurocmDjZGYNz2rqTjz+Sgh3DCfRc
         Pfq5WtRupPT31sivjVqm1WT66KRoj1RRI5BpVuahZGYM6cCTktx1fRKm+lHllMR5W6uH
         MH4iceWt+pWQIZX1Jzf7qANDe77R0xQ+zclk1cw1PNeqbS6xuWJJ9wGCqOH4h8JqIfOk
         6QObAnUW6kJkKfArxU3L18Iw5Iuq2sXspHU7vZ5TtHbHTs7Xuwb+hUQ84Erq0FKd1RAi
         dOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778369; x=1793383169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GVmgd8z0CPb2cc8gY/ciKAfurSnSMglt/JBh+HjasTs=;
        b=dSD5lHI9BYIc7TyMc9oENM+Bnqj0nMbwL6Wxzq37bCOYkBnZbFOhEYpXDgP/8C9Ms6
         CekMXns/77ZZ366Ubw2vh9keQRFmxfGkSNmgQiWFIsy4jCW86DiyWwfNugE5fxUaXRNX
         jnHrCgPjASM8rzPqzA7cKal7Cg5DKl9XsylG0bLLItn7+9wCjN/3cS83OSjXHNb1GwGP
         +piG1tPRMrgoHN04hu/y1kPsIJswvPS2EwXF08hLAcnYXMniTFGRef11wTofpuINa1Xg
         bQnTljGdsydvpR2gjl9w+MH01+uHUSzwZgOTUcDyurLM+Prvg2QMrKfLxws65IPNdcVS
         D93Q==
X-Gm-Message-State: AFq9FYIjgFCOGZ1PEfpXTeOnv3xLhQ+fTUIP2zC3W/kfSySyopm1rh8h
	a6bEeL8qTzLZkLaOmwhwCJBNy7EGEnyHxVNFTVh/lwMq5CV8Pt6IYiB0NjdcKmCx
X-Gm-Gg: AYBFou2bPAhCBwz7NI5ZgUkjfwPsH/8HtMfgT0vLBtTsuUxpHwfpDtz7h1r2FY0ei/U
	FwuBkIVeIRNXamlVhmzN1mCaxGuu47gY0h6j4FG3lEVMizFvfOP/X40d4pCdaCj0MWE1OuxYKcC
	baWBuc0NMvCnaFESHeX7hbit/XkiERsZm9hqw2vXn9snde2cpZKeBtONo0tW5xFvTs51SAdOAvy
	+YvIE8xxFTOqwmWleXClBu6KSVxHr4GT4pzMiBYQNsZCsr00c3a1tAGOVFTpnrphuGa1SwbtEHD
	1bB9WECAax7Vj35CfUTJvMuU6ENWMWiOHG9fxQ/Z55Fs82yAmUWsCn5CFWqvoTLVAd2WlBlbhJa
	zSLxcwuzHfAqV3LxW+E3nQGWzsJA2060DwAlURaA5DpsQw3/+jJyaRNYNUQ42n34TCVPB+QN+yE
	pSVjLQgDZ3/XsKUF90q6mIpSIjFs7rZhVjRm4qDzcKdVnWOvx61+2Ee9n9355BKfgnwBUPm0Qr3
	tAAGOa9i2JPQIIp10GWeC5nN73q+Jw6ZL3famWf1dzvxsVJVhpn3Lfj6a5Bw43QgbpoLe2ecmut
	4p4X+EcuZFHmaVaPdwhurCpQMmRiUZDlGkxrz5K2yMsFgIvjLIpsUOkwF17+4+TYA+1V9+/B8pl
	V/wEZfusHUXJfrC7DAvoKLM7EobFDMUgV1sMJjo87ySDZNQ==
X-Received: by 2002:a05:6000:22c5:b0:48d:f9dd:e3df with SMTP id ffacd0b85a97d-48e3859df07mr4841249f8f.18.1792778369013;
        Fri, 23 Oct 2026 10:59:29 -0700 (PDT)
Received: from iku.example.org (host86-133-9-17.range86-133.btcentralplus.com. [86.133.9.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37ca2asm1342800f8f.8.2026.10.23.10.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:59:28 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
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
Subject: [PATCH v3 4/8] iio: adc: rzt2h: Add optional reset support
Date: Fri, 23 Oct 2026 18:59:15 +0100
Message-ID: <20261023175919.160103-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v2->v3:
- rzt2h_adc_pm_runtime_suspend() checks the return value of
  reset_control_assert() and returns it if non-zero. This is to
  avoid churn in future patch.

v1->v2:
- No change
---
 drivers/iio/adc/rzt2h_adc.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 2ada8ecb2603..51a976f85ae7 100644
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
@@ -709,6 +711,10 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, adc);
 
+	adc->rstc = devm_reset_control_get_optional_shared(dev, NULL);
+	if (IS_ERR(adc->rstc))
+		return PTR_ERR(adc->rstc);
+
 	ret = rzt2h_adc_parse_properties(adc);
 	if (ret)
 		return ret;
@@ -770,10 +776,27 @@ static const struct of_device_id rzt2h_adc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rzt2h_adc_match);
 
+static int rzt2h_adc_pm_runtime_suspend(struct device *dev)
+{
+	struct rzt2h_adc *adc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_assert(adc->rstc);
+	if (ret)
+		return ret;
+
+	return 0;
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
@@ -785,11 +808,15 @@ static int rzt2h_adc_pm_runtime_resume(struct device *dev)
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

