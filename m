Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35973 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387480AbeKGBOD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Nov 2018 20:14:03 -0500
Date: Tue, 6 Nov 2018 21:18:06 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Chris Coffey <cmc@babblebit.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: Add driver for Microchip
 MCP41xxx/42xxx
Message-ID: <20181106154806.GB20842@himanshu-Vostro-3559>
References: <20181106113130.9612-1-cmc@babblebit.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181106113130.9612-1-cmc@babblebit.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 06, 2018 at 11:31:30AM +0000, Chris Coffey wrote:
> This patch adds driver support for the Microchip MCP41xxx/42xxx family
> of digital potentiometers:
> 
> DEVICE      Wipers  Positions   Resistance (kOhm)
> MCP41010    1       256         10
> MCP41050    1       256         50
> MCP41100    1       256         100
> MCP42010    2       256         10
> MCP42050    2       256         50
> MCP42100    2       256         100
> 
> Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
> 
> Signed-off-by: Chris Coffey <cmc@babblebit.net>
> ---
>  .../bindings/iio/potentiometer/mcp41010.txt        |  29 +++

WARNING: DT binding docs and includes should be a separate patch. 
See: Documentation/devicetree/bindings/submitting-patches.txt

Please run checkpatch.pl on this patch once.

> +#define MCP41010_MAX_WIPERS	2
> +#define MCP41010_WRITE		(0x01 << 4)

#define MCP41010_WRITE			BIT(4) ?

> +#define MCP41010_WIPER_MAX	255
> +#define MCP41010_WIPER_ENABLE	BIT(0)
> +
> +struct mcp41010_cfg {
> +	int wipers;
> +	int kohms;
> +};
> +
> +enum mcp41010_type {
> +	MCP41010 = 0,

0 initialisation is implicit, hence `= 0` not
required.

> +	MCP41050,
> +	MCP41100,
> +	MCP42010,
> +	MCP42050,
> +	MCP42100,
> +};

[]

> +static int mcp41010_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	int err;
> +	struct mcp41010_data *data = iio_priv(indio_dev);
> +	int channel = chan->channel;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val > MCP41010_WIPER_MAX || val < 0)
> +			return -EINVAL;
> +		break;

This looks weird.

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&data->lock);
> +
> +	data->buf[0] = MCP41010_WIPER_ENABLE << channel;
> +	data->buf[0] |= MCP41010_WRITE;
> +	data->buf[1] = val & 0xff;
> +
> +	err = spi_write(data->spi, data->buf, 2);
> +	if (!err)
> +		data->value[channel] = val;
> +
> +	mutex_unlock(&data->lock);
> +
> +	return err;
> +}

[]

> +static int mcp41010_probe(struct spi_device *spi)
> +{
> +	int err;
> +	struct device *dev = &spi->dev;
> +	unsigned long devid = spi_get_device_id(spi)->driver_data;
> +	struct mcp41010_data *data;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +	data->spi = spi;
> +	data->cfg = &mcp41010_cfg[devid];
> +
> +	mutex_init(&data->lock);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &mcp41010_info;
> +	indio_dev->channels = mcp41010_channels;
> +	indio_dev->num_channels = data->cfg->wipers;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +
> +	err = devm_iio_device_register(dev, indio_dev);
> +	if (err) {
> +		dev_info(&spi->dev, "Unable to register %s\n", indio_dev->name);
> +		return err;
> +	}

I think direct return is preferred.
Nevermind ...


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
