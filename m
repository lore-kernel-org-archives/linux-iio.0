Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3833BE633
	for <linux-iio@vger.kernel.org>; Thu,  1 Oct 2026 03:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790824161; cv=none; b=Te3JUsGchzqyfJ34baeBJFdg1HeXTZpXWm+W1yDyZFUZglXIOuxGiMLMmuiJBKO26uGwnocsit+QX0OtltxDHkYJ+3JZ2CZXZJ6e0NKa6xOQJLWqGl5JKQQPnL6BzTxjIbuAxYkeyb6r+A/D+/9u1qPr67LzbACIiIe8xBmVzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790824161; c=relaxed/simple;
	bh=HJ782ZkVd+cwbg2zr5WPHdLJxTol40QDCPVd3j2YWCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XpIWm6Gy7262Ne7AW1HxzyW7TnpTGr3XBU1lZix2r9s8Ks9cE3hVZ/fRgxodGqnG885Aqg0aJTsyPxUnrCuMMYHlsYmGQTsn5cFlCYKrs4K1iIOnobM6hsw/EHwD0ZOhOJDihMAVQhH++oZJUxdqDT9bfJlAQbJH53YtdM3y5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mLTxWQJT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mLTxWQJT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so45101595e9.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 20:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790824157; x=1791428957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ebr0zKwmRy5Wy2u8eNXuEfkoYnCwRU2+CdFY8YmOfEU=;
        b=mLTxWQJTr9+8kDTGwGXy7NPOSfOvKqRT0UJEeiCOAFwQ9DsYzkgQHRE3S24wpy7Kk7
         XV8NUoGRBadLY9cqsFftFXdeCobwJJuYSaZR9kxfBX+kQydC7hHt23HH9Zw1WXVwDSIU
         BHXR0KIkcAYQpoBzSCOZIT+8FzmIQRtXgvJ+xKZqbNfDQGrEKXXpRdS+kX/3uqjpZN2F
         DYQowM8ZVlAIJWzcpLgW+9r0dPZrsRF1ywqHl562od7xV0rxTbkZ4LaJccpM9o9morjh
         XdFAoUgsGM1Hx1G/4zla/o45vM8YSnYhIBGWoPiV2fkEy7/yocHQkWNsz505vh4/W4tJ
         G9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790824157; x=1791428957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ebr0zKwmRy5Wy2u8eNXuEfkoYnCwRU2+CdFY8YmOfEU=;
        b=bbiXAqYfTTl1Xh2ll2fm+7mp12n24N1/3s5M6JeeEbk+8+g/UPVS2TxjcLP85R0nsu
         jK82CfTSynLScnKX93DsAhoCDo2CUWvZjBGeprSvplleJbwrFRwxHwrIBMQYHbhKnitG
         +VkGcW2adSShj59oFpfEzxAa5LPCzdPhwHtk5v8tHJnZK369rS4OeoLbTP/tX6BMnay2
         w+hqEke70uvfwlED3RNmS10AEVOf8CJjJ8NBQGZHoTk3Gs5jrb5wWXz3xPuTkCa3uA39
         DZy2Jj/xQxXERb7b/X5XaNaelWAhFFHAo1450DmPwtayC75huCJctufUbnmwJmPQHZuZ
         V22w==
X-Gm-Message-State: AFuF++kiPFjpaDhQBNoFz/jpAzsWxjVDZnatKvXk3vTk9osv+7kE5tQF
	vyHZbi2XawAVYU/khBhF9uWmVKIQiuh2wTUlO/Xt+ksvxDJdeBWW/0zX0pU1ZNVWE0Y=
X-Gm-Gg: AYBFou1Nv6H40d5dJLEy9WjEGURo/Qm0KXFUSli5j2NK+0WtGp70Vzu2wwexlPuMSf/
	MJF3TPGi2gKYjbeMe3oRVVIlRi1Ou3E0X6K2zlsiHFAlKbPpkAOXYyma/Fv/kwp8vFBVvY3RHLT
	i0fg40qNuW0Gx66M8bAELGqBhhOB0by6puyJZ1FVJVPK9xALGhzcMn/p7VHEoXxub8uyNnmW7V/
	6nfgy99WtWtsgKLgxoz/6xB9gwdkLClXDokU3Twz4kaS3FfSf4BygsacJS9k+2/a+1vH80/y1tU
	dJGi3R182/05tVRyCAGdAQ+dX3jm0zZR14Q8TAGzrGDRF66qMa27EmOB0j14srHfUGNvopot4R9
	63a60LUDn3oNbbaiJ1Nu0sulAnV+OJ5U9jzstk1QSYibFT+mCJVvN8uFqOHZDTiQyD1U1f3meZ9
	38aanDHl8yc7OgvpIgkzNpCBJMlfsO/udPqTRqjLzcv/RYPhVy2UlIZwXd+cLdq+CqmMNGPjKCS
	Gar6g8OTvMHvfsRofB8vaWqgRwV/Fk6qA6JKmjiwqHk9zn2sP/vZJSYIsgiUQ==
