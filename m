Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbeIVVR2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Sep 2018 17:17:28 -0400
Date: Sat, 22 Sep 2018 16:23:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH V2] staging:iio:ad7606: update structs with doc
 annotations
Message-ID: <20180922162328.68957971@archlinux>
In-Reply-To: <20180918121503.12651-1-alexandru.ardelean@analog.com>
References: <20180918121503.12651-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 18 Sep 2018 15:15:03 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The current structs are only partially documented via annotations. This
> change updates annotations for all structs in the ad7606.h file.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied. Thanks,
> ---
>  drivers/staging/iio/adc/ad7606.h | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index 4983e3aa6b0e..86188054b60b 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -24,7 +24,27 @@ struct ad7606_chip_info {
>  
>  /**
>   * struct ad7606_state - driver instance specific data
> - * @lock		protect sensor state
> + * @dev		pointer to kernel device
> + * @chip_info		entry in the table of chips that describes this device
> + * @reg		regulator info for the the power supply of the device
> + * @poll_work		work struct for continuously reading data from the device
> + *			into an IIO triggered buffer
> + * @wq_data_avail	wait queue struct for buffer mode
> + * @bops		bus operations (SPI or parallel)
> + * @range		voltage range selection, selects which scale to apply
> + * @oversampling	oversampling selection
> + * @done		marks whether reading data is done
> + * @base_address	address from where to read data in parallel operation
> + * @lock		protect sensor state from concurrent accesses to GPIOs
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
>  
>  struct ad7606_state {
> @@ -55,6 +75,10 @@ struct ad7606_state {
>  	unsigned short			data[12] ____cacheline_aligned;
>  };
>  
> +/**
> + * struct ad7606_bus_ops - driver bus operations
> + * @read_block		function pointer for reading blocks of data
> + */
>  struct ad7606_bus_ops {
>  	/* more methods added in future? */
>  	int (*read_block)(struct device *dev, int num, void *data);
