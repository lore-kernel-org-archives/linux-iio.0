Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC12366836
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347178; cv=pass; b=FeTbifZRzkSqehncvWViCmZVcYDubAa/aW+KbB+aWIRCXa7LL5xm12Q1PsuGrPvHXD08KM7yhmMch/ZF9OUgEkXO2Db+lw8oNZKW3HVHYFkJBsafjNM0yyzwoOHtd7SWce/sEz9GAholbq5a/BqOalTQicpQZs2A/gg3LcbBplY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347178; c=relaxed/simple;
	bh=6HO38PZZZsB3m1kXqh9TtwZsbP1X0xEZ8z8RAnLko/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIh4zz5K/Mrexcq6JzsNolLcaGtbUaEgfQLBcMiAmP4VyHYFQcKRMLh1QaFUlt30EwTTiG+AlIfuIiqouAuqWxvKrEZvKWZXfxBu3gwEd7Fdypgq5zUVmsfpBpSAkAqfBAGs4rYGw15hALD1ihbl1trVGN5tPBbyeIIIHg7Am1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZwUkEHF; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZwUkEHF"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso59905085e9.3
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 00:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779347174; cv=none;
        d=google.com; s=arc-20240605;
        b=IJS8dEvGjAOTqC797QTp/bpRDvAnnxJ20OQgBNmMEdpLZSCzI/hBdDOqbmB2J/f2u9
         C5hF4GDLIhHqxTMJsfssnOq5nQDt4QunvkmbxrFO14zE+RH+JNeI974p+6XJGY9X1Z7c
         Qz1FLNHmvfNd5AYLHgF7S6VRWNirzm123u17xqR7IX6MyLq5CYQclSmDj1W75zedX9Hr
         4uCc6sg3KhQbbF9MJ+Ac/TJI6IuHNbT4d25hYChjQLCrO315ZnvTnzAyfY1dH1JzOQRF
         jch+R1qhTWBZV1ImNZzZ001vnY9yNHRdLdC6/Zv4vJCp42dVMya+VP57zyKbGRPi0STS
         +TTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QrsRXhf1ZkNQz2w+Lp+NAldJ6nnCD2hOsmDTNZtG1rw=;
        fh=pD7wOKv+tncYhuVRu3MLxiatdGSHrgJBDMbl5LitYRI=;
        b=dPi+El+lF/C6SDK2/RYDz2s5V/jpxDKRRP5v4OpA0skunfEBZip4Pmm58BSYB/OJit
         dQ7GgGl2VVijxb/mWi9pZwn9rZksz+XSIkVDm9hjaMeUHBkYa0+v5SM6tLanlppIBfEK
         zECkTIWKgOA0fbpNNM1FF1vZvfcO35oX048hjmcTDnu0/WsTz7T7bUiKK3V5cO9ioyQp
         urJwwAqANu50QFJ755Zmt6MZ0YWSKu8qIUh11CwQy3j4XfG6srQylsGubEClIc1SOGjn
         nwzgu5k07JwhgGXjyh40KqGMRMBHgRy7gB7QDRbcdXJ8j+QU8O1S8H0mXWtr7tCyLrzg
         dK6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779347174; x=1779951974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QrsRXhf1ZkNQz2w+Lp+NAldJ6nnCD2hOsmDTNZtG1rw=;
        b=JZwUkEHF/cQDvIjeBixSmxqOuHuHQpsHCdjc7q0OPHRaL9S37CSARFcm2pZEX5s/wD
         JXEzzJ+QjQ10Ie/aUaJ/sDlCVWL3a/l1K6G6OCeViixphBSKf9oObozk5bdp7kBqUMZo
         W+dWW2kcD4rhW+hsLO+tOTMgZ7FnXzpMKNAyIDM0fJ+SWJn0NwQg5I/xnng1uW3iB3Th
         guidxA6eBz9WXVsFZCM1EeRJakRaJtpDjhxmtK18+wdAyhotk1+b3e2m6cjpdk1p4IVH
         6zuJEGYTGM5ZNPg/bHl3+lP3NCvH5OjT3SOM/eHj5P5kjMfSAIgnIibUjmMN1dSkpvhP
         JbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779347174; x=1779951974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrsRXhf1ZkNQz2w+Lp+NAldJ6nnCD2hOsmDTNZtG1rw=;
        b=sm2NtJuy0whMzqkIFICdsSG+fRLwoMATfrz1diI6llUPBma/CT2waw6flxeKA24Nmw
         A/07S5n4u9FYPTZ4KMHQrYkUJrkk7UnYGRO95+QNFSkoea2xVWUA6x+fU8vQbwNzZ054
         rpYMHJ2rdZrgCsxwvK+i9GoJONARIcQbzI4edM6joD3UTfC7SnhFgbCf2etAfngNRPrL
         2Wyb4itysrBz2zEou9j9HE/RCLBKIpGBbR8gBDHOsET1JHdnDFc7qtL1MkCu85aYZC5C
         NSp9Ru5+g7s5lfNzhS+FSwOhLl7QrQiJZMKvTvgx7r6bH5z1dVLd7EGrLSr5UzEDPCGE
         TBAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Fgp1KxKVZ61evwjSdsFZyuyn1Z6DWwTNZBlXVaAb6P31dVzf8fQSsayANOZ/Ky9FH1l1VJs7cJeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Y65+cxj6Gh77XzJL0+VjPtSXOb/vpFoW1i6QG7Lkey1cVsKg
	Zhu+4nySa9a51fe+stJq86jsoL+s0soTPYghu/HF+e26Xl4jJYibTlGDonqwn/+C5C76r3dZqSM
	oUONRb6KtV6keqBt6U8W1eq9nXwzZU5o=
