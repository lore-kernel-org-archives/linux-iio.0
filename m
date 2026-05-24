Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A523909C
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 02:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779591363; cv=pass; b=l7PQulcHh0N1jIrbEkeIu9XMz/dM2utCHHyt9Wr4wd20MN6XuJasTZHZQhdmqXhpUgGNDzsOElBNMgoJDbfqISd2ofXLT8tX0+jXaeiUZM08exYWu2eCO4wCNQ14djKefXP8/f/u1nDvf6p/XcZeo1zsh2i0FOe/dlFsAmFGFNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779591363; c=relaxed/simple;
	bh=GGQ247UeDeQbFJuWdyJGXSh7JAbSPQWiKQJvb5FePoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzNpRNWqghjX788eSNYP7MJYxBHRyQtVDzw4a669741Kr9MuSER1xM3mJxImhRPQ+EX92YAl+F13zsSYGyJNHpYbQWATX30b477yYZVQEojQ4i7Wuo+xFW8mfxGb4V4wj09xOc5EVDKhle4+c07hJbTyOdnUvpbVYW92pkPLh7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmpPJ0rS; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmpPJ0rS"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a40502e63bso8714518e87.0
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 19:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779591359; cv=none;
        d=google.com; s=arc-20240605;
        b=gtVNrGMCihvysS3wDhI5zMWhcQ1geoCiWUkcCcFK900FSaAUGV9P+ba0XsjpYCYbsG
         /M1UfOwuNlYcFIjvdmkgkSSg83ggRpmB1X3AajbyvwdT6NYAptOVsGKIwAvAZ+TvUMaL
         eCohiNDbwMTUTwevOIWlztSs4hpRnEZyf/3uByROVSeR4+soZSgyIeRkVBUlp889lD84
         Mec9qAa9nh4GWkD2qsINwcH2SAlpNgKvD9IjBLw424pLjItbI/SlQHBFtznD2V3IM4wo
         VVxP+qVGwDYtsZeJBb5Iv2clGCNg7DVr6mHZwsw9ABd/cHxYi5uy+QTVi86WRqLWeNEt
         89sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YvQBA1KgfeoEv/AC1zUlAOpplXi4c1lOtwwbNp8fSds=;
        fh=IUBVRv0LkA2fTmEdnXJAOpW+T8xzg3AtLoy/R2nvIWw=;
        b=NrD4SFWVkNmsvR1bh6w2gQDdEvdTv3O39se325amg7M9JEz4Zl0lOuXQbcp62Xt+2O
         N2Rf964RWs2nPmD85S6+QH2T6URDz9ccB3M/M4R/jpuUXWxP40WWLQibXjqClT2ErLBA
         sa3LGBPBuwD76V1Gr4ASTXl9EwnemCo1ildFwn8Fkjcn3GiahfFuQcpypLQeT5GUCTHk
         vPb3LW9MRp4HX4eo30grCjHOLD94ovXtK6iWKfumh6UgH9S84DwGXVDyVLdnQyAfeEWf
         +jk5ilNti6ieS+9F98CRqUw50UMqhmMEz3+eTm4bcx72o7yH1wNJrh/UM/zbHbxSGiI9
         BvFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779591359; x=1780196159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvQBA1KgfeoEv/AC1zUlAOpplXi4c1lOtwwbNp8fSds=;
        b=HmpPJ0rSUTEQJ5jIbiN87c7MZ3E7EUi/W6pW17zlxJk2Uii/H8tuBD/IwUs8X1SjxW
         oNFlFSk94tdvw3LQ/cCdoY/Yxm5ofkKnB89SJnlX3saaBubw5XtURPKzFQ5uHRbinSgu
         nmRRazVmn5AMM7uJYGKtqfgz0F7GlK03l+QBkE1SwNuUwg8Oz02/lopMO/qVgNnCmTIF
         7/xO8FQdFf2jJK/q2yXhO5lAdf2jT5j/DzPHXzeRA8NuUsN1ug4Ua1RBHzuKS/LOn8zn
         xoFickkeEz2epF8F0AC55xp8a1++DSelZiX5coUUPWZGbHFfHsYfeHIQRF9Y0VdMLD/V
         ospg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779591359; x=1780196159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YvQBA1KgfeoEv/AC1zUlAOpplXi4c1lOtwwbNp8fSds=;
        b=Eamrfqcg7tmOdReoxflGlePLqpfkqYgKOWIggnHTmImPZuzNuB2u6BNiHgtkFRugjl
         +1CJfDbNBkgsLUVq5ItRyZfXj2/RoyaKjYTycdk66W9xL33vxUENOmyWHN72d76C8y86
         98F9E6vJSZurdFptHb54JMzW0BvAMuG0AsplM0fumxEqnz58x8X4xbDFfbK2Uur0aOzS
         jaIh/8E9cPSsS8q1wcEiK8mMRdPGh7u70KxWCBCDpodmJDP+g8JgXZFAYk+trNRtD6lB
         8Z1g/PeakJT4xBTuotE03yhnqACkH1OtHJEp2hf52glI/8AaTd1ufVs3XFMHN6ZIl2SL
         6BTg==
