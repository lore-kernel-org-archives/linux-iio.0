Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C1133BBCD
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240611; cv=pass; b=CYuh4SXhhHl+2LypBav67CwBaP2iCHswBtvDM/uxgcYFuI8WVfVn/bcr3kKyMBit8mdf+KpaudncFhm8CoYvLuL4p5AFCt9NZ0jqpUXroCZCFRQT5Um6lc8f4oBb+P7A00hNk1bHibOiciAnPkPSWB7zDlvoMnGAmSvhEw+bVnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240611; c=relaxed/simple;
	bh=2i7rua0A3sCIdIAznJi/9R/6Zhg0AyV1Lx8kkxysH5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeOSVdqfGQhVTCF2yJBnWpdVNF1Z4XBCXa/uodRsN6Z1UdKYaMBWmiGiRSLJGSWC0DQpIMFzP7vasMDDUG+vEj3TVivkTfNAft3CH1vPTRcdXVR5m9kPf+YNqtceLONnsTf7f30Q/aRp76jfmRjZfY1/C/eyNlTONn8KaLnNxrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3TYuF7j; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3TYuF7j"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c7d329fe93so1096215ad.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 11:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782240609; cv=none;
        d=google.com; s=arc-20240605;
        b=jJUdAU8SOn+U0dHcdh0Lrfr/wPR7yTQd288HZK1fdXblHG/GPiLD4NOAAGb/6T/8Sv
         YxwEI6kJE0RzBRRAB2CSAfpNcWXUdeEFL3bRXQa56lVdf8TLGf0Qmr4giDU5OtmXlUsW
         XpffdM27rBwQBFvGGETJ1oF1sbrIsxA1ytm6ORGm47NbSSPYk8EW1qvHamMqBYmOmDfn
         SuKFwDyEGPAabi0d7Ws3XsVseqPe64y7XtFMJPL27yxNJHt7FnbyfMH43olbvONJBf9Y
         TPnR5nf1+jp/YkI6Fc8ur1Rlg5ldCHkesx8AbjstKQhKtZmYX+qfFdxzR0CE2WDSIeEW
         sm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1sIxIo8I1GNUGXmx5ajo2afqYjnbFmaeXVsrW46Jp7E=;
        fh=SMuAOcUI2sY1zk900S95/XfKvuRul/YXSS3EopxduyE=;
        b=kwap1TinTGXcJz8xYWNoKxJI4JwCpoOyB/ybREUQka11Q5HiIrlQ0nEOLB/kfHW0Tl
         aew8hkQX9egu9BlBTJkD9Wy8CIWUVBzTPkckXhxKeEQBvsmbiBrMkYRpK1+OBaM3Eipk
         BEmRrAyax5E6O8w+jSd9lAwKdAvXrtFQP9Accdw/HPxUceioODRKmL6UjvvoaKLRM1a0
         GEHUIdQxOTJ+lyqrotjLOA2UZPH8FCHoASLzCcKeScX6BN//IgJzmfTpfz8h72DFYYxO
         BPl8rjmI+NvDseJ806gODzrUcPybo9cZ/lWW2FCkn5N8klTPrEmIzOWqYFUdAs39sSfD
         gBvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782240609; x=1782845409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sIxIo8I1GNUGXmx5ajo2afqYjnbFmaeXVsrW46Jp7E=;
        b=R3TYuF7jdBrtyOY033yxSpRM+lNXM6py2+7aTM4U5Bf+ijMIIBiauPfA2BuWkhyIV+
         0PM45sS3n2IzTxjsPXKdUH3zT62NgEph37cPvk3QtpUh/0vC0vOqnYof6M4XmRYhvKAH
         KwrS7F8GPdBf3nDeKFBVEbMbtveZnClubCa7Tob2UA0qAoC3fAq7A/dYSRwATBidlMpS
         WdE1/ZRtmgqaqoGnCN6CGszVtLcHwPSeDlyEXJTwbJaj6e2bp+GTHcIzwr0vJl3oD3JJ
         TCm42dPFVDKEiHO+gYwPtEI25A1O+zRPmaI97+LwEDINzTbGMaD2VtJB3D432QYUIpSo
         H6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240609; x=1782845409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1sIxIo8I1GNUGXmx5ajo2afqYjnbFmaeXVsrW46Jp7E=;
        b=Y5WbibctCV9Fw0Gtq5Zfo893kzWlHvyq5f5KGRIlrzrOQ6mV3OWG8/ltm/6oxotJKg
         3Ih3NiN3XLTEYaLmX8mUQCjsEWpUq4OUhwpJsJxWo4FRnphM5Vlo7Nu0qK+OK2tt9Pfy
         v2wso7yXTzchD7K9YBIA8MZK3cqFTfEK/9YlsDUC4Nvp3YTTfP18Ycu1bFkQAprTAXYu
         qKKrNaWydnZ9/yx2Mq2J/CB+sY+R/jIOn3TjkvI+k6YOCKSE5nH0PTQRTVvSATorJhVU
         wjkchGV9Iexo2PrqEU2YVUjezfDPMsrOrfvc0XbdwWMH8viJmHF3O+tGsL3cdGQgVaVB
         7ENA==
