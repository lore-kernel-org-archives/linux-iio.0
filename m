Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36787 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbaBRInn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 03:43:43 -0500
Message-ID: <53031D66.8090004@kernel.org>
Date: Tue, 18 Feb 2014 08:44:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH]iio:max1363 fix typos of int_vref_mv
References: <5300A545.5040308@gmx.de>
In-Reply-To: <5300A545.5040308@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/02/14 11:47, Hartmut Knaack wrote:
> This patch fixes some typos in max1363_chip_info_tbl[].
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Good spot.  As it has been there for quite some time and no one has
noticed, I'll put this through the togreg branch rather than fixes-togreg.

Applied to the togreg branch of iio.git.  Thanks.
> ---
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index e283f2f..de7d3b4 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1253,7 +1253,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>   	},
>   	[max11604] = {
>   		.bits = 8,
> -		.int_vref_mv = 4098,
> +		.int_vref_mv = 4096,
>   		.mode_list = max1238_mode_list,
>   		.num_modes = ARRAY_SIZE(max1238_mode_list),
>   		.default_mode = s0to11,
> @@ -1313,7 +1313,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>   	},
>   	[max11610] = {
>   		.bits = 10,
> -		.int_vref_mv = 4098,
> +		.int_vref_mv = 4096,
>   		.mode_list = max1238_mode_list,
>   		.num_modes = ARRAY_SIZE(max1238_mode_list),
>   		.default_mode = s0to11,
> @@ -1373,7 +1373,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>   	},
>   	[max11616] = {
>   		.bits = 12,
> -		.int_vref_mv = 4098,
> +		.int_vref_mv = 4096,
>   		.mode_list = max1238_mode_list,
>   		.num_modes = ARRAY_SIZE(max1238_mode_list),
>   		.default_mode = s0to11,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

