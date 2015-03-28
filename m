Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60462 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbbC1NxZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 09:53:25 -0400
Message-ID: <5516B252.6040104@kernel.org>
Date: Sat, 28 Mar 2015 13:53:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Darshana Padmadas <darshanapadmadas@gmail.com>,
	outreachy-kernel@googlegroups.com
CC: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	daniel.baluta@intel.com
Subject: Re: [PATCH] iio: imu: Use iio_trigger_get for indio_dev->trig assignment
References: <1427524634-5677-1-git-send-email-darshanapadmadas@gmail.com>
In-Reply-To: <1427524634-5677-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/15 06:37, Darshana Padmadas wrote:
> This patch uses iio_trigger_get to increment the reference
> count of trigger device, to avoid incorrect assignment.
> 
> This patch refers to a similar situation encountered through the
> following discussion:
> http://www.spinics.net/lists/linux-iio/msg13669.html
> 
> Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
Applied to the fixes-togreg branch of iio.git with it marked for stable
as well.

Added a note that this can cause a null pointer dereference to make
it clear why this should be in stable.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/adis_trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
> index e0017c2..f53e9a8 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -60,7 +60,7 @@ int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
>  	iio_trigger_set_drvdata(adis->trig, adis);
>  	ret = iio_trigger_register(adis->trig);
>  
> -	indio_dev->trig = adis->trig;
> +	indio_dev->trig = iio_trigger_get(adis->trig);
>  	if (ret)
>  		goto error_free_irq;
>  
> 

