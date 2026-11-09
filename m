Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794210020;
	b=nX8mht1DZ4CEcKAJ/6McHjBTKePMmhnjgwRovxr65lXASXWOzdfsprIuqSZqrQQj204k
	 c0LKItNmBp90V4qAQRDOeG4tzo/M7DGkKJuGGMx2cEynvivaJpHHZJfrADOWK4JL5kAo8
	 WVAEGQeJp399RgltaAOOiN9pBpe5OiBCiVWM5+C+fExEx6TS58/ibNFd6ebEVFldkQCoU
	 MPyaQw62q5hALDrEZuUMn2qOVeRWYsAQLAg+CdKruNMF7kzYKstKVyXkQxYIqHoDJbpxp
	 xAcZjqGuSaDs1HTTs3c2jIEtNot/z7qWFLWnWTnLhstCpQ7187JNVk6j+on7TE5sraA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
	b=QBesZPWX15By7jNyXGqcoxXYohIVHA3FpN6hLQjn1pYckS6iWWHPEIoFaEXBz8P4v0uH
	 vrsxypH7JcYDX+gw7MTuMXTfyPSrphSn15m3ILvCfsHchldreIWAVRGaSPBiwulbLtiQ4
	 TnaBxXhcK4IoxpL0oISseB0MJnYr7ckMUOsOEiu56ac9+cyEl0AB5+h+E+E9CCoPmStIn
	 Aem9ePOT1m8fglaEX4kNWTgGFBnIIeBOS7V+bVl8RYGFbhKgfbuwS3JleyPxZSORMzjkI
	 c2/a9LzYTnDghKFrQfxhEhzYeCboPJ8GiNqphhtMKQVUFiOdiLcpMqCvRrkgqXObdaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fw1HJ3eB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9F606A331
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 07:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC9F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fw1HJ3eB
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so228658a12.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 23:40:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794210020; cv=none;
        d=google.com; s=arc-20260327;
        b=skd/RcrWY9s40mLkvArSKwdSQhpMGWPMyB8oBptbF8w9c5SKInfRlF7V88G7WPWzba
         WN/110uEy9fUR7Git8X6Vy6QTCp1mhWhnNTckWMNxeUbDm9DTk5WpmVt7my67HfL2ZJ4
         Uvi1Rby7mBODe9X8DSFyZhqwk6yJGGEpEd9hx3enkAcoBe+cd1Hmu4NkU49gMYDtlX2G
         1DYRQDgprbBlDE6+KPS3resKOqOW9amaolmadruq/WIAEFW9BBF2YHi8sOxwfrvIkb70
         W1eD9TlAmIIg0xTLxBcm9otarHTCz6XNYM7tSoqFiMd2aOjX25gXye19WHmFjaONaHxp
         6PLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        fh=d6UcKgKNb/HsoRXLQD+CWDmrq6jSXLkSGIOXhVbsfag=;
        b=Zzypd+mQBLzPGu5uVLhp5hdHuOaysTwW3/s8/ul3AFZ30o48GT6KIGRiz8je8Yv3qJ
         HRfZDDxshut53w1dn6oGY24d66UrJLzawSkLGrovNWTvPEfDBy9+FNUGUy0vT9FzY/qG
         jLSIP0aumNob/5HJSLz6V6unIxOxye4qctUjbKHPdTMQKm+E9PBtL02rpF9JHR44IjMi
         bL+Fo/Tv1BY/b6xP1Tg3M9OWJO552NSmKQ1BzjyACNJngHRNpOYu9CSBqsPZ/Gt0x31v
         334COY3BiEVTsoVNPv4l3BlSxIFA9xG9AHRvVpu10nZa4kC0SObVtguGKmcWI7oGQ07v
         j+6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794210020; x=1794814820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        b=Fw1HJ3eBrEG+YcG2OfXIKNyXLbtxL6pFyShNR64xnTBicLVJTLcqI70PP7XlmXPNx6
         VWmQ662eksYGc8vJo+lcMpjTIaYcJB9aokKPIxavS8OWhjpOs8W89bix1ozwYvKeb3b4
         M7C1Y4n+R7cdsAeFDh3I3fT0WNvzf0CnRZWDlQZYC+5M2rSyX8wMQx9uS+vQs8QSo0d/
         2FLip2Uo0zLuYIubK7TNTBZ4sl8ZrZ+JeHk7SDm/ZlHHFtWu1M3YyNEi+YttPBGWC2RM
         X/hXAhXzRlZNf20NwByFmIPl+GnzmQCqAB4nehLzmm3jWxLA5k3xC+msTg/JbR6XvUqv
         ep4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794210020; x=1794814820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        b=jA8JOC3k7AKlCN4SNEjakCAsUCDBwyD+tupJbkDf12e9cu7PO4RzkebbTXvxfka62Q
         8mjy3yYkJ5HzU+14O3MtiiFcJRvLiXs1+ZYNCH2NeQ9rir6ylXY1XOe4d7ifPElqfe9Y
         zLz6mNr9zyC7bbtKIS470EiBOm6G0Ev0D6RD4y9MaxhWbtq1KJD6qNLfUY3g46J/OQ8X
         Ku+KMhMmcdwM4HqalVuRzCm4fARp9GePSOKdFgOiac4T+GR84gQ3J/HGd0b96B5Ylzlh
         nOb+xpJ6ffbdhg4s4BFst4vcLpob9xvOmZmT0aXYkEkvcaqbpLXIL9T/mH9iAUx+vanr
         qJiA==
