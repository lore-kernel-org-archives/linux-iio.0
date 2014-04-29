Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51729 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbaD2VIB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Apr 2014 17:08:01 -0400
Message-ID: <5360150C.1010904@kernel.org>
Date: Tue, 29 Apr 2014 22:09:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/6] IIO: core: Add quaternion modifier
References: <1398729107-16748-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1398729107-16748-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1398729107-16748-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/14 00:51, Srinivas Pandruvada wrote:
> Added quaternion in the list of supported modifiers.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/industrialio-core.c | 1 +
>   include/linux/iio/types.h       | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e22a984..dcc1849 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -84,6 +84,7 @@ static const char * const iio_modifier_names[] = {
>   	[IIO_MOD_LIGHT_RED] = "red",
>   	[IIO_MOD_LIGHT_GREEN] = "green",
>   	[IIO_MOD_LIGHT_BLUE] = "blue",
> +	[IIO_MOD_QUATERNION] = "quaternion",
>   };
>
>   /* relies on pairs of these shared then separate */
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index a13c224..4fdab2e 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -53,6 +53,7 @@ enum iio_modifier {
>   	IIO_MOD_LIGHT_RED,
>   	IIO_MOD_LIGHT_GREEN,
>   	IIO_MOD_LIGHT_BLUE,
> +	IIO_MOD_QUATERNION,
>   };
>
>   enum iio_event_type {
>

