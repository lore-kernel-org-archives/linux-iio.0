Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB96368940
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772967901; cv=none; b=pi+QsmhDCqgwdDSCkM9jtJjl6kgqTDkZlUw85VffrKE/dB91uR+o2RD0FgiKfewKDnhUJJODkTAMzFTtV4Tnd7LNFGrgJpVSMMXXWLTAY+QV3CcUXM8nLzD/TMFtxnE7fdgk8MDvKJNOibHHPu7HqLabrTvNo8btOFBzyvJukwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772967901; c=relaxed/simple;
	bh=9gPDtpd4mBNWOUOxraJnQcOsDJMondQzmRZFVuBawzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5Zhtl6EJxDi3/Of3LcSrIBi3BDsL520ptMxAUJiOFU7+BQquqoCArOaj7zPfUO0P0FfldE+gwbBmDvcqtqwiKvdG3BnUMxuLXdqcrqfmYI/7fWXXMPAlDUcDDY8Gow/de45NpmlK3Szau6RGD9opH9itUTvY5ra//iDa+RjD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so9810056d50.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 04:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772967899; x=1773572699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wTltxE2z0oe8oSkasQNopG2LUPadxirCkumepv6l9/s=;
        b=vWKEtsS6vW7Bq78gL5ae3MamSUIy20UpsNOzWIDZ0GLl9F8XQBgl6a1VqOm976sUZR
         uErRzvSNNUZ5pqLxGeOHCSB+zGnLiSssX9eAs5QhE0uUro2p0BzODoWBcGm7hZjS4kiO
         w2NK9fsbvGyF1T1qhsIX6a+0OZ+3ZuYGcE6yP9YpGWoFCHkA0+A5RkH73JseQyl2JvKZ
         8sGJhN6jd2/hoGkoUDfj5tHF25sR9+cDT6vmxjEeM6nRk50X4stON27CXTVMNTXussuZ
         9J68NUF4pt+cDAT7UeTDs/sX3q5adlI4EO0oAPD8xx1bGVlMxPkZJMsxIlxfs1IPxR0z
         fhNQ==
X-Gm-Message-State: AOJu0Ywy5WL1fuhWPOsMUhVwVmbsFo8GxcdI2rflTtc1ep6a5gJ8tKWG
	7cg+cmjDSY7oSrzk4h0d2HfmmzEP7dLMn7gaQAmwDklPtJZhphaO4ExJ0cgN89OLfxM=
X-Gm-Gg: ATEYQzw1eN/RtdsDoJ2X4jiehDn5dKTqgjP/jL14EVGiM8mAQF8QqCorXYOfS1+/sjq
	3OgAScgZ35fO8oXKCPWNtt8mikQf1cpJBWhEdee3z1Qz4pnjUJd2ET/sHjYT3xhQRq3S9sQgKId
	UkwH5Db8ebybu+39IBmjICT4MQuk6mQNzwsvxQ7HFMwZY83/dnqN4c+GtngtcXcpJxLdXctuaAk
	2Bm1VOm2Ie0Hu5Q6yD1xUrWSSfFshDNo8R97ziRW4pWjrsdQchFOSazV0/R41dRXXI3bMbJXV6t
	RNwUEXvL74HKEGTECduvDu06nZiTvw0jmcZMKsG1YYhRydtjermFQVrJBWDbmYE7e4r4Uja6dc/
	tY1loU0+F2CriFaeTvenZquocMgs2vKcEwIT+Q0rE/NAmh0pQCbKq86v1NeGcWjJ/LFz7+lUO9I
	aZxlnyctvVruHW9zExSF6bJUO7S+suglz67vE3cX6lzkxC9tBPqRl3
X-Received: by 2002:a05:690e:d42:b0:64a:db17:3ce6 with SMTP id 956f58d0204a3-64d1406e410mr7544756d50.2.1772967899239;
        Sun, 08 Mar 2026 04:04:59 -0700 (PDT)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com. [74.125.224.53])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm3274887d50.20.2026.03.08.04.04.56
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 04:04:57 -0700 (PDT)
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ae222d87dso9693527d50.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 04:04:56 -0700 (PDT)
X-Received: by 2002:a05:690e:120e:b0:64a:f927:b3b7 with SMTP id
 956f58d0204a3-64d14358867mr7876885d50.77.1772967896431; Sun, 08 Mar 2026
 04:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303090253.42076-1-email@sirat.me> <20260303090253.42076-3-email@sirat.me>
 <3181de17-d3f6-479e-9500-f5d552bb4151@baylibre.com>
