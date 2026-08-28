Received: from out-2z4y-a151.jellyfish.systems (out-2z4y-a151.jellyfish.systems [198.54.127.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAD336F8EF
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932058; cv=none; b=OiksNLHpnZPbEoIHzo3vbwdxzOdyzQGUcCCYXJEE2y6M4KrWefix1N4UUF8y42z3QRlObt7knD4EWGA5m+2NW1TTebUOz5Ln2aOuglJZYoUIf5GrCeZE1fu0oMxRRkpzk/N2pA+DUmIjto4R4CokUtzjFvtjvIgYOtCIE3GjXwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932058; c=relaxed/simple;
	bh=ykybaExyluxLNHtsX+aTNcRDNKzUzqtUoz+rN4hiTlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8GcSac7g5KTOV7z0ZTU5WSx+Ciev6G8kFmVsYI67kdy2O2N7fdv1Afo636uVXIavRD0yUh7ZilegyXrlhOsgaRPV2YCyZvkHcm25my2vPpyw4k+b1Y1Rf0LEF8uQa+YOHyzxNwvM279hfvpF1BI9+e4NILzpGZOHdPc7BgtkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hWjSH4sghz8sWT;
	Fri, 28 Aug 2026 15:47:11 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 5/5] iio: light: stk3310: support the Sensortek STK36C61
Date: Fri, 28 Aug 2026 17:47:05 +0200
Message-ID: <20260828154705.11962-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apEMCqQXyj1tAMoP@debian-BULLSEYE-live-builder-AMD64>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net> <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net> <apEMCqQXyj1tAMoP@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

On Fri, Aug 28, 2026 at 01:18:18AM -0300, Marcelo Schmitt wrote:
> > @@ -417,10 +459,10 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
> >  		mutex_unlock(&data->lock);
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_INT_TIME:
> > -		if (chan->type == IIO_LIGHT)
> > -			ret = regmap_field_read(data->reg_als_it, &index);
> > -		else
> > +		if (chan->type == IIO_PROXIMITY)
> >  			ret = regmap_field_read(data->reg_ps_it, &index);
> > +		else
> > +			ret = regmap_field_read(data->reg_als_it, &index);
> The above seems unnecessary. Why changing the comparison from IIO_LIGHT to IIO_PROXIMITY?
> After the proposed update we would have the integration time for both light and
> intensity channels being read from the same register field?

These arms now see three channel types instead of two, so the two-way
branch has to put the intensity channels on one side or the other:
keyed on IIO_LIGHT they would fall into the else and read or write the
proximity fields. Proximity is the odd one out - its engine has its
own integration-time and gain fields - so the comparison keys on it
(the write_raw arms route identically, hence the same change there).

And yes, light and intensity read the same field: the chip measures
the colour channels in the same engine run as the ALS data, over the
ALS integration time. Stepping that field through the driver doubles
the ALS count and all four colour counts together (measured on the
device: ALS 30/59/120 across three settings, C 83/167/334, R/G/B
likewise).

> > @@ -428,10 +470,12 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
> >  		*val2 = stk3310_it_table[index][1];
> >  		return IIO_VAL_INT_PLUS_MICRO;
> >  	case IIO_CHAN_INFO_SCALE:
> > -		if (chan->type == IIO_LIGHT)
> > -			ret = regmap_field_read(data->reg_als_gain, &index);
> > -		else
> > +		if (chan->type == IIO_PROXIMITY)
> >  			ret = regmap_field_read(data->reg_ps_gain, &index);
> > +		else if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
> > +			ret = regmap_field_read(data->reg_clear_gain, &index);
> > +		else
> > +			ret = regmap_field_read(data->reg_als_gain, &index);
> Similar question here. What do we accomplish by comparing to proximity instead
> of light? Is the gain info the same for light and intensity red/green/blue channels?

The same keying, plus an extra arm because the gains split
differently: one field serves illuminance, R, G and B - switching it
x16 moved all four together (ALS 25->404, R 42->677, G 25->404,
B 15->248) - while clear did not respond to it and is gained by its
own register, which is what the IIO_MOD_LIGHT_CLEAR arm selects.

Thanks,
Jorijn