X-Gm-Gg: Acq92OEZu5pxcxhxb6LLPbBx9aRthEVNPt8ixkhRgn7tRgeLMXqLTf31pcgDvkzNcnG
	P1jFUc8jhCMNHioBqHFAtRtkQ3a52x4Dgbcjf7kITLh+Bcpgns5VlS/XSSKUnSZ8uPMY/OTlGx1
	z+z2QwFsZN6LZXM+TsRxNjigpSdk8z10zYnYCXaY68X2iSNCNhhprBLFr1LUIMxgWcIf15zWb5S
	rH6xoA1Ytr3XXwDqmAAqgriQETdXFG5EwSNQTqRyftPqih4VuQtZOQfGfdMramEBUr69MYhk/cv
	VSgRX10Q8AIYR2YzCKdHagEDORc/uH1gWPx6lSbJuIdp4Ks4aMUX2X+FsaB5W1r/YqP8S07at1F
	FOdTU5t/ebnhjzkoQYOPz+hGQvYLM5wDAWIXfesV167Tb7FFLzDHmiUdkV/MQyzpQcxTI59Gs2J
	ejCp++9GLj4h+Ea2Ck
X-Received: by 2002:a05:600c:1f89:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-4903606c383mr18603175e9.15.1779347173423; Thu, 21 May 2026
 00:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
 <20260518-magnetometer-fixes-post-pickup-v8-1-088d610108a0@gmail.com> <20260520163114.612745d4@jic23-huawei>
