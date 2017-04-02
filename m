Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47498 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdDBJSd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 05:18:33 -0400
Subject: Re: [RESEND PATCH] iio: st_pressure: initialize lps22hb bootime
To: Shrirang Bagul <shrirang.bagul@canonical.com>
References: <20170330154723.9612-1-shrirang.bagul@canonical.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcin Niestroj <m.niestroj@grinn-global.com>,
        Rob Herring <rob@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7618daba-7fb8-4e14-97ed-72bdd13a14a3@kernel.org>
Date: Sun, 2 Apr 2017 10:18:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170330154723.9612-1-shrirang.bagul@canonical.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/03/17 16:47, Shrirang Bagul wrote:
> This patch initializes the bootime in struct st_sensor_settings for
> lps22hb sensor. Without this, sensor channels read from sysfs always
> report stale values.
> 
> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/st_pressure_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 5f26808..fd0edca 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -457,6 +457,7 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
>  		.multi_read_bit = true,
> +		.bootime = 2,
>  	},
>  };
>  
> 

