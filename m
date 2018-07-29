Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeG2NFs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Jul 2018 09:05:48 -0400
Date: Sun, 29 Jul 2018 12:35:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Novotny <tomas.novotny@tbs-biometrics.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomas Novotny <tomas@novotny.cz>
Subject: Re: [PATCH v3 2/4] iio: vcnl4000: add VCNL4010 and VCNL4020 device
 id
Message-ID: <20180729123535.25fcddc9@archlinux>
In-Reply-To: <20180725151821.17566-3-tomas.novotny@tbs-biometrics.com>
References: <20180725151821.17566-1-tomas.novotny@tbs-biometrics.com>
        <20180725151821.17566-3-tomas.novotny@tbs-biometrics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 25 Jul 2018 17:18:19 +0200
Tomas Novotny <tomas.novotny@tbs-biometrics.com> wrote:

> From: Tomas Novotny <tomas@novotny.cz>
> 
> The driver already supports VCNL4010/20 devices. The currently supported
> features and detectable product id are the same, so add shared id for
> them.
> 
> This is a groundwork to extend the driver by detecting incorrectly
> specified device id.
> 
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
Applied.

Thanks,

Jonathan

> ---
> Changes v2..v3:
> - improve commit message
> - add vcnl4020 device id
> 
>  drivers/iio/light/vcnl4000.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 32c0b531395f..980eb3b77d5f 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -48,6 +48,7 @@
>  
>  enum vcnl4000_device_ids {
>  	VCNL4000,
> +	VCNL4010,
>  };
>  
>  struct vcnl4000_data {
> @@ -68,6 +69,8 @@ struct vcnl4000_chip_spec {
>  
>  static const struct i2c_device_id vcnl4000_id[] = {
>  	{ "vcnl4000", VCNL4000 },
> +	{ "vcnl4010", VCNL4010 },
> +	{ "vcnl4020", VCNL4010 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
> @@ -157,6 +160,12 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
>  		.measure_light = vcnl4000_measure_light,
>  		.measure_proximity = vcnl4000_measure_proximity,
>  	},
> +	[VCNL4010] = {
> +		.prod = "VCNL4010/4020",
> +		.init = vcnl4000_init,
> +		.measure_light = vcnl4000_measure_light,
> +		.measure_proximity = vcnl4000_measure_proximity,
> +	},
>  };
>  
>  static const struct iio_chan_spec vcnl4000_channels[] = {

