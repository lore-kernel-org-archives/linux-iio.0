Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46639 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489AbcB1QiS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2016 11:38:18 -0500
Subject: Re: [PATCH v3 1/1] staging: coding style cleanups for
 staging/iio/light/tsl2583 driver
To: Bijosh Thykkoottathil <bijosh.t@hotmail.com>,
	gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
References: <BLU437-SMTP46745C0D4BEFE546C5C7A280B90@phx.gbl>
Cc: mahfouz.saif.elyazal@gmail.com, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56D32276.7070705@kernel.org>
Date: Sun, 28 Feb 2016 16:38:14 +0000
MIME-Version: 1.0
In-Reply-To: <BLU437-SMTP46745C0D4BEFE546C5C7A280B90@phx.gbl>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/02/16 08:28, Bijosh Thykkoottathil wrote:
> This patch fixes following coding style warning reported by check patch
> script, in tsl2583 driver:
>     - Block comments use a trailing */ on a separate line
> 
> Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
Hi Bijosh,

When issuing new revisions of a patch it is best to put a brief
summary of what the changes were from the previous version (under the ---
normally)  I haven't even tried to figure out what the difference is between the
3 revisions you sent this morning.  If you are sending a revision without any
changes (usually due to a formatting error or similar - please reply to the original
thread with a quick notes saying what was wrong and that you are going to send a new
version - that way we don't accidentally review the previous version)

Also, if cleaning up comment style like this, please read the style guide as the
start of these comments are all wrong as well and should be fixed in the same patch.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2583.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 3100d96..9159298 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -241,7 +241,8 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  	}
>  
>  	/* clear status, really interrupt status (interrupts are off), but
> -	 * we use the bit anyway - don't forget 0x80 - this is a command*/
> +	 * we use the bit anyway - don't forget 0x80 - this is a command
> +	 */
>  	ret = i2c_smbus_write_byte(chip->client,
>  				   (TSL258X_CMD_REG | TSL258X_CMD_SPL_FN |
>  				    TSL258X_CMD_ALS_INT_CLR));
> @@ -430,7 +431,8 @@ static int taos_chip_on(struct iio_dev *indio_dev)
>  	chip->als_time_scale = (als_time + 25) / 50;
>  
>  	/* TSL258x Specific power-on / adc enable sequence
> -	 * Power on the device 1st. */
> +	 * Power on the device 1st.
> +	 */
>  	utmp = TSL258X_CNTL_PWR_ON;
>  	ret = i2c_smbus_write_byte_data(chip->client,
>  					TSL258X_CMD_REG | TSL258X_CNTRL, utmp);
> @@ -440,7 +442,8 @@ static int taos_chip_on(struct iio_dev *indio_dev)
>  	}
>  
>  	/* Use the following shadow copy for our delay before enabling ADC.
> -	 * Write all the registers. */
> +	 * Write all the registers.
> +	 */
>  	for (i = 0, uP = chip->taos_config; i < TSL258X_REG_MAX; i++) {
>  		ret = i2c_smbus_write_byte_data(chip->client,
>  						TSL258X_CMD_REG + i,
> @@ -454,7 +457,8 @@ static int taos_chip_on(struct iio_dev *indio_dev)
>  
>  	usleep_range(3000, 3500);
>  	/* NOW enable the ADC
> -	 * initialize the desired mode of operation */
> +	 * initialize the desired mode of operation
> +	 */
>  	utmp = TSL258X_CNTL_PWR_ON | TSL258X_CNTL_ADC_ENBL;
>  	ret = i2c_smbus_write_byte_data(chip->client,
>  					TSL258X_CMD_REG | TSL258X_CNTRL,
> @@ -696,7 +700,8 @@ static ssize_t taos_luxtable_show(struct device *dev,
>  				  taos_device_lux[i].ch1);
>  		if (taos_device_lux[i].ratio == 0) {
>  			/* We just printed the first "0" entry.
> -			 * Now get rid of the extra "," and break. */
> +			 * Now get rid of the extra "," and break.
> +			 */
>  			offset--;
>  			break;
>  		}
> 

