Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51303 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaECKha (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 06:37:30 -0400
Message-ID: <5364C748.6010601@kernel.org>
Date: Sat, 03 May 2014 11:39:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: Add TEMP_AMBIENT and TEMP_OBJECT channel modifiers
References: <1399046226-6673-1-git-send-email-pmeerw@pmeerw.net> <1399046226-6673-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046226-6673-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/14 16:57, Peter Meerwald wrote:
> useful for contactless temperature sensors to distinguish
> between the ambient temperature and the temperature of the object
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks
> ---
>   drivers/iio/industrialio-core.c | 2 ++
>   include/linux/iio/types.h       | 2 ++
>   2 files changed, 4 insertions(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index de8b1c2..4b1f375 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -85,6 +85,8 @@ static const char * const iio_modifier_names[] = {
>   	[IIO_MOD_LIGHT_GREEN] = "green",
>   	[IIO_MOD_LIGHT_BLUE] = "blue",
>   	[IIO_MOD_QUATERNION] = "quaternion",
> +	[IIO_MOD_TEMP_AMBIENT] = "ambient",
> +	[IIO_MOD_TEMP_OBJECT] = "object",
>   };
>
>   /* relies on pairs of these shared then separate */
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 4fdab2e..d480631 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -54,6 +54,8 @@ enum iio_modifier {
>   	IIO_MOD_LIGHT_GREEN,
>   	IIO_MOD_LIGHT_BLUE,
>   	IIO_MOD_QUATERNION,
> +	IIO_MOD_TEMP_AMBIENT,
> +	IIO_MOD_TEMP_OBJECT,
>   };
>
>   enum iio_event_type {
>

