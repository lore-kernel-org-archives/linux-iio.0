Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:48217 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab1HZLwG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 07:52:06 -0400
Message-ID: <4E578AD1.8080806@cam.ac.uk>
Date: Fri, 26 Aug 2011 13:00:17 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: accel: ADIS16209: Fix double registration of in_incli0_index
References: <1314358594-2565-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314358594-2565-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/26/11 12:36, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> iio (null): tried to double register : in_incli0_index
oops.  That (null) is clearly an issue to.

As for the fix.  Yet another bug due to that pesky IIO_CHAN
macro. hohum.

Thanks and merged.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/accel/adis16209_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> index 183b5c2..8d5f1d5 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -431,11 +431,11 @@ static struct iio_chan_spec adis16209_channels[] = {
>  		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
>  		 in_aux, ADIS16209_SCAN_AUX_ADC,
>  		 IIO_ST('u', 12, 16, 0), 0),
> -	IIO_CHAN(IIO_INCLI, 0, 1, 0, NULL, 0, IIO_MOD_X,
> +	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_X,
>  		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  		 incli_x, ADIS16209_SCAN_INCLI_X,
>  		 IIO_ST('s', 14, 16, 0), 0),
> -	IIO_CHAN(IIO_INCLI, 0, 1, 0, NULL, 0, IIO_MOD_Y,
> +	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_Y,
>  		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
>  		 incli_y, ADIS16209_SCAN_INCLI_Y,
>  		 IIO_ST('s', 14, 16, 0), 0),

