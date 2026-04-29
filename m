Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480462D0C89
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470553; cv=pass; b=I4IZ4QcfCiifG1vdydQesQJ0gW2wPP/ELwldDKHUPi5eT2Fuaf1SnyYZXt0ggTMMqDxApNdQPnN3HZvga2I+eIkwrA4C+egFNsX90736a5M0JkpK81yskPpV2lqhz+pMBdBNYDhdjkQOW31gmeTuOlIGFjSPDKOiTA2wtA6nXuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470553; c=relaxed/simple;
	bh=HS0f+TQzh536B5LM+2a2qBT5yfbIqaujje2sFOKqNgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbzM08CfteFwLGqj1wh2x+F6usw1tV1IMdicGux7vBw1C6pNJBC3hZiYoqzlKf9h8zWrAFHvw55TZ6ontjOOsF73o90linVgNyvnqbxZetEhLP2NvajCiY3VE8AYIFLL1a8qCN7KbJ0ZGpz1N+AaLlY9NVfU/4/nTdd3e2iW0MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUPs0PAc; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUPs0PAc"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d70b3e159so6752481f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 06:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777470545; cv=none;
        d=google.com; s=arc-20240605;
        b=c84xAsRjJnL3m8SHq4iEEnppzJtXkZwq+1yvIc4ZQC6rmncdscga4Ml3bX/nStiUZ2
         Xwd62HUG3pCeZFsg/cUlLlQv2Xmm3BXXx2OuhcrFPKtlByWnrxHhinePLwoe8cLbP1W5
         l4hCEvV1Om49dL1/gogaWOmLxXIttIs7NEAHLVBKXjsAPbdMJ0zo7u6p0bN1CpTF+HG+
         L9ZUkO+0Kg3BWt2+FY3qECwD5GjMTAEIN5xni5Pmm2eE67yz71VfuaAgrdfNzGLBNq+8
         /CbhQIy9uWAh/se4KPOY2NEdMxk/74tnyrGu/jFZVUi2PsxbNjC0nrGeWBsOAMji49dx
         plMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2/K+dBjl8H3UMhdYevOjyRfAyQx5Fle18ACEqi389PE=;
        fh=ip/XDDYpsazTIJWxZGYcDd6MtjYeE7bLWZ8t0jyat58=;
        b=BQY5y5CcFHAFo474Bil+soE6A+CWSXIUfdsHTbIwr5+u4fezMiCBEb8iLS5sEBUJOI
         yCXOTDsjpN6NeZIs4SlQPYFpanTUG++QR1XD9wA80+hRWUUIacVMfsJ7AiekhUChFg3L
         4++kFv3dD7DtXCSAaNKgoxQUZxSfZr5GX++rZjvhGaFmNsZWMdP8LxMg2Macrb89aRtk
         mAufznHhXElj3ycWleHMZmPsPPnS05EaCtbkD3kBocHyupuai3Xl75S8XXjeytgq4+GF
         eCYd11B4iw1qx5bZXx7LByu1edsF+pBg3EmFUkMWic/F82edpP9E2dsaIBxa7INiGuEu
         6Fmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777470545; x=1778075345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/K+dBjl8H3UMhdYevOjyRfAyQx5Fle18ACEqi389PE=;
        b=JUPs0PAc7/dLjlU1bJg1pmRTkuhtelr5qwojaBdbwLeGO9hx7P7uk5XGEQTxxw9wf3
         amWoBLYDPKoY3rYPFIQ4hBkO3drCMsMksAUxFsIwn/avfP9UZX+Md99QePz9BsPBtRq8
         WzKo/ss4VrGKkp6Jz+VoIQqjY+mtyG4rrRYC+/C5F1LImQRTafmFp3o7pP2Ii0mYEnFE
         4wGFQoesGuxW3HDW4AhvRsNGDoj2FNjO1mYAsdjQ79xFBFE3eiqNNd2W+Iybl/aHneqP
         gPw+PG/Qs4kw0IssPwiQcFcQb+3usJCEuKllbKJWr1fCtoKPDjD60LRyJ2J2uTqnQL05
         gWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777470545; x=1778075345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/K+dBjl8H3UMhdYevOjyRfAyQx5Fle18ACEqi389PE=;
        b=o0a31jp1dX0ANDC4zrUcx6oapvvkaSJp49P7YjrS94o+P34SL4KnywBhOUDMkxZB4N
         t6KFrzhSUjNNh3Un/6zunuZ5cf74tEy88Y4rN9+gAAG7ClfTS6KQmAddR1jCVBkAErNs
         U7Em/V1YWQm7fYlqpXFkjb0tIKPXaBWs1K0/Nk+1iBWWyQkhKcVldspO2s9ADhdS2eOc
         RWKNcbQ+OcMz6n0pcaIklhNjObam/v56nfDlNhoWWFbweXPNmoCDuFi4gh4SUzm+K4FW
         R2oZllOnDWYhbxQXExFjrRrwtqByhM61xiCni21GaQQzKo2gLXrCb4QtMVQu5UzYu+dz
         ThlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+p9M8e8YG0erUXUwFD52jK4ST+A0ArB6+4L9uWqnTuu+RCb3Cxh6fbJJU7TCK6ROV+YaDndSJLLLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRD/+DXJ7wUwKiDhpNgt5TlKj2NpgsyF1JT8ZwYdefaIv1JFG
	CGIvZwb3OXB6KdnqZxpJhL/gHuXxuO0bEwWMopTpAFGM8zTmXvaTYWx8l3nkjcM4G/+f8KvdzCJ
	otP62tQAbTN9K22+3/ugv8q0/7svNneA=
