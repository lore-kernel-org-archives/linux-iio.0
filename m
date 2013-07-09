Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45253 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab3GIVPR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jul 2013 17:15:17 -0400
Message-ID: <51DC7D64.506@kernel.org>
Date: Tue, 09 Jul 2013 22:15:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: staging: fix device.txt documentation
References: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/2013 09:24 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
applied to the togreg branch of iio.git.
Thanks.
> ---
>  drivers/staging/iio/Documentation/device.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/device.txt b/drivers/staging/iio/Documentation/device.txt
> index ea08d62..8be32e5 100644
> --- a/drivers/staging/iio/Documentation/device.txt
> +++ b/drivers/staging/iio/Documentation/device.txt
> @@ -56,7 +56,7 @@ Then fill in the following:
>  
>  - indio_dev->modes:
>  	Specify whether direct access and / or ring buffer access is supported.
> -- indio_dev->ring:
> +- indio_dev->buffer:
>  	An optional associated buffer.
>  - indio_dev->pollfunc:
>  	Poll function related elements. This controls what occurs when a trigger
> @@ -67,7 +67,7 @@ Then fill in the following:
>  - indio_dev->num_channels:
>  	How many channels are there?
>  
> -Once these are set up, a call to iio_device_register(indio_dev),
> +Once these are set up, a call to iio_device_register(indio_dev)
>  will register the device with the iio core.
>  
>  Worth noting here is that, if a ring buffer is to be used, it can be
> 
