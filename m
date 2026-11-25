Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616625;
	b=tOG3+/r4MV2WXwEQ2fS1ATO5ne777gd8/pd2WmYJguv9oSrKdsIKgdhtt0RKJYVEgmmd
	 3Rmi63M1IBt/gPHbFltkXYdfz+ErvsIozxiPgShF9im0DS8OyBAEQ1ddC5xXoi7sGH6PH
	 oM1AptwDaLEhUncs1LAVgsWH4FxfAug7u9bF6jb3Jze1/BNodPNF43c/A5hDlyHKlB9T0
	 YF7H5fr2j5Ddcy3nQ13lIif3Prne4zyD4LLnLqN30q7nzMBwE0kwu9FYMN+QuCNRPCzQr
	 I15sKhWk8ehgooIkHD8oKw15l1ft3fY9q4qgN9cNdCX9Mf5+7jTy3nXMvQGx7BoWQQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=0/aFPQt49ikbeQUDeEJ95DjEIDG8hIXLsnOyjwQr970=;
	b=p8QXZa4CPeYovUqIKsUunASmeLkkh8UeO54FLZpJWLLw6Y5CtVqfsEGvn5P58HdqERMp
	 qsmiN9vrDQ38lfxoqNocsOiAPN1AoXSFtLKFdr6ilaDBGwN6SsdAaAChHuxC8rEGSNyMR
	 cdSbd+sUn7UEP6BmdSbN8TUhX8WBrxFZb5MS9Jot9OL5dTlRtrlsYyzc0f8GupyT2k7sV
	 JMngFesBjkvNKlns8xcjHEsmCzXud4rinPdgHnLG7rqL44OjCZZ2uQ406Cv4OIHnaDpRK
	 1mjMQ/ulOuWpJoUZYsfdhi5oKfK3iXW6GVOw1WNuVt4blMme6rk3L2hypJU3i2m5rmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hiJcPhUU;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00EB606A336
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 14:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F00EB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hiJcPhUU
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso72561445e9.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 06:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795616623; x=1796221423; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/aFPQt49ikbeQUDeEJ95DjEIDG8hIXLsnOyjwQr970=;
        b=hiJcPhUULAmPztjzWi/HrHtJ9NlPw0ZsmybzonAHMZG3H7hf5ktLxpZKK2WpGaRmCU
         7465xBkTFmS1/bfrtmtkafpgUPmTwg9+lIqBpUf45FbO1SEZopixDcjb0s4LeseVkc+u
         zIUeYKMAs9yZrb3vj39jbA69KUpl6jBt2qFybYiwATe4KlBLkIHVkPk8syLbLoqNrKh0
         A0GPjX/O+QsT7CZObIuq+21p3gG1LPVVg/uJbWJzRmcWG3vgSVa5Ie45HsJb2ekOXVnv
         TjBdCErxqS2XwEchv/ECFoTCqp6NeZ3Z+z1+EVFyKb+CYzHra63jzqNWVmpgv8kyhARW
         bP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616623; x=1796221423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/aFPQt49ikbeQUDeEJ95DjEIDG8hIXLsnOyjwQr970=;
        b=MZvYQjO91YAwJo7EhaVYQN92qM0I4HTTkQdSYOlu/iwBRZT0b047RmkmbzPqLl+IVu
         zOjEnRYrkgntVwZiUwzFhKTQ11SWi0oWZbTu02nTHMmuu/up++5Z2Ytp96uRCdopIjtL
         QrTtFzYh0gCcbYHdZrek22Rh/yDqtPZVVnj7CvDqwe1pbe2NEwaGujI07DZ7umzLx8ZG
         VRZwR0epJ+jr6B2jwFJQM7ljUmgl9IggZYmPMgHy0KMUa0QSa125FCA59MkPMS0Tri1v
         eeij9pp9hQSMTYczZGfqJH8lrfbsomwLjHqK53bgONWvGCS7lRmYbG1x1C9BdlFDmAkr
         lIEw==