X-Gm-Gg: AeBDiesMDbLrJgggLlvY9BrvOBKriLNzQ2RAu3Tgs8k5YQKQMqPpRZ7AsL6BOg1EusI
	5gsvlILA4Wr11Argb41XUTTGeED/gyrb0BEpIluPOBDVjcODRugmnYIG0MHh96hW3SN1Kv1OdcN
	+rNfp4tCSzJDT9vu/3G2paLQam1Hul43ThU5V6mt7F8fHxkPrr69OPczq9D7xuEZAjYRlVOi8KQ
	ar328+xktpXRi6EuSqfnML/JHXwNHUyhu//0wMWPAgLJentptUscqpJaKRxJPF8Y2WAnjZzD5Fr
	OpQ5qg5NitPFKTF1B2Yk1DQqVEyOFFH9G+DuO328xecWiqs6MhVZZ224fjO6dgOPlSHLIB8UIAu
	TGlYU29zAhxPin5rJyfM14bJyYIlvywhLolp9M6BUJ3URPAjUVa19z4dKvWhipsjL4JjqJsMtum
	ptW/MO5ItaMpJmpfK0
X-Received: by 2002:a05:6000:290d:b0:43f:dfbc:8c71 with SMTP id
 ffacd0b85a97d-446496d7980mr13997418f8f.25.1777470544979; Wed, 29 Apr 2026
 06:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260427201412.3067235-11-andriy.shevchenko@linux.intel.com> <20260428173256.25a64370@jic23-huawei>
