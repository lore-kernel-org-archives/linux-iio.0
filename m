Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F237BE8B
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139855; cv=pass; b=Dt7NJeEsiF1UmVFeRTCq4hwRNtN2pOVPovJLa3hsX9J95nbNK5+B02TPek2o8V7TWMT6jto5cWKdY83AEbxto8xpO4gxh+GjzZm4w9iRIVnIAkhEREF2u11IR3W8VYJKnYax6kPX7BlflW7n6t/elEuI55fG4mpwTJ89+atg2fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139855; c=relaxed/simple;
	bh=le/hQYlmF/6b761T9Rx4bLDpGIWBkCA1cOsd1cBIlJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRMm9AEm/p+E1tmE9jEeZKIyOQT1I9NfG6BVrrJfx/Al6TEi6xiNjhcg875LrCJyei94roo7/RfJ1IQGQiM59q7NcEU2LOGJSIqE4FksvwuEsbi71E3u3miVxVVyHYjpsUB+whSt9b1aZQrOabXcPmwWOGKVAxvg65pZVdJl3cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOyc9ZyN; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOyc9ZyN"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40d02b58bso2108356e87.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 14:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779139852; cv=none;
        d=google.com; s=arc-20240605;
        b=Tnr81CFrw8LB687Bb6A1XH/sb/cLq1INO5sPjzeDUdmt4vSgTPFMMfI5eiQ7Cq6BzN
         VMpAecg7HPXAxtT2apXVxA5ACDKsMeAvJ2ZNVUaJxvH4sMH+0BhKOvM7jp+l9LrAldgC
         4buRzagtupAOr4qP80Le6x09h36fYUF6hw7iFQbMCT7KK7oP3CcC7ugQ+WBEaf3xGJL6
         WYkO7vpapmucgqPZKqZ1i1DczrrO4JwyF5+RIJBFBtT006mTFyUBkerPPzM8EHeLC/13
         RBHCBUbaD/oMbbWTD3XXm0spAqoEBVmkxyktXqV8FaSVIAiMUA/+5Dhfx13XB6KKFxcR
         hE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bd7vYJplBbBzOnELLDZvPr8fn2AoBJSrdCftd49937E=;
        fh=yWbAHmfV6S+abSDiEgR3ONFD3q2ch3OxQ/XE9fFK+dI=;
        b=BvX7MXu77xj65+oJSkDc7Iyems24dQemVomjdpA7jBeG/bOJYGUZwdbLIL/EBZDCJn
         ne/bge7fgfbIY+XGnll9Kd7VkchjP0URx3jDfH5UEaiVBOQCyOCf8Fgf/mbtf5xWJXm4
         yGWbl5S42kySYafmvCXPNOizKtk9lg9jFRIr6Uha2OyuNNJB1Hj5IkLW8rC3bnP1jodK
         LfYtrOC5aMhoI+Htj8H/ItyV8RQsfn8v4USMfApZj60NaoZtDlkYfYh4j6qafqPbifvp
         vzWpglAzZftEEVjB6WPpdS/ezV69Ny0wQJYQ4RBFEmkoIQah2jEb3AUnqhjWTm7ieZOw
         ma7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779139852; x=1779744652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd7vYJplBbBzOnELLDZvPr8fn2AoBJSrdCftd49937E=;
        b=JOyc9ZyNV/vKgk0at0A6CFOI20ISSK3itlZoFEw0oK8jtS6XSPbZmQcKwLi6SogHlh
         0PXqwCmiIjV/awuSubwaEnF1UCMbm7cqO5O6Tx7HjAg5XRn9ZBCDAGd1NtERVWI4alKc
         4ERhLQbCfPm5T0kdnjDz3foZex72p3ZFuNxsYwcT26LTPmqBNjW8VGUoDEtK2bvryrZ3
         8JlnxhYcn2hSxlnW84vUj80+3eolwl5Oa7nGL6utn7QMyZr0OmVOImhv05pKZUpymJdF
         gHoQphGOc0TuOt6FG4g+B75hzgG+kQxFs8XS2cLH+fXR/D8keaGaH6yGzJDDez2WRioB
         LXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779139852; x=1779744652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bd7vYJplBbBzOnELLDZvPr8fn2AoBJSrdCftd49937E=;
        b=lkt346tVAn21YX7i5ZYWV+ZDNrSy5n8qFxIXzjyZBsK8LO5qsa5sJIVs6vOiI03/Gc
         0FcIZBlijjMvXI5/qYm3/FtxxYrfCW4yYJx9B0NH4vZwanVHRZKwXiB+evnphIm21c+C
         Lf7evP422xQgnMK5r8QwQwzeQN/CVdOlF2vl0bgHWGVZLi/y/+5/ykmja5j+o2Bthe0i
         TLngNMbYXJdZYX3L15FLSuwmLU/ne1DCDLWV9KZ8Tdhl/GsEUqP+p4gy6ZknSxoX0Gab
         WU9wT37pNlnwGYPhFOLWd51Z3ELfUJXJNdshsynClw3UEaLrhkhqDViwzicPWIFHNPY0
         MGEw==
