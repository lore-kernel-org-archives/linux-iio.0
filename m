Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbeIPQrR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Sep 2018 12:47:17 -0400
Date: Sun, 16 Sep 2018 12:24:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH] staging:iio:ad7606: update structs with doc annotations
Message-ID: <20180916122436.63916f40@archlinux>
In-Reply-To: <20180913110736.31182-1-alexandru.ardelean@analog.com>
References: <20180913110736.31182-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 13 Sep 2018 14:07:36 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The current structs are only partially documented via annotations. This
> change updates annotations for all structs in the ad7606.h file.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Good stuff, though a few questions inline.

I'm hoping this means you are planning to finish tidying this driver
up and move it out of staging?=20

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7606.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/a=
d7606.h
> index 4983e3aa6b0e..f422296354c9 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -24,7 +24,26 @@ struct ad7606_chip_info {
> =20
>  /**
>   * struct ad7606_state - driver instance specific data
> + * @dev		pointer to kernel device
> + * @chip_info		entry in the table of chips that describes this device
> + * @reg		regulator info for the the power supply of the device
> + * @poll_work		struct info for reading data in buffer mode
I'm not quite sure on the intended meaning of this one above...

> + * @wq_data_avail	wait queue struct for buffer mode
> + * @bops		bus operations (SPI or parallel)
> + * @range		voltage range selection, selects which scale to apply
> + * @oversampling	oversampling selection
> + * @done		marks whether reading data is done
> + * @base_address	address from where to read data in parallel operation
>   * @lock		protect sensor state

=46rom what? Concurrent changes I guess, but would be good to be clear.

> + * @gpio_convst	GPIO descriptor for conversion start signal (CONVST)
> + * @gpio_reset		GPIO descriptor for device hard-reset
> + * @gpio_range		GPIO descriptor for range selection
> + * @gpio_standby	GPIO descriptor for stand-by signal (STBY),
> + *			controls power-down mode of device
> + * @gpio_frstdata	GPIO descriptor for reading from device when data
> + *			is being read on the first channel
> + * @gpio_os		GPIO descriptors to control oversampling on the device
> + * @data		buffer for reading data from the device
>   */
> =20
>  struct ad7606_state {
> @@ -55,6 +74,10 @@ struct ad7606_state {
>  	unsigned short			data[12] ____cacheline_aligned;
>  };
> =20
> +/**
> + * struct ad7606_bus_ops - driver bus operations
> + * @read_block		function pointer for reading blocks of data
> + */
>  struct ad7606_bus_ops {
>  	/* more methods added in future? */
>  	int (*read_block)(struct device *dev, int num, void *data);
