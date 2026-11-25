Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616626;
	b=yMJC7bqFuTr1jOaHSZxKsqB2qF59tUiNNsjCgQSXA1tPY709Vq8WzHSPVFhlemXhmITo
	 NYk8PZi6O5NVqLQhciZFINAogoFvvYhzd5k7z0i/mjXYO3nWJRa/SbBMy5IeXqkCnaftN
	 lO+1zIroCkyIMhtpYk+woQIbRa7EojjzkbTzqa5mHloE7SLtXaWQNqXlV+N0OqggTb1WD
	 4Ny58zS+pkZ/0IhNM4IWSg8CntYDnjiXtWXUixiThKNDxOQVAxIt2/SRvjLh47ApgWhu2
	 Utn3yyFOFbbODde1HCDzX0NHYNNOpzmDCws275M7LZ3W1uy2knHd7aho6YNn6DGZ1mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=W/tWqCt9Fy+4s0v2ubcz5FyoYjRxKRthZCQi1c9cxS4=;
	b=lsQcSvhrMxD3bHxln0EKRDmUprIC9fINWKgkvlY7bwl1Di3qmoVjkHj1SfO2FOAGz3Md
	 mfiQY69xYASBrefZaA42P5QI7H72kIsnMzfEwOALinn1cML4KYHbaVw4XCkhC60zkZ/ok
	 fB48rXluSJ9kfdhw27B/yJ1Qv+17fIuBf/ybL4d3OWc24U5TJ9ZvmhRXrWoF34gAW9w3v
	 QiTS8bhURI4BoJ5ERUzyvTIDVh4HmDCDU85uMxHakOdJHyAyDSDgG0QTVBbry1SrmA5Uh
	 5d8AdRl5RYNPTPvKw83y1c4kXV9tXhvz0eCXQWRUFXiR3VHqNBqaQzX13qXaqWEuiZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A0sRnbpd;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B472606A337
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 14:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B472606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A0sRnbpd
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so4517845f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 06:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795616624; x=1796221424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/tWqCt9Fy+4s0v2ubcz5FyoYjRxKRthZCQi1c9cxS4=;
        b=A0sRnbpdEp9bRwWm7n1SKo07iYgVbG4yS+gCF3Kw3P53kdbbL10p7APEcPps4zUEkL
         AegJrjCRe+13LmBOZt1u2XpQFfogVQkHH6rnhfADXugUhZf3577Ny72g8tjqqOHMhBV1
         KymRC2cRCY6oHj/MrUXx/Oc3/+mKr0bindxjTz0TRFl9QBYJGjzJMTnaYBAAUVnuuKrq
         oHeYZKe0DG7bfX/5wfnFRLDpiyQQITqXoHWixZ1Dwj4K0LxUekBinW6xBWpa55kbVOux
         kkYhQ55BvBU9Q7nT8GzjvxhFPE5FsBsRBSJTmHrIwelPvNjWjsOo0pTE4LNDxKegTbY4
         q1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616624; x=1796221424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W/tWqCt9Fy+4s0v2ubcz5FyoYjRxKRthZCQi1c9cxS4=;
        b=n8f5MfahcHtv3YdbBaZBM8WosA7ycZtMxLdKd3gRy6u8VRXIPJCyC+R98JVpNjZ+zf
         L8i1JWfZtvxFbExiO4vM0WF20ixQTvHCj1MrgshoeTCg+oCap7PnrEgIhWkFq4G2hg5i
         Hi9eo691tSFzS9CqrK1YNiwC72wiHTiUW/NWZ7H5eoWB0nljnNyx5pJhBHLDi2urTI3I
         +fb/uvGTBIWRlQbcpt1SjleIqxNP11QpTtJphiliSrRBnZz/QQxJGeq/C9gGwPeZuNYv
         wowT/3lAToDZMV6UAOzB5h0MOFcIxR/AgVX6OiXvJd9Ceko1b+OwnPkKqpIK4iU7KLay
         MFcQ==
