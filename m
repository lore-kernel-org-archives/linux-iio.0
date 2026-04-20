Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922CB375AD0;
	Mon, 20 Apr 2026 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690665; cv=none; b=hMl6yNUGOl2LWsPl8KUrMQTg/dqlQ7tNBlkF13KiE/+oXSni8/kxdvxfR3qEBtwe+ERS0aD2rxAIdDQMmYXHe74dJdzJ22cbBPA1HDuaKIfXv1yuvBU6hKQlNEhCzoyQRKuT4Ic/TUXzwOzjOXqx4GgYTKana7B6M0us8SRsk7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690665; c=relaxed/simple;
	bh=OMPojxdGE92qxA4SiqvcjVFtfvC1wSL/23UsiQq7OW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJcbsRfil1K3P+dUsFiaFtXQH67FxUwjAIJRf/yp8AsxdUEJ6EhKIpVcXlbjik9btYaQQ4vgR/CwGNyZ21q5nVnjfQHw7EZnVqMjfA1J8BfvSWxav7AvFO0Pw/t5meQvPaIfMjSgXDos0dY6NUotRZuxnY6Pt/AATDeTvqsh0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2KwLf0P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2KwLf0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99687C19425;
	Mon, 20 Apr 2026 13:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690665;
	bh=OMPojxdGE92qxA4SiqvcjVFtfvC1wSL/23UsiQq7OW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h2KwLf0PWVPiSL9SIBr/E5TlHN0Oaj0uzKdCHZCPwwZFAsbRsRWNQ62tiUcEO8sWL
	 +2I6MN1cbM6+z7wAFxMnqK3VCHBGOYxQUdObXsTstA4ktSMf0cbqnpTllzn3RRZKXb
	 qBwFcUI5GF1paQndn8GU/eCW5kqdOO7KToKw9YNlX0betD6krha5Za0yqy8UcEJOjL
	 Ujbv0vrb+89eiVjy2eGu9sVTCl5hTNMNbV8vhqHKDGKYIkdGLw6yAVNh/C/CVaTYxg
	 FKZVJi9sYwkfcDGkJVFBvvGAS4hTY7d9Uo1jZoJZWsbCOvAYKDE7LgqXQpmd8KUnW4
	 JQEN+AMAipfQQ==
Date: Mon, 20 Apr 2026 14:10:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Alexandru-Catalin Ionita
 <alexandru-catalin.ionita@nxp.com>, Felix Gu <ustc.gu@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: nxp-sar-adc: use field_get() for EOC bit
 check
Message-ID: <20260420141056.2075cbac@jic23-huawei>
In-Reply-To: <CAMB+xkb+R2ODUx+dn3W5k5+3-QbH5PSxE1hcET_hLrRk7QQe3Q@mail.gmail.com>
References: <20260410214130.188694-1-piyushpatle228@gmail.com>
	<58af4ec0-f00b-42d9-89a9-542228488980@oss.qualcomm.com>
	<CAMB+xkb+R2ODUx+dn3W5k5+3-QbH5PSxE1hcET_hLrRk7QQe3Q@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Apr 2026 22:30:19 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> On Sat, Apr 11, 2026 at 7:53=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
> >
> > On 4/10/26 23:41, Piyush Patle wrote: =20
> > > Use field_get() here now that runtime-mask support exists, and drop
> > > the obsolete TODO. Since NXP_SAR_ADC_EOC_CH(c) is BIT(c), the
> > > resulting !-test is semantically identical.
> > >
> > > No functional change.
> > >
> > > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com> =20
> >
> > Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Applied. Thanks,

J
> > =20
> > > ---
> > >   drivers/iio/adc/nxp-sar-adc.c | 6 +-----
> > >   1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-=
adc.c
> > > index 58103bf16aff..d6c2a0d50bb4 100644
> > > --- a/drivers/iio/adc/nxp-sar-adc.c
> > > +++ b/drivers/iio/adc/nxp-sar-adc.c
> > > @@ -316,11 +316,7 @@ static int nxp_sar_adc_read_data(struct nxp_sar_=
adc *info, unsigned int chan)
> > >
> > >       ceocfr =3D readl(NXP_SAR_ADC_CEOCFR0(info->regs));
> > >
> > > -     /*
> > > -      * FIELD_GET() can not be used here because EOC_CH is not const=
ant.
> > > -      * TODO: Switch to field_get() when it will be available.
> > > -      */
> > > -     if (!(NXP_SAR_ADC_EOC_CH(chan) & ceocfr))
> > > +     if (!field_get(NXP_SAR_ADC_EOC_CH(chan), ceocfr))
> > >               return -EIO;
> > >
> > >       cdr =3D readl(NXP_SAR_ADC_CDR(info->regs, chan)); =20
> > =20
>=20
> Hi,
> Gentle ping on this patch.
>=20
> I=E2=80=99d appreciate any feedback whenever you get time, or let me know=
 if I
> should resend/rework anything.
>=20
> Regards,
> Piyush

