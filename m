Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59340 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946068AbbHHQ2y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 12:28:54 -0400
Subject: Re: [PATCH 2/7] iio:accel:mma8452: drop double include
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438483410.git.knaack.h@gmx.de>
 <91382bd835c10eaa15598d3ea3ca09d1a873f74d.1438483410.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C62E44.8090505@kernel.org>
Date: Sat, 8 Aug 2015 17:28:52 +0100
MIME-Version: 1.0
In-Reply-To: <91382bd835c10eaa15598d3ea3ca09d1a873f74d.1438483410.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/08/15 21:43, Hartmut Knaack wrote:
> One inclusion of linux/iio/trigger_consumer.h is sufficient.
> 
> Fixes: 	ae6d9ce05691b ("iio: mma8452: Add support for interrupt driven triggers.")
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/accel/mma8452.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 245b95fc22be..153f26bc88dc 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -16,7 +16,6 @@
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
> 

