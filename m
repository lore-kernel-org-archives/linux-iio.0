Return-Path: <SRS0=bx8B=SC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5AEC43381
	for <linux-iio@archiver.kernel.org>; Sun, 31 Mar 2019 09:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383512183F
	for <linux-iio@archiver.kernel.org>; Sun, 31 Mar 2019 09:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554025595;
	bh=B0E7zrhyfmtS3/6++sC2FE2TUx5DAYK7v7S3WNn22O8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AfMHrxVeUXeY/9QKSO0LHVr8mLmWb76dL+F7wI7QmgUPF9+tK5F78Mpskw8GwYNgq
	 b5rPCoSlQdp5og9piB+KpmpP14rOxN3eUwUo3TEZpD/HTObrbfx1TD4Zriw1DFI3DX
	 R/9QZZqBUFxBmUppfTMAXlg7L6OD53OCQtfncXgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfCaJqe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfCaJqe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Mar 2019 05:46:34 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E88320850;
        Sun, 31 Mar 2019 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554025592;
        bh=B0E7zrhyfmtS3/6++sC2FE2TUx5DAYK7v7S3WNn22O8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J4idZB0w52HygkcljzrhBlRsuHvQB7coDHyUjzUySdTnroX6ylMjCkxIN1ivLLssH
         2Q74fODXlxrmhhaY5QngvVvxQbDTotnLgPoWTBYvq1ozMXQCadT+OlXsHvDoCxfRHT
         cFg5roDprcN5mbszYL77yKkx+tDLHRgoLNLkXvDE=
Date:   Sun, 31 Mar 2019 10:46:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/6] iio: gyro: add core driver for fxas21002c
Message-ID: <20190331104626.1b204fdb@archlinux>
In-Reply-To: <20190326101651.25056-3-rui.silva@linaro.org>
References: <20190326101651.25056-1-rui.silva@linaro.org>
        <20190326101651.25056-3-rui.silva@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Mar 2019 10:16:47 +0000
Rui Miguel Silva <rui.silva@linaro.org> wrote:

> Add core support for the NXP fxas21002c Tri-axis gyroscope,
> using the iio subsystem. It supports PM operations, axis reading,
> temperature, scale factor of the axis, high pass and low pass
> filtering, and sampling frequency selection.
> 
> It will have extras modules to support the communication over i2c and
> spi.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
Ah, slightly missunderstanding around what I suggested for probe / remove
ordering.  I've marked it inline and would have just fixed it whilst applying
but there is another issue inline that I had missed before.


> ---
>  drivers/iio/gyro/Kconfig           |   11 +
>  drivers/iio/gyro/Makefile          |    1 +
>  drivers/iio/gyro/fxas21002c.h      |  151 +++++
>  drivers/iio/gyro/fxas21002c_core.c | 1006 ++++++++++++++++++++++++++++
>  4 files changed, 1169 insertions(+)
>  create mode 100644 drivers/iio/gyro/fxas21002c.h
>  create mode 100644 drivers/iio/gyro/fxas21002c_core.c
> 
> diff --git a/drivers/iio/gyro/fxas21002c.h b/drivers/iio/gyro/fxas21002c.h
> new file mode 100644
> index 000000000000..e21fd410950c
> --- /dev/null
> +++ b/drivers/iio/gyro/fxas21002c.h
> @@ -0,0 +1,151 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Driver for NXP FXAS21002C Gyroscope - Header
> + *
> + * Copyright (C) 2019 Linaro Ltd.
> + *

I'm a stickler for hanging blank lines.  So drop this one.
> + */
> +
> +#ifndef FXAS21002C_H_
> +#define FXAS21002C_H_
...

> +
> +static irqreturn_t fxas21002c_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct fxas21002c_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_bulk_read(data->regmap, FXAS21002C_REG_OUT_X_MSB,
> +			       data->buffer, CHANNEL_SCAN_MAX * sizeof(s16));
> +	mutex_unlock(&data->lock);
A side note here.  Right now it's not possible to use data->buffer concurrently
so I'm not sure this lock is actually needed. In most drivers we also
end up using the same buffer for other accesses, but here it it is only
this one which is in a thread which can only be running once at a time IIRC.

Ah well, paranoid never hurt anyone ;)  I only got suspicious when I noticed
it didn't protect the buffer when it is still be used in the push_to_buffers
call below.

