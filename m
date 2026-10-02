Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1A24B8288
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951572; cv=pass; b=Jgknc24mdGDiazJ7kJ1iaemBIacrjv82B89eYPwbpmoPWriZhtJhhA47kRwmlOGEC46R/6oUzmfIMT9S/MwMbzG64UEelKl0plXK3YFHEMVlwUox8Q4mMq6FRQLgbaOHqe/4veZ1QtpxaOzsZWU3CSKoW/9rmqfxkjliAd5lv6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951572; c=relaxed/simple;
	bh=bZmAl6ztxWgtImD9IPg8gArzLJy06elWJ/9P6bULdpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udGfzAbUjWPFgjBYxTWkFCxktZqopiBKsm/ykxkBI+U2f1IMaTTnzqoFft/yFKdsu1vVvDOa4uJBeMSLDzl01xuLbXwnCCpowT1Cs1HnX3RaCuFSbz+Vi34WlMjyUU4z0f/tZh43AzsVvnDY7Zq0VoE4Jl6Dj8sIOdZLCEyeqrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ql6oXgmJ; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ql6oXgmJ"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6ad186afdf4so6172650a12.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 07:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790951569; cv=none;
        d=google.com; s=arc-20260327;
        b=Mwo7DLwozOIUsLdgga4bYc/LK+/7tnHFo3k/YaZE7MUFcdcTmcjeFw0HDVJqx9RAo8
         BQ8i4MV3BqyJ38gwwQptCZ1AMSk5iBUeJJnrpCOYlPtWLOsjk5K037eZD6Vwr7x9BK4J
         Dw8aDAiW3v8L8AiP+0jBkuSXZW+sldXVKOW0k3mj+HI7CiSuuVEljyE04zccgNIJG1MS
         ceBqa0IW15i5A6QhlRu3ijQo1fJT0eDlXc3bhF787MsvMSISdBTsTUZIbXvr7fJXAMHN
         bsJv+fqgXKhA8U1qVmducRG9BI3m4S/x6p31P5Iil0A+9/d93YCKb6D/VmZvvEjZPcm3
         7vuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WVZnneXo79e+eMoEqif/HgEGGF2FDvOfyTIiKbvv9fg=;
        fh=2SFqPFTQ9QD2RtOiLnlfrHkzJRJ/BW28074sEXDbkZ0=;
        b=RHVNr6RmXQE9C73EGhFcKJzIJlyApAtGpgtbLjJs9bXoOJsXxZJB0glv21Imk/OYz9
         u1JuRiPia5I+UeP7j7fM8CckBTjC2VAlTs34xSHwDPGWwBTmwxi9GemtmURbH7/tIPfJ
         wSL7woYyI/WeK/Rc8jLSK4EvuMxZCfqw9e6l2W40oMzI53iFtaGXGL7I2sGB0z9xoF8p
         7y3pJguqO311m/niTUCvsRrsQyhm6iPV8p361V5BjJwlC0lFTOb9weRRKxbewxdpEvJY
         STjjBJ/tVQ7+wS2SllFTsHYiqwDw3bwgdkzvDWOdqepW6Oz3+xLNMWSgMOzyU5lWgZAJ
         PlXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790951569; x=1791556369; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WVZnneXo79e+eMoEqif/HgEGGF2FDvOfyTIiKbvv9fg=;
        b=ql6oXgmJM9iQfN4Vl6JClWkyeDmHrS99BDRebg3wSUSBZ/4Icllt0SjezxKw9fEXP8
         i7rYiI9wU06tpHB1bSFmznJUzwjUir5yHQGypE0QOWL+SPF0x4aulwQh76qe2MyVCFlb
         Zq4c6VcWPj2RRIqMCVDkcnQjKN8suo3g2TlWoVt2GgukMCkh0/JHJqcvzw6rNIoaXcO7
         zYYMf+8pwFF2WTrZPxYCHogXKW42s0mb8FX5FtPN0VkbP71r91+c3MaDYhAVbtNAWP5d
         9vmUYNTz1jlgAsyEKZ/uM/g9IbN/5sgElzuk4zUwFv4F4Ebh/GYLHPeuKDfv8i6Y/3Jn
         ZSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951569; x=1791556369;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WVZnneXo79e+eMoEqif/HgEGGF2FDvOfyTIiKbvv9fg=;
        b=pwsCSL4/hc7URPynJbNYkuCr31LlsBKmZIZOOiok5gqaEguTMnz0isgGi2npBLjDBz
         AunAKsY8riNK2iHWLZvcCEeQso4CBTmIboV3AiG3VrRizBCOQpefp5oxNlws8AdWmAMQ
         8kPNKtc1nwvLmdWBev0G5xMvQKC3Z3MxmmznC6OuszHLGlmdl0GkAxsm2LOiuRs70nAZ
         WjGOE/9ShOwrCa0jBiy8wqYBv9frRL687IW27bCNCAPRE4Cp7dHiLnyaNwBv+YNa5nsY
         pKcCV6MspdBpyjQFkFmXvSGTw72P2QIlbvWz9x74k1B6tsd26BNUEeJy1mcXMokQ/o+n
         Elew==
