Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB463C43334
	for <linux-iio@archiver.kernel.org>; Sun, 12 Jun 2022 09:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiFLJqZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Jun 2022 05:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFLJqY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2022 05:46:24 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A127636B79
        for <linux-iio@vger.kernel.org>; Sun, 12 Jun 2022 02:46:22 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 0KAlob505OXCy0KAlocd3n; Sun, 12 Jun 2022 11:46:20 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 12 Jun 2022 11:46:20 +0200
X-ME-IP: 90.11.190.129
Message-ID: <9e232b74-6fb0-fd89-a043-71d5faf92cc6@wanadoo.fr>
Date:   Sun, 12 Jun 2022 11:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Content-Language: fr
To:     ddrokosov@sberdevices.ru
Cc:     andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        jic23@kernel.org, kernel@sberdevices.ru, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, stano.jakubek@gmail.com,
        stephan@gerhold.net
References: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
 <20220525181532.6805-3-ddrokosov@sberdevices.ru>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220525181532.6805-3-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le 25/05/2022 à 20:15, Dmitry Rokosov a écrit :
> MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> sensitivity consumer applications. It has dynamical user selectable full
> scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> with output data rates from 1Hz to 1000Hz.
> 
> Datasheet can be found at following URL:
> https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> 
> This driver supports following MSA311 features:
>      - IIO interface
>      - Different power modes: NORMAL and SUSPEND (using pm_runtime)
>      - ODR (Output Data Rate) selection
>      - Scale and samp_freq selection
>      - IIO triggered buffer, IIO reg access
>      - NEW_DATA interrupt + trigger
> 
> Below features to be done:
>      - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov-i4r8oA+eLlH99rHkP+FxIw@public.gmane.org>
> ---
>   MAINTAINERS                |    6 +
>   drivers/iio/accel/Kconfig  |   13 +
>   drivers/iio/accel/Makefile |    2 +
>   drivers/iio/accel/msa311.c | 1525 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 1546 insertions(+)
>   create mode 100644 drivers/iio/accel/msa311.c

[...]

> +static int msa311_probe(struct i2c_client *i2c)
> +{
> +	struct msa311_priv *msa311;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &i2c->dev;
> +	int err;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*msa311));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "iio device allocation failed\n");
> +
> +	msa311 = iio_priv(indio_dev);
> +	msa311->i2c = i2c;
> +	i2c_set_clientdata(i2c, indio_dev);
> +
> +	err = msa311_regmap_init(msa311);
> +	if (err)
> +		return err;
> +
> +	mutex_init(&msa311->lock);
> +
> +	err = devm_pm_runtime_enable(dev);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "cannot enable runtime PM (%d)\n", err);
> +

Nit: dev_err_probe() already print the 'err' (in a human readable 
maner), so unless the code itself is of any interest, it can be removed:

i.e.:
+		return dev_err_probe(dev, err,
+				     "cannot enable runtime PM");

This pattern is used in many places.

just my 2c.

CJ

