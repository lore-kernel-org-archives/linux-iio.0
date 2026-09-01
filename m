Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1861366042
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246721; cv=none; b=JHtapgP4bdYQ72AkeMON3O1oEhTrwsB4Z/hTUw6WsA+X/aPXZ4JMd8iptC2pHS5Hy/Zxv+BBPXpTUqqobkNRA3e/disnTzrzbvsxpiSBjvNt7Twy/6w1QH4+gFEQYRYO/vUugWtvHcQap89oMCm7Hx2gj7LYzskyp5r9zu1DIUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246721; c=relaxed/simple;
	bh=IJV+cJcfZdPXEq3nWzfJc7AtEYY8y/J55FvImPI05W8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NuYRV930SY5q3UEnez+Ar7rw/ut9zPOKKOUpdI7Ch6CBETYvvOddChmsI0NYAF9S9XzxZhT6KJw84Ks0frPB0Cipp+Uq/m4yptaTM5IvMpTL2qLkuFobBySk2uOpZsrnwloij2B96HhqGKiQZlgQJNWe1EJQKZHgWv0KgzFSqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEagW3rK; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEagW3rK"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a20d12211bso8450181fa.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 00:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788246718; x=1788851518; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=D+CSScneE3PY8jH7ppTyN3wkhx3v10vl4wTiv7mZ0VM=;
        b=QEagW3rKPA2MVmiM5LCKWzP1ZFMhY8EJ+qSs9OdLhVg3L8QbE+ceEqACa8JyJoTc0R
         OWsgAfQTjq6m/UT4Ltj1XmfGEexCni1ABarf5p8kFaOuNGxX5/SBAndwmVvDBeBbhnNE
         rahDEjV6FuK3Q4DhRd2fE1gUWI1mSv+xqbO0ZRyNtm9qu/LZC8X2ytdQSnncNTajRRmR
         38Oy62iEp0e+E4EtIT6YB1jbiox6TwMm5lhjrrfnyWlpEzBlV841HG8J8IV7Algh1TfM
         fRgu/C8j0lnxayecL58eX7jpJEhxSIarowEVwinO6uOt0GHl38u9wqmdqeVQ0+me4dus
         WQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788246718; x=1788851518;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D+CSScneE3PY8jH7ppTyN3wkhx3v10vl4wTiv7mZ0VM=;
        b=JTgKtJkDrLo2NhN0LOQKY2WKY1fSVMyU7VuxvtrmD5aATplpvjY79Ea2gthpkh/Xwj
         gRcrzPQi0bEVDAu/8E1pfdA/HV7WBW8oo9K8tQFrP6OizHa7RygG8nE7iBUxQ+msQfvG
         vfEabRdZsi4SCI5qAZ967rhwz0eDrt6VGGHJy2XyaDEUAq/qCtAMlJeus7t8OmC71Yu5
         5kZol1/LTMZ2nffhuNVUX5stidyHfHssQ+bVAq7Ga4ZT2D3zVjPNN8EGMreFONBaB7tb
         To67WQNtdHkdiEO+NazEGXVxEr2xGluXyrOAPZoBWIRguU66p2veHREJOc0yyzNZ/2xe
         bNLA==
X-Forwarded-Encrypted: i=1; AKwUvBwTRYnnrAWduvfnv38WlEgUus66KDv5XSnWJY7C2vyzCn6iaqI6nJx5I727KnI0EjxARqDor9mx1rk=@vger.kernel.org
X-Gm-Message-State: AFuF++krgGPFKX9IAPUzJ8BoOtS8HiheDksSg4sMgkBXTNXReXF9QnsJ
	DVBZWNxbtucXHmmaOuPa7ObicOvFa6LfT5zPChjod2I+3tO03YnumQRTDChReUoT
X-Gm-Gg: AYBFou0yE1gTtKVeS3Tkkz6gYXt6cGs9A2jlszOg4/YSDZ2EPA+/2pcBVsW8XhInCyl
	YvS9P/7XC3IGRpj7fvUX2Mw6bgvgogzyipI6b6s7ny/Zuvlt7x7HDb3/OfayUG113t7X0nXwpEL
	MM/pJRAKpJmvg1a9UJsJTc9xZaGT7XmHFVNGzEc0mXXOdXAE2S2uig584ziBZqOFGe98uBwJcgB
	JxTsqkbN/iWViFFuqmh4TZclcTolHU+QH4OcYNFpvKJShnnOglnA/nwIHl+Almnr5XOIJn85+s5
	s6CfpHxLU+XczuBSxa62aRmLVVIpW1umU5O/PYPK5kQd60w47+gIPJDKFSvrTZPO5KU/OTzWfBg
	Id6pakdTjNTgJuKyiN0M32nDjvRqUJgDFp5XsmyG7doghcgclqQPFc2sdv1oaHNjugowV7ZaV7s
	9Fk69FqqglDqXm2vbCiC9hvjl/4aK/SmCIJEAM3oKebeRWaLPv6LoJGlQbAHvwW4Q=
X-Received: by 2002:a05:651c:a201:10b0:3a3:3fa3:25a6 with SMTP id 38308e7fff4ca-3a33fa3324cmr3629011fa.3.1788246717606;
        Tue, 01 Sep 2026 00:11:57 -0700 (PDT)
