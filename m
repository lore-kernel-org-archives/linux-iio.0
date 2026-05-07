Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF523264D4
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145592; cv=pass; b=QvYwwGKAsd/wmng+6DvhjryBq/ObnhiTtSYk2vuZdWqqqscrGK4bdDyNY85fBPLRBRaMpiIBQkfHDf0+HJM8WI7dBMUKzPhUAqagjZFm+gM+3cA2yCNiIqI7Pt5hTTuVqoGtKhxvMwykwC/yTY1nbdAg9Iuio6lh4Ftbzsp6VCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145592; c=relaxed/simple;
	bh=IHks2ccziWE/qxvN+2yaNAY/kc/BmNNTXwTsDEGKcaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0qJ7U+Rlu3OuMwmwR5gRMD5MyCxIbj00h6TFki/jZGDngZ0HrmMEvtnjf6//CCLnPjmCEOu6XhICPWmTAWZBeuc49Fw7oqUfwf/ySEvqPVogUAuWsDou7IN3I4OP6vtQWVy0YNsIaT1OHwNsSviSHklwwvl5zi+Yv4Eoal2CZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEVsZrxL; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEVsZrxL"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-452169ae568so457702f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 02:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778145584; cv=none;
        d=google.com; s=arc-20240605;
        b=b7xe8K+rKKCXxC+Wg24UB+nyHt1LLscPHWwa+Efqs7a/88Cj2U97lbXUm7NRG1Jm/B
         w4x1xcV5nLwJzfF+wH1vd62+NLo+2ZnqvASZdVx3v9NYKehT/QiJ21FugkKsW0n3cxij
         HKdlDG+sQmZl8/AaVB3AF5erPQVc3Ae6sSXg6FK9vrSKJpL9H/HzPfgNqjIF2wNmDeRD
         IBDJT49Nq3I69s3NOPGap4uqTWYuPVise4vjvQc2PKv3nCaesSQZkLiUaF6kONf9FWN/
         NB9Tz+QRtOHa3tI1PhZqvEbInMNLhl61SPxOeiMOXsFQgezYxoPGzaNRIUdpazaOwr0v
         7CJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IMO2tEdVmYdiY0bGlzGKngBiTzkk8QPgqpJvrjsFSIs=;
        fh=6A7d/EW62RGRWlMHY3xRzCSOzxaWiYCiXShJG1P+IDA=;
        b=XSLKPrwmv9Fg4516Nxm2GKCT0uPBO1jO2gPxvZiGouhTQGIMj6FxhRFMwyYJ0K00Nc
         TNgqc/1JQAkw/N/qomwdi6rtn0lL4NmCwTRxRHViZsZ2rJVMMO6fN4EzgFaG4Xbc4kIf
         XHz0+aWemjtw24kphqoYexM6Y3XTxBbtLeQwCTxsY5zjEU4f1qQ7MvQ2RF8+JhXqgSN0
         dUg2vL4k8FEImwZcFZV7pOLBvMB73t2MC5qrmTbdGVAQ4lerKvzolvRdu+WX4y1McOTH
         1hYCM0E3/0fCBSRuApqRekhDmByB1GHM97yoD9Ht+XejoQgGFPhc2NG5MQMJj+BavtJF
         fM1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778145584; x=1778750384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IMO2tEdVmYdiY0bGlzGKngBiTzkk8QPgqpJvrjsFSIs=;
        b=AEVsZrxLHnhttmKOQxGd42ipkD1qVdhLVkKZZTY2WDKGZl19cD1Mk6TBO9v4tCshTc
         dTj36GjjGAgrbmUtB28qS90jsOppolxDiZVGzAlJUcjGZynbhPcr9j+0M3ZDWcbTwzno
         TQIp0hZlu1Osu1/2HikeJeezwIkdFrp8YpyqiHmWSt2wSpcznBd8rHZIlypLNkc1FrDI
         PK4D2ZjHIXpRahLIup6CJgF9LQai6/bKpNX1gm9Vc/ADfoJ2vnmpgQI4tq2iGsd5M+GT
         Ep7oMvUg1BtyBMfcfDCW+c6ajHIpFK+6Fy48tjq2WPysnXnTRtRB6c3o2mFsZh5dSiEy
         VClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778145584; x=1778750384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMO2tEdVmYdiY0bGlzGKngBiTzkk8QPgqpJvrjsFSIs=;
        b=e1QQXa0wC8jlfJF9lT/vFoWlYoMOpnQE8/cYx63ePmp4G+QtI3MZ6poTfV7xcLGWRS
         XnVURqcGCHRfaRmrc+Qit6219p/zVksszsE33SoEQE8OWr4vrIGRZBqOMNQn1CwpZiCK
         TOYdd+YovIWDzUJZ0gWLx6PiAHY/GrWoehhuMF3PaLVAJOx4Uhmq7pvgvmpPfXh6VuA1
         q5MYyAgq1oksbJgs6i38neRlizu9KR7D1LyZ7/E0SY1pdS2NEmACE5sCHr4pipB1HRbB
         rwN2EtCez7kMBlFDQbOpuQPzHPQBwAbdpjqBluIpzk73YnonUNxP5dX/65eqBZx1rgCn
         HaKw==
