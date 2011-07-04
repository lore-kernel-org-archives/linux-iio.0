Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:60296 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756588Ab1GDIxG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2011 04:53:06 -0400
Message-ID: <4E118157.3020906@cam.ac.uk>
Date: Mon, 04 Jul 2011 10:01:11 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Chris Forbes <chrisf@ijw.co.nz>
CC: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] drivers: staging: iio: adc: fix uninitialized use
References: <1309657621-21711-1-git-send-email-chrisf@ijw.co.nz>
In-Reply-To: <1309657621-21711-1-git-send-email-chrisf@ijw.co.nz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/11 02:47, Chris Forbes wrote:
> Fixed an uninitialized variable access. In the first two error paths in
> max1363_probe(), 'st' is not yet initialized, but its 'reg' member is
> accessed anyway. This would most likely crash.
Good spot. Please tech TODO files for staging patches. In this case it would
have given you the mailing list, now cc'd.
> 
> The intended value for st->reg *is* available at that point in 'reg',
> so just use that directly.
> 
> Signed-off-by: Chris Forbes <chrisf@ijw.co.nz>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/max1363_core.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
> index 98cebd2..ebecf14 100644
> --- a/drivers/staging/iio/adc/max1363_core.c
> +++ b/drivers/staging/iio/adc/max1363_core.c
> @@ -1335,11 +1335,11 @@ error_free_device:
>  	else
>  		iio_device_unregister(indio_dev);
>  error_disable_reg:
> -	if (!IS_ERR(st->reg))
> -		regulator_disable(st->reg);
> +	if (!IS_ERR(reg))
> +		regulator_disable(reg);
>  error_put_reg:
> -	if (!IS_ERR(st->reg))
> -		regulator_put(st->reg);
> +	if (!IS_ERR(reg))
> +		regulator_put(reg);
>  
>  	return ret;
>  }

