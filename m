Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44960 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759776Ab2KBJas (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Nov 2012 05:30:48 -0400
Message-ID: <509392C6.6050201@kernel.org>
Date: Fri, 02 Nov 2012 09:30:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Kumar Amit Mehta <gmate.amit@gmail.com>
CC: jic23@cam.ac.uk, gregkh@linuxfoundation.org, lars@metafoo.de,
	michael.hennerich@analog.com, thomas@m3y3r.de,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7280a.c: fixed macro coding style
References: <1351841333-30581-1-git-send-email-gmate.amit@gmail.com>
In-Reply-To: <1351841333-30581-1-git-send-email-gmate.amit@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/02/2012 07:28 AM, Kumar Amit Mehta wrote:
> remove unnecessary semicolon from the macro definition
> 
> Signed-off-by: Kumar Amit Mehta <gmate.amit@gmail.com>
Thanks, added to togreg branch of iio.git

> ---
>  drivers/staging/iio/adc/ad7280a.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index cfc39a7..e7cb3b2 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -117,7 +117,7 @@
>   */
>  #define POLYNOM		0x2F
>  #define POLYNOM_ORDER	8
> -#define HIGHBIT		1 << (POLYNOM_ORDER - 1);
> +#define HIGHBIT		(1 << (POLYNOM_ORDER - 1))
>  
>  struct ad7280_state {
>  	struct spi_device		*spi;
> 
