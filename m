Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45029 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaLZMGM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 07:06:12 -0500
Message-ID: <549D4F30.4000904@kernel.org>
Date: Fri, 26 Dec 2014 12:06:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Arnaud Ebalard <arno@natisbad.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	Andrew Morton <akpm@linux-foundation.org>,
	=?windows-1252?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCHv2 5/8] staging: iio: isl29028: deprecate use of isl in
 compatible string for isil
References: <cover.1418763328.git.arno@natisbad.org> <f935306404d9b6d8a37862987122b6988cb6ffff.1418763328.git.arno@natisbad.org>
In-Reply-To: <f935306404d9b6d8a37862987122b6988cb6ffff.1418763328.git.arno@natisbad.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/12/14 21:20, Arnaud Ebalard wrote:
> 
> "isil" and "isl" prefixes are used at various locations inside the kernel
> to reference Intersil corporation. This patch is part of a series fixing
> those locations were "isl" is used in compatible strings to use the now
> expected "isil" prefix instead (NASDAQ symbol for Intersil and most used
> version). The old compatible string is kept for backward compatibility.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
This is getting a little silly. 

I'll go with whatever the device tree maintainers decide. Hence if they are happy,
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/light/isl29028.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index e969107ddb47..6440e3b293ca 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -537,8 +537,8 @@ static const struct i2c_device_id isl29028_id[] = {
>  MODULE_DEVICE_TABLE(i2c, isl29028_id);
>  
>  static const struct of_device_id isl29028_of_match[] = {
> -	{ .compatible = "isl,isl29028", },
> -	{ .compatible = "isil,isl29028", },/* deprecated, don't use */
> +	{ .compatible = "isl,isl29028", }, /* for backward compat., don't use */
> +	{ .compatible = "isil,isl29028", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, isl29028_of_match);
> 

