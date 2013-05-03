Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-053.synserver.de ([212.40.185.53]:1511 "EHLO
	smtp-out-053.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab3ECJfu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2013 05:35:50 -0400
Message-ID: <518384D1.8030802@metafoo.de>
Date: Fri, 03 May 2013 11:35:13 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Oskar Andero <oskar.andero@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCHv3] iio: adc: add driver for MCP3204/08 12-bit ADC
References: <1367571310-20491-1-git-send-email-oskar.andero@gmail.com>
In-Reply-To: <1367571310-20491-1-git-send-email-oskar.andero@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/03/2013 10:55 AM, Oskar Andero wrote:
[...]
> +
> +struct mcp320x {
> +	struct spi_device *spi;
> +	struct spi_message msg;
> +	struct spi_transfer transfer[2];
> +
> +	u8 tx_buf;
> +	u8 rx_buf[2];
> +
> +	struct regulator *reg;
> +	unsigned int ref_mv;

ref_mv looks unused.

> +
> +	struct mutex lock;
> +};
> +
[..]
> +static int mcp320x_probe(struct spi_device *spi)
> +{
[...]
> +
> +	ret = regulator_enable(adc->reg);
> +	if (ret < 0)
> +		goto reg_free;

You shouldn't disable the regulator if enabling it failed.

> +
> +	mutex_init(&adc->lock);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto reg_free;
> +
> +	return 0;
> +
> +reg_free:
> +	regulator_disable(adc->reg);
> +	regulator_put(adc->reg);
> +iio_free:
> +	iio_device_free(indio_dev);
> +
> +	return ret;
> +}
[...]

