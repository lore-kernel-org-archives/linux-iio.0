Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52041 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab1LDUo6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2011 15:44:58 -0500
Received: from [192.168.0.2] (cpc1-cmbg6-0-0-cust492.5-4.cable.virginmedia.com [81.101.137.237])
	by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 47FBB4037F
	for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2011 20:44:55 +0000 (GMT)
Message-ID: <4EDBDBC8.5040508@kernel.org>
Date: Sun, 04 Dec 2011 20:44:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:adc:max1363 actually make timestamp controllable
References: <1322396541-29959-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1322396541-29959-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

gone to Greg
> From: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Previously timestamps were always on in this driver.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
> A random minor fixlet that has been in my tree far too long.
> 
>  drivers/staging/iio/adc/max1363_ring.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
> index a87fbe8..3c5e199 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -138,9 +138,8 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
>  		goto done;
>  
>  	time_ns = iio_get_time_ns();
> -
> -	memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
> -
> +	if (indio_dev->buffer->scan_timestamp)
> +		memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
>  	indio_dev->buffer->access->store_to(indio_dev->buffer, rxbuf, time_ns);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);