X-Forwarded-Encrypted: i=1; AL+hErFqTV8BjCQymLpl3fSvczpv6dJrs2m7XpzU3GxcUA/XioR4jp0HGog9e9ZYrGRDebcu5P9/Rxl5pmI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/klYVzvEpLTxl1Js/02z+a2uqdxxPk6LfBB0p03KE2GoeIKkmX
	QLarHbrHk32OwNHaL+WNOqPXjA4Wm21gfZ8aSBZJCoRrXdgKRrHSqvTl0gjX+KTlf3U=
X-Gm-Gg: AZFdTZfbE00l7Jg2qxBz8vXI4VbpHzzv5FW9poBMp4XtQVrpC9Rpoj/Syah+Kv8Ewje
	zrDMCWGIXNyjhCY1Y0nPYYr8AczPtw3AcONs80R7RNeFOs3Q1WNy7Gl1sRJkGThLVBSWQMdjLtv
	c4OhckhioESLd+Jkf1HWJsvKnX2KvuAmIr0sbW9MbaSbIIlvIAL2DV6HSQpnZNG3uUESveBoX5g
	Nh+WmBdRPvtvmQP7Ew25RUghZ8xskXt1Lm+VKkv9IAjCPCZKqcmwvEy2haYEllcvXbKnmKmTz5w
	94wprHB9IFLb0l5XbP/dN7ECJe2NooVGd0ZhMVCmw4AbPs9BNDG5931eUppd6XuApR7igZZE/lA
	gPzqx5QDzLBgBMarLl2GigsngPdlk3cXBw7muLmoCM80cQAefOOwoOOz7DcGrt7Dh6/vbLKwQk+
	TBMv36IysHLIQzUHUX4Sl6uOtxZGt+/b3O47AVAc99dioFBORB3b5n+r2iivQub2e5c6U9EWZHG
	GeO9Zv3oLRY7gxstlSkvxXLCoPtcrsxByLpEj+VJUzeSNdHgGHqhvLKxzGmqgGeqD2R1Zrje+An
	kCTZP2MY6RcQj7mgSYG6CtI/dzd2ASHiuKfXvn+2knCDUHdFir9fpjftCfbp0soxfsG6uSZkNhs
	5UMm7RZEktsQVBZ+7V1HtWXU=
X-Received: by 2002:a05:600c:3ba3:b0:4bb:6118:4c9a with SMTP id 5b1f17b1804b1-4bb88819940mr421222855e9.30.1795616623233;
        Wed, 25 Nov 2026 06:23:43 -0800 (PST)
Received: from [127.0.1.1] ([2a02:c7c:5e34:8000:720:5dc9:500c:65bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm33638667f8f.47.2026.11.25.06.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:23:42 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 25 Nov 2026 14:23:35 +0000
Subject: [PATCH v2 3/5] iio: adc: exynos_adc: add Exynos850 support
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-exynos850_adc-v2-3-26de1c6f1717@linaro.org>
References: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org>
In-Reply-To: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Sam Protsenko <joe.skb7@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.14.3

The Exynos850 ADC controller located inside the CMGP block differs from
other Exynos ADC controllers, mainly in its register layout.
Specifically, the data register sits at offset 0x08.

Add the exynos850_adc_data struct that describes Exynos850 ADC ops.
It also requires its own hardware initialization and exit routines.
Add them as well.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 drivers/iio/adc/exynos_adc.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index a1124a418f29..3e9b5d28b922 100644
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
@@ -410,6 +412,51 @@ static const struct exynos_adc_data exynos7_adc_data = {
 	.read_value	= exynos_adc_v1_read_value,
 };
 
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
+};
+
 static const struct of_device_id exynos_adc_match[] = {
 	{
 		.compatible = "samsung,s3c6410-adc",
@@ -432,6 +479,9 @@ static const struct of_device_id exynos_adc_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-adc",
 		.data = &exynos7_adc_data,
+	}, {
+		.compatible = "samsung,exynos850-adc",
+		.data = &exynos850_adc_data,
 	},
 	{ }
 };

-- 
2.53.0