X-Gm-Message-State: AOJu0Yx5I34ivKn54+tdq3PGWtxGtKFbvnF/k9VrlnK0AlYI6hYn3ipX
	sgxZb/B7fXta5QQNiBpQ95uD9cTxvw7RNew+Ga1v8yIOE9w03P8f/04lAPo4rf96EmRNqkvwGqH
	XMEl83KsVUy3j42JCwBaZn4rLxobne9A=
X-Gm-Gg: Acq92OE/xbkWGUYGrfppVUiUV/CJuKivNzuXC/zy4TL26xHWSTOEHbbPOYvxG6EYqyV
	tfVgzUIvDju2d6w/LxWZFX2PiHqMGlndB4W0FniLx3UGbOqueA1tYkWw1yEU4kCwHs++E/8R75O
	ENfu4kE089+J5Nd7+6YzRiuulSWl17kMfXt4LxPFKLpIzTFkwntoS7YL6cS5uvlJ0Nz2Vbgr4Im
	DPbklUQL6Ty+9sW8xIU0jLVS8jJPatS4RWk38pT6rzmbGLfhq8l96Mcgp206ZV6Bc4TQlt0rI2o
	E7Xp83iN94sZV0J4+yaBZmVHSC+9k5vrHM2xaDLk
X-Received: by 2002:ac2:5230:0:b0:5aa:b6a:738f with SMTP id
 2adb3069b0e04-5aa323bbb3dmr1997230e87.45.1779591359254; Sat, 23 May 2026
 19:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
 <20260518220228.63322-12-piyushpatle228@gmail.com> <20260520113153.3e663a7c@jic23-huawei>
In-Reply-To: <20260520113153.3e663a7c@jic23-huawei>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Sun, 24 May 2026 08:25:21 +0530
X-Gm-Features: AVHnY4LO-E5tiBxAo-5X6MJtvI0nqCHRGgb9XR1QpdZlYSEqcPk6vWv7Ji0SpIw
Message-ID: <CAMB+xkYpfF5aGKUdDACVUXwK7P1xbMf2B_6eStJSRRLjoy6RCA@mail.gmail.com>
Subject: Re: [PATCH v9 11/11] iio: adc: hx711: add support for HX710B
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>, 
	Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:01=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 19 May 2026 03:32:27 +0530
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
>
> The vast majority of sashiko feedback on this version is incorrect
> or already something we've ruled out as needing handling.
>
> However, very last point looks valid to me so I've highlighted that.
>
> Otherwise, the main thing is it is better to keep the structure
> for the buffer now we don't have variable numbers of channels between
> the two devices.  That is the preferred route except when it becomes
> misleading (which it did with 2 vs 3 channels).
>
Yeah! Since both variants are now fixed at 2 physical channels, IIO_DECLARE=
_
BUFFER_WITH_TS() adds nothing over the explicit struct.  Will revert:

      struct {
          u32 channel[2];
          aligned_s64 timestamp;
      } buffer;

