Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:47569 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab1BVTKo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Feb 2011 14:10:44 -0500
Message-ID: <4D640A50.9020700@cam.ac.uk>
Date: Tue, 22 Feb 2011 19:11:12 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: Documentation: iio_utils: Fix typo
References: <1297781180-5071-1-git-send-email-michael.hennerich@analog.com> <1297781180-5071-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1297781180-5071-3-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/15/11 14:46, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> 
It's not an actual bug, but your version is certainly easier to read,
hence the ack. Not worth pushing to stable though and might want to have
a description that makes it clear that it is for readability.

Thanks to helpful denizen of another list for providing the following
succinct argument. As he put it when I queried a**b...

Reference: http://www.cs.man.ac.uk/~pjj/bnf/c_syntax.bnf

There's no "**" token, so "a**d" has to be parsed as "a" "*" "*" "d".

And there's no postfix "*" operator, so "a" "*" ... can only be a
mult_exp. Given it's a mult_exp, the "*" "d" is parsed as a cast_exp,
which inevitably means treating it as a unary_exp consisting of a
unary_operator ("*") followed by an id which, all by itself, qualifies
as a primary_exp, a postfix_exp, a unary_exp and a cast_exp, and is
therefore legal as the rhs of a multi_exp.

> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/Documentation/iio_utils.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index 3cf01a5..4b023aa 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -374,7 +374,7 @@ inline int build_channel_array(const char *device_dir,
>  		}
>  	}
>  	/* reorder so that the array is in index order*/
> -	current = malloc(sizeof(**ci_array)**counter);
> +	current = malloc(sizeof(**ci_array)*(*counter));
>  	if (current == NULL) {
>  		ret = -ENOMEM;
>  		goto error_cleanup_array;

