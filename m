Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B33A758C
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433647; cv=none; b=h0dRnBlwWveqWJlQkRCtjAN200Ik3GcdiI5He+Orug15efnL47hxAqiNen896c285/m+ZEnZd8X6s6MQo3xzBzGkoxRpEBhmMBDNxFpFNNK1RSw8gKjcNSEm+BIbtKIlvJyNmORak/HGVyU7zXHoYGhw93XTFkFQg3Ys9Wo3zgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433647; c=relaxed/simple;
	bh=odJWbCaP0lmit5rLsXxRBXtkP6ZV4LNpp0nhdo89p6I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r9JFQONhTDDCuvmvTkaw31x/qdmcqd4yKYXBSpKJ5HhU0lHN5/hhcBV63K7H8IGfEnZi+tW1499v5BWb/R2L51jXLVse/jeFTiwGWh8b8NYnLC3f2YAMq7o9SV1jNZnnOoa51kH9Cfr4KId21WBGXEBdCZDCJy0iAHTGpxHORwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6Wi+i3D; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6Wi+i3D"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b527ac5d0so2592116f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774433644; x=1775038444; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dFC9v3RA0+njBsaguL/yT+mILr4lqhBw+oEWCcpW5UA=;
        b=X6Wi+i3DJPfitsgNgUCGfJwzqTR1BeZL9HBN9wBb5/pVskRv89DBmHtir5M3DEufFE
         ApA7cZvoy2J1mbPVVjB1CK2iMhyQzNYJ7+xx0XckftRKrlTgH6j1BZbaQ4bjILL+k1Eu
         TG3HkU+cUN0C6Ck9jdr8IXlG5/i7tODdJlAz7HdyA9ytvARpt6B8Tt0pJGmEpQndvPpj
         p0hZaOhsFhrC9uksfPwp3ormm/ObRiA5/8S3hAv3rfw/1Akd/ddmPTdiLpV+c3ulLGef
         lqtCHwVv1JtAleoSizJ4kyCgXsukcQxdH8Oc4g6IvqRPYtiB8GWoZ9NZXdHddj7BPEqo
         T1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774433644; x=1775038444;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFC9v3RA0+njBsaguL/yT+mILr4lqhBw+oEWCcpW5UA=;
        b=o8A0N/enlxeKKkDQ5b4BDWx/5vKO3TzBAtzlV9NPh7IyrmwNGleyOwTezeZQ+cmael
         uXhZR1KhXoRgpvMwNOAJNjOAiCdteG7WHS37L94dGbo2YEjSgARk/XsawAulDLz5hDV5
         9RD6hSXlBfoJ/RfUeKY1c8y6S+yfayKyCi1i2eV4W01t5/sqSWJ5uBC6L1Lsl4q3p+mr
         PBoWL21pQhoc2+Ru8Lpmf9D81XpXj08S1IhPtEVh9cj+cGAPfT13qdf63IaA/auAQRh/
         2HIqts5IUzjdIWoqDQdA9cjC4EimnXVzluLSnh0IM0M1U47UBxuWxT6gIGxGfMGKf2xy
         qc4g==
X-Forwarded-Encrypted: i=1; AJvYcCXNlablHcoJOkLXdmt0VHXsafZjbmSo+n3kPrsif/G9LfbujRtLVgYJ3X8QyUELvzUoLzFDh36fREk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq05+QTYMHQtfqB1hZCfe1s3hc9xIH5DwXkpe8QOw8ATTrxmyJ
	A0+r77wV+ol/ecP0wssrBuX1aD1l2Sy3RyoHp+Mqn30UV/1Qd1RxO+bL
X-Gm-Gg: ATEYQzwrhhtRs99M5jmGvT6nLZ2gvhgbXHPYppBLMm3wjB8IkfTZ/gFZZz58vDuMkUU
	E+1jtoMbZ1fLQA+a67cadwEwGwcWUbbANLdOfs0KCfSzL8m0YVgwLKL/72/fmijtxbyjdsjVdgC
	hEmVIfzzMNoAU0v+X99FOz72pkO2VfEq3npO5JB/NZJjy1SPI+D/sXervbSGYjwwFrw6mCnqBCw
	NX11rDh3/1DWwUMjP5LIcDRAXt+mTCfd2pkASijwjgcBWsdrrnEHvtn6RsPKNElUjU0wbLv6wxr
	4cilrCDytxaj4R/ZIfm+ehYMgAjw+gho5LSqnvxcSUkzaewvaaQP5Xo/alRqW0j0RYuEqbXoM5/
	z2FTVir28rcFMGfSteuyKA/3I5z4F9WK/W5FWDZutIpHrqNUpUHd95dFHyqaAuowZFgxdlnGumo
	tfE/3GEnLB0PrNI97M+9VLmLF+o5HVBc4=
X-Received: by 2002:a05:6000:22c1:b0:43b:87e9:6aee with SMTP id ffacd0b85a97d-43b88a57005mr3984417f8f.54.1774433643870;
        Wed, 25 Mar 2026 03:14:03 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b85082842sm10732177f8f.20.2026.03.25.03.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 03:14:03 -0700 (PDT)
Message-ID: <975f2df6090f3aea0524369ef07f2a648064f010.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>, Jonathan
 Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"	
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  "linux-iio@vger.kernel.org"	
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"	
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>
Date: Wed, 25 Mar 2026 10:14:50 +0000
In-Reply-To: <PH0PR03MB6351C1D87987E0533F4A07EEF149A@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
		<20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
	 <20260321183909.45761710@jic23-huawei>
	 <PH0PR03MB635133FB434235B7542770ABF149A@PH0PR03MB6351.namprd03.prod.outlook.com>
	 <PH0PR03MB6351C1D87987E0533F4A07EEF149A@PH0PR03MB6351.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-25 at 03:13 +0000, Torreno, Alexis Czezar wrote:
> > > > +	ret =3D spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
> > >=20
> > > Can you use spi_write_the_read()?
> > > Has the added advantage that it bounces the data so doesn't need DMA =
safe.
> > > Can also use more meaningful types like
> > > __be16 tx;
> > > __be16 rx16;
> > > u8 rx8;
> >=20
> > Ok, will shift to spi_write_the_read(). There was another place to use =
this
> > above, just trimmed it off here. Noted on the more meaningful variables=
.
> >=20
>=20
> I only just checked spi_write_then_read() but, it seems this doesn't supp=
ort
> variable spi_speed_frequency for my future patches. Should I still use it=
 for now
> and revert in the future?

There's still the open regmap discussion. Independent of that, if you can't=
 use
spi_write_then_read(), you need to make sure the buffers you pass spi are D=
MA safe.

- Nuno S=C3=A1