The hx711_trigger() memset and iio_push_to_buffers_with_timestamp()
call sites will be updated accordingly.
>
> > diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> > index 183568196d52..d5c977b4669b 100644
> > --- a/drivers/iio/adc/hx711.c
> > +++ b/drivers/iio/adc/hx711.c
>
> >
> >  struct hx711_data {
> > @@ -99,16 +105,12 @@ struct hx711_data {
> >       int                     gain_set;       /* gain set on device */
> >       int                     gain_chan_a;    /* gain for channel A */
> >       int                     gain_scale[HX711_GAIN_MAX];
> > +     int                     channel_set;    /* HX710B active channel =
*/
> > +     unsigned int            samp_freq;      /* HX710B differential ch=
annel sample rate */
> >       const struct hx711_chip_info    *chip_info;
> >       struct mutex            lock;
> > -     /*
> > -      * triggered buffer
> > -      * 2x32-bit channel + 64-bit naturally aligned timestamp
> > -      */
> > -     struct {
> > -             u32 channel[2];
> > -             aligned_s64 timestamp;
> > -     } buffer;
> > +     /* 2x32-bit channels + 64-bit naturally aligned timestamp */
> > +     IIO_DECLARE_BUFFER_WITH_TS(u32, buffer, 2);
>
> Now we are back to fixed 2 channels, don't need this change. The structur=
e
> is easier to interpret so please go back to that.
>
> >       /*
> >        * delay after a rising edge on SCK until the data is ready DOUT
> >        * this is dependent on the hx711 where the datasheet tells a
>
>
> > @@ -463,6 +527,50 @@ static const struct iio_info hx711_iio_info =3D {
> >       .attrs                  =3D &hx711_attribute_group,
> >  };
> >
> > +static const int hx710b_samp_freq_avail[] =3D { 10, 40 };
> > +
> > +static int hx710b_read_avail(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan,
> > +                          const int **vals, int *type, int *length,
> > +                          long mask)
> > +{
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             *vals =3D hx710b_samp_freq_avail;
> > +             *type =3D IIO_VAL_INT;
> > +             *length =3D ARRAY_SIZE(hx710b_samp_freq_avail);
> > +             return IIO_AVAIL_LIST;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int hx710b_write_raw(struct iio_dev *indio_dev,
> > +                         struct iio_chan_spec const *chan,
> > +                         int val, int val2, long mask)
> > +{
> > +     struct hx711_data *hx711_data =3D iio_priv(indio_dev);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             if (val !=3D 10 && val !=3D 40)
> > +                     return -EINVAL;
> > +             mutex_lock(&hx711_data->lock);
> > +             hx711_data->samp_freq =3D val;
> > +             hx711_data->channel_set =3D 0;
> > +             mutex_unlock(&hx711_data->lock);
> From Sahiko:
>
>   Does this implementation need to use iio_device_claim_direct_mode() to
>   prevent concurrent hardware changes while a buffered capture is active?
>   If userspace modifies the sampling frequency during an active IIO trigg=
ered
>   buffer capture, it resets channel_set to 0. This could alter the hardwa=
re
>   configuration (changing the trailing pulses) out from under the IIO cap=
ture
>   thread, which violates IIO concurrency semantics.
>
> Two possible fixes:
> - The one sashiko suggests around claiming direct mode.
> - Maybe not set channel_set =3D 0?  Then it becomes a simple race for
>   whether the value of samp_freq is updated or not.  Either is harmless.
>
> I'd be tempted to go with direct mode claiming but also consider if you c=
an
> drop that channel_set =3D 0 - or add a comment on why it's there perhaps.
>

Agreed the last of Sashiko's points is valid.  In v10, I will update
these 2 thing:
 - Guard the samp_freq update with iio_device_claim_direct_mode() /
    iio_device_release_direct_mode().  This causes write_raw to return
    -EBUSY when a triggered buffer capture is active, which is
    standard IIO semantics for writes that change hardware channel
    configuration

 - Drop the "channel_set =3D 0" reset.  It is not needed for
   correctness: hx711_set_hx710b_channel() always compares
   extra pulses only when they differ, so the chip will be
   re-configured automatically on the next hx711_reset_read() call.
   dropping it also eliminates the race entirely.

The resulting write_raw case will be:

      case IIO_CHAN_INFO_SAMP_FREQ:
          if (val !=3D 10 && val !=3D 40)
              return -EINVAL;
          ret =3D iio_device_claim_direct_mode(indio_dev);
          if (ret)
              return ret;
          mutex_lock(&hx711_data->lock);
          hx711_data->samp_freq =3D val;
          mutex_unlock(&hx711_data->lock);
          iio_device_release_direct_mode(indio_dev);
          return 0;
>
> > +             return 0;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static const struct iio_info hx710b_iio_info =3D {
> > +     .read_raw               =3D hx711_read_raw,
> > +     .write_raw              =3D hx710b_write_raw,
> > +     .read_avail             =3D hx710b_read_avail,
> > +};
>
> >  static const struct hx711_chip_info hx711_chip =3D {
> >       .name           =3D "hx711",
> >       .channels       =3D hx711_chan_spec,
> > @@ -502,6 +655,15 @@ static const struct hx711_chip_info hx711_chip =3D=
 {
> >       .num_channels   =3D ARRAY_SIZE(hx711_chan_spec),
> >  };
>
> > @@ -608,6 +781,7 @@ static int hx711_probe(struct platform_device *pdev=
)
> >  }
> >
> >  static const struct of_device_id of_hx711_match[] =3D {
> > +     { .compatible =3D "avia,hx710b", .data =3D &hx710b_chip },
> >       { .compatible =3D "avia,hx711", .data =3D &hx711_chip },
> >       { }
> >  };
> > @@ -625,7 +799,7 @@ static struct platform_driver hx711_driver =3D {
> >  module_platform_driver(hx711_driver);
> >
> >  MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> > -MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
> > +MODULE_DESCRIPTION("HX711 and compatible bitbanging ADC driver");
>
> Trivial but switch that to 'and similar' as they aren't quite compatible.
> Sometimes vagueness is helpful :)
>
> Anyhow, looking in pretty good shape so hopefully v10 is the lucky versio=
n.
>
> If you have time, it would be nice to get rid of the custom available att=
ributes
> for the hx711 as well - similar approach to you have done for the new par=
t.
>
>
> Jonathan
>
>
> >  MODULE_LICENSE("GPL");
> >  MODULE_ALIAS("platform:hx711-gpio");
> >
>