X-Forwarded-Encrypted: i=1; AKwUvBzJJcgBuw/+75r3VB7XjRq5wgxzxWs1oFx+uThQXCf4sYNnPQx6ge5eX+DzGY+0ONYkV3VlsETsT88=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsqJN0E93mvzd1b3nuwT9ix28Odsfna7Af0nRhThSj+iWIMuwA
	4nEE0JZZTg+MAKR3setve9DTJVbLd/CIGS7HcU4xJ9Of0i0fGrvS1FnOfYHBK/KrNPu6vYzeYu0
	pZ5Dxu+qJOkCFBtSgjlzYAOb6dzVonVzSTKDH7EVOCQ==
X-Gm-Gg: AYBFou3eW+cXfcDzEU4+7mVBBf79Vq5HdiCYGrYUdF6u6bs0EPykOOVepDL+qOopPtw
	FXOz9S9GEikq7nivFN+MZxDmXiTqnQsAOBEUC5fIzAH+0eTHBnO0/bFiglcl4kzkuqqBqvaLp8O
	y5wLoQ9HvkUxsdmMILHU4XM0UFP+pAMLjp3beDuPGzoaRUPNKh1eazx0qWJ2Gm7Au8fkP9JcbI/
	5RIQ5TqUupdoqhKe5PaARz/LTHLdXFmyXSxnb3M71uF3x/VXpD2XTonpdVc6d680CRF4K82fbXN
	6OaJDMoXRpzSaTrW/x9C0Q4NUv99chuXG/SWIBUNuvq7wJG6RiY4KuscxJO+yBqrgxSGGJ/9bCq
	LKlkRfsYPbrq7nA==
X-Received: by 2002:a05:6402:27c9:b0:6af:9dd5:f524 with SMTP id
 4fb4d7f45d1cf-6af9e312059mr1764408a12.37.1790951569540; Fri, 02 Oct 2026
 07:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-exynos850_adc-v1-0-791b3516bb9d@linaro.org> <20261001-exynos850_adc-v1-3-791b3516bb9d@linaro.org>
In-Reply-To: <20261001-exynos850_adc-v1-3-791b3516bb9d@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 2 Oct 2026 15:32:38 +0100
X-Gm-Features: AclHuK8RgbuTKFPwHvZ2diSbOtgklcZExTKeCVUevkgRzFlX0CzGjFVcTRb15lQ
Message-ID: <CADrjBPpOcpgLeRBYaf=RtLecjBEWK32icf8DcY5d1F4GQJ=WVg@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: exynos850: add ADC node
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Oct 2026 at 04:09, Alexey Klimov <alexey.klimov@linaro.org> wrote:
>
> Exynos850 SoC has the ADC controller within CMGP (common GPIO) block.
> Add DT node that describes it.
>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  arch/arm64/boot/dts/exynos/exynos850.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> index 8a4771899a8e..eb87225a756b 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> @@ -355,6 +355,16 @@ cmu_cmgp: clock-controller@11c00000 {
>                         clock-names = "oscclk", "gout_clkcmu_cmgp_bus";
>                 };
>
> +               exynos_adc: adc@11c40000 {
> +                       compatible = "samsung,exynos850-adc";
> +                       reg = <0x11c40000 0x100>;
> +                       interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +                       #io-channel-cells = <1>;
> +                       clocks = <&cmu_cmgp CLK_GOUT_CMGP_ADC_S0_PCLK>;
> +                       clock-names = "adc";
> +                       status = "disabled";
> +               };
> +
>                 cmu_core: clock-controller@12000000 {
>                         compatible = "samsung,exynos850-cmu-core";
>                         reg = <0x12000000 0x8000>;
>
> --
> 2.51.0
>