X-Forwarded-Encrypted: i=1; AL+hErFqA1qVxm6QYXvH+qF3JaJbZ01uprdbNJoGOpZFyP3kLKXXa5PkjvjvE+uoue/LB3AnWjwHMIz/trc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yPap0thZ1disuUc+/Y1YENlJDS+vDpaJV0i0yCFJ4CehMQPEI
	vvPGFWYpr851bn22to96pyNGZg6tUl/+EhhNK7URVzurnsb6xVm8o8EXL/AWBK35S0xDanlyETM
	zK8/KX8s=
X-Gm-Gg: AZFdTZcaDYlIVX5K1BOf6Y5F5iLzVyw6wK/b9ZAtvAD3adJs0a8kLm9ioaAV81CvmcD
	5HeKOHbZponatS+zzBDNucfKak2ZvbEzgrP8OtutZrEA3PlifbhSgLkfGx+eTMkdoPaVJgnD8sQ
	CG9gXFmLHAEewsB6+ihH+HbBvIXCOA4/nQqVxKV2WVIaOojcohYATQQM72g+9xZkiBUEBLdxd4q
	QpaKTxYx5/z+i2Q/1/+TVmAKyxIomhsP5Ya4mmS3MO6Rxg7WfXH7JNE7QPvHZpbO0qNco/BI8Eu
	JdCJJR2NTdbbsa10eDDwiku/JaFwsSt5Cd3s7U6V8LSQVwMlfiIpzdrhQj6EAhubqG4TaWjUYJt
	p2XxHuH9RQwBB8Q9mh8+5I0CBRLw9eU6oTlhqrw0XUO09VdSGAlmDgpFz0ysLoxS7Qi+M2kNbQS
	7q/FsHN16QU9sFijmqq0tCcIvD4HSFT3IChjzyN8hFcpDrvL206qN/EUDWw74m8YjCY3J5Ai2C0
	tot4R4X9XS7v/Ak6iv6eLE+G6af1jfhInOjD9gQvQSnNjixFMCZGhsOlolng16VWf0jpI9p/N10
	+cE9v+xe2Iyi1YsbHmuKROzCutAS4xGilJZopoJul6ojXGxmwdnMaeqfTa7daI6i9g0UFbxkqWG
	96lsfNoEEjtq2tyCe1DhLtbiEI1vfBNFBAm8zPyoLeV8=
X-Received: by 2002:a05:6000:2401:b0:4b4:2ce4:6dc4 with SMTP id ffacd0b85a97d-4b42ce46e8amr17140435f8f.48.1795616624336;
        Wed, 25 Nov 2026 06:23:44 -0800 (PST)
Received: from [127.0.1.1] ([2a02:c7c:5e34:8000:720:5dc9:500c:65bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm33638667f8f.47.2026.11.25.06.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:23:43 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 25 Nov 2026 14:23:36 +0000
Subject: [PATCH v2 4/5] arm64: dts: exynos850: add ADC node
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
Message-Id: <20261125-exynos850_adc-v2-4-26de1c6f1717@linaro.org>
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

Exynos850 SoC has the ADC controller within CMGP (common GPIO) block.
Add DT node that describes it.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index ace747fa80c4..feac3ebc4de9 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -354,6 +354,17 @@ cmu_cmgp: clock-controller@11c00000 {
 			clock-names = "oscclk", "gout_clkcmu_cmgp_bus";
 		};
 
+		exynos_adc: adc@11c40000 {
+			compatible = "samsung,exynos850-adc";
+			reg = <0x11c40000 0x100>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			#io-channel-cells = <1>;
+			clocks = <&cmu_cmgp CLK_GOUT_CMGP_ADC_S0_PCLK>;
+			clock-names = "adc";
+
+			status = "disabled";
+		};
+
 		cmu_core: clock-controller@12000000 {
 			compatible = "samsung,exynos850-cmu-core";
 			reg = <0x12000000 0x8000>;

-- 
2.53.0

