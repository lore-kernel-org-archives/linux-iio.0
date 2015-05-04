Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46912 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbbEDQYR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 12:24:17 -0400
Message-ID: <55479D2D.7000807@kernel.org>
Date: Mon, 04 May 2015 17:24:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
CC: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 04/10] iio: st_sensors: make detection more helpful
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org> <1430399755-26475-4-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1430399755-26475-4-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/04/15 14:15, Linus Walleij wrote:
> The ST sensors are detected by reading a WhoAmI register and
> matching the number found to a sensor name string. To make it
> easier to figure out what happens when things go wrong, print
> the WhoAmI value and the device name we're trying to match.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied.
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index cbeb5e01bc3a..1255b157c71c 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -503,7 +503,8 @@ int st_sensors_check_device_support(struct iio_dev *indio_dev,
>  			break;
>  	}
>  	if (n == ARRAY_SIZE(sensor_settings[i].sensors_supported)) {
> -		dev_err(&indio_dev->dev, "device name and WhoAmI mismatch.\n");
> +		dev_err(&indio_dev->dev, "device name \"%s\" and WhoAmI (0x%02x) mismatch",
> +			indio_dev->name, wai);
>  		goto sensor_name_mismatch;
>  	}
>  
> 