X-Forwarded-Encrypted: i=1; AFNElJ/uPSViJa7yWHssEyPYqcUSpUVywgpxZ+DPKp1IMRh2kUb4eXv2VyaIYgIogXvbD0S8UDHqcDDG4hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHG6gE4tcc6LonQjj1zYvCuAhmOdFhEppn3r/9X4p+jLm4dvv
	z06I0P27JLFb0QBFGUNXiAmf8evQn2ggX2osPY+TuYNhvhyLgj0+kATUTFErqutDzRnpUPr48+Y
	9GdsXVK1MuO3joE2uUxvVcL3l+4x2U9E=
X-Gm-Gg: AeBDiesy5ndw9b9ZSt5raVqaNJd5BVF7Lbd+f0ZTOSOimVHW8MxfqauknSCY1b3Uc7q
	aW0Sc3vSFPoOhj4sm6N9WGaHc8EeaAOzXdTsayr4tWxMqEfULIqE0WNHSPXiUG62To9B94NxGjU
	I7nUaqoNJgrqimijPUAvCPWYiC+28bpfhxSZ/mQ5SzrCMNgiUGRnQlmGHA/dJBHqMvXT2HF9YiL
	4PuBKJSpSn7V2eTipOKpdHKB43LF65jw6ybTJa3BPzPzWRJnXG8V88mscCr4yAIyEP7qI9GYLAD
	a2WvP5yXuf2LFl/ySujHqqjfwc+EJDPUOqJhjkLGLQEYc2zYntZxjltw53d6pPy865xUmzY9kN0
	RL6wpsNziAGHr5cHDZjz7e36e0mdVIJFuv8Eq+fExQsnl409rG42Ccdp0zB+R46JCFkaaLcxZbc
	pPmtOqQsZihUGP2nx1
X-Received: by 2002:a05:6000:1885:b0:44b:d975:1293 with SMTP id
 ffacd0b85a97d-4515b056ab6mr12781325f8f.1.1778145583922; Thu, 07 May 2026
 02:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-14-831b9b5550fc@gmail.com> <20260506180925.3fb80edf@jic23-huawei>