In-Reply-To: <20260520163114.612745d4@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 21 May 2026 09:06:03 +0200
X-Gm-Features: AVHnY4KesLkAxEzINEl0NkyBFSC8bryxyYjVoDGMiSa_dUhjsL7EKlAxiNbYcsw
Message-ID: <CALoEA-wV0u0sy3DswDxBpBBO65gcQXCJxya9ShFHRNRmKVMavw@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] iio: magnetometer: ak8975: switch to using managed resources
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 May 2026 at 17:31, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 18 May 2026 09:50:25 +0200
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
> > Additionally, remove any pm_runtime_get/put*() function calls that
> > dummy cycled the counter to autosuspend the device.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/iio/magnetometer/ak8975.c | 77 ++++++++++++++++++++++-----------------
> >  1 file changed, 43 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> > index bb74abb648f138352576a68c49d3c7dce7cc068e..de4402201783430fc69369f1accaab35145e9f0c 100644
> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c
> > @@ -935,9 +935,25 @@ static const struct iio_buffer_setup_ops ak8975_buffer_setup_ops = {
> >       .preenable = ak8975_buffer_preenable,
> >       .postdisable = ak8975_buffer_postdisable,
> >  };
> > +
> > +static void devm_ak8975_power_off(void *data)
> > +{
> > +     struct ak8975_data *ak = data;
> > +     struct device *dev = &ak->client->dev;
> > +
> > +     /* Only power down if currently active */
> > +     if (pm_runtime_suspended(dev))
> I don't think we established that this actually works without underflowing
> the regular reference counts if in runtime pm suspsended state when
> we tear get to devm cleanup.
>
> Sashiko correctly moans about this and points out you refer to a different
> check anyway on the comment below.
> https://sashiko.dev/#/patchset/20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0%40gmail.com
>
> I'm not convinced pm_runtime_status_suspended() is sufficient either.
>
> The only path I'm 100% sure of is when we add tracking flag in the
> iio_priv() to indicate if we are already runtime suspended.  Ugly but
> at least we know that will not run into these odd race conditions.
>
> This is 'probably' a new bug rather than a latent one because of the
> unusual handling below.  I think there is a race in original code but
> it is narrow so unlikely anyone ever hit it.
>
> Whilst I do discuss what else you might do - I'd throw a flag in iio_priv()
> because it is a simpler solution.
>
> Now, if you happen to have some sort of real hardware or emulation to test
> the different flows, then I'd be interested to see if there are advantages
> to doing something closer to what this driver originally did.

I've thought about dropping this patch as power management in this driver
seems to be a complete rabbit hole, and that I don't have the actual hardware
to test this (IMO stubbing won't really help). Although the flag
solution is a bit
hacky, it could work.

> > +             return;
> > +
> > +     /* Soft-stop the chip before hard-stopping the regulators */
> > +     ak8975_set_mode(data, POWER_DOWN);
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
> > @@ -1005,10 +1021,21 @@ static int ak8975_probe(struct i2c_client *client)
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
> >       ret = ak8975_who_i_am(data, data->def->type);
> >       if (ret) {
> >               dev_err(&client->dev, "Unexpected device\n");
> > -             goto power_off;
> > +             return ret;
> >       }
> >       dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
> >
> > @@ -1016,10 +1043,13 @@ static int ak8975_probe(struct i2c_client *client)
> >       ret = ak8975_setup(data);
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
> > @@ -1027,52 +1057,32 @@ static int ak8975_probe(struct i2c_client *client)
> >       indio_dev->modes = INDIO_DIRECT_MODE;
> >       indio_dev->name = name;
> >
> > -     ret = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
> > -                                      &ak8975_buffer_setup_ops);
> > +     ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +                                           ak8975_handle_trigger,
> > +                                           &ak8975_buffer_setup_ops);
> >       if (ret) {
> >               dev_err(&client->dev, "triggered buffer setup failed\n");
> > -             goto power_off;
> > +             return ret;
> >       }
> >
> > -     ret = iio_device_register(indio_dev);
> > +     ret = devm_pm_runtime_enable(dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = devm_iio_device_register(dev, indio_dev);
> >       if (ret) {
> >               dev_err(&client->dev, "device register failed\n");
> > -             goto cleanup_buffer;
> > +             return ret;
> >       }
> >
> > -     /* Enable runtime PM */
> > -     pm_runtime_get_noresume(&client->dev);
>
> See below for comment on this.
>
> > -     pm_runtime_set_active(&client->dev);
> > -     pm_runtime_enable(&client->dev);
> >       /*
> >        * The device comes online in 500us, so add two orders of magnitude
> >        * of delay before autosuspending: 50 ms.
> >        */
> >       pm_runtime_set_autosuspend_delay(&client->dev, 50);
> >       pm_runtime_use_autosuspend(&client->dev);
> > -     pm_runtime_put(&client->dev);
> >
> >       return 0;
> > -
> > -cleanup_buffer:
> > -     iio_triggered_buffer_cleanup(indio_dev);
> > -power_off:
> > -     ak8975_power_off(data);
> > -     return ret;
> > -}
> > -
> > -static void ak8975_remove(struct i2c_client *client)
> > -{
> > -     struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > -     struct ak8975_data *data = iio_priv(indio_dev);
> > -
> > -     pm_runtime_get_sync(&client->dev);
> This forces device to wake up.
>
> > -     pm_runtime_put_noidle(&client->dev);
> This forces the counter down to 0 but doesn't trigger a runtime
> pm suspend.   I'm nervous though as userspace is still in place
> (before iio_device_register() - so it's possible another
> get / put cycle can occur before the next call).
>
> > -     pm_runtime_disable(&client->dev);
> Hence when we disable runtime pm the device is powered up and
> the rest won't underflow.
>
> Now interestingly there is a :
> devm_pm_runtime_get_noresume() which calls
> pm_runtime_get_noresume() and schedules the
> pm_runtime_put_noidle() in the tear down path..
>
> However it is vanishingly rarely used and the sequence to me
> is non obvious - the two users are inconsistent :(

Hmm, I guess I could reorder the set to get things moving a bit more,
the rest of the patches are trivial.

-- 
Kind regards

CJD