X-Gm-Message-State: AOJu0Yy37hYvy7d22FMxVu7PWv3ht5M+h10FJ0Xzh2UFWoZ8M6NVLGtf
	Q+hOQYh3fhra3i4WMJTO/wpkLNawMjka+2/nyiXrnwF3i1iFsVM8mi0Vmatikx37Eg5pZ5dqd2E
	afQFWWIf4IjfFaAnrZmwne09SjVkKV5U=
X-Gm-Gg: AfdE7cka/vQsAPIIjgNtk58AsvbmQData8/OGEm5VTsvgph9aKNj8O7sMU1z2Q2CNoG
	BMKWmGipsOE7J/01BXTMk8kX4CrkbRI2KigC1n0/n7oU2gBiELcRTBjI61CELl5b3WmY1bJ74UH
	KY7xmTkuST5MbTFOQ1khiB4bdkNMX0rVNoZN1Ayzbmk+KZw9iDWgOD7mxu/0gK+wyHp9jFdUUAA
	XfkeOJV2rGNfaDS50CeFrhISuzsVR4Xd1Oz5aRshElyZtgmX68r46OtcXlPbDZ1sHjMZwSMsdXQ
	xDqoAbtxl/gP
X-Received: by 2002:a17:902:f651:b0:2c0:ab82:6b9d with SMTP id
 d9443c01a7336-2c7e15555e5mr920525ad.29.1782240609373; Tue, 23 Jun 2026
 11:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
 <20260622221550.374235-4-jakubszczudlo40@gmail.com> <ajpQn8EVOx3ssxG6@ashevche-desk.local>
In-Reply-To: <ajpQn8EVOx3ssxG6@ashevche-desk.local>
From: =?UTF-8?Q?Jakub_Szczud=C5=82o?= <jakubszczudlo40@gmail.com>
Date: Tue, 23 Jun 2026 20:49:57 +0200
X-Gm-Features: AVVi8CfpUH9nZN7h7nfQ8v1HKhudLTDUvSugvE2PGx9Vd29bDH02CXQJEhI3XJs
Message-ID: <CA+gq5JitNkTpNbeKUd7bSnCx1bt2ypJxpK7SZsiybAOiWvHUeg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100 driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, 
	duje@dujemihanovic.xyz, jic23@kernel.org, jishnu.prakash@oss.qualcomm.com, 
	jorge.marques@analog.com, joshua.crofts1@gmail.com, krzk+dt@kernel.org, 
	linusw@kernel.org, linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com, 
	mazziesaccount@gmail.com, mike.looijmans@topic.nl, nuno.sa@analog.com, 
	robh@kernel.org, sakari.ailus@linux.intel.com, wens@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 23 cze 2026 o 11:23 Andy Shevchenko <andriy.shevchenko@intel.com>
napisa=C5=82(a):
>
> On Tue, Jun 23, 2026 at 12:15:50AM +0200, Jakub Szczudlo wrote:
> > Add ADS1110 support that have faster datarate than ADS1100, it also use=
s
> > internal voltage reference of 2.048V for measurement.
>
> ...
>
> >  config TI_ADS1100
> > -     tristate "Texas Instruments ADS1100 and ADS1000 ADC"
> > +     tristate "Texas Instruments ADS1100 and similar single channel I2=
C ADC"
> >       depends on I2C
> >       help
> > -       If you say yes here you get support for Texas Instruments ADS11=
00 and
> > -       ADS1000 ADC chips.
> > +       If you say yes here you get support TI ADS1100 and similar sing=
le
> > +       channel I2C Analog to Digital Converters.
>
> User won't know what similar are really supported. The rule of thumb is t=
o add
> the list of supported here as
>
>           - ADS1000 (...perhaps some very short spec info...)
>           - ADS1100 (...perhaps some very short spec info...)
>
>
> >         This driver can also be built as a module. If so, the module wi=
ll be
> >         called ti-ads1100.
>
> ...
>
> > +static int ads1100_get_vref_milivolts(struct ads1100_data *data)
> > +{
> > +     if (data->ads_config->has_internal_vref_only)
> > +             return ADS1110_INTERNAL_REF_mV;
> > +
> > +     return regulator_get_voltage(data->reg_vdd) / MILLI;
>
> For now we used "(MICRO / MILLI)" instead of "MILLI", to show the unit
> conversion.
>
> > +}
>
> ...
>
> >       if (ret < 0) {
> >               dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> >               return ret;
>
> > +     } else if (ret < 2) {
>
> Redundant 'else'.
>
> > +             dev_err(&data->client->dev, "Short I2C read\n");
> > +             return -EIO;
> >       }
>
> ...
>
> > -     microvolts =3D regulator_get_voltage(data->reg_vdd);
> > +     microvolts =3D ads1100_get_vref_milivolts(data) * (MICRO / MILLI)=
;
>
> See above, here you correctly used the existing pattern, the above is
> inconsistent and needs to be addressed.
>
> ...
>
> > +     model =3D i2c_get_match_data(client);
> > +     if (!model)
> > +             return dev_err_probe(dev, -EINVAL,
> > +                                  "Can't get device data from firmware=
\n");
> > +
> > +     data->ads_config =3D (struct ads1100_config *)model;
>
> You can't drop const like this. If you need to apply modification,
> use devm_kmemdup(). Otherwise it won't work correctly if you have two dif=
ferent
> sensors of the same driver in the system.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


thanks for review, I will wait few days and start working on v5

best regards,
Jakub Szczudlo
