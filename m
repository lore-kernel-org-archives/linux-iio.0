Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CF3126B0
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783851391; cv=pass; b=RSLNbyJtycE8qWCvLuhfJ4JwL4+LABPlZkxmXv09ToJQbpqiz8snahQq6YUIfJBc9IaxHC4HZBatHCV0fErmA3gv+bYJ3fjnZld6nODiHNSt/wWr177np4E3M9wvSaSB/Z9PRNGdGYEyIP0piF4R6nkEzLD12/u4Kj0FGJQMORc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783851391; c=relaxed/simple;
	bh=CkFv28+JxLuiDYyVGVUBnuoNV0qPyEi3cMALyJp88Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2TeBbv3xHycYSQL6QPqHIUoR/TxTo+GhwkD59gFoACastSZ3bG7fqGn9lmS4nFFlMo4/77Ya9G/zZWkDHIjEaqz7sAUcBvvrK5x4MblG8/SLC4C5PDYSEugR1rBXeBdlvE9/ihjt/f3DrIxbMep41R+jQ7MBfKjADJKcSIB39g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDofYl5b; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDofYl5b"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so2007996b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 03:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783851389; cv=none;
        d=google.com; s=arc-20260327;
        b=a98kWQbPZKGB5eTlCCO3VPaZ9Pw0gqU4BsnM3Te6Ptv6wbroPjexeljoBBNTfPhTlH
         sIAlM4BQ4Xjf/fPpLfQlIR12ytK3N3FkaVlYslQcUAC+XMvRyDVFlPDd1B836Z0GNRUk
         HZgH9rw05K8NR4zmD4tYvLoqm+0JzIQM8qmDALkfwieZy2XEHVGiWldWTfCo9Mcv27om
         hpziu2wxKZFHxQAKLfHlB57NP2CW4DwCIu2tF2L7d9IWoKeP5SU/scl+XrI/zt8q+pGy
         ppg0Q5OOr3b+EhmJzCNOd82w1EavPmBQMkXpP0MFZ3M5ZdQhTXFdw8kgozZ8yoFE4i9G
         X6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tMianh5edCr8euLIfheCzNHGjdZcQsdz0PWxBLB0Dl8=;
        fh=HtlxYRI7AuCUKhFEgPZmrkM1LeHOIMzHwIrA9vst/IE=;
        b=YLKKtsAV5L1LIiXpO9KaBZpBo9rIrUii5xZpD56OoImsmTvNUbCFIMkk66u9UH1fgI
         0gKIo9mIfcVo+47qA1Dt9njVF1G+PRqfxcRUOulsA2CocLoQJ4MCwzcTcyesPaAYy9pl
         jgUU/f4/AL8qB7nh5afSAhAxiDIN1zghURODjVuGmQDdyAVJmum19FIOFryzyHz+jfze
         IgKm7n9hkxEifEzQbdkuCSrxwu/tyfNo8u6JHv/E0t2fuTLQQZxgmBAE34Ck9xRtpn38
         qAopCyIUyxsNqHGaBpNEaKiTcPklI1rHlD3ivQA5lb4679N4/k/batd2hu9+v/L+huX4
         UPUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783851389; x=1784456189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tMianh5edCr8euLIfheCzNHGjdZcQsdz0PWxBLB0Dl8=;
        b=lDofYl5bawhX3upFX/aNGRp8gE6wH/RQPcO07G2eJEjB8+T4hEuHTNw8/uNJHDy7I9
         y/mWkrS1YdYDBtGXUtXLe0M75+4d2Zfy+7j5vMOvADOf6NNfj9bsnway4ENd+SVVPrdv
         ToEspRIk5nwEtchA0hi2dXqxj/6G6PN1u6uM8ofRqiRqmfA6FUze1TXW1jfK6U5AeZwh
         EgojTy1uN84ikoPsllpOBgfXHMXZFHybam0wI9GyzMPAfHg7HDH+/7ElCOzMoan7lM2a
         ED4OD8Ieb9gums/SeJMuJTve6ltuKU9MgGj2in2QAjKaij50IJe5k7Qra43Qr4OndRtk
         VFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783851389; x=1784456189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMianh5edCr8euLIfheCzNHGjdZcQsdz0PWxBLB0Dl8=;
        b=duIcrwg4EJRY5gbaiZYUMcPbnnriPFwZRKxVML+mbPufxGnTgYHBsuzkwCXGVe5bHg
         ruZmdCTfnMNrsly9TKB+qnSXbsnLAe0tcohiQrxiPQWnMQzibNJoetjOwPdEMF3SkbXq
         xeaFMvisSsTn2YgLPSd+PoDwGE7qll5smlmIQxFqIzCHtTZnQ9CElj4MesLbu8KQeow3
         7hisOb4bGVL3FwFrqHKBXu1JtISaYJTXo54CikxXhjm7uVBA4dmB1QvCFHRQX+qgCB+a
         5I779e44n8S41+krH1Ed/Fm0n3cwfnyA7Pkrkt+jpd7Gk5/BR3uejK5YEGe+RLfWIoVM
         6PQg==
