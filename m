Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33231 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab3JXKRv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 06:17:51 -0400
Message-ID: <52690209.8020604@kernel.org>
Date: Thu, 24 Oct 2013 12:18:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 8/9] iio: Add channel modifiers for Quaternion Rotations
References: <1382555476-15826-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1382555476-15826-8-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1382555476-15826-8-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/23/13 20:11, Srinivas Pandruvada wrote:
> A quaternion is composed of four components: a vector with x, y, z
> coordinates and a w rotation. Added channel modifiers for exporting
> these four components via user space.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Quaternions are one of the 'interesting' cases that make me wonder if we need
a slightly more generic form of read_raw.  The quaternion only has meaning
with an associated scale.  Hence you really have to guarantee that you can grab all
4 components together.

Do we need to rethink how the read callback works?

Mind you, if we do that then we need to extend the description of the buffer element
in the scan_mask.  We could define a compound description for a channel, but that is 'interesting'.

I also don't like this being defined as type IIO_ROT - the units (such as exist are different).
See next patch for what I'm referring to here.

I've cc'd a few people who might have views on this.



> ---
>  drivers/iio/industrialio-core.c | 4 ++++
>  include/linux/iio/types.h       | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f95c697..4ffaead 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -80,6 +80,10 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_LIGHT_RED] = "red",
>  	[IIO_MOD_LIGHT_GREEN] = "green",
>  	[IIO_MOD_LIGHT_BLUE] = "blue",
> +	[IIO_MOD_QUATERNION_X] = "quat_x",
> +	[IIO_MOD_QUATERNION_Y] = "quat_y",
> +	[IIO_MOD_QUATERNION_Z] = "quat_z",
> +	[IIO_MOD_QUATERNION_W] = "quat_w",
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 88bf0f0..ac2345c 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -52,6 +52,10 @@ enum iio_modifier {
>  	IIO_MOD_LIGHT_RED,
>  	IIO_MOD_LIGHT_GREEN,
>  	IIO_MOD_LIGHT_BLUE,
> +	IIO_MOD_QUATERNION_X,
> +	IIO_MOD_QUATERNION_Y,
> +	IIO_MOD_QUATERNION_Z,
> +	IIO_MOD_QUATERNION_W,
>  };
>  
>  #define IIO_VAL_INT 1
> 
