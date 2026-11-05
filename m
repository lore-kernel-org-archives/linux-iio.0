Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846395;
	b=4lpyjxSmmDBoE1C2pyOuNpTXxizGuwOXY1eq/i3h04DxLP08SjppJ3IpXuA5DJitJO9O
	 SKf4BdMXlqKZUHM5+HPxIvATvgLcWwoFonPJjYAdHjWkmwTjKiPWJmhFg5n97y7mz7+Hm
	 0DYVU0MA1U8i8TFoKW2Nl9ZrFtQ5+hG/rpC7rdR6Ae1oAJFveeaanfLgldN67Dt+ngwSj
	 V1zhB3EKY2sEmucrc64HxZMY+iAMrdRhKRP9gl/ItbQfgIJIE96y2/m/gT8ZZiO8eNcoZ
	 zPXq0fdK9FNlR7UV71+vM66YlbYPGCm6vaHMUC1tEbwZWapsF1jSVOIbuz9/8Cjpw4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846395;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=8nHg2KK9YdUFsDyCN5OyhUk3RMp8EQBW/fDZ8x8OirA=;
	b=BzUVEwgt8LiZt7bpu0/Zl9k9K67disAvCebE44RmRmOaHsmHgLHWbSUxRmMnQIHaoWRv
	 LcN3vVfG7TK9uIRiWkogtpAhnY5Wype6ONr/WX2C3rXj68bmOJCKw1j+hyZGTzDPpNu7k
	 5liUU1B/llNE4mWlzwTHggq/19QOhspar1EGsH/27bxM2qXjv0Yvyw4I+qLYeZc41+xP3
	 RpjitWHmPsDmaAqVVKYWyMOsczIb1Dh4gIKMoLN9BP9Vz3N/MyT3XG3hEjx6h8ZKKpK6b
	 dr3NOPSa4W2Of5ZCsAH6xPeCU9DSFQa3SShn97x/QTFjGZWj4gb1H9GRQ9uzk6wz3LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=Nqz4+xih;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFC606A326
	for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2026 02:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71CFC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=Nqz4+xih
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793846386;
	bh=8nHg2KK9YdUFsDyCN5OyhUk3RMp8EQBW/fDZ8x8OirA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=Nqz4+xihSRA/SOazc9ytMPaaon6hM2Zpa/k876GDLA/rAvSdmROK7bgusiNH5yJRm
	 MxDa4YviOx4vP5CKZmEuJc3kfvwqLKu/L2OohyPYk21mJnJpm1Y7KU5OpOGkVf3+ti
	 zev+B3KBBNrXf3bQvlO8tLbPTEvcdSoXebx80EGI=
X-QQ-mid: zesmtpsz6t1793846385td1ac90c4
X-QQ-Originating-IP: jgdb2xzAqhb9lr3BxQNJ902WZ5AWSU8U65ma4J7AUyg=
Received: from mail-pj1-f41.google.com ( [209.85.216.41])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 10:39:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5678375001129183796
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1102405a91.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 18:39:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByjp6KjkaTyUBbKNm2Gd3pePX40pfb3h4cp3CBSrsmr6J6KpwPIGmee+8MxgGVFaTx1uwj8TUGynRY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cSLF608PHOZHjHoVQQQCi2GaHJ/Nq3B4oG4ftHqcBMbQHmgLo
	i6HNKDoX33oihQRxcy1gPMcckCw+l0aAPeUwS1C976Lj4DCn7EbCAv+dOBZnD2v5rSc/CHNfuOb
	RuiDmqdEN0zqUFm2vYVVY6X3+Ld/S3Qs=
X-Received: by 2002:a17:90b:562d:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3ae8982c1ffmr16206466a91.45.1793846382617; Wed, 04 Nov 2026
 18:39:42 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org>
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
From: Chunyan Zhang <chunyan.zhang@linux.spacemit.com>
Date: Thu, 5 Nov 2026 10:39:06 +0800
X-Gmail-Original-Message-ID: <872B2B4EAE847E62+CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
X-Gm-Features: AclHuK-lEE7dv-iC1Lsio6aPGOufL5hgelB1hFojisk2-zoMsjC0hhsp9HraOXA
Message-ID: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ivan Vecera <ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, 
	Chanh Nguyen <chanh@os.amperecomputing.com>, Alistair Francis <alistair@alistair23.me>, 
	Julius Werner <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>, 
	Dmitry Osipenko <digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MQUAIPmk2iPQdz4H9gfFskneD3KrVFCVpTONl50p8FJdow7ng0KFKwER
	KvdR5MxKAPThZ6vvjLwlhZK3j+mhXiViEbsF1EKIElIdG7ue2GYxUCxLrDr4gUFcVsfZKX2
	0ola5SlNOtkEqGistr5AGptcLYuiQiNosWU/ucdf8CdmEnhVV4h9tkEJS4r32/o87bdG32N
	LGgj0mmf8uwy42royZt+3ZyzWxJMx5QUNaGUYc6ixDtxD1F7vOk+XsdM419PqCHkAtgD0d3
	k+Jbb068Ex3gcu5CuK3lSj0WX5lCDcDVKF6sFcx9bW6UCiteSVSpmuv0Mx4PscPTnbpDw1r
	OdqrZXnCOGpGxoZyqOwGcYadxNjSuKo2AlU49IyCEkSCpHGdd7UKnfaX4X6VvDNik3mY5bc
	Fjl+dsDzVxF3JgCraeAZAW8OtDqy4zlFbaQU7AcTr8NcfQcZOIbeFbhkqXQ+MkmYMKfP1PO
	A34rr1AXg9f3gODhYxjT7miOlLtJiTSZnExPE+jOL2fX3h1fmwZ8I2g4mVeEirhPMO1AtaK
	6DHMvdJouyqcIXOTtQj9sxsRQ8KC7GCXlt9OWKwnQr8u6UEZoic1Usux+6J5K6fw7lep7ES
	qWniE06rEAILcPeA/SoIIXTASN/lCJBdhFARAZR0N9OQAIHwVDQFaOUXRquY9ZUOF7U+L2o
	+2TKsLsKAR8zbHlmug7houOueupGVzEMFNsvF6Nwq/lNpA9QKTvYYVWTigltS2qWCNQldxT
	hTCEYEOSptpDgo5hpA3lUFNC47CPcMf2T1p/UnDwrfuhHWnWNJNc6Eo6xkFCVP/hT9fgMno
	zI5Y1Ui8974JOP/Q7N2Mxnc6gMSJeYSfThEAwwyCya76uhHR4Luw6PDNXG4kukqDoH/YefB
	bleAkM9AFMwRsSBeJw3w6dPQEqkYQi3HAbwutKLYSnSpvg5s+PvLwiidhvD18nwGSNcwkk2
	JlI/ABxytqXN6qqq9TRR1SE2RnXJH6/LBtUNz3aWA8ISLQZa+Is/zoMKY97OZvpN50ovALT
	STByJS8NphbiWIbdx1B4ju26zPvk4Y2apFHJIxlvZPkcTPW7Ke
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

[snip]

> diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> index afa551f6185f..222d70baef1e 100644
> --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> @@ -47,7 +47,7 @@ properties:
>      const: 0
>
>  patternProperties:
> -  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
> +  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan
