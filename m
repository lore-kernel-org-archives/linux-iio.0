Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04B3AEB5D;
	Fri, 31 Jul 2026 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510788; cv=none; b=kEtmbr2BN2sTlUoGfAiqhPQkDqhS113qIhC4yEOWzxxW+B9ej7XAHsnlde7gUoRtTmP/8z4jI2voofYMbhWcOaUYSpiwVqjrKQ21utNq4SyaGfwhg1jUs1sHS5kdqcaNW+hPT/NyfqTrbH2s/Hu7Li+wgEALLPD7IaoTS2K8YfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510788; c=relaxed/simple;
	bh=10bW9KIHTS86Wv0uE9N/XOdM8tig5gHXHCJE/PxHKtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXYyYc4FKbxxRasWf4klRnPnNcMcdOS4e3j4N0nUE4531oZWXQJaxJrdgAE0VnHZ5rrKo5LTPqlOsZz+VCsEN3w+9XO72YJ14kJHo0hJxT9OOXbEzNoUI/6A3b2yqEZdJA18Cd5TZH4tPZzIlXwyMCiDEBCmxIFKTyEIJtJaCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4kfuWNC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4kfuWNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67471F000E9;
	Fri, 31 Jul 2026 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785510785;
	bh=/NVYBiS7+7h+ce6axPagWQx9EDiqcteYWEdh+1Ot/nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q4kfuWNCqH7NTjUflHvf1DQ/Q6aoj5/rYdk6HQnMSfE29Ns4+B/0m4OGZ5s5q0jun
	 Vl85sK3jfsoc9BoXf3baQEnwvEUVwLd8mSGokuR386umwiJOKGdONrNQp+y86pE7p9
	 vuJM57KCLqoJdIBizITBG4fABJUEQ+pZ6X7nNosjiN+HEAoDIuYoZDLPU8DqDZcsbx
	 nd9T6O0ABjf+iqlM+RxqZHZURqLA19yhaylMfPcJKvdiKDx25lESvbBC5sEolNtVRJ
	 PrJdNwkuwenYHaKyStVCY4zKsZm3aaWREpdjtiNeXesTwhgHC99CDkKeX6O5YJ9gFe
	 1VwvV2EOAHBBw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wpov0-00000000YFf-49RS;
	Fri, 31 Jul 2026 17:13:02 +0200
Date: Fri, 31 Jul 2026 17:13:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 08/14] mfd: lm3533: Convert to use OF bindings
Message-ID: <amy7fpjsUwZ9qJmF@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-9-clamor95@gmail.com>
 <akeXAOpb13hupUGM@hovoldconsulting.com>
 <CAPVz0n2trouADTziWXnpt=-hwKdsZWGQib+-nVCLaSLibTbATg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n2trouADTziWXnpt=-hwKdsZWGQib+-nVCLaSLibTbATg@mail.gmail.com>

On Tue, Jul 14, 2026 at 04:57:01PM +0300, Svyatoslav Ryhel wrote:
> пт, 3 лип. 2026 р. о 14:03 Johan Hovold <johan@kernel.org> пише:
> >
> > On Wed, Jun 17, 2026 at 11:00:25AM +0300, Svyatoslav Ryhel wrote:
> > > Since there are no users of this driver via platform data, remove the
> > > platform data support and switch to using Device Tree bindings.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backlight
> > > ---
> > >  drivers/iio/light/lm3533-als.c      |  67 +++++---
> > >  drivers/leds/leds-lm3533.c          |  50 ++++--
> > >  drivers/mfd/lm3533-core.c           | 236 ++++++++++++----------------
> > >  drivers/mfd/lm3533-ctrlbank.c       |   5 -
> > >  drivers/video/backlight/lm3533_bl.c |  55 +++++--
> > >  include/linux/mfd/lm3533.h          |  52 +-----
> > >  6 files changed, 220 insertions(+), 245 deletions(-)
> >
> > >  static int lm3533_als_probe(struct platform_device *pdev)
> > >  {
> > > -     const struct lm3533_als_platform_data *pdata;
> > >       struct lm3533 *lm3533;
> > >       struct lm3533_als *als;
> > >       struct iio_dev *indio_dev;
> > > @@ -803,12 +817,6 @@ static int lm3533_als_probe(struct platform_device *pdev)
> > >       if (!lm3533)
> > >               return -EINVAL;
> > >
> > > -     pdata = dev_get_platdata(&pdev->dev);
> > > -     if (!pdata) {
> > > -             dev_err(&pdev->dev, "no platform data\n");
> > > -             return -EINVAL;
> > > -     }
> > > -
> > >       indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*als));
> > >       if (!indio_dev)
> > >               return -ENOMEM;
> > > @@ -817,25 +825,27 @@ static int lm3533_als_probe(struct platform_device *pdev)
> > >       indio_dev->channels = lm3533_als_channels;
> > >       indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
> > >       indio_dev->name = dev_name(&pdev->dev);
> > > -     iio_device_set_parent(indio_dev, pdev->dev.parent);
> >
> > Why are you reparenting the iio device here?
> >
> 
> Because every cell has its own binding now and using phandle to parent
> when device has its own node is not a good practice.
> 
> > That's an ABI break.
> >
> 
> This driver does not have any active users in the kernel and no
> activity for more then 2 years.