Received: from [192.168.1.161] ([81.200.11.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e89c5c9asm2754562e87.11.2026.09.01.00.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:11:57 -0700 (PDT)
Message-ID: <5951b1195537558a5e93cfd44bd24fe56d446f81.camel@gmail.com>
Subject: Re: [PATCH v2] iio: proximity: vcnl3020: fix ISR bitmask check in
 IRQ handler
From: Ivan Mikhaylov <fr0st61te@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Sep 2026 10:11:56 +0300
In-Reply-To: <20260901022731.10771244@jic23-huawei>
References: <20260824042908.8887-1-salah.triki@gmail.com>
	 <20260901022731.10771244@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-01 at 02:27 +0100, Jonathan Cameron wrote:
> On Mon, 24 Aug 2026 05:29:07 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
>=20
> > The threaded IRQ handler contained multiple issues in handling
> > interrupt
> > events and clearing status flags:
> >=20
> > 1. ISR bit check: The handler incorrectly checked the Interrupt
> > Status
> > =C2=A0=C2=A0 Register (VCNL_ISR) against VCNL_ICR_THRES_EN (BIT(1)), wh=
ich is
> > a
> > =C2=A0=C2=A0 bitmask meant for the Control Register (VCNL_PS_ICR). In
> > VCNL_ISR,
> > =C2=A0=C2=A0 BIT(1) corresponds only to low-threshold interrupts. A hig=
h-
> > threshold
> > =C2=A0=C2=A0 interrupt (VCNL_INT_TH_HI, BIT(0)) on its own was complete=
ly
> > ignored and
> > =C2=A0=C2=A0 returned IRQ_NONE.
> >=20
> > 2. Event direction & channel index: The handler unconditionally
> > pushed a
> > =C2=A0=C2=A0 RISING event code on channel index 1. The driver only regi=
sters
> > a single
> > =C2=A0=C2=A0 proximity channel (index 0), and low-threshold interrupts =
should
> > be
> > =C2=A0=C2=A0 reported with IIO_EV_DIR_FALLING.
> >=20
> > 3. ISR clearing: The write-back to acknowledge the interrupt only
> > preserved
> > =C2=A0=C2=A0 BIT(1) instead of masking against both valid status bits.
> >=20
> > Fix this by checking both VCNL_INT_TH_HI and VCNL_INT_TH_LOW bits
> > in
> > VCNL_ISR, pushing separate IIO events with the correct direction
> > and
> > channel index (0), and properly clearing handled status bits.
> >=20
> > Fixes: 3363fbbe19e5 ("iio: proximity: vcnl3020: add periodic mode")
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
>=20
> Trying an active address that is hopefully the same Ivan!
>=20
> This looks fine to me, but I'd ideally like input from Ivan.
>=20
> Jonathan
>=20
> > ---
> > Changes since v1:
> > =C2=A0 - Extended the patch to fix additional bugs found in
> > vcnl3020_handle_irq_thread():
> > =C2=A0=C2=A0=C2=A0 - Corrected event directions (RISING for high thresh=
old,
> > FALLING for low threshold).
> > =C2=A0=C2=A0=C2=A0 - Fixed channel index from 1 to 0 (matching single p=
roximity
> > channel).
> > =C2=A0=C2=A0=C2=A0 - Corrected ISR W1C clear logic for both HI and LOW =
bits.
> > =C2=A0 - Updated commit message to detail all IRQ handler fixes.
> >=20
> > =C2=A0drivers/iio/proximity/vcnl3020.c | 24 +++++++++++++++++-------
> > =C2=A01 file changed, 17 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/iio/proximity/vcnl3020.c
> > b/drivers/iio/proximity/vcnl3020.c
> > index 7f417372566a..d0b8f429999f 100644
> > --- a/drivers/iio/proximity/vcnl3020.c
> > +++ b/drivers/iio/proximity/vcnl3020.c
> > @@ -584,16 +584,26 @@ static irqreturn_t
> > vcnl3020_handle_irq_thread(int irq, void *p)
> > =C2=A0		return IRQ_HANDLED;
> > =C2=A0	}
> > =C2=A0
> > -	if (!(isr & VCNL_ICR_THRES_EN))
> > +	if (!(isr & (VCNL_INT_TH_HI | VCNL_INT_TH_LOW)))
> > =C2=A0		return IRQ_NONE;
> > =C2=A0
> > -	iio_push_event(indio_dev,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_UNMOD_EVENT_CODE(IIO_PROXIM=
ITY, 1,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 IIO_EV_TYPE_THRESH,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 IIO_EV_DIR_RISING),
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> > +	if (isr & VCNL_INT_TH_HI) {
> > +		iio_push_event(indio_dev,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_UNMOD_EVENT_CODE(IIO_PROXI=
MITY,
> > 0,
> > +						=C2=A0=C2=A0=C2=A0
> > IIO_EV_TYPE_THRESH,
> > +						=C2=A0=C2=A0=C2=A0
> > IIO_EV_DIR_RISING),
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> > +	}
> > +
> > +	if (isr & VCNL_INT_TH_LOW) {
> > +		iio_push_event(indio_dev,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_UNMOD_EVENT_CODE(IIO_PROXI=
MITY,
> > 0,
> > +						=C2=A0=C2=A0=C2=A0
> > IIO_EV_TYPE_THRESH,
> > +						=C2=A0=C2=A0=C2=A0
> > IIO_EV_DIR_FALLING),
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> > +	}
> > =C2=A0
> > -	rc =3D regmap_write(data->regmap, VCNL_ISR, isr &
> > VCNL_ICR_THRES_EN);
> > +	rc =3D regmap_write(data->regmap, VCNL_ISR, isr &
> > (VCNL_INT_TH_HI | VCNL_INT_TH_LOW));
> > =C2=A0	if (rc)
> > =C2=A0		dev_err(data->dev, "Error (%d) writing in reg
> > (0x%x)\n",
> > =C2=A0			rc, VCNL_ISR);

Jonathan, thanks for pinging me, yes, address still same, I'll check
patch until end of the week.

Thanks.
