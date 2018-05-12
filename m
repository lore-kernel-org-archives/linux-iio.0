Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbeELLUz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 May 2018 07:20:55 -0400
Date: Sat, 12 May 2018 12:20:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        drew.paterson@ams.com
Subject: Re: [PATCH v3 4/9] staging: iio: tsl2x7x: use macro to populate
 tsl2X7X_device_info
Message-ID: <20180512122049.7e704d7a@archlinux>
In-Reply-To: <20180511001223.12378-5-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
        <20180511001223.12378-5-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 10 May 2018 20:12:18 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch creates a macro that populates the tsl2X7X_device_info
> structure to reduce duplicated code in the driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 61 ++++++++++---------------------------
>  1 file changed, 16 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index f5ca5ada0358..51c1a90cb592 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1305,52 +1305,23 @@ static const struct attribute_group tsl2X7X_device_attr_group_tbl[] = {
>  	},
>  };
>  
> +#define TSL2X7X_DEVICE_INFO(type)[type] = \
> +	{ \
> +		.attrs = &tsl2X7X_device_attr_group_tbl[type], \
> +		.read_raw = &tsl2x7x_read_raw, \
> +		.write_raw = &tsl2x7x_write_raw, \
> +		.read_event_value = &tsl2x7x_read_event_value, \
> +		.write_event_value = &tsl2x7x_write_event_value, \
> +		.read_event_config = &tsl2x7x_read_interrupt_config, \
> +		.write_event_config = &tsl2x7x_write_interrupt_config, \
> +	}
> +
>  static const struct iio_info tsl2X7X_device_info[] = {
> -	[ALS] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[ALS],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> -	},
> -	[PRX] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[PRX],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> -	},
> -	[ALSPRX] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> -	},
> -	[PRX2] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[PRX2],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> -	},
> -	[ALSPRX2] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX2],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> -	},
> +	TSL2X7X_DEVICE_INFO(ALS),
> +	TSL2X7X_DEVICE_INFO(PRX),
> +	TSL2X7X_DEVICE_INFO(ALSPRX),
> +	TSL2X7X_DEVICE_INFO(PRX2),
> +	TSL2X7X_DEVICE_INFO(ALSPRX2),
>  };
>  
>  static const struct iio_event_spec tsl2x7x_events[] = {