We have never required board files to be upstream.

And a working driver does not need to be changed every year.

In any case, something like this at a minimum needs to be highlighted in
the commit message.

> > > +static const struct of_device_id lm3533_als_match_table[] = {
> > > +     { .compatible = "ti,lm3533-als" },
> > > +     { }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, lm3533_als_match_table);
> > > +
> > >  static struct platform_driver lm3533_als_driver = {
> > >       .driver = {
> > >               .name   = "lm3533-als",
> > > +             .of_match_table = lm3533_als_match_table,
> > >       },
> > >       .probe          = lm3533_als_probe,
> > >       .remove         = lm3533_als_remove,
> >
> > You should also remove the platform module alias below.
> >
> 
> Why?

Because your change makes it obsolete. The driver now only supports OF
probing.

> > > @@ -680,15 +684,22 @@ static int lm3533_led_probe(struct platform_device *pdev)
> > >
> > >       platform_set_drvdata(pdev, led);
> > >
> > > -     ret = led_classdev_register(pdev->dev.parent, &led->cdev);
> > > +     ret = led_classdev_register(&pdev->dev, &led->cdev);
> >
> > Here too you appear to be reparenting the class devices.
> >
> > >       if (ret) {
> > > -             dev_err(&pdev->dev, "failed to register LED %d\n", pdev->id);
> > > +             dev_err(&pdev->dev, "failed to register LED %d\n", led->id);
> >
> > This does not seem to be necessary.
> >
> 
> Agreed.
> 
> > >               return ret;
> > >       }
> > >
> > >       led->cb.dev = led->cdev.dev;
> > >
> > > -     ret = lm3533_led_setup(led, pdata);
> > > +     device_property_read_u32(&pdev->dev, "led-max-microamp",
> > > +                              &led->max_current);
> > > +     led->max_current = clamp(led->max_current, LM3533_MAX_CURRENT_MIN,
> > > +                              LM3533_MAX_CURRENT_MAX);
> >
> > Why clamp instead of having lm3533_led_setup() fail below?
> >
> 
> According to OF schema default lower margin is set to
> LM3533_MAX_CURRENT_MIN so clamping seems a good option here, even
> though it will clamp max value.

Just let it fail to probe. The driver already have the necessary checks.

> > > +
> > > +     device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
> > > +
> > > +     ret = lm3533_led_setup(led);
> > >       if (ret)
> > >               goto err_deregister;
> > >
> > > @@ -725,9 +736,16 @@ static void lm3533_led_shutdown(struct platform_device *pdev)
> > >       lm3533_led_set(&led->cdev, LED_OFF);            /* disable blink */
> > >  }
> > >
> > > +static const struct of_device_id lm3533_led_match_table[] = {
> > > +     { .compatible = "ti,lm3533-leds" },
> > > +     { }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, lm3533_led_match_table);
> > > +
> > >  static struct platform_driver lm3533_led_driver = {
> > >       .driver = {
> > >               .name = "lm3533-leds",
> > > +             .of_match_table = lm3533_led_match_table,
> > >       },
> > >       .probe          = lm3533_led_probe,
> > >       .remove         = lm3533_led_remove,
> >
> > Remove platform alias below as well.
> >
> 
> Why?

Same reason as above.

> > >  static int lm3533_device_init(struct lm3533 *lm3533)
> > >  {
> > > -     struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
> > > +     struct device *dev = lm3533->dev;
> > > +     struct mfd_cell *lm3533_devices;
> > > +     u32 count = 0, reg, nchilds;
> >
> > Don't mix multiple declarations with initialisation like this.
> >
> 
> Checkpatch does not complain on style issue, hence this is not prohibited.

Checkpatch does not define good style.

> > >       int ret;
> > >
> > > -     dev_dbg(lm3533->dev, "%s\n", __func__);
> > > +     nchilds = device_get_child_node_count(dev);
> > > +     if (!nchilds || nchilds > LM3533_CELLS_MAX)
> > > +             return dev_err_probe(dev, -ENODEV,
> > > +                                  "num of child nodes is not supported\n");
> > >
> > > -     if (!pdata) {
> > > -             dev_err(lm3533->dev, "no platform data\n");
> > > -             return -EINVAL;
> > > -     }
> > > +     lm3533_devices = devm_kcalloc(dev, nchilds, sizeof(*lm3533_devices),
> > > +                                   GFP_KERNEL);
> > > +     if (!lm3533_devices)
> > > +             return -ENOMEM;
> > >
> > > -     lm3533->hwen = devm_gpiod_get(lm3533->dev, NULL, GPIOD_OUT_LOW);
> > > -     if (IS_ERR(lm3533->hwen))
> > > -             return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen), "failed to request HWEN GPIO\n");
> > > -     gpiod_set_consumer_name(lm3533->hwen, "lm3533-hwen");
> > > +     device_for_each_child_node_scoped(dev, child) {
> > > +             if (count >= nchilds)
> > > +                     break;
> >
> > How could count be larger than nchilds?
> >
> 
> Only if the tree is malformed, hence this check was added.

But you've just retrieved nchilds by parsing the tree and counting the
child nodes. So how can count possibly be larger than nchilds here?

> > > +
> > > +             if (fwnode_device_is_compatible(child, "ti,lm3533-als")) {
> > > +                     lm3533_devices[count].name = "lm3533-als";
> > > +                     lm3533_devices[count].of_compatible = "ti,lm3533-als";
> > > +                     lm3533_devices[count].id = PLATFORM_DEVID_NONE;
> > > +
> > > +                     lm3533->have_als = true;
> > > +                     count++;
> > > +             } else if (fwnode_device_is_compatible(child, "ti,lm3533-backlight")) {
> > > +                     ret = fwnode_property_read_u32(child, "reg", &reg);
> > > +                     if (ret || reg >= LM3533_HVLED_ID_MAX) {
> > > +                             dev_err(dev, "invalid backlight node %pfw\n", child);
> > > +                             continue;
> > > +                     }
> > > +
> > > +                     lm3533_devices[count].name = "lm3533-backlight";
> > > +                     lm3533_devices[count].of_compatible = "ti,lm3533-backlight";
> > > +                     lm3533_devices[count].id = reg;
> > > +                     lm3533_devices[count].of_reg = reg;
> > > +                     lm3533_devices[count].use_of_reg = true;
> > > +
> > > +                     lm3533->have_backlights = true;
> > > +                     count++;
> > > +             } else if (fwnode_device_is_compatible(child, "ti,lm3533-leds")) {
> > > +                     ret = fwnode_property_read_u32(child, "reg", &reg);
> > > +                     if (ret || reg < LM3533_HVLED_ID_MAX ||
> > > +                         reg > LM3533_LVLED_ID_MAX) {
> > > +                             dev_err(dev, "invalid LED node %pfw\n", child);
> > > +                             continue;
> > > +                     }
> > > +
> > > +                     lm3533_devices[count].name = "lm3533-leds";
> > > +                     lm3533_devices[count].of_compatible = "ti,lm3533-leds";
> > > +                     lm3533_devices[count].id = reg - LM3533_HVLED_ID_MAX;
> > > +                     lm3533_devices[count].of_reg = reg;
> > > +                     lm3533_devices[count].use_of_reg = true;
> > > +
> > > +                     lm3533->have_leds = true;
> > > +                     count++;
> > > +             }
> > > +     }
> >
> > Why do you need the above at all? Shouldn't you be able to just use
> > of_platform_populate().
> >
> 
> of_platform_populate() is not a part of mfd framework.