X-Forwarded-Encrypted: i=1; AFNElJ9if8WvgJYS0gNQtWQrHUBBn80njxSSbAdtWhPxWhJ4gdVnq3ZeqACqMUDpUp1Y1aunV7JUq/isv5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfAqLBZeX+2xuD/Fsxdd2tZw59EtG+JfCD19knPTh07uCAZN9u
	SD7y6+98GmytemL1QuhVT/ptZVsuO86zZ3b4f6wpMFsHclmv3OBWrunjTv7Pr0hvQC8tKMnLaQ5
	Q9Mf6rVaUBAvPhXu+pBJIWcUPZvyIugM=
X-Gm-Gg: Acq92OEIJCz8QTDU2XBmtjkim3fz1XPhY415Vm/nGwr7EagGmfD9we4wmMzkFAuBy+r
	aCm5Sdy3e5N7cY+jRWIojILbO1R4bVnwazOnAHG9PUxSxOPoaLDXbg4D36cBo7wES1w5aZnUzr0
	PEsxH9QQN/JbqPkTOiNqvEbV1hv6Fcb+oBUnz4TVsjJ/YCIRzYlGWO+GeKZmsfr9jtcUaqqJ47U
	IzCTjgSSp37fgkq2beTJRb8KxU7zETdAnNrLj+LDDP+SFX4YwdmsVp37fCCKdPUj2dT9ZpEUsEH
	QTe0kXHFZIlm+zNfOsFEA4NrpyJq5ewFBLJsT20=
X-Received: by 2002:a05:6512:3087:b0:5a8:89d6:93e0 with SMTP id
 2adb3069b0e04-5aa0e742990mr4824546e87.13.1779139852267; Mon, 18 May 2026
 14:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
 <20260511174342.123820-12-piyushpatle228@gmail.com> <20260512133806.74c566e0@jic23-huawei>
