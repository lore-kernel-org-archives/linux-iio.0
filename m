Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35025 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2IOJKH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Sep 2012 05:10:07 -0400
Message-ID: <505445EE.5050601@kernel.org>
Date: Sat, 15 Sep 2012 10:10:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	Milo Kim <Milo.Kim@ti.com>,
	anish kumar <anish198519851985@gmail.com>
Subject: Re: [PATCH 1/4] iio: consumer.h: Fix kernel doc incosistency
References: <1347636104-3419-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1347636104-3419-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/14/2012 04:21 PM, Lars-Peter Clausen wrote:
> For the iio_read_channel_raw and iio_read_channel_scale the kerneldoc comment
> refers to an argument called "channel", while the argument is called "chan" in
> the function signature. This leads to the following warnings from kerneldoc:
> 
> 	Warning(include/linux/iio/consumer.h:71): No description found for parameter 'chan'
> 	Warning(include/linux/iio/consumer.h:71): Excess function parameter 'channel' description in 'iio_read_channel_raw'
> 	Warning(include/linux/iio/consumer.h:109): No description found for parameter 'chan'
> 	Warning(include/linux/iio/consumer.h:109): Excess function parameter 'channel' description in 'iio_read_channel_scale'
> 
> This patch fixes the warnings by naming them consistently.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Why do it this way round? It is inconsistent with most of the other functions
in consumer.h and if you were to do this I'd argue in favour of also changing
the naming in the implementation.. Much easier to just change the documentation
to match the implementation!
> ---
>  include/linux/iio/consumer.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 06ab4ec..27759ac3 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -67,7 +67,7 @@ void iio_channel_release_all(struct iio_channel *chan);
>   * Note raw reads from iio channels are in adc counts and hence
>   * scale will need to be applied if standard units required.
>   */
> -int iio_read_channel_raw(struct iio_channel *chan,
> +int iio_read_channel_raw(struct iio_channel *channel,
>  			 int *val);
>  
>  /**
> @@ -90,7 +90,7 @@ int iio_get_channel_type(struct iio_channel *channel,
>   * as IIO_VAL_INT_PLUS_MICRO telling us we have a value of val
>   * + val2/1e6
>   */
> -int iio_read_channel_scale(struct iio_channel *chan, int *val,
> +int iio_read_channel_scale(struct iio_channel *channel, int *val,
>  			   int *val2);
>  
>  #endif
> 