X-Received: by 2002:a05:600c:6206:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-4a01b128d1amr54436895e9.33.1790824157298;
        Wed, 30 Sep 2026 20:09:17 -0700 (PDT)
Received: from [127.0.1.1] ([94.4.85.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9145e6sm27091885e9.5.2026.09.30.20.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:09:16 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Thu, 01 Oct 2026 04:09:13 +0100
Subject: [PATCH 2/4] iio: adc: exynos_adc: add Exynos850 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-exynos850_adc-v1-2-791b3516bb9d@linaro.org>
References: <20261001-exynos850_adc-v1-0-791b3516bb9d@linaro.org>
In-Reply-To: <20261001-exynos850_adc-v1-0-791b3516bb9d@linaro.org>
To: Sam Protsenko <semen.protsenko@linaro.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

The Exynos850 ADC controller located inside the CMGP block differs from
other Exynos ADC controllers, mainly in its register layout.
Specifically, the data register sits at offset 0x08.

Abstract the read_value() operation in driver data exynos_adc_data to
support SoC-dependent data register read callbacks.
Add the exynos850_adc_data struct that describes Exynos850 ADC ops.
It also requires its own hardware initialization and exit routines.
Add them as well.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 drivers/iio/adc/exynos_adc.c | 66 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index c1a0061b16ca..3e9b5d28b922 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -46,6 +46,8 @@
 #define ADC_V2_INT_ST(x)	((x) + 0x14)
 #define ADC_V2_VER(x)		((x) + 0x20)
 
+#define ADC_EXYNOS850_DAT(x)	((x) + 0x08)
+
 /* Bit definitions for ADC_V1 */
 #define ADC_V1_CON_RES		(1u << 16)
 #define ADC_V1_CON_PRSCEN	(1u << 14)
@@ -133,6 +135,7 @@ struct exynos_adc_data {
 	void (*exit_hw)(struct exynos_adc *info);
 	void (*clear_irq)(struct exynos_adc *info);
 	void (*start_conv)(struct exynos_adc *info, unsigned long addr);
+	u32 (*read_value)(struct exynos_adc *info);
 };
 
 static void exynos_adc_unprepare_clk(struct exynos_adc *info)
@@ -195,6 +198,11 @@ static int exynos_adc_enable_clk(struct exynos_adc *info)
 	return 0;
 }
 
+static u32 exynos_adc_v1_read_value(struct exynos_adc *info)
+{
+	return readl(ADC_V1_DATX(info->regs)) & info->data->mask;
+}
+
 static void exynos_adc_v1_init_hw(struct exynos_adc *info)
 {
 	u32 con1;
@@ -252,6 +260,7 @@ static const struct exynos_adc_data exynos4212_adc_data = {
 	.exit_hw	= exynos_adc_v1_exit_hw,
 	.clear_irq	= exynos_adc_v1_clear_irq,
 	.start_conv	= exynos_adc_v1_start_conv,
+	.read_value	= exynos_adc_v1_read_value,
 };
 
 static const struct exynos_adc_data exynos_adc_v1_data = {
@@ -264,6 +273,7 @@ static const struct exynos_adc_data exynos_adc_v1_data = {
 	.exit_hw	= exynos_adc_v1_exit_hw,
 	.clear_irq	= exynos_adc_v1_clear_irq,
 	.start_conv	= exynos_adc_v1_start_conv,
+	.read_value	= exynos_adc_v1_read_value,
 };
 
 static const struct exynos_adc_data exynos_adc_s5pv210_data = {
@@ -274,6 +284,7 @@ static const struct exynos_adc_data exynos_adc_s5pv210_data = {
 	.exit_hw	= exynos_adc_v1_exit_hw,
 	.clear_irq	= exynos_adc_v1_clear_irq,
 	.start_conv	= exynos_adc_v1_start_conv,
+	.read_value	= exynos_adc_v1_read_value,
 };
 
 static void exynos_adc_s3c64xx_start_conv(struct exynos_adc *info,
@@ -295,6 +306,7 @@ static struct exynos_adc_data const exynos_adc_s3c64xx_data = {
 	.exit_hw	= exynos_adc_v1_exit_hw,
 	.clear_irq	= exynos_adc_v1_clear_irq,
 	.start_conv	= exynos_adc_s3c64xx_start_conv,
+	.read_value	= exynos_adc_v1_read_value,
 };
 
 static void exynos_adc_v2_init_hw(struct exynos_adc *info)
@@ -356,6 +368,7 @@ static const struct exynos_adc_data exynos_adc_v2_data = {
 	.exit_hw	= exynos_adc_v2_exit_hw,
 	.clear_irq	= exynos_adc_v2_clear_irq,
 	.start_conv	= exynos_adc_v2_start_conv,
+	.read_value	= exynos_adc_v1_read_value,
 };
 
 static const struct exynos_adc_data exynos3250_adc_data = {
@@ -369,6 +382,7 @@ static const struct exynos_adc_data exynos3250_adc_data = {
 	.exit_hw	= exynos_adc_v2_exit_hw,
 	.clear_irq	= exynos_adc_v2_clear_irq,
 	.start_conv	= exynos_adc_v2_start_conv,
+	.read_value	= exynos_adc_v1_read_value,
 };
 
 static void exynos_adc_exynos7_init_hw(struct exynos_adc *info)
@@ -395,6 +409,52 @@ static const struct exynos_adc_data exynos7_adc_data = {
 	.exit_hw	= exynos_adc_v2_exit_hw,
 	.clear_irq	= exynos_adc_v2_clear_irq,
 	.start_conv	= exynos_adc_v2_start_conv,
+	.read_value	= exynos_adc_v1_read_value,
+};
+
+static void exynos850_adc_init_hw(struct exynos_adc *info)
+{
+	u32 con1, con2;
+
+	con1 = ADC_V2_CON1_SOFT_RESET;
+	writel(con1, ADC_V2_CON1(info->regs));
+
+	/* Bring out of reset */
+	writel(0, ADC_V2_CON1(info->regs));
+
+	/* 64 times conversion */
+	con2 = ADC_V2_CON2_C_TIME(6);
+	writel(con2, ADC_V2_CON2(info->regs));
+
+	writel(1, ADC_V2_INT_EN(info->regs));
+}
+
+static void exynos850_adc_exit_hw(struct exynos_adc *info)
+{
+	u32 con2;
+
+	con2 = readl(ADC_V2_CON2(info->regs));
+	con2 &= ~ADC_V2_CON2_C_TIME(7);
+	writel(con2, ADC_V2_CON2(info->regs));
+
+	writel(0, ADC_V2_INT_EN(info->regs));
+}
+
+static u32 exynos850_adc_read_value(struct exynos_adc *info)
+{
+	return readl(ADC_EXYNOS850_DAT(info->regs)) & info->data->mask;
+}
+
+static const struct exynos_adc_data exynos850_adc_data = {
+	.num_channels	= MAX_ADC_V2_CHANNELS,
+	.mask		= ADC_DATX_MASK, /* 12 bit ADC resolution */
+	.needs_adc_phy	= false,
+
+	.init_hw	= exynos850_adc_init_hw,
+	.exit_hw	= exynos850_adc_exit_hw,
+	.clear_irq	= exynos_adc_v2_clear_irq,
+	.start_conv	= exynos_adc_v2_start_conv,
+	.read_value	= exynos850_adc_read_value,
 };
 
 static const struct of_device_id exynos_adc_match[] = {
@@ -419,6 +479,9 @@ static const struct of_device_id exynos_adc_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-adc",
 		.data = &exynos7_adc_data,
+	}, {
+		.compatible = "samsung,exynos850-adc",
+		.data = &exynos850_adc_data,
 	},
 	{ }
 };
@@ -484,10 +547,9 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
 {
 	struct exynos_adc *info = dev_id;
-	u32 mask = info->data->mask;
 
 	/* Read value */
-	info->value = readl(ADC_V1_DATX(info->regs)) & mask;
+	info->value = info->data->read_value(info);
 
 	/* clear irq */
 	if (info->data->clear_irq)

-- 
2.51.0

