Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46F33B6CC
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582667; cv=none; b=V54MIzIQMOXp2kat80KFH+3XPkBY4nu7Gx2cpmC/BH25i61UbpWAJ1UAVE6Bg46ZUMhSIQRXVLIssFovQiJk2UxvI33BFcMMToQD4OY0Dnihs/h9UZ3R3WhZEhZm3nIy1aafwH8QCSa0+B2+kTgfKbZ7r63KXdwRCZvATfFmHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582667; c=relaxed/simple;
	bh=8JPAPEZguacmifSWCnnDXUVYRogc7fx9Jf3HfyYCE3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XLfGltrU25IwUSTDg6toxqa2QSXkRXld4sqRBebkk/KWnBSAmk3R/m6fX2Z297ZfO2+Y/HoCqBPrdNwLgNFWchrKgARo3/elCyKwErGd9v3IdHdFub8kcukdDNZFBD7Bz60tpB+thmNJ6BnvPPz3doJhmYn1665PBOZVtwWXa5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuHW5xgN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuHW5xgN"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4362507f396so1924843f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 02:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771582664; x=1772187464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=foa7kGkA11ij00nt3xJx3lBVlw2GastjEXv+CSxW2yk=;
        b=iuHW5xgNXlMkYa5na6xVFsFvMgX/y+z0qv99LuwzI8lHpFPtsx5OcI9a87+oqUuNwj
         Mk+SGUZGdTiCrs2xadCfd1d6xPxMu7AOhyF6n6WqZvo47+3T/VfTx5ZY54d+kwT88m0M
         hfRd5J4dEYL6EILboAPm5wPpLo7c80Q5sU/hVoZdGcQMVHTkNpg9MvqHZby8X3Dn7xyN
         UESxVZ8Aue+81XHBsJYdA7aqR0/4Zg1wIQuCKXVqQdcJEenBnGv7ClPxWAgXiiNPaMhf
         l3zb9byU00RccX1i3rPoM/Anlce6rTCNnJr9Ss8qk7WItarMWm8vTOhT6XLmLKOhRDLy
         G9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771582664; x=1772187464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foa7kGkA11ij00nt3xJx3lBVlw2GastjEXv+CSxW2yk=;
        b=VLkCXhUdD2ZwSDIYZHtX91WM0q4ewWPIH8N5V4WEOg8/Mq8yImzbZNEnsN8qDXtV66
         AJ3FHq9u0QZekHZPtdvJZIg0xoeVI6CBEcPI7nQWer4SXvxuRhqYjfXE8d3g/oXYr/k2
         /gYUX1HltiQ9wydbKgUE/hoXt+pHsGQzF9r4E/PHvM2w340Vu7GoruegRslOJl1QuZEb
         HGj+rRsYetyDozp9f5vS8nRPVMX2O51hvxYoIOTK2W+EIfXe54gf3s1WfFs+2g5K3csW
         N1RvfKTFawid1GragdMhg/RUZATNZf4QK+vp+bSo9KS6zaDYN21CSP9zfpeSLQSh+Q9U
         rS9w==
X-Gm-Message-State: AOJu0YwzuqqlK3TKzqyJdn5WIs6lJdmVvoc6Yeh+DlTXqccCnnfi2mYo
	u2GEcBkCLn9Eoj5l2FkMBfxzK99n0eRnm5VLeG8rXs2FqwJWMDNG19Tn
X-Gm-Gg: AZuq6aLhsbJ52sj8dc0Cg/7rsdTimqxA/cdfNkij+yzw6BNp+tEs6LD9fQ1sa+HNiir
	h8sdTMZ82crogcAH7qftWV5qTisCrx/YymFsTUsCN0Vf79cchRo+sIvfUZ86G45C06QpmviT6jw
	YGz09m1+9Ehvws3gFiz2Y1FbhLODLPktXHX3rfAVAZhfJcUAild1JuKNSK6wVM+V74pHowFCWAX
	0aKBmDNKwHxIWpkcgyQSKC8Qu4mLnFSRylpT5A+U0SjThe82gU9W+wxNIx1x+AjOZMSDfAgFCHE
	DIw7d6Iu+oJ0zvcR3NE59NO7OqRlBpLtBspg4KiQKTlyaXuTZXiLppDIPZ51zfWG1mh2QzUFB9u
	GNmNlw/goplzjckUky9ib4qTASsmSteim0ZxWn+DhH+RbJJCcdg68Sr1QY833mJZ7YV2bEuSkdr
	DMdgRJhFCFY8qh1QDRKdsDgJ+Qsl1SrOI=
X-Received: by 2002:a05:6000:2911:b0:437:71b2:6f34 with SMTP id ffacd0b85a97d-43958df112cmr13666718f8f.1.1771582663829;
        Fri, 20 Feb 2026 02:17:43 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abe3b3sm62452448f8f.18.2026.02.20.02.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 02:17:43 -0800 (PST)
Message-ID: <9951c2fc9bbca27e0a5e7d953a31a0f802bac38f.camel@gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add entry for AD5706R DAC driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron	 <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Fri, 20 Feb 2026 10:18:26 +0000
In-Reply-To: <20260220-dev_ad5706r-v1-3-7253bbd74889@analog.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
	 <20260220-dev_ad5706r-v1-3-7253bbd74889@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-20 at 16:02 +0800, Alexis Czezar Torreno wrote:
> Add maintainer entry for the Analog Devices AD5706R DAC driver
> and device tree binding.
>=20
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> ---

Hi Alexis,

Fairly sure checkpatch will complain in other patches as files are being ad=
ded. Need to
speak with Jorge as I just saw this was not triggered in internal CI.

- Nuno S=C3=A1

> =C2=A0MAINTAINERS | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1251965d70bdfa990c66966cd77f7ab52ae3385f..3d7bd98b4d1b55836e40687a9=
a3ac9f4935a8acb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1496,6 +1496,14 @@ W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
> =C2=A0F:	drivers/iio/adc/ad4851.c
> =C2=A0
> +ANALOG DEVICES INC AD5706R DRIVER
> +M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
> +F:	drivers/iio/dac/ad5706r.c
> +
> =C2=A0ANALOG DEVICES INC AD7091R DRIVER
> =C2=A0M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> =C2=A0L:	linux-iio@vger.kernel.org
