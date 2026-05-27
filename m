Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32252C11F9
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 05:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859789; cv=pass; b=HaQGmBvXMVuTQUJhjQvM7R9pg9KmDUVXGyc5J2M7JYm51p24DBO6IP74+GOskjz61rKpA/RhNjo014I/i/7DU1ENrjmc2KkwNMK2QeV+OosdCor+elJp9cbky5tRm26IDnDKxZx9DQf5CGFgkWuI6zCPnWnaWLAyv1WrnfBGA08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859789; c=relaxed/simple;
	bh=rijSLO8wERJrlBkKmldP6GoWjVWR6dDNxw0bhl7eoSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiMPqISPvkalvVfuFHwgXK/Ygf6L11nUN4xSSj0U9kg1ip+5YF8/3eotH6BM72mGwQ0f5b4thQU6LLfUjz6+qIB+0I/bxsgL7kkPdGRJAZ4H0LauFUF79bXxDm5WkPjhTsJPE2M/F2Ut6HZHzTieNrPuOCu+bZt64ta4lvvD2mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MV6AECKh; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MV6AECKh"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-395f24a5f2cso34708431fa.2
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 22:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779859786; cv=none;
        d=google.com; s=arc-20240605;
        b=H9DSwfWlBysi+CbIjoUXoj4YpMY0IAEbvMYOTofG33O6EiVny9xGZfADidXB4IGPm6
         BzoHiPvUl9vNmBpY16gb+UVdLOKupEiTANu9tL+0gNn6VAVq8tkKgYvEM4keSWPccI8H
         01BFmI72BgRKSgt1pKlFCotgbdlS/FkaXwQB5y+c+A7V4xrMolWYZt6MlRkzPZ92E7Lu
         8d2UGLDAgD/sCOzma+gppBc3brQQ5yIKNA7PtAjnYKgpbGdvm4ZGc3zqB8AGebM+kUFu
         UyyA8qd0uZLqQcjcinuS5SQYSnrZVOCPvZSH8LJsry2Vo5OHkBssO1RZUK4wz5ip73T9
         vjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sWU01JGA+KO3onhm4zSW7+7G6c0/a5rCe2jY0OsegKE=;
        fh=/qymKPIxrCgo2/Da58/cj+70ovGmqAY62dKl6/uSV/w=;
        b=kEbV4LSaAwWBvIaI6jPkFn/gQRnK8NK/8AAxH/FaQ7N2YIR/KiBnThOzyU3/MZILzt
         dwGlaRl7lfOjgZ6XrFIq66JA6BIwdvsabydFog2p5xOKhdI5E0n0RUEMRlRGEwyyEuon
         BG+dl3bHKZR/8tURnKwn70RJPBdwobE3wSANmLFn6uzveI1P+rfn21Z8nHfcPqObGSfv
         71FED1Hob1D9D8PAhFe51IhAZSop97fVZbbQznQFjK4gxbGpPjEFtigLOWhh1W3s5r2K
         +njXkDkxtvWxnkgPtkAxbevKmTlQiQduo7Q/UL0PtfCs8E2ybDXEgOL9r/j1BWveTF/S
         l4iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779859786; x=1780464586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWU01JGA+KO3onhm4zSW7+7G6c0/a5rCe2jY0OsegKE=;
        b=MV6AECKhggZoGg9XhcycCH5RW1A+Mg5EQ1yE1J97E9fev6TY1PyD+rXxj0XOnnSDYx
         FzKrImGkzKg9ZKIfRb9+s+EgIB+V9OX+PU6mQdpWThDlf/3gMAC55TEgJItxkSLhG/iD
         SWRG34edcY3ziNK6Qp/0/iofT1Llvl5Ykn5KJT6GXU12aYy487xhC0uVWb56EsmnAoKK
         cDe22baOf/s7jsn8DnY/7MZtCcfES82o6/nWR/nlqe8zEDz15RpNFcuqRERZ+EgOPRXw
         IdmDFcauN/f6jovIOPtGyNA3WyV5VY7pcg9eRzilRjN5PRHqhLMj0XmWsCXoVIyK0L7S
         4Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779859786; x=1780464586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sWU01JGA+KO3onhm4zSW7+7G6c0/a5rCe2jY0OsegKE=;
        b=APpzAGXH11JUfCi6n3hBKK/B08VEJWyhfVfNXHoITWCpMd+MSkhO/EO9R/MpTMPNzo
         kjiYpHv0GQCM/wA3L12RFdX2qJFehJTFwYpaO243G2zzDVLKZ/ak1oKZu/R8bTqKgdVs
         QDxZLFCDpNoTegGdGtRLEnZx0qgJuD433RjWiJgFV1S0RJvai1mcouGaZmV/x/evTDrE
         YLdeVfUhh9aNM1kgpzFzne5pVY4U6JtWaQkRBIztnD0cEiuLJZc7sixGU8VCfes3h6oe
         vEU6lsnT+nmHuN/UHs5FB1Xhcp2h3gSez6yzit1lvnmNgjSlct13NhLvqui5f6R/StPS
         pIuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tht5qxS2eAzEcvZCI4MLVR2crbnOe2zYgY0OIJV4gMylQ5+CURqp6fbCy6gmvseiSkr+fC/hbmWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+jrNk1IHsiPjKPoAD1wLTdTzopPh4MnzQ2nCd2ZjArc6Bond
	PYtgLNpMmgIB7BkQ0G+d2CLEEoroQMYcE6Ioa8HEGh1vqqBWkX/bBbOnJuKMZs6A8Tcw2VX+l9g
	61L43ZKdGfPaLnjm+UTDO07jPPU49SfhNI9rFEz2NRA==
