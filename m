Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB893D8129
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444303; cv=none; b=p4U38BNB4RF3UUFpc68Xt/JKzHSc0GWeY3piaCGKfaOFnL+Qj0NAb9hIsBjMk7dummV/yXNwJPc+obyhr8I5zWh6uXN4liw4qALywftc5IF4uKni0r7vuyUTGzvrXRLgqUpU8IsFtE/8Q6GL/JsgGiktP6ZOy+Iaa57BQ4HjTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444303; c=relaxed/simple;
	bh=g4wYbCrQQciM5eAA7bNgeswNgh+jLdm3yzIf2O7Ct2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=or4Yfvh+Dq0Q1SHFKbyojwl2VXa6pWoK6SHdcEYtIuI9RLRvC0wP6UGwUmazQwtOn/c4/Vh61B29lpqSaH8n93/YYN/sXmU7n8EsuBz9SgEaGq00g86Lf7HtnNDJDuoQEefFsG8zbSdrkoPNzfxfjtuM5zWmL2ZA6FyBa4/HHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlUEcTUS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlUEcTUS"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso18422565e9.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774444301; x=1775049101; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3GPRX2Yqkh2fKcDql2NbbWnYF5EebgqjYrmp0cfTJ5I=;
        b=FlUEcTUSYKpCxvw92RDkKefbBgYBLc4ykoYW58S+9zQ3sNCSyItFQKnJX0mKXARFO2
         E9oo13U9zxVGkgarArAhzOZQliIG4F3CzAppc+X/xd1UklAGVxE+Pyv8oVqSR8Nmk7pW
         D3/JeMcd/wjGKnW3U0iac994/Akstb/UZtq1CSVlJBeKPWLqELnkrYUAXL7CWpb1vgGH
         uRdr/b4OWGQhJTwuP2vZIpjKAFm519CweJHdSicKy3nE3BYWKzM8/f0/tOJmVnsWc3CK
         ofbPmE+kU383DzjJOFdNEjTZNRmX4Ospc/wb2eylB7QgKfdyW+OtmehKkRFnpycQdcm1
         EZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444301; x=1775049101;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GPRX2Yqkh2fKcDql2NbbWnYF5EebgqjYrmp0cfTJ5I=;
        b=rWtMAsKZUqbaiJGzDC/C0qdORsKfRWgX6TFOQ0YAljIFV5aDb/xdQtVgwlZbLccB8q
         d6634ag8u9lOlkrHlBvahxCGdvmHO6P09uHVxDlUukE1b5JWm3IOdV1oVaZ30w1xfYmJ
         9i43sMum0OJeZiVWMeLq2dERv133uxQNr20hqsFw2/VeSGvanUJgq7uQOBkvU8EW8Sd2
         X9pQodJU9aBYWy1y/D6kRbyraLHiGaSCLO32w+Q/FB9B7ZRLPZpnrMKJ5VA62AocT374
         VG7qPpJSxhF1GxcLa/ZjzHxhsCWG8eJKDzI23KtE0pJtKaS0KJSvOxGSGG69yp0XTGWw
         L30g==
X-Gm-Message-State: AOJu0YzBcOhzf/hUC0CFcWkJAI3/zYvogV8glojcG0iDozOn8GrdzoEk
	2HLvT5OZFNC5VEUyvANuK6jXTt5iXCpoLF9PHOl3tnW39WpSqHvxrh6c
X-Gm-Gg: ATEYQzwc0+kePF9JaoVSiRe4PnW65BGUo1AroawUmEyD9tvcd45LSf5gjoh9rXjH7bC
	HbBxWvtOa3unLRDAzzMHnX/i8t7riYPV5p1vfgJlHogrnhu3i1cYhSO9iKBhbjQJoDdcrszyuMT
	U0ZyezrDasBOsNcog6VCZCvzyhM1zzgRSMlFa6sMDWHgKDozXXpGl4NTJEWpkpbvFRc4B9lsDKD
	6XnZOnmemw3uOx+DHuK7Kd1ULNOG5DjffBJxdvPuxG81Wzk/JGdrLOhvo7e9f5IIp/JUZbIMOJZ
	VZ9VfIYm6aOpuSYiSnz5UU8HngG1bixybtynSj/m3whNLQJ0SutA9nH4ux9OSxZ8NoF1Hj2tIEf
	RVit8kmneQQgIVlOEmBGORjk3lLfUfMxFNw/iS2Zjw+Q3YRJTIzzeQhEspFmVzmNCTXeNUueK45
	QzmoTkBjy1JhqThW+cU8xVXD+TOHnxJPk=
X-Received: by 2002:a05:600c:4ecb:b0:487:1520:d107 with SMTP id 5b1f17b1804b1-487160aa232mr49865885e9.31.1774444300774;
        Wed, 25 Mar 2026 06:11:40 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711709e95sm132827945e9.8.2026.03.25.06.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:11:40 -0700 (PDT)
Message-ID: <852233180cce9c9adffc491e4cdc16f281bfe09c.camel@gmail.com>
Subject: Re: [PATCH v4 3/4] iio: adc: ad4691: add triggered buffer support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, "Sa, Nuno"	 <Nuno.Sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,  Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>,  Bartosz Golaszewski	 <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
 "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	 <linux-pwm@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	 <linux-gpio@vger.kernel.org>
Date: Wed, 25 Mar 2026 13:12:26 +0000
In-Reply-To: <SA5PR03MB84250500F1FB9567F7FD2701F749A@SA5PR03MB8425.namprd03.prod.outlook.com>
References: 
	<20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
		 <20260320-ad4692-multichannel-sar-adc-driver-v4-3-052c1050507a@analog.com>
	 <83d87ff35002e5c7b9448a5ee7f2791a63c38c38.camel@gmail.com>
	 <SA5PR03MB84250500F1FB9567F7FD2701F749A@SA5PR03MB8425.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-25 at 12:47 +0000, Sabau, Radu bogdan wrote:
>=20
>=20
> > -----Original Message-----
> > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > Sent: Tuesday, March 24, 2026 2:23 PM
>=20
> ...
>=20
> > > +static int ad4691_cnv_burst_buffer_postdisable(struct iio_dev *indio=
_dev)
> > > +{
> > > +	struct ad4691_state *st =3D iio_priv(indio_dev);
> > > +	struct device *dev =3D regmap_get_device(st->regmap);
> > > +	int ret;
> > > +
> > > +	disable_irq(st->irq);
> >=20
> > Should we use disable_irq_sync()?
>=20
> Isn't disable_irq() already calling synchronize_irq() inside it? I can't =
see
> disable_irq_sync() in the current kernel, only disable_irq_nosync().

You're right! Sorry for the noise

- Nuno S=C3=A1

>=20
> > > +
> > > +	ret =3D ad4691_sampling_enable(st, false);
> > > +	if (ret)
> > > +		return ret;
> > > +