X-Gm-Message-State: AOJu0YwZSXLRJt4dgk5Z0Nd5n+hKrgMl8zeu/31s5UbqTVQwM/IaVPur
	1lqgNjZbbxW3NPX3GN73xEDOR8T8gRyM+4N0TR+saChXiwtH1MrKsZvvJwgcl8Z8/2vnNbSsSz8
	f6cU147DayQL42obKT7tJFhhnNOoI5tI=
X-Gm-Gg: AfdE7ck2l2oSCyV2ZkXMDm4g7NS7QS/jy25y+tDQR2hyyfTsYnWYBH+2Tl2SN9cLPde
	LCDL8ao7EUQK2SqxBabssT0PqPuL4qHyqvbTgGsRpBOdt68hCP89ZvSsodjj7fw/UEo1I+2Dr9u
	UxrCNuzBoxcK6RgffZ7o4hDzLhopOw04e5DeVW3uV7yyKFnCZvV0vHLWKqmhOX43Q/Q2j7HcMPe
	xXOdS7rnKK4/FxnX5qmrlyk9XGHiA6vp4TN7tFJnwrRwdzFfqbjLX9OS3MoVHWHQ4jyHqeslHCB
	fNZ82w8Kk0pIRTub71uElZzwmbir
X-Received: by 2002:a05:6a00:8b8e:b0:84a:30be:7909 with SMTP id
 d2e1a72fcca58-84a30be7d02mr595985b3a.17.1783851389183; Sun, 12 Jul 2026
 03:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
 <20260711184414.1013686-4-jakubszczudlo40@gmail.com> <35c47ff5-0a8b-4c99-8e5b-d86c04039e17@baylibre.com>
In-Reply-To: <35c47ff5-0a8b-4c99-8e5b-d86c04039e17@baylibre.com>
From: =?UTF-8?Q?Jakub_Szczud=C5=82o?= <jakubszczudlo40@gmail.com>
Date: Sun, 12 Jul 2026 12:16:17 +0200
X-Gm-Features: AVVi8Cez6I1jTDfxtg1MHCxEwED0k6HkZlinYACuuAAlx3AjbW48A9xsrF1chvw
Message-ID: <CA+gq5JjrNzZHFhPeSM=AEpevHgStV2T6dEGHTUpnvzAbSeO1FQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100 driver
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, duje@dujemihanovic.xyz, 
	Jonathan Cameron <jic23@kernel.org>, jishnu.prakash@oss.qualcomm.com, 
	jorge.marques@analog.com, joshua.crofts1@gmail.com, krzk+dt@kernel.org, 
	linusw@kernel.org, marcelo.schmitt@analog.com, 
	Matti Vaittinen <mazziesaccount@gmail.com>, mike.looijmans@topic.nl, nuno.sa@analog.com, 
	robh@kernel.org, sakari.ailus@linux.intel.com, wens@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sob., 11 lip 2026, 22:01 u=C5=BCytkownik David Lechner
<dlechner@baylibre.com> napisa=C5=82:
>
> On 7/11/26 1:44 PM, Jakub Szczudlo wrote:
> > Add ADS1110 support that have faster datarate than ADS1100, it also use=
s
> > internal voltage reference of 2.048V for measurement.
> >
>
> ...
>
> > +static int ads1100_get_vref_milivolts(struct ads1100_data *data)
> > +{
> > +     int voltage_uV;
> > +
> > +     if (data->ads_config->has_internal_vref_only)
> > +             return ADS1110_INTERNAL_REF_mV;
> > +
> > +     voltage_uV =3D regulator_get_voltage(data->reg_vdd);
> > +     if (voltage_uV < 0)
> > +             return voltage_uV;
> > +
> > +     return voltage_uV / (MICRO / MILLI);
> > +}
> > +
>
> ...
>
> T;
> > @@ -276,6 +310,7 @@ static int ads1100_read_raw(struct iio_dev *indio_d=
ev,
> >                           int *val2, long mask)
> >  {
> >       int ret;
> > +     int data_rate_index;
> >       struct ads1100_data *data =3D iio_priv(indio_dev);
> >
> >       guard(mutex)(&data->lock);
> > @@ -292,12 +327,12 @@ static int ads1100_read_raw(struct iio_dev *indio=
_dev,
> >               return IIO_VAL_INT;
> >       case IIO_CHAN_INFO_SCALE:
> >               /* full-scale is the supply voltage in millivolts */
> > -             *val =3D ads1100_get_vdd_millivolts(data);
> > +             *val =3D ads1100_get_vref_milivolts(data);
>
> Obviously, the existing code was getting away without checking for
> error here. Since the ads1100_get_vref_milivolts() function handles
> the error case now, seems like we should be checking the return value
> here as well.
>
> >               *val2 =3D 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
> >               return IIO_VAL_FRACTIONAL_LOG2;
> >       case IIO_CHAN_INFO_SAMP_FREQ:
> > -             *val =3D ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
> > -                                                data->config)];
> > +             data_rate_index =3D FIELD_GET(ADS1100_DR_MASK, data->conf=
ig);
> > +             *val =3D data->ads_config->available_data_rate_hz[data_ra=
te_index];
> >               return IIO_VAL_INT;
> >       default:
> >               return -EINVAL;


I'm thinking about next patchset where I will address voltage
regulator stuff, adding it to struct and taking it voltage just once
in probe. Can we leave it as it is for now?

Best regards,
Jakub Szczudlo