In-Reply-To: <20260506180925.3fb80edf@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 7 May 2026 11:19:32 +0200
X-Gm-Features: AVHnY4IzopOauEOqYRMGtpTn167jkbLNeFjxNX1L_hSBG9LDhJORajCtnPPBrpU
Message-ID: <CALoEA-x0baxV+9-rsN9omJ9GnLw3zp2qmU08RjzWniPOU+uxKw@mail.gmail.com>
Subject: Re: [PATCH v5 14/18] iio: magnetometer: ak8975: switch to using
 managed resources
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 19:09, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 05 May 2026 13:46:10 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Switch the driver to use managed resources (devm_*) which simplifier
> > error handling and allows removing ak8975_remove() method from
> > the driver.
> >
> > Note, on error path we now also set mode to POWER_DOWN state which is
> > fine. Even if the device is in that mode, there is no problem to set
> > that mode again, it should be no-op.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Hi Joshua
>
> Looks fine, but one stale comment needs an update.
>
> Jonathan
>
> > ---
> >  drivers/iio/magnetometer/ak8975.c | 77 ++++++++++++++++++++++-----------------
> >  1 file changed, 44 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> > index 1c05e380a4d4f968f505a7d5c0acbec86ad949e1..84ccbca758b0121a9c4930a368cb113471d389da 100644
> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c
> > @@ -900,9 +900,27 @@ static irqreturn_t ak8975_handle_trigger(int irq, void *p)
> >       return IRQ_HANDLED;
> >  }
> >
> > +static void devm_ak8975_power_off(void *data)
> > +{
> > +     struct ak8975_data *ak = data;
> > +     struct device *dev = &ak->client->dev;
> > +
> > +     /* Only power down if currently active */
> > +     if (pm_runtime_status_suspended(dev))
> > +             return;
> > +     /*
> > +      * The device may not be runtime suspended when the driver is
>
> If we get here it's definitely not runtime suspended.  Hence
> this comment needs a rewrite.

Missed that one, thanks.

> > +      * removed, so we soft-stop the chip before hard-stopping the
> > +      * regulators.
> > +      */
> > +     ak8975_set_mode(data, POWER_DOWN);
> I went looking into how we get into different modes...
> This deals with a latent bug in ak8975_setup() in that it can be in fuse mode
> in some exit paths.  Arguably if we had an i2c bus fail we probably can't
> change the mode anyway, but we should be trying from point of view
> of no side effects. I wonder if we should fix that in a precursor to this
> patch (given the amount of churn from earlier patches an obscure corner
> case of the bug - I don't plan to mark it for backports either way!)
>
> Maybe it's just not worth the bother given this is now here anyway.
>
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
> > @@ -970,10 +988,21 @@ static int ak8975_probe(struct i2c_client *client)
> >       if (ret)
> >               return ret;
> >
> > +     /*
> > +      * Set device as active early so pm_runtime_status_suspended() works
> > +      * correctly if probe fails before pm_runtime is enabled. Do not attempt
> > +      * to move this line lower.
> > +      */
> > +     pm_runtime_set_active(dev);
> > +
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
> > @@ -981,10 +1010,13 @@ static int ak8975_probe(struct i2c_client *client)
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
> > @@ -992,52 +1024,32 @@ static int ak8975_probe(struct i2c_client *client)
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
>
> huh. Not sure what this was doing in original code.
> I guess forced an immediate power down rather that after an autosuspend
> period.  I think that's fine to change - however perhaps do a bit
> of analysis on whether my assumption is correct on what this did
> and then mention it in the commit message.

This is a fun one. pm_runtime_get_noresume() increments the counter,
then later on pm_runtime_put() was called, essentially tricking pm_runtime
into thinking that some task has ended, forcing it to autosuspend. Looking
at the code now, the device won't autosuspend after probe() is finished, it
will just be active until the driver is accessed from userspace (and
subsequently completes the task).

Sashiko is pretty impressive, it took me a long time to see what's going on.

> > -     pm_runtime_set_active(&client->dev);
>
> > -     pm_runtime_enable(&client->dev);
> > +     ret = devm_pm_runtime_enable(dev);
> > +     if (ret)
> > +             return ret;
> > +
> >       /*
> >        * The device comes online in 500us, so add two orders of magnitude
> >        * of delay before autosuspending: 50 ms.
> >        */
> >       pm_runtime_set_autosuspend_delay(&client->dev, 50);
> >       pm_runtime_use_autosuspend(&client->dev);
> > -     pm_runtime_put(&client->dev);

I'd just add pm_runtime_mark_last_busy() and pm_request_autosuspend() here
to make the device suspend.

Perhaps unrelated, however I found an issue with the pm_runtime documentation,
as it incorrectly says that pm_runtime_mark_last_busy() is always called with an
autosuspend function (which is not the case, looking at the definition).

"Drivers may also continue to use the non-autosuspend helper
functions; they will
behave normally, which means sometimes taking the autosuspend delay into
account (see pm_runtime_idle). The autosuspend variants of the
functions also call
pm_runtime_mark_last_busy()."

-- 
Kind regards

CJD
