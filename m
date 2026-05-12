Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9F48A2BE
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573192; cv=none; b=D763T40FCAFxfFTspmEcXs0Zz4CK6hTMNQCg6bOXzCG1NLgMSPI71R2xe5RM4oVVQP1vqMK+gYTI+YhS51XH7wTl8x7pmsUj4ZskAMwXzXUIWI45ko9L8bwaAJHlVMaD91WuNbaq3qcxvjEM0yIAldw/VJ7s/Zqti0nKiHSP5g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573192; c=relaxed/simple;
	bh=+5KS0O2K9/LUz5Y3nje0oEQg0pZ+5krWzURAvMW8v1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i17xWWAaSmSz6BNa2F0hTrpeRjdTAuhiSZ5Otv/ptwiCl/Y37zBzS759uZeaLKJdBszFYpsmDBPvCqRtpkR60R27g4tMlVa9NLVzY2Kqa/CTTkFvnkroMjXg6gJBQi8Fm+FwnPpFpsbqY2cUp109M/oJCbJK4EvryH3J7Jakvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQNSHYfa; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQNSHYfa"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44a5174670eso2884586f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778573189; x=1779177989; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OZwdc1rq8NGBU/NyylRNOL9ywQsbRRReCOuX7R8/31Q=;
        b=LQNSHYfalR3797pXrs35Ka2ertZVNS01egVmixsQirGX18kIX5pxpk4maY3xNKJPHU
         6ED9/8xqBQraLwmyLvFRzDVexOQkj2jLFCmRGL8C+1w6F86NryqmKtPzTgtGUMKBYRVT
         NTf6fMTSgn8g0DjAqAIAAl5pq/wQJd25K9u3YeJOSVXZAUJ4y6EQIthUbme3X7++/cXX
         GzDmC+dUU3rKhzVeUQ2LFoLhyE06xEX4pENIY1sR6lwWSadXyc+vJMqlLEktrQtGKaHP
         g6FLce1AbOd2BZpkuKxwRWaE6shRteqF86qAxTD709zs8lVSzW8OBOdz5hOSUOYq0QAb
         x+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573189; x=1779177989;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZwdc1rq8NGBU/NyylRNOL9ywQsbRRReCOuX7R8/31Q=;
        b=bVzdA/TDqx9cPeUarmaK5UNk6zxzOBmkS59Tf4cPB3/6S9OAnDwLaSP0Y+DsmjebT/
         J2/tNurnFzM71sGftQ7ao3DzbgHDlEqvyEJXz7DTgOsDVOUDvBAeue/cDJRjySB8KPaX
         adpXOeWZtUOq+weR9D6nojETXm7W6qkCGWVSK+itReJudya/oVUpIrkzlnBcwGc07ZlL
         IsNghY7LSi1gt6mYDrHW95u6Uz+hEExjhxSYJl8Itb1R4vv6/MYu++tjIeMKk8oRttuk
         mCfzwMttG/K95HgYhRAJ/8t6ftVPpfqTh+17s4hQLLsfxnTBEYjZziJdu/EKLQxtZDkU
         PlLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4mtoaSduarE++gUpsXOtVm4D9mrhW7OOvo+E+WBmtscxR/HFvIOcFKxGVRjDZGQY5J/qVPgqc3CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyauxbwuEfBCYn17TWgYaM7gOUPA/vwmVG3IsFLeKVGQBwTC0wl
	wPqfzQu02tpm+B5vAQ0KQBO7hzSMPiLArIOHKbzs4GCbCVp57Gf8D0MA
X-Gm-Gg: Acq92OHt3A8IJMwyoIwjKagf4Mrv9u2z3FWRSsHu+/aWJk1WYymx7Rr/40JEjjbFShf
	2U5b0QkgvnHVTOS8LHmIYJqjkbR5u4PlGRFspN7VgpOMwTcsX4GCrUfkne9tK2GddMZ/G9JSeB3
	xzACNE5PEqzX8DQwjKrTqOmiq8pI4vg2o+7ZFwM6YRF2RLS5RUDLm2XHrynWgQgyGJp+0a9KLNR
	ee8p9Hxnfg+MsQuWyNA3Tu0Sx8Jv12yVaXQF9fGFsjSrRdBV6rQtY+XfgCFgdXIq5OOAyBFnyuq
	wORqHcy57nJyoZoiywdE+k3djM69ZT1T84GXwXpb4KkGdlnsjhjMRt9G4Ai28wyyWpGfLttGsDq
	Bp2tumnMZzfIy7mFPB0fI56VH6EH6E6lYlihfDK91p/5fAeShW5x+Gw5eN12kuUFA/nKpns4a3c
	kKheMzSzlJm/4AEE5CS4oTCGt/
X-Received: by 2002:a05:6000:1ac6:b0:43e:a9ba:b194 with SMTP id ffacd0b85a97d-4515d5c6b69mr44739016f8f.34.1778573188663;
        Tue, 12 May 2026 01:06:28 -0700 (PDT)