X-Forwarded-Encrypted: i=1; AL+hErF+IE2/N2l3mPZNHHeo2lLZMdZGoaS0OCs0HPgirYvh63Nu68C0e/AdttmwTV5FZIL3Yo3AVtRoLG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/Vr1JK216XHvPyqNDwWwcu0qORJbqtOUKGQQOUcTc74CQytQA
	gU6geDXimssh4lr8fdPVF+bNCC/GHztAuHrZUsvD5TFRuHe6sZ7FqZrD1dok0jkZzQyz+QJnVLo
	byanHJ+ZS51ipBZmQblCSHVgPqvivmkc=
X-Gm-Gg: AYBFou3Uvi0HM8kQmsCEWKzQ5gqRO2W5NQdT5NRoP2IhzUrbHgubqSFZS88scHdMxIU
	9YPoXCOvrD5MZc07Jw8WpUJpJutBw1m5RgPujUs7nvThDThIzeG5aCSfsb+1lGMO+prZD9MeDS2
	QPtCtiSw06BSeK5upTQF5Es+yU2J3L31Q1syGH9YXuqpC1LKUQrdzaWIdoxF2sVrDrZhmgKPngp
	CwlSUfIUOC3PMtJluNEGX5kart5scXlugZrCrJ/L6cD8tujv/8o2aFCeTWO1wnzAur/5UZksF4b
	2oBUYILMvzVVcXNMWoCXauxJxplQgEsnm4686nCAWTwDlzDM4NXwtuByNcELH9jkCrmaqSVUUHC
	kL2RnXNn0YdkI3yTRD28mEcYkvf/h7OG8Y0Q=
X-Received: by 2002:a17:90b:384c:b0:3ad:a270:a623 with SMTP id
 98e67ed59e1d1-3b12d107e44mr3364118a91.4.1794210019701; Sun, 08 Nov 2026
 23:40:19 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org> <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
In-Reply-To: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 9 Nov 2026 15:39:42 +0800
X-Gm-Features: AclHuK_dnPMk52UN3-2_wspDGRy5a6s-cwmnh8paY6ZY-G54Qz5KZ0bygsAWCVc
Message-ID: <CAAfSe-shr1+0YpxEvf+4k+DyGe3==PUiD72CwjE+RC4gX-ShiQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2026 at 10:39, Chunyan Zhang
<chunyan.zhang@linux.spacemit.com> wrote:
>
> On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> > Unit-addresses by default (and most commonly) are hexadecimal. There's =
a
> > number of cases using decimal patterns. Fix all of them, limiting the
> > pattern to match the 'reg' limits if there are any.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
>
> [snip]
>
> > diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yam=
l b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > index afa551f6185f..222d70baef1e 100644
> > --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > @@ -47,7 +47,7 @@ properties:
> >      const: 0
> >
> >  patternProperties:
> > -  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
> > +  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":
>
> Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Following up on Andy's note about this:

Please disregard my Reviewed-by. Even though I did look at some of
the other hunks, given that I'm not familiar with the other hardware,
I don't feel comfortable giving a whole-patch Reviewed-by out of
caution. And since I'm no longer the SPRD maintainer, an Acked-by
wouldn't be appropriate either. So withdrawing is the best option =E2=80=94
sorry for the inconvenience.

Thanks,
Chunyan
