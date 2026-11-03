Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732348;
	b=I8gE0dP6cCKQ6pYvf0P5nNQ56V3WuYDFDZZi5hRuCk1apfqCw6A7EQl1gAd6k+f+tQp+
	 RcKAyEQH6ejgVQOJ80bYT+yYKi/rKc+cLo7sga4lNwF0GKhXT+Ls+ABaWBvXQZGqQnjbU
	 m4ykCfxfM8OayjvaqvagSpxUN2+/oBwTPAWg7C/Rz93z6n0l8/hfi5OpTPDeWTP4v9Qyr
	 0VROO9eNBDVCpSVqgOsaSbbJx0OZhoj4hJaRdtXaHlyZ091vmHHhytLcOgyHf4m00v8WG
	 JtdgipbNCIVUiieziVCmymauZEr4XsJahlIl8k0KmHI6Xb5HEScNuKvJyQSAbJsVf+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=J7X+N3b/Iozr8Iw7Q9vLqcq+wqZH/CWnHiKVeMbKEmo=;
	b=TZ1++ey1JMIoITl+C/Q1QjmJ8DWZ+7/BN85ei2h9pzH23QajPAHS8tNL4HjUhf5PYOVv
	 TGf9AXGRD7y5ZU7uIUHTmawAq9862o4o0edti9ccJ1eob4Na8Dbyvqj0JDk5K3Sf6Y4Aa
	 /42a2ldDU0Ml3KYO77bq5WO31u1uBwB5I9aMaGE/Fwr3sWxY+ifG/CM+qJoMuzG8itGfT
	 qjYG0YxItiHSqTQZna3up1glNaVcGt6nDdON3MAU2EQANjt6NPTk3HWz5FoI6S536PS2S
	 qFu2jLLC71+7/R/FfqAEu1Mzcm3nUStbU2aziuCuwWQoVyM09qc4pVC9NMXyHHpCIhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MUGv2Kdq;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A0606A334
	for <linux-iio@vger.kernel.org>; Tue,  3 Nov 2026 18:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D7A0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MUGv2Kdq
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso7522358eec.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732347; x=1794337147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J7X+N3b/Iozr8Iw7Q9vLqcq+wqZH/CWnHiKVeMbKEmo=;
        b=MUGv2KdqugwUjwtDn+5TEs87XsBH6SLTKU2VnuO7MeKo6hr4G5WH4O55wxRf43JXjq
         s4GLbtJziYvCL8aJeaRkPvbVSJRuYcD79RqLOhm3K8WcuWsYcB6Ziudrzsv1CrC07u0F
         eeK0IGODbK1MBN0NyElMx/axzRgFDpbY/f4N1s0bQx8OzhaCbM4C77eijEtz2tK6avwd
         jIuK+W4ysYUA0fCY/zhjI3sP/rkF9QL4GSrBo5192CeRPPyJlisVudQsAqBsfuVbx201
         8WfWRhga3xBSMnG6+AMLIpCzka4/V3h3bqBZnqQBBngmWmeWgvYnwglc9N9f6vswPPA4
         4s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732347; x=1794337147;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J7X+N3b/Iozr8Iw7Q9vLqcq+wqZH/CWnHiKVeMbKEmo=;
        b=SA9/sledp1sghkGMUAm2ewguOoW5pAVeWcnW5InAXZjlcxn5KCiSRf/ircJWsiDjSZ
         R3tnlMmpBiQW2J0AYnFuU00jH0lUj2+2UvsfEAqOGS3vlaz3ztTyjGOOl0DWgkbigrNx
         0KQj6RwEg7zqrEoixpEtZBFVZluwDXdT1D8abaqdoELe56rn1pbsJJIpc/f6lQ/bzUe0
         xH8Z7aacV+5ZtdifBxVmXx4OInUMJL3kGFhJws7+3nmHMASIPBztc4KEB2Ljlk7ZD5ba
         6toNFkhxK0t/7zbIMdCE1i4SHsqdgqO+g3hNGX8u7gulj5RC1GIL3h58cRnSImXgvflo
         QHjw==