In-Reply-To: <20260512133806.74c566e0@jic23-huawei>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Tue, 19 May 2026 03:00:13 +0530
X-Gm-Features: AVHnY4KGl6KN8fz9MnmyUah6Swvo5JtlVgairdcJc8lsRYz7ujlNacoZz2O94KI
Message-ID: <CAMB+xkYugs9GvcQBum_B_fx6Qcy5zD-KSEcZova39S0An4L-cw@mail.gmail.com>
Subject: Re: [PATCH v8 v8 11/11] iio: adc: hx711: add support for HX710B
To: Jonathan Cameron <jic23@kernel.org>
Cc: ak@it-klinger.de, andriy.shevchenko@linux.intel.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 6:08=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 11 May 2026 23:13:36 +0530
> Piyush Patle <piyushpatle228@gmail.com> wrote:
>
> > Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> > interface but uses trailing PD_SCK pulses to select the active mode.
> >
> > Model the HX710B with variant-specific channel tables and IIO info,
> > track the active channel across conversions, and use the fixed gain
> > value when computing scale.
> >
> > Also update the adjacent Kconfig text, file header, and module
> > description so the driver text matches the newly supported variant.
> >
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Hi Piyush,
>
> A few things I'd missed that Sashiko mentioned.
> Note that most of what it calls out in v7 of this patch is wrong because
> of the whole active_scan_mask / timestamp bit being set or not thing.
>
> The channel representation is indeed odd and I think that bit needs
> a rethink unfortunately.  I'd failed to notice it wasn't just two differe=
nt
> channels but instead is one physical set of inputs measured at different
> sampling rates.
>
>
> > @@ -403,16 +442,16 @@ static irqreturn_t hx711_trigger(int irq, void *p=
)
> >
> >       mutex_lock(&hx711_data->lock);
> >
> > -     memset(&hx711_data->buffer, 0, sizeof(hx711_data->buffer));
> > +     memset(hx711_data->buffer, 0, sizeof(hx711_data->buffer));
> >
> >       iio_for_each_active_channel(indio_dev, i) {
> > -             hx711_data->buffer.channel[j] =3D
> > +             hx711_data->buffer[j] =3D
> >                       hx711_reset_read(hx711_data, &indio_dev->channels=
[i]);
>
> Sashiko pointed out (v7 review) that this can return an error. We should
> really be checking for negative values and if they occur don't push data
> to the buffer.  Given this is unlikely to happen except when the device
> is very broken, a rate limited dev_err is usual way to report this then
> carry on without calling iio_push_to_buffers_with_timestamp().
Agreed. I missed that.
In v9 I will make hx711_trigger() check hx711_reset_read() and skip
iio_push_to_buffers_with_timestamp() if any channel read fails.
>
> >               j++;
> >       }
> >
> > -     iio_push_to_buffers_with_timestamp(indio_dev, &hx711_data->buffer=
,
> > -                                                     pf->timestamp);
> > +     iio_push_to_buffers_with_timestamp(indio_dev, hx711_data->buffer,
> > +                                        pf->timestamp);
> >
> >       mutex_unlock(&hx711_data->lock);
> >
> > @@ -463,6 +502,10 @@ static const struct iio_info hx711_iio_info =3D {
> >       .attrs                  =3D &hx711_attribute_group,
> >  };
>
> > +/*
> > + * HX710B channels (Table 3 in datasheet).
> > + * 25 pulses (1 trailing): differential input, 10 SPS -> channel 0
> > + * 26 pulses (2 trailing): DVDD-AVDD supply monitor, 40 SPS -> channel=
 2
> > + * 27 pulses (3 trailing): differential input, 40 SPS -> channel 3
>
> I'd missed this previously but sashiko raised a question on it.
> Why are we representing the same physical input channel as two different =
IIO channels
> based only on the sampling rate?  That doesn't seem to make a lot of sens=
e.
> Should be one channel with a sampling_frequency control.
>

Yes, you are right. I should not expose the 10 SPS and 40 SPS
differential modes as separate IIO channels.
In v9 I will model HX710B as two physical channels:
- voltage0-voltage1: differential input, with selectable sampling
frequency of 10 or 40 SPS
- voltage2: DVDD-AVDD supply monitor, fixed at 40 SPS
The differential channel will get IIO_CHAN_INFO_SAMP_FREQ. The driver
will map 10 SPS to one trailing pulse and 40 SPS to three trailing
pulses at read time. The supply monitor will always use two trailing
pulses.

I will also update channel_set immediately after hx711_read() succeeds,
because that is when the trailing pulses have been sent and the hardware
state has actually changed.

Will send v9 with these fixes.
>
> > + * .address stores the trailing pulse count for hx711_set_hx710b_chann=
el().
> > + * Channel 2 is used for the supply monitor to avoid aliasing the
> > + * channel2 terminal of the first differential pair.
> > + */
> > +static const struct iio_chan_spec hx710b_chan_spec[] =3D {
> > +     {
> > +             .type =3D IIO_VOLTAGE,
> > +             .differential =3D 1,
> > +             .channel =3D 0,
> > +             .channel2 =3D 1,
> > +             .indexed =3D 1,
> > +             .address =3D 1,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> > +             .scan_index =3D 0,
> > +             .scan_type =3D {
> > +                     .sign =3D 'u',
> > +                     .realbits =3D 24,
> > +                     .storagebits =3D 32,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> > +     },
> > +     {
> > +             .type =3D IIO_VOLTAGE,
> > +             .channel =3D 2,
> > +             .indexed =3D 1,
> > +             .address =3D 2,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> > +             .scan_index =3D 1,
> > +             .scan_type =3D {
> > +                     .sign =3D 'u',
> > +                     .realbits =3D 24,
> > +                     .storagebits =3D 32,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> > +     },
> > +     {
> > +             .type =3D IIO_VOLTAGE,
> > +             .differential =3D 1,
> > +             .channel =3D 3,
> > +             .channel2 =3D 4,
> > +             .indexed =3D 1,
> > +             .address =3D 3,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> > +             .scan_index =3D 2,
> > +             .scan_type =3D {
> > +                     .sign =3D 'u',
> > +                     .realbits =3D 24,
> > +                     .storagebits =3D 32,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> > +     },
> > +     IIO_CHAN_SOFT_TIMESTAMP(3),
> > +};
>
