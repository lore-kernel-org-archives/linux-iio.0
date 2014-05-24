Return-Path: <knaack.h@gmx.de>
Message-ID: <53810894.2000806@gmx.de>
Date: Sat, 24 May 2014 23:01:08 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: Erik.Habbinga@schneider-electric.com
Subject: Re: [PATCH] iio:adc:max1363 incorrect resolutions for max11604, max11605,
 max11610 and max11611.
References: <1400933041-7007-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1400933041-7007-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron schrieb:
> Reported-by: Erik Habbinga <Erik.Habbinga@schneider-electric.com>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/adc/max1363.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 9cf3229..1b3b74b 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1252,8 +1252,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>  		.num_modes = ARRAY_SIZE(max1238_mode_list),
>  		.default_mode = s0to11,
>  		.info = &max1238_info,
> -		.channels = max1238_channels,
> -		.num_channels = ARRAY_SIZE(max1238_channels),
> +		.channels = max1038_channels,
> +		.num_channels = ARRAY_SIZE(max1038_channels),
>  	},
>  	[max11605] = {
>  		.bits = 8,
> @@ -1262,8 +1262,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>  		.num_modes = ARRAY_SIZE(max1238_mode_list),
>  		.default_mode = s0to11,
>  		.info = &max1238_info,
> -		.channels = max1238_channels,
> -		.num_channels = ARRAY_SIZE(max1238_channels),
> +		.channels = max1038_channels,
> +		.num_channels = ARRAY_SIZE(max1038_channels),
>  	},
>  	[max11606] = {
>  		.bits = 10,
> @@ -1312,8 +1312,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>  		.num_modes = ARRAY_SIZE(max1238_mode_list),
>  		.default_mode = s0to11,
>  		.info = &max1238_info,
> -		.channels = max1238_channels,
> -		.num_channels = ARRAY_SIZE(max1238_channels),
> +		.channels = max1138_channels,
> +		.num_channels = ARRAY_SIZE(max1138_channels),
>  	},
>  	[max11611] = {
>  		.bits = 10,
> @@ -1322,8 +1322,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>  		.num_modes = ARRAY_SIZE(max1238_mode_list),
>  		.default_mode = s0to11,
>  		.info = &max1238_info,
> -		.channels = max1238_channels,
> -		.num_channels = ARRAY_SIZE(max1238_channels),
> +		.channels = max1138_channels,
> +		.num_channels = ARRAY_SIZE(max1138_channels),
>  	},
>  	[max11612] = {
>  		.bits = 12,
