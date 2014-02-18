Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38298 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbaBRK04 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 05:26:56 -0500
Message-ID: <53033597.1010503@kernel.org>
Date: Tue, 18 Feb 2014 10:27:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Don't include extended name in shared attributes
References: <1392387566-8411-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1392387566-8411-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/02/14 14:19, Lars-Peter Clausen wrote:
> The extended name is channel specific and should not be included in shared
> attributes.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

> ---
> It's a fix, but there are no drivers yet, which have channels with extended
> names and shared attributes, so no need to apply it to the fixes branch.
Thanks for making this clear - saves me checking ;)
> ---
>   drivers/iio/industrialio-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index acc911a..fd96e8b 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -558,7 +558,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>   								    ->channel2],
>   						 postfix);
>   	} else {
> -		if (chan->extend_name == NULL)
> +		if (chan->extend_name == NULL || shared_by != IIO_SEPARATE)
>   			full_postfix = kstrdup(postfix, GFP_KERNEL);
>   		else
>   			full_postfix = kasprintf(GFP_KERNEL,
>