Received: from nsa ([185.128.9.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548bb51d40sm29894943f8f.0.2026.05.12.01.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:06:28 -0700 (PDT)
Date: Tue, 12 May 2026 09:07:22 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed
 resources
Message-ID: <agLd7t10HBjbEzYq@nsa>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
 <0a3e455c86cef14fe3481019031ebf04f98470f7.camel@gmail.com>
 <CALoEA-x9TtnWbGCtTo-jhrJ7Zic1S7J=xRYSL0VZgOvTb1GGCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALoEA-x9TtnWbGCtTo-jhrJ7Zic1S7J=xRYSL0VZgOvTb1GGCA@mail.gmail.com>

On Sat, May 09, 2026 at 03:32:59PM +0200, Joshua Crofts wrote:
> On Sat, 9 May 2026 at 11:02, Nuno Sá <noname.nuno@gmail.com> wrote:
> >
> > On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > Switch the driver to use managed resources (devm_*) which simplifier
> > > error handling and allows removing ak8975_remove() method from
> > > the driver.
> > >
> > > Note, on error path we now also set mode to POWER_DOWN state which is
> > > fine. Even if the device is in that mode, there is no problem to set
> > > that mode again, it should be no-op.
> > >
> > > Additionally, remove any pm_runtime_get/put*() function calls that
> > > dummy cycled the counter to autosuspend the device.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > > ---
> > >  drivers/iio/magnetometer/ak8975.c | 74 ++++++++++++++++++++++-----------------
> > >  1 file changed, 41 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> > > index
> > > 63b6e8465f5f3873841550a1cd03ce86b95d1d67..1d8f448d5179fe9b33af989cc2f456ac91bc2f17
> > > 100644
> > > --- a/drivers/iio/magnetometer/ak8975.c
> > > +++ b/drivers/iio/magnetometer/ak8975.c
> > > @@ -898,9 +898,24 @@ static irqreturn_t ak8975_handle_trigger(int irq, void *p)
> > >       return IRQ_HANDLED;
> > >  }
> > >
> > > +static void devm_ak8975_power_off(void *data)
> > > +{
> > > +     struct ak8975_data *ak = data;
> > > +     struct device *dev = &ak->client->dev;
> > > +
> > > +     /* Only power down if currently active */
> > > +     if (pm_runtime_status_suspended(dev))
> > > +             return;
> > > +
> > > +     /* Soft-stop the chip before hard-stopping the regulators */
> > > +     ak8975_set_mode(data, POWER_DOWN);
> > > +     ak8975_power_off(data);
> > > +}
> > > +
> > >  static int ak8975_probe(struct i2c_client *client)
> > >  {
> > >       const struct i2c_device_id *id = i2c_client_get_device_id(client);
> > > +     struct device *dev = &client->dev;
> > >       struct ak8975_data *data;
> > >       struct iio_dev *indio_dev;
> > >       struct gpio_desc *eoc_gpiod;
> > > @@ -968,10 +983,21 @@ static int ak8975_probe(struct i2c_client *client)
> > >       if (ret)
> > >               return ret;
> > >
> > > +     /*
> > > +      * Set device as active early so pm_runtime_status_suspended() works
> > > +      * correctly if probe fails before pm_runtime is enabled. Do not attempt
> > > +      * to move this line lower.
> > > +      */
> > > +     pm_runtime_set_active(dev);
> > > +
> > > +     ret = devm_add_action_or_reset(dev, devm_ak8975_power_off, data);
> > > +     if (ret)
> > > +             return ret;
> >
> > This looks a bit hackish to me. Why don't we just register this powerdown action
> > after enabling PM?
> 
> This is to prevent a resource leak. If we register the power_off
> function at the end,
> any potential probe() failures will leave the regulators on.

Okay it does make sense! I now see the action is registered after
ak8975_power_on() which what makes sense. Still would like to avoid that
weird pm_runtime_set_active() call. It would be nice if we could
guarantee through PM that the device get's suspended on unbind. Oh well,
I guess this is ok.

- Nuno Sá

> 
> > > +
> > >       ret = ak8975_who_i_am(client, data->def->type);
> > >       if (ret) {
> > >               dev_err(&client->dev, "Unexpected device\n");
> > > -             goto power_off;
> > > +             return ret;
> > >       }
> > >       dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
> > >
> > > @@ -979,10 +1005,13 @@ static int ak8975_probe(struct i2c_client *client)
> > >       ret = ak8975_setup(client);
> > >       if (ret) {
> > >               dev_err(&client->dev, "%s initialization fails\n", name);
> > > -             goto power_off;
> > > +             return ret;
> > >       }
> > >
> > > -     mutex_init(&data->lock);
> > > +     ret = devm_mutex_init(dev, &data->lock);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > >       indio_dev->channels = ak8975_channels;
> > >       indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
> > >       indio_dev->info = &ak8975_info;
> > > @@ -990,52 +1019,32 @@ static int ak8975_probe(struct i2c_client *client)
> > >       indio_dev->modes = INDIO_DIRECT_MODE;
> > >       indio_dev->name = name;
> > >
> > > -     ret = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
> > > -                                      NULL);
> > > +     ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > > +                                           ak8975_handle_trigger, NULL);
> > >       if (ret) {
> > >               dev_err(&client->dev, "triggered buffer setup failed\n");
> > > -             goto power_off;
> > > +             return ret;
> > >       }
> > >
> > > -     ret = iio_device_register(indio_dev);
> > > +     ret = devm_iio_device_register(dev, indio_dev);
> > >       if (ret) {
> > >               dev_err(&client->dev, "device register failed\n");
> > > -             goto cleanup_buffer;
> > > +             return ret;
> > >       }
> > >
> > >       /* Enable runtime PM */
> > > -     pm_runtime_get_noresume(&client->dev);
> > > -     pm_runtime_set_active(&client->dev);
> > > -     pm_runtime_enable(&client->dev);
> > > +     ret = devm_pm_runtime_enable(dev);
> > > +     if (ret)
> > > +             return ret;
> >
> > Maybe it would make sense to move this before devm_iio_device_register(). At the
> > point we register the device, userspace can start to interact with the device where
> > we have pm calls? Not that it is a problem (I think) but makes sense to me to enable
> > PM before exposing the device.
> 
> Sure, I agree with this.
> 
> -- 
> Kind regards
> 
> CJD
