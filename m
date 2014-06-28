Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:50979 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbaF1IdF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 28 Jun 2014 04:33:05 -0400
Message-ID: <53AE7E3D.70807@kernel.org>
Date: Sat, 28 Jun 2014 09:35:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] iio: core: add xyz modifier value
References: <1403829626-17660-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1403829626-17660-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1403829626-17660-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/14 01:40, Srinivas Pandruvada wrote:
> iio types defines a modifier called IIO_MOD_X_AND_Y_AND_Z, but since
> no modifier name is specified, it shows (null) as channel name.
> Here name is assiged a value "xyz".
Hmm. The purpose of this particularly modifier was for boolean combinations
of events.  There are devices out there that will only fire an interrupt
if say they detect changes in acceleration in all 3 directions...
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>   drivers/iio/industrialio-core.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4b1f375..e8428bb 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -87,6 +87,7 @@ static const char * const iio_modifier_names[] = {
>   	[IIO_MOD_QUATERNION] = "quaternion",
>   	[IIO_MOD_TEMP_AMBIENT] = "ambient",
>   	[IIO_MOD_TEMP_OBJECT] = "object",
> +	[IIO_MOD_X_AND_Y_AND_Z] = "xyz",
>   };
>
>   /* relies on pairs of these shared then separate */
>