X-Gm-Gg: Acq92OEBKVBWKEnpVuokXNwslEm1skt2Y8G0rxdguGICmtH1Dn8okcidQgmfKmbPxos
	/xGQy/jhnHPziXPJZKpwuiw/G9cu9v67zKy0UQs6kYqnoLrFAuOTs4QFhAheOpJNl3e9KyQQwRw
	Oa5Y4dZ3Y8ZPr7GGm3RDXVFt88+aiirlZKEay54dNtMA3qan/p/Vne9riKYLzEEllIAYqIQIpfa
	BpVM/Ay4Wv/7rs9VW4flntKQApgEs3gzIVpVbu1Byg1g14uIGOTGnTxGoOHFGFzTDWFgXrlQYIA
	3Lqv6hFDQugdhh/9uIiXKnnIa6r04pc3uHb2tX4nelRbG6n+JQ==
X-Received: by 2002:a2e:8090:0:b0:393:e50b:6b2a with SMTP id
 38308e7fff4ca-395d8c935d7mr49951611fa.11.1779859786057; Tue, 26 May 2026
 22:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <af0EGv172ZMl/6N5@JSANTO12-L01.ad.analog.com> <af2gJyG3rDjsjFmo@nsa>
 <agdKRhtywsThg/gT@JSANTO12-L01.ad.analog.com> <20260516113738.4103f388@jic23-huawei>
 <fe766c2a-3662-4896-b7ec-b569791630cd@baylibre.com> <ahXle0pZjpldxASF@JSANTO12-L01.ad.analog.com>
In-Reply-To: <ahXle0pZjpldxASF@JSANTO12-L01.ad.analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 27 May 2026 07:29:34 +0200
X-Gm-Features: AVHnY4KPeRFOt6loq4mrCx4OstUgML83TNvRyVA8kmSgRMQGC6K9ziPReSIphZ4
Message-ID: <CAMknhBHe4vyS=5vbDwonxzr67Z9=bRm6TW_n=yowBN1My4jA=A@mail.gmail.com>
Subject: Re: [RFC] iio: adc: support for multi-device aggregation
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 3:50=E2=80=AFAM Jonathan Santos <jonath4nns@gmail.c=
om> wrote:
>
...
> We had a 'hack' in the HDL where we tied the CS pins to activate them at
> the same time, but since we are aiming to handle each device indually it
> would be nice to at least enable all CS defined in the devicetree. It is
> strange that we can define up to 8 CS for one device, but the spi-engine
> only selects the first one.

When I did the multi-data-lane SPI work, it was only for the multi-SDI
case, not multi-SDO, so that didn't get implemented yet. We would need
to extend the core SPI API to handle this new case and then implement
that in the AXI SPI Engine driver.

>
> > For this type of SPI controller where it can read multiple data
> > channels at the same time, the .dts should look like this:
> >
> > spi {
> >     #address-cells =3D <1>;
> >     #size-cells =3D <0>;
> >
> >     adc@0 {
> >       compatible =3D "adi,adaq7768-1";
> >       reg =3D <0>, <1>, <2>, <3>;
> >
> >         spi-rx-bus-width =3D <1>, <1>, <1>, <1>;
> >
> >       /* other properties */
> >     };
> > };
> >
> > The reg property is the 4 CS lines and spi-rx-bus-width having 4 items =
means
> > that the controller has four SDI lines (the value <1> could be differen=
t if
> > each data channel/device was dual or quad SPI).
> >
> > This goes along with what jic23 suggested about making it similar to
> > what we do with daisy-chaining.
> >
>
> Since last week I have been testing  the approach you and jonathan sugges=
ted,
> handling the multiple device support within the driver and using the mult=
iple
> data lane. Additionally, I have included the ancillary device to manage
> the devices individually when required (and to make it easier to write
> and read using regmap), but some other problems came up:
>
> * When addressing the devices/channels individually, I would like to
> select only the respective SDI lane on each transfer, but with the
> ancillary interface there's no way to define a rx lane mapping.
>
> e.g: If we want to read a register from the device 2 (index 1), the
> ideal scenario is to activate only the SDI1, so the controller writes
> the right value into the read buffer. Without this mapping, we get
> the trash from the lane SDI0.
>
> can we add some new parameter to set the rx/tx lane mapping in the
> devm_spi_new_ancillary_device()?

I don't think we should be using devm_spi_new_ancillary_device() here,
but rather add more to struct spi_transfer to allow selecting a
specific CS line in the multi-data-lane case.

>
> * This driver registers a regulator and a GPIO provider associated with
> the main SPI device. Can we register them for each ancillary device too
> or this is not allowed? I am still confused on how to handle this kind
> of situation.
>