In-Reply-To: <3181de17-d3f6-479e-9500-f5d552bb4151@baylibre.com>
From: Sirat <email@sirat.me>
Date: Sun, 8 Mar 2026 17:04:45 +0600
X-Gmail-Original-Message-ID: <CANn+LW+uLQuoRbN4UMq1-pVcsJqzc0sMQNGwfwuSrTR-pNdLog@mail.gmail.com>
X-Gm-Features: AaiRm52PYb_rtA4-d1aCtn2cfZ_t84oqp4uh_6f1BHRnrYpTvIcQXG-7edeB8Zg
Message-ID: <CANn+LW+uLQuoRbN4UMq1-pVcsJqzc0sMQNGwfwuSrTR-pNdLog@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: proximity: add driver for ST VL53L1X ToF sensor
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 11:17=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 3/3/26 3:02 AM, Siratul Islam wrote:
> > Add support for the STMicroelectronics VL53L1X Time-of-Flight
> > ranging sensor with I2C interface.
> >
>
> ...
>
Hi, Thank you for reviewing the patch! Please find my responses below.
>
>
> > +static int vl53l1x_set_distance_mode(struct vl53l1x_data *data,
...
> > +             if (ret)
> > +                     return ret;
> > +             ret =3D regmap_write(data->regmap,
> > +                                VL53L1X_SD_CONFIG__INITIAL_PHASE_SD1, =
6);
>
> Maybe worth using regmap_multi_reg_write() above and below?
>
Done. Put the register values into const reg_sequence arrays
per mode and use regmap_multi_reg_write(). Much cleaner.
>
>
> > +     case IIO_CHAN_INFO_RAW:
>
> What is here is perfectly fine, but I'm sure someone will eventually
> want to change it to IIO_DEV_ACQUIRE_DIRECT_MODE().
>
> > +             if (!iio_device_claim_direct(indio_dev))
> > +                     return -EBUSY;
> > +             ret =3D vl53l1x_read_proximity(data, val);
> > +             iio_device_release_direct(indio_dev);
>
Noted. keeping iio_device_claim_direct() for now.
>
> > +
...
> > +     ret =3D regmap_read(data->regmap, VL53L1X_RESULT__RANGE_STATUS,
> > +                       &range_status);
> > +     if (ret || (range_status & VL53L1X_RANGE_STATUS_MASK) !=3D
>
> Probably best to use FIELD_GET() here and redefine VL53L1X_RANGE_STATUS_V=
ALID
> accrodingly.
>
Switched to FIELD_GET() in both the trigger handler and read_proximity.
>
...
> > +
> > +static int vl53l1x_configure_irq(struct i2c_client *client,
> > +                              struct iio_dev *indio_dev)
>
> Would be more logical to move this function closer to probe.
>
Moved it right above probe.
>
> > +{
> > +     struct vl53l1x_data *data =3D iio_priv(indio_dev);
> > +     int irq_flags =3D irq_get_trigger_type(client->irq);
> > +     int ret;
> > +
> > +     if (!irq_flags)
> > +             irq_flags =3D IRQF_TRIGGER_FALLING;
> > +
> > +     ret =3D devm_request_threaded_irq(&client->dev, client->irq, NULL=
,
> > +                                     vl53l1x_threaded_irq,
> > +                                     irq_flags | IRQF_ONESHOT,
> > +                                     indio_dev->name, indio_dev);
> > +     if (ret) {
> > +             dev_err(&client->dev, "devm_request_irq error: %d\n", ret=
);
>
>
> Can use return dev_err_probe() here since this is only called in probe.
>
Done for both error paths.
>
> > +             return ret;
> > +     }
> > +
> > +     ret =3D regmap_write(data->regmap, VL53L1X_SYSTEM__INTERRUPT_CONF=
IG_GPIO,
> > +                        VL53L1X_INT_NEW_SAMPLE_READY);
> > +     if (ret)
> > +             dev_err(&client->dev, "failed to configure IRQ: %d\n", re=
t);
>
> ditto
>
> > +
...
> > +
> > +static const struct iio_buffer_setup_ops vl53l1x_buffer_setup_ops =3D =
{
> > +     .postenable =3D &vl53l1x_buffer_postenable,
> > +     .postdisable =3D &vl53l1x_buffer_postdisable,
> > +};
>
> These are not symetric. It either needs to be postenable/predisable
> or preenable/postdisable.
>
Fixed.
>

Thanks again,
Sirat
