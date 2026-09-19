Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1091133938D
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789824677; cv=none; b=IvkojHO9uR7V/PeAM/Sj7e8lr0U2kIlVPlthZf8AGSBjpFfXSEI4JALEXFAAymcalUrie5k2QLwXZbbwpbTzctxj418lP0nT6gFCEZde8/hySxY7ueRUwaWwjwmh2703fCFNLp22GDGHhA4hlrQds+FKE5Zp83uo3MI8luJKfSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789824677; c=relaxed/simple;
	bh=Puhb9y8XG8KLGLMFjlsPhq/rxjMdTvMoxR1pFU+GbOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m4vyJKxylpJGNtdy0YVPSWF48mHJ6ZdXSORlx1RlZ+4RsKIOfo5NESGlgc4Q5ZYPWrUa+L7vetl6VwJLbhZrjM5g5oXZ5tewakPqCfmYL2apNvWdCqxz+PsvCfjoUKkM312HllpRcMdYE6JAYCsP3vzeQSyGypVPWQEsqmgxNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=or1/tCms; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="or1/tCms"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so9503785e9.3
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1789824672; x=1790429472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M59/iU/94UEEWnEAOxMnAplI0bpHeu60K9JCIDTKOvo=;
        b=or1/tCmsTRrZGSclfbKWwbs5ZMvAWDaVgdLfYrQSf+U4ApxQbn3XFGLKReFn2tyyTt
         3LUUgTTzNBBJwG9hvoF2oqlu/t/r54fX68AERs80Gp32+qT7p/qvw/jdRIEZSDmpbOlz
         YFbnMosJoBdoiW0vZZeNl5gl4OxjeNahJVhV1t535LvE4G9ND8OO9Kd5hFrJ4ccqHfaC
         7yWzJLE1Xf2EZ7vN2xcziaegFaRPP6EPT2KOXtmJeJ38yvMAaL3jQQi3LNtAhKUr8kUI
         EaaD8oPpeRIf4baODu8847f2ODi/uRup78Zloift2T7OE6JvstkyvBCxw4LYFx9U7BU6
         WsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789824672; x=1790429472;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M59/iU/94UEEWnEAOxMnAplI0bpHeu60K9JCIDTKOvo=;
        b=kSplf+mA3nmrasljgQyTBTG0MwEoU/I7u31LMVUscIkTrddv9qHS9m9JM6FWV4djOO
         e13QY154BD5SRKOpoqbX6Lmbi0vHaqSfzvNV5xT0Gn7bdP8QdKIlPdtcHVcROTxVNEK0
         G69Y+U8Wil+kaZsrLeaeU9cluT6qbrHJPbKHB0FeX8MbsAzzomeIamliNmkJ5lmBN/aq
         uwwqT7B7+Rb7zhhP5AUzR0DlpSMe9VOdQllYBAaTXDYbbs8X/ymKr3tCKTsxx1ctZ8KB
         IRarjVQMToOXKwnqX3VvDE98uz5BJVlSgaFIIvf9qFTL5zFIQrNTAiw/3Zg/164vcWnS
         syxg==
X-Forwarded-Encrypted: i=1; AKwUvBymgcdJ0tLGVYtrKY+pPhATtVU3IEgS5o+UZZ49Ecj4/s3NZesNzJ/DNoj6I26gu6roNYLHBch6M/s=@vger.kernel.org
X-Gm-Message-State: AFuF++ldklRvE95wOyUryfJEqbCPVJeXedM3aJapqykj3rz5jKZVfP1K
	FXWBmcYlfvP5Rh37ChRwS7A/PMQjam0+VP8V2H13UOQYqHqX1/cVSsasRTNFz/YakKQ=
X-Gm-Gg: AYBFou1I+yv2DB1Lwl6wkdbXu3Q4Qx+pNO3bbWk1zlGvJO0Fw6BzEecv41euz1iUVSW
	8UWDThUpevUcJIAhgs1KfZkwxoF1oOEISzwX5mHI8P7uy+5wVln7cS1sw3wZHIYGDaZh87VHj2o
	AvLrJ3crdmnZ9Up+0n2PcxRNkLNsoE3BLi95Ni6ylPhGkkFN8CreHMugVIvGCEZAQiECJ9bBZEQ
	LJBMTdBs37kx26G7/fkVIutPrOMKtJGWCYZKTY8FSuHAD01w8JdxZX82xi3zNlxBc7X6IKY5WeJ
	x4kErUMM/wPgSHhQvC05hyEZvzFzqP9YmR21qpWsHuuky8b3U0yWCCW5ly7DREWL+ylR7TPt1T5
	yWPvXzCwJtsAIWb4VoreNhYKnJ5Cl0SL8ZM5bo6/YwCxlniZJjrwQ3N15cfv5+NrLUuv4Zzuvpm
	uRByA4qm+YhpoBHr8+9BJSk+8/v3B7g4SwM6qzkB7ltrvSSA9SjR6xJZ5lR6SbNT5c55YktGGs1
	AlNq2CD5yRRNWsR2lgKCF/8QsKL6hSeUtqCojAh7ygxfbp+rxg4VJM=
X-Received: by 2002:a05:600c:6211:b0:49f:bc28:e8b1 with SMTP id 5b1f17b1804b1-49fc5735be8mr67988985e9.14.1789824672039;
        Sat, 19 Sep 2026 06:31:12 -0700 (PDT)
Received: from ?IPV6:2a02:2f05:1204:e000:2cf7:c250:64a9:ae77? ([2a02:2f05:1204:e000:2cf7:c250:64a9:ae77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd086ce9sm105569825e9.12.2026.09.19.06.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 06:31:10 -0700 (PDT)
Message-ID: <b63a2054-c695-4bdc-809c-924742526122@tuxon.dev>
Date: Sat, 19 Sep 2026 16:31:06 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/17] ARM: dts: microchip: sama7d65: add otpc node
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, srini@kernel.org, marcelo.schmitt@analog.com,
 radu.sabau@analog.com, joshua.crofts1@gmail.com, jorge.marques@analog.com,
 Jonathan.Santos@analog.com, jishnu.prakash@oss.qualcomm.com,
 antoniu.miclaus@analog.com, duje@dujemihanovic.xyz,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
 <20260806074024.531259-15-varshini.rajendran@microchip.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260806074024.531259-15-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/6/26 10:40, Varshini Rajendran wrote:
> Add OTPC node along with temperature calibration cell.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>   arch/arm/boot/dts/microchip/sama7d65.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> index c35f27615bc4..aac2e22d96cb 100644
> --- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> @@ -15,6 +15,7 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/mfd/at91-usart.h>
> +#include <dt-bindings/nvmem/microchip,sama7g5-otpc.h>

This header is not needed for now. I can drop it while applying, if any.

Other than that:

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

>   
>   / {
>   	model = "Microchip SAMA7D65 family SoC";
> @@ -1111,6 +1112,21 @@ ddr3phy: ddr3phy@e3804000 {
>   			reg = <0xe3804000 0x1000>;
>   		};
>   
> +		otpc: efuse@e8c00000 {
> +			compatible = "microchip,sama7d65-otpc", "microchip,sama7g5-otpc", "syscon";
> +			reg = <0xe8c00000 0x100>;
> +
> +			nvmem-layout {
> +				compatible = "fixed-layout";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				temperature_calib: calib@41435354 {
> +					reg = <0x41435354 0x2c>;	/* Temp calib data packet TAG */
> +				};
> +			};
> +		};
> +
>   		gic: interrupt-controller@e8c11000 {
>   			compatible = "arm,cortex-a7-gic";
>   			reg = <0xe8c11000 0x1000>,

