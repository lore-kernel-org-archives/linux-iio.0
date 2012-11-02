Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45131 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab2KBJpk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Nov 2012 05:45:40 -0400
Message-ID: <50939643.3090503@kernel.org>
Date: Fri, 02 Nov 2012 09:45:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: Reject trailing garbage when parsing fixed point
 numbers
References: <1350904515-696-1-git-send-email-lars@metafoo.de> <1350904515-696-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1350904515-696-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/22/2012 12:15 PM, Lars-Peter Clausen wrote:
> When parsing a fixed point number IIO stops parsing the string once it has
> reached the last requested decimal place. This means that the remainder of the
> string is silently accepted regardless, of whether it is part of a valid number
> or not. This patch modifies the code to scan the whole string and only accept
> valid numbers. Since fract_mult is 0 after the last decimal place any digit that
> may follows won't affect the result.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Nice little trick.

Added to togreg branch of iio.git

> ---
>  drivers/iio/industrialio-core.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a2e9953..fe593bf 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -440,8 +440,6 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  				integer = integer*10 + *buf - '0';
>  			else {
>  				fract += fract_mult*(*buf - '0');
> -				if (fract_mult == 1)
> -					break;
>  				fract_mult /= 10;
>  			}
>  		} else if (*buf == '\n') {
> 