In-Reply-To: <20260428173256.25a64370@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 29 Apr 2026 15:48:52 +0200
X-Gm-Features: AVHnY4K2rzcMCthisymX9vAXnppU42EwUbZdAHh3IaFX3Uh-XBbn8zF8Ow8Jt3w
Message-ID: <CALoEA-x5aQNs74QDRV6iQjRWQ==wVAtVGikNyCGKQMD=hkiejA@mail.gmail.com>
Subject: Re: [PATCH v0 10/14] iio: magnetometer: ak8975: switch to using
 managed resources
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 18:33, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 27 Apr 2026 22:09:55 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > Switch the driver to use managed resources (devm_*) which simplifier
> > error handling and allows removing ak8975_remove() method from
> > the driver.
> >
> > Note, on error path we now also set mode to POWER_DOWN state which is
> > fine. Even if the device is in that mode, there is no problem to set
> > that mode again, it should be no-op.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> One day I'll have time to write up some notes on patterns that work
> for runtime pm + devm. I don't think think this one does - note original
> code didn't work either as would underflow on regulators in some paths
> and hence print warnings.
> > ---
> >  drivers/iio/magnetometer/ak8975.c | 59 ++++++++++++++-----------------
> >  1 file changed, 26 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> > index 53158ffd173b..d666d9d171bd 100644
> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c
> > @@ -888,9 +888,16 @@ static irqreturn_t ak8975_handle_trigger(int irq, void *p)
> >       return IRQ_HANDLED;
> >  }
> >
> > +static void devm_ak8975_power_off(void *data)
> > +{
> > +     ak8975_set_mode(data, POWER_DOWN);
>
> Add a comment somewhere appropriate on what we are undoing with this.
>
> It's a 'might not be runtime suspended' at time of remove I think
> rather than the mode being set at that point in probe.
>
> If it is suspended, we shouldn't call the regulator disables
> in power_off.  So maybe gate this whole thing on
> whether runtime suspended.  If you do that be careful with what
> state we are in until runtime PM is enabled.  Maybe you already have that
> covered elsewhere.

Okay, I'll add a pm_runtime_status_suspended() check here.

> > +     ak8975_power_off(data);
> > +}
> > +
> >  static int ak8975_probe(struct i2c_client *client)
> >  {
> >       const struct i2c_device_id *id = i2c_client_get_device_id(client);
> > +     struct device *dev = &client->dev;
> >       struct ak8975_data *data;
> >       struct iio_dev *indio_dev;
> >       struct gpio_desc *eoc_gpiod;
> > @@ -958,10 +965,14 @@ static int ak8975_probe(struct i2c_client *client)
> >       if (ret)
> >               return ret;
>
> If following comments above and below you'd need to set the state
> to active here.  If you go that way, make sure to add a comment to
> say why it is up here (and hopefully prevent someone thinking they can
> move it down).

I'll make sure to write a comment warning others about moving the function call.

> >
> > +     ret = devm_add_action_or_reset(dev, devm_ak8975_power_off, data);
> > +     if (ret)
> > +             return ret;
> > +
> >       ret = ak8975_who_i_am(client, data->def->type);
> >       if (ret) {
> >               dev_err(&client->dev, "Unexpected device\n");
> > -             goto power_off;
> > +             return ret;
> >       }
> >       dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
> >
> > @@ -969,10 +980,13 @@ static int ak8975_probe(struct i2c_client *client)
> >       ret = ak8975_setup(client);
> >       if (ret) {
> >               dev_err(&client->dev, "%s initialization fails\n", name);
> > -             goto power_off;
> > +             return ret;
> >       }
> >
> > -     mutex_init(&data->lock);
> > +     ret = devm_mutex_init(dev, &data->lock);
> > +     if (ret)
> > +             return ret;
> > +
> >       indio_dev->channels = ak8975_channels;
> >       indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
> >       indio_dev->info = &ak8975_info;
> > @@ -980,52 +994,32 @@ static int ak8975_probe(struct i2c_client *client)
> >       indio_dev->modes = INDIO_DIRECT_MODE;
> >       indio_dev->name = name;
> >
> > -     ret = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
> > -                                      NULL);
> > +     ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +                                           ak8975_handle_trigger, NULL);
> >       if (ret) {
> >               dev_err(&client->dev, "triggered buffer setup failed\n");
> > -             goto power_off;
> > +             return ret;
> >       }
> >
> > -     ret = iio_device_register(indio_dev);
> > +     ret = devm_iio_device_register(dev, indio_dev);
> >       if (ret) {
> >               dev_err(&client->dev, "device register failed\n");
> > -             goto cleanup_buffer;
> > +             return ret;
> >       }
> >
> >       /* Enable runtime PM */
> > -     pm_runtime_get_noresume(&client->dev);
> > -     pm_runtime_set_active(&client->dev);
> > -     pm_runtime_enable(&client->dev);
> > +     ret = devm_pm_runtime_set_active_enabled(dev);
>
> This hits the race with whether we can query if the device is disabled mentioned
> above. Dance where we need to be able to check that before we turn runtime pm on
> so that we can correctly do regulator disables if we error out before here.

So just do a devm_pm_runtime_enable() instead?

-- 
Kind regards

CJD