We have several MFD drivers using of_platform_populate().

> > >
> > >       lm3533_enable(lm3533);
> > >
> > >       ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
> > >                                LM3533_BOOST_FREQ_MASK,
> > > -                              pdata->boost_freq << LM3533_BOOST_FREQ_SHIFT);
> > > +                              lm3533->boost_freq << LM3533_BOOST_FREQ_SHIFT);
> > >       if (ret) {
> > > -             dev_err(lm3533->dev, "failed to set boost frequency\n");
> > > +             dev_err(dev, "failed to set boost frequency\n");
> > >               goto err_disable;
> > >       }
> > >
> > >       ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
> > >                                LM3533_BOOST_OVP_MASK,
> > > -                              pdata->boost_ovp << LM3533_BOOST_OVP_SHIFT);
> > > +                              lm3533->boost_ovp << LM3533_BOOST_OVP_SHIFT);
> > >       if (ret) {
> > > -             dev_err(lm3533->dev, "failed to set boost ovp\n");
> > > +             dev_err(dev, "failed to set boost ovp\n");
> > >               goto err_disable;
> > >       }
> > >
> > > -     lm3533_device_als_init(lm3533);
> > > -     lm3533_device_bl_init(lm3533);
> > > -     lm3533_device_led_init(lm3533);
> > > +     ret = mfd_add_devices(dev, 0, lm3533_devices, count, NULL, 0, NULL);
> > > +     if (ret) {
> > > +             dev_err(dev, "failed to add MFD devices: %d\n", ret);
> > > +             goto err_disable;
> > > +     }
> > >
> > >       return 0;
> > >
> > > @@ -504,7 +440,26 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
> > >               return PTR_ERR(lm3533->regmap);
> > >
> > >       lm3533->dev = &i2c->dev;
> > > -     lm3533->irq = i2c->irq;
> > > +
> > > +     lm3533->hwen = devm_gpiod_get_optional(lm3533->dev, "enable",
> > > +                                            GPIOD_OUT_LOW);
> > > +     if (IS_ERR(lm3533->hwen))
> > > +             return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen),
> > > +                                  "failed to get HWEN GPIO\n");
> >
> > Please use brackets around multline statements for readability
> > throughout.
> >
> 
> Checkpatch does not complain on style issue, hence this is not prohibited.