> +	if (ret < 0)
> +		goto notify_done;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +					   pf->timestamp);
> +
> +notify_done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int fxas21002c_chip_init(struct fxas21002c_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int chip_id;
> +	int ret;
> +
> +	ret = regmap_field_read(data->regmap_fields[F_WHO_AM_I], &chip_id);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (chip_id != FXAS21002C_CHIP_ID_1 &&
> +	    chip_id != FXAS21002C_CHIP_ID_2) {
> +		dev_err(dev, "chip id 0x%02x is not supported\n", chip_id);
> +		return -EINVAL;
> +	}
> +
> +	data->chip_id = chip_id;
> +
> +	ret = fxas21002c_mode_set(data, FXAS21002C_MODE_STANDBY);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set ODR to 200HZ as default */
> +	ret = fxas21002c_odr_set(data, 200);
> +	if (ret < 0)
> +		dev_err(dev, "failed to set ODR: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int fxas21002c_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +						 bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct fxas21002c_data *data = iio_priv(indio_dev);
> +
> +	return regmap_field_write(data->regmap_fields[F_INT_EN_DRDY], state);
> +}
> +
> +static const struct iio_trigger_ops fxas21002c_trigger_ops = {
> +	.set_trigger_state = &fxas21002c_data_rdy_trigger_set_state,
> +};
> +
> +static irqreturn_t fxas21002c_data_rdy_trig_poll(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct fxas21002c_data *data = iio_priv(indio_dev);
> +	unsigned int data_ready;
> +	int ret;
> +
> +	ret = regmap_field_read(data->regmap_fields[F_SRC_DRDY], &data_ready);
> +	if (ret < 0)
> +		return IRQ_NONE;
> +
> +	if (!data_ready)
> +		return IRQ_NONE;
> +
> +	iio_trigger_poll(data->dready_trig);

This isn't right.  The function sleeps in the regmap_read above adn
iio_trigger_poll is to be called from an irq context. You want
iio_trigger_poll_chained (which is missnamed and I should fix that
one day - it should probably be _nested) which is the version
that only calls the thread parts.

https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-trigger.c#L189

The problem is that you are relying on the iio_pollfunc_store_time
top half which won't ever get called.  Easy fix though is to just
get the timestamp in your interrupt thread function directly.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct device_node *np = indio_dev->dev.of_node;
> +	unsigned long irq_trig;
> +	bool irq_open_drain;
> +	int irq1;
> +	int ret;
> +
> +	if (!data->irq)
> +		return 0;
> +
> +	irq1 = of_irq_get_byname(np, "INT1");
> +
> +	if (irq1 == data->irq) {
> +		dev_info(dev, "using interrupt line INT1\n");
> +		ret = regmap_field_write(data->regmap_fields[F_INT_CFG_DRDY],
> +					 1);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	dev_info(dev, "using interrupt line INT2\n");
> +
> +	irq_open_drain = of_property_read_bool(np, "drive-open-drain");
> +
> +	data->dready_trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						   indio_dev->name,
> +						   indio_dev->id);
> +	if (!data->dready_trig)
> +		return -ENOMEM;
> +
> +	irq_trig = irqd_get_trigger_type(irq_get_irq_data(data->irq));
> +
> +	if (irq_trig == IRQF_TRIGGER_RISING) {
> +		ret = regmap_field_write(data->regmap_fields[F_IPOL], 1);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	if (irq_open_drain)
> +		irq_trig |= IRQF_SHARED;
> +
> +	ret = devm_request_irq(dev, data->irq, fxas21002c_data_rdy_trig_poll,
> +			       irq_trig, "fxas21002c_data_ready",
> +			       data->dready_trig);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->dready_trig->dev.parent = dev;
> +	data->dready_trig->ops = &fxas21002c_trigger_ops;
> +	iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> +
> +	return iio_trigger_register(data->dready_trig);
You are fine using the devm version of this . See below.
> +}
> +
> +static int fxas21002c_power_enable(struct fxas21002c_data *data)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(data->vdd);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regulator_enable(data->vddio);
> +	if (ret < 0) {
> +		regulator_disable(data->vdd);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void fxas21002c_power_disable(struct fxas21002c_data *data)
> +{
> +	regulator_disable(data->vdd);
> +	regulator_disable(data->vddio);
> +}
> +
> +static void fxas21002c_power_disable_action(void *_data)
> +{
> +	struct fxas21002c_data *data = _data;
> +
> +	fxas21002c_power_disable(data);
> +}
> +
> +static int fxas21002c_regulators_get(struct fxas21002c_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +
> +	data->vdd = devm_regulator_get(dev->parent, "vdd");
> +	if (IS_ERR(data->vdd))
> +		return PTR_ERR(data->vdd);
> +
> +	data->vddio = devm_regulator_get(dev->parent, "vddio");
> +	if (IS_ERR(data->vddio))
> +		return PTR_ERR(data->vddio);
> +
> +	return 0;
> +}
> +
> +int fxas21002c_core_probe(struct device *dev, struct regmap *regmap, int irq,
> +			  const char *name)
> +{
> +	struct fxas21002c_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap_field *f;
> +	int i;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +	data->irq = irq;
> +	data->regmap = regmap;
> +
> +	for (i = 0; i < F_MAX_FIELDS; i++) {
> +		f = devm_regmap_field_alloc(dev, data->regmap,
> +					    fxas21002c_reg_fields[i]);
> +		if (IS_ERR(f))
> +			return PTR_ERR(f);
> +
> +		data->regmap_fields[i] = f;
> +	}
> +
> +	mutex_init(&data->lock);
> +
> +	ret = fxas21002c_regulators_get(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = fxas21002c_power_enable(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, fxas21002c_power_disable_action,
> +				       data);
Good. This effectively makes up for us not having a devm_regulator_enable
so it will be automatically cleared up in remove or error paths.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = fxas21002c_chip_init(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->channels = fxas21002c_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(fxas21002c_channels);
> +	indio_dev->name = name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &fxas21002c_info;
> +
> +	ret = fxas21002c_trigger_probe(data);
> +	if (ret < 0)
> +		return ret;
This can still use the devm_iio_trigger_register internally so
doesn't need clearing up by hand.
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
> +					 fxas21002c_trigger_handler, NULL);
> +	if (ret < 0)
devm_iio_trigger_buffer_setup is fine.
Then return ret;
> +		goto trigger_unregister;
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret)
> +		goto buffer_cleanup;
So this is the point where we now have to stop using devm_ based
cleanup if we want to maintain ordering.  So all correct from
here, but before here you are fine using devm.

> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto pm_disable;
> +
> +	return 0;
> +
> +pm_disable:
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
> +
> +buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +trigger_unregister:
> +	if (data->irq)
> +		iio_trigger_unregister(data->dready_trig);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(fxas21002c_core_probe);
> +
> +void fxas21002c_core_remove(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct fxas21002c_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
> +
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +	if (data->irq)
> +		iio_trigger_unregister(data->dready_trig);
> +	fxas21002c_power_disable(data);
This is handled by the devm_action_or_reset  in probe.

That will ensure that remove automatically calls this.
As a result there is no need to use non devm_ functions for
the next few. I'll clean it up when applying but please
check I didn't mess it up!

> +}
> +EXPORT_SYMBOL_GPL(fxas21002c_core_remove);
> +
> +static int __maybe_unused fxas21002c_suspend(struct device *dev)
> +{
> +	struct fxas21002c_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	fxas21002c_mode_set(data, FXAS21002C_MODE_STANDBY);
> +	fxas21002c_power_disable(data);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused fxas21002c_resume(struct device *dev)
> +{
> +	struct fxas21002c_data *data = iio_priv(dev_get_drvdata(dev));
> +	int ret;
> +
> +	ret = fxas21002c_power_enable(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	return fxas21002c_mode_set(data, data->prev_mode);
> +}
> +
> +static int __maybe_unused fxas21002c_runtime_suspend(struct device *dev)
> +{
> +	struct fxas21002c_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	return fxas21002c_mode_set(data, FXAS21002C_MODE_READY);
> +}
> +
> +static int __maybe_unused fxas21002c_runtime_resume(struct device *dev)
> +{
> +	struct fxas21002c_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	return fxas21002c_mode_set(data, FXAS21002C_MODE_ACTIVE);
> +}
> +
> +const struct dev_pm_ops fxas21002c_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(fxas21002c_suspend, fxas21002c_resume)
> +	SET_RUNTIME_PM_OPS(fxas21002c_runtime_suspend,
> +			   fxas21002c_runtime_resume, NULL)
> +};
> +EXPORT_SYMBOL_GPL(fxas21002c_pm_ops);
> +
> +MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("FXAS21002C Gyro driver");

