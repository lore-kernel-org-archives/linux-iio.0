Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38331 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbbJaJje (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2015 05:39:34 -0400
Subject: Re: [PATCH] iio: core: added support for IIO_VAL_INT
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>, linux-iio@vger.kernel.org
References: <1445935915-7765-1-git-send-email-sean.nyekjaer@prevas.dk>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56348C54.7070705@kernel.org>
Date: Sat, 31 Oct 2015 09:39:32 +0000
MIME-Version: 1.0
In-Reply-To: <1445935915-7765-1-git-send-email-sean.nyekjaer@prevas.dk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/10/15 08:51, Sean Nyekjaer wrote:
> Addded core support for IIO_VAL_INT in write_raw_get_fmt function.
too many 'd's
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
I'm not convinced this works.  In iio_str_to_fixpoint if fract_mult ==1
and the value passed is say 1.2 we will get 1 + fract_mult*2 = 3.

Maybe it's just too early in the morning!  fract_mult = 0 would probably
do the job, but this does all seem rather silly given we can just use
the kstrto* function in the integer case rather than bludgeoning it
into the fixed point string reader.

Jonathan
> ---
>  drivers/iio/industrialio-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 208358f..2d08c3c 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -571,6 +571,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  	if (indio_dev->info->write_raw_get_fmt)
>  		switch (indio_dev->info->write_raw_get_fmt(indio_dev,
>  			this_attr->c, this_attr->address)) {
> +		case IIO_VAL_INT:
> +			fract_mult = 1;
> +			break;
>  		case IIO_VAL_INT_PLUS_MICRO:
>  			fract_mult = 100000;
>  			break;
> 