X-Forwarded-Encrypted: i=1; AKwUvByerq1aY00uR081ognAFq8jrbYpwyQn2WlFmhyV+PXQMNKkWS7Hlu8LQ2IRiSbxbvP9+934DAgrw5c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qPq9EZSdAL1SZjc2XJeZ+HT5ttmX1TmWQsBPvozwppkg29YHw
	Kcq9fqBe9LFTrl4M/Utj5z8DCCU0ssBOtpmflXG5/GXAhtFdMW8PNMmC
X-Gm-Gg: AYBFou3wxbx3mNZAyHAxTrJZ2M56m3Tz/t1hizUEM2/w/QgI9k6NBCRspmGnBEDSWGC
	gOY7N9ECTVbs8eH/x14QgZGG7IqigPAK/0MoUTydWd2Dd/kr/cMPfa8fes0VjM1d9ejhpJVnSdu
	KnY7hDQjDVC+Eo89A+UFrDfyMEBIkgLhcS6/sZoImtPHaEJu2KXFD85C73kWfh+U1UJ2lzdNP3e
	0NVoBBfrKhKFdJLzJn868065Iz7gzx8F1PUtKgjr0ptkJL7Ak0+RorKLWqdZbpiQ+8i5aE0Uj25
	rKDsPWmxKfUih6fCU3oTFZQ7Dt9VOMArsjvAHdQd4hRt94eRMU3yi2vNIoI7VGAvGNOz67RkRWl
	oCAgQme3fCkN5w+Cxz+UggAYjiINkvlaAbKA8j9xHHeDcwEP6yF40fygU2V7xqwaqOkAfc8r34C
	YtHQK8213P4AMkF75P5EaijSM0/BaJv+qblix9L1eKPPAZlCGX+IWh4NAscwtYsAbDxmGgLHSj0
	/Z5Xi2l3n7x/W6zdB3Rta+L2ij/FCjcBT57rgq++Kncq8pBV/CwmTgaFFUfemVbiIGU9wdVENrz
	QswXF5fdksXMn5h9Ca2OjCD30dJu5M+H8FlloRCRPngVzhA0iBj17RrNr4Pv3Cdt6AMN
X-Received: by 2002:a05:7300:7b81:b0:351:7ec1:a92c with SMTP id 5a478bee46e88-36a42431768mr30787340eec.28.1793732346941;
        Tue, 03 Nov 2026 10:59:06 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b3b7esm49159eec.28.2026.11.03.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:59:06 -0800 (PST)
Date: Tue, 3 Nov 2026 10:58:59 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, 
	Chanh Nguyen <chanh@os.amperecomputing.com>, Alistair Francis <alistair@alistair23.me>, 
	Julius Werner <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>, 
	Dmitry Osipenko <digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sound@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-tegra@vger.kernel.org, mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
Message-ID: <auou2CBiiR6zA0G0@google.com>
References: <20261102135330.2493332-1-robh@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>

On Mon, Nov 02, 2026 at 07:53:22AM -0600, Rob Herring (Arm) wrote:
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/display/xylon,logicvc-display.yaml      |  2 +-
>  .../devicetree/bindings/dpll/dpll-device.yaml        |  2 +-
>  .../bindings/embedded-controller/google,cros-ec.yaml |  4 ++--
>  .../intel,ixp4xx-network-processing-engine.yaml      |  2 +-
>  Documentation/devicetree/bindings/gpio/gpio-mxs.yaml |  4 ++--
>  .../devicetree/bindings/hwmon/maxim,max31790.yaml    |  2 +-
>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml    |  2 +-
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml         |  6 +++---
>  .../bindings/input/touchscreen/cypress,tt21000.yaml  |  2 +-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