Checkpatch is irrelevant.

> > > +
> > > +     device_property_read_u32(lm3533->dev, "ti,boost-ovp-microvolt",
> > > +                              &lm3533->boost_ovp);
> > > +
> > > +     lm3533->boost_ovp = clamp(lm3533->boost_ovp, LM3533_BOOST_OVP_MIN,
> > > +                               LM3533_BOOST_OVP_MAX);
> > > +     lm3533->boost_ovp = lm3533->boost_ovp / (8 * MICRO) - 2;
> > > +
> > > +     device_property_read_u32(lm3533->dev, "ti,boost-freq-hz",
> > > +                              &lm3533->boost_freq);
> > > +
> > > +     lm3533->boost_freq = clamp(lm3533->boost_freq, LM3533_BOOST_FREQ_MIN,
> > > +                                LM3533_BOOST_FREQ_MAX);
> > > +     lm3533->boost_freq = lm3533->boost_freq / (500 * KILO) - 1;
> >
> > Again, why clamp instead of failing probe?
> >
> 
> According to OF schema default lower margin is set to
> LM3533_BOOST_FREQ_MIN so clamping seems a good option here, even
> though it will clamp max value.

Just let the driver fail to probe as the sanity checks are already
there.

> > >       return lm3533_device_init(lm3533);
> > >  }
> > > @@ -518,6 +473,12 @@ static void lm3533_i2c_remove(struct i2c_client *i2c)
> > >       lm3533_device_exit(lm3533);
> > >  }
> > >
> > > +static const struct of_device_id lm3533_match_table[] = {
> > > +     { .compatible = "ti,lm3533" },
> > > +     { }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, lm3533_match_table);
> > > +
> > >  static const struct i2c_device_id lm3533_i2c_ids[] = {
> > >       { "lm3533" },
> > >       { }

Shouldn't you drop i2c probing now as well?

> > > @@ -528,6 +489,7 @@ static struct i2c_driver lm3533_i2c_driver = {
> > >       .driver = {
> > >                  .name = "lm3533",
> > >                  .dev_groups = lm3533_attribute_groups,
> > > +                .of_match_table = lm3533_match_table,
> > >       },
> > >       .id_table       = lm3533_i2c_ids,
> > >       .probe          = lm3533_i2c_probe,

Johan
