Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74513335061
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771405883; cv=none; b=EpyLlyo1vrzJlGbxmxEUxMDbhmWzY+WVjqdphZqYtq87t1/BHr/3fUStBUxq5qErViszq3lL5xy1gBuMZ8Oeue2x/qVBC3cTiW41OMy9vSFwLxzrjZ3ufBy7bU4J6RRj5fitZZt/VMterJVlotViQHvbwUB4Tj2u0MNIllwYDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771405883; c=relaxed/simple;
	bh=K81aBw9PHTIyTGzm0ahYqyXP39Z6oxa3Bkh+nhvpzUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mJMRjia1cKZhFYt/Rs1c/+nNO/mFKnjjLLD5eO8ifWxtp267/9BzFporsWVhbF14O1kvFEL48FJPyJYJBcKzug6bUNU1E94x8iPzMNeGuIUlZxUavIrS1NCcdwR1jNMaN69WCrYUzgO5ZIwCE8yb6Me5rczKqjBOHmgEVn0WVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqF3/XhR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqF3/XhR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4834826e555so50433335e9.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 01:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771405881; x=1772010681; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tLcrjjQRa0M8vJiWefRWPzwInBQOVnFBnP/W42lQU04=;
        b=BqF3/XhRmbo04dZImlN1YUiSSt9icApzttyE4jdyq92ax7RTM57NvYKhjpNqQaBmBA
         xGqyzsm4a+KzdHcTQvwTmwyOtjbTvxSmBvoBp+6WXHrRUA4JQe/gzd5SDUD4P1x0rM07
         skX9IJoIXZbG1RiqSsbJKlbHJ4+ItwwPEvvS7lzvDOPHctNjy/PFYuZkZVEyjgwlj/TL
         1dtTbA5l+aXpK0Ymi37b0QdpInw0K4tceepRbPbt1X7Vim+3oinFTNRjiZOTW+PoeVE6
         u2eaBgJh43CoB8j80n7p/Cf89SnXwuT4lIzKxTNYPWMvzFaEX4dcSwqVn3+kpKe1JEkh
         Viwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771405881; x=1772010681;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLcrjjQRa0M8vJiWefRWPzwInBQOVnFBnP/W42lQU04=;
        b=OD6N2gfGyEoBbMCgb8yJNRc3tIY0JeLM6xaZcJWTmNjf5IPKSwwEajgfwKVg77pctJ
         1JrGZ9b9pYIditQKCf78diV8N69fK+6QJa8OQE9VU7IIltYegD5r1CRd2wVXC0RTStvX
         SXtfoEKqwOYZOhnr8lQ393sa0q4GGWFoV/MCNbwmM6JWtmAlLW7pNFpYlvVdSoBx09M8
         m2RpkwIQTCTNQ+G4O4viBoGljg++H4foiMugRi8FV6vGsOHKdrXoKb4PKNmLhacQNUz5
         YKI0iohjSeGe4DFKufw1kR3HMOzMT1yf7O1vLsWDx53Z3SGq6j+QrUPdiaLx/05Ex9IE
         RN3w==
X-Forwarded-Encrypted: i=1; AJvYcCWoclXZ7cKPXWU0D8bo+N1jURCabN/g+QoL6Ys6YkN13+uRH5QZu1i3swLQ9mnnHN9ArfqgtduKRdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9cx323LVvBG/sKEJdqaGAUbQQ7s1I7fp39lnmnkvsx8FIfgE
	GWfnYnYNlMwa9iHz/vN5uP5Qb9XLVvc2MnrCw8I35SIFxtXXCfiFIcAH
X-Gm-Gg: AZuq6aJUfuhfQ9p1VQZf6j/f+7E5RFm1rg67r1eqN8I285HLRTkWtPbgtnlB3KcWIov
	C2g0tnRHzkAhSozww+pSqt9fmjATHcBCEiZxattGWRGL3gxviYvHtgItV1mY2lsJompFKIk82GN
	ZvyRFvjDl5oYMCsZZqq7DodJIVw/y7ovGvTOc7svYX+o8d2AwaY8MMOfcnCP/tvdmmFsSeJPPFu
	kmO6QkyOPazl0e+RMyr/ac1jFIJ/nOj3tt91suhiB3euPuNOIgo88v536VvlL50iYDbCQzWoscK
	YzVS3NaHRh9EIB9CjSaIUlPqzMity30RuIlxrosS4WJoZUZ4VfdS8l887HPqWFrDoYuvVm+kw2I
	Gq1jDZ64+pIr3s1UNNQ+Loe68YXTRFML69uHpqgTNfh/d6hmktOviWGy911bjZgokGrJvuGuupC
	lQ6aK4OinT8TNoSW1o8bqBKSc1tQhcO1U=
X-Received: by 2002:a05:600c:4e45:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-48379bab48bmr283637085e9.16.1771405880574;
        Wed, 18 Feb 2026 01:11:20 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm555595975e9.14.2026.02.18.01.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:11:20 -0800 (PST)
Message-ID: <a823c9b72fcc3b1d88ff9dd93580be6241826153.camel@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7192: Revert "properly check
 spi_get_device_match_data()"
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org, Alisa-Dariana
 Roman <alisa.roman@analog.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Harshit Mogalapalli	 <harshit.m.mogalapalli@oracle.com>
Date: Wed, 18 Feb 2026 09:12:03 +0000
In-Reply-To: <aZSD-3WIVwT6XYWX@smile.fi.intel.com>
References: <20260217080514.1288115-1-andriy.shevchenko@linux.intel.com>
	 <aebc2f13040d97e6e3b9797d3fa580198125e3f5.camel@gmail.com>
	 <aZSD-3WIVwT6XYWX@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-17 at 17:06 +0200, Andy Shevchenko wrote:
> On Tue, Feb 17, 2026 at 01:47:59PM +0000, Nuno S=C3=A1 wrote:
> > On Tue, 2026-02-17 at 09:05 +0100, Andy Shevchenko wrote:
> > > This reverts commit b7f99fa1b64af2f696b13cec581cb4cd7d3982b8.
> > >=20
> > > The added code is currently a dead code. Moreover, the driver is not
> > > designed to have any defaults effectively making driver data a mandat=
ory
> > > information to work with. Taking all together, revert unneeded change=
.
> > >=20
> > > Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad7192.c | 3 ---
> > > =C2=A01 file changed, 3 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > > index 530e1d307860..8b1664f6b102 100644
> > > --- a/drivers/iio/adc/ad7192.c
> > > +++ b/drivers/iio/adc/ad7192.c
> > > @@ -1402,9 +1402,6 @@ static int ad7192_probe(struct spi_device *spi)
> > > =C2=A0	st->int_vref_mv =3D ret =3D=3D -ENODEV ? avdd_mv : ret / MILLI=
;
> > > =C2=A0
> > > =C2=A0	st->chip_info =3D spi_get_device_match_data(spi);
> > > -	if (!st->chip_info)
> > > -		return -ENODEV;
> >=20
> > I'm ok with this but as long as we get some consistency agreed on. So f=
ar,
> > IIRC, the policy was to check for the NULL case even for the cases wher=
e that
> > was not possible to happen.
>=20
> Is it kernel-wide policy?

Nope... Just IIO IIRC. Actually, I'm pretty sure we had patches in the past=
 just adding the
check. But again, I'm fine with the above as long as we are consistent from=
 now on.

- Nuno S=C3=A1
