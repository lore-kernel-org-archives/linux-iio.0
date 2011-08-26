Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:59268 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab1HZJMT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 05:12:19 -0400
Message-ID: <4E57655D.4060303@cam.ac.uk>
Date: Fri, 26 Aug 2011 10:20:29 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: imu: adis16400: Avoid null pointer dereference
References: <1314348200-11112-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314348200-11112-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/26/11 09:43, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Not sure if this is a proper fix. However it should do the trick.
> ring->scan_maks is allocated in iio_ring_buffer_register() which called
> after adis16400_configure_ring. So the time this pointer dereference takes
> place scan_mask is uninitialized.
Dratt missed that one.  This definitely isn't the right fix as it will get
wiped out when that element is initialized.

Mostly I fixed equivalents elsewhere by not setting a default.
After all user space shouldn't be relying on any particular set of channels
being enable anyway.  Do we have a good reason to not just remove it here?

> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/imu/adis16400_ring.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
> index 1a47d07..f6d50be 100644
> --- a/drivers/staging/iio/imu/adis16400_ring.c
> +++ b/drivers/staging/iio/imu/adis16400_ring.c
> @@ -191,7 +191,7 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
>  	ring->setup_ops = &adis16400_ring_setup_ops;
>  	ring->owner = THIS_MODULE;
>  	/* Set default scan mode - assumes single long is big enough */
> -	*ring->scan_mask = st->variant->default_scan_mask;
> +	ring->scan_mask = &st->variant->default_scan_mask;
>  	ring->scan_count = hweight_long(st->variant->default_scan_mask);
>  
>  	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,

