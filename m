Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51709 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbaD2VEk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Apr 2014 17:04:40 -0400
Message-ID: <53601443.50306@kernel.org>
Date: Tue, 29 Apr 2014 22:06:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/6] devres: introduce API "devm_kmemdup
References: <1398729107-16748-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1398729107-16748-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1398729107-16748-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/14 00:51, Srinivas Pandruvada wrote:
> Introduce devm_kmemdup, which uses resource managed kmalloc.
> There are several request from maintainers to add this instead
> of using kmemdup.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git.  Initially pushed out as testing
for the autobuilders to play.

Thanks,
> ---
>   Documentation/driver-model/devres.txt |  1 +
>   drivers/base/devres.c                 | 21 +++++++++++++++++++++
>   include/linux/device.h                |  2 ++
>   3 files changed, 24 insertions(+)
>
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index 4f7897e..4999518 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -236,6 +236,7 @@ certainly invest a bit more effort into libata core layer).
>   MEM
>     devm_kzalloc()
>     devm_kfree()
> +  devm_kmemdup()
>
>   IIO
>     devm_iio_device_alloc()
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index db4e264..d0914cb 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -831,3 +831,24 @@ void devm_kfree(struct device *dev, void *p)
>   	WARN_ON(rc);
>   }
>   EXPORT_SYMBOL_GPL(devm_kfree);
> +
> +/**
> + * devm_kmemdup - Resource-managed kmemdup
> + * @dev: Device this memory belongs to
> + * @src: Memory region to duplicate
> + * @len: Memory region length
> + * @gfp: GFP mask to use
> + *
> + * Duplicate region of a memory using resource managed kmalloc
> + */
> +void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp)
> +{
> +	void *p;
> +
> +	p = devm_kmalloc(dev, len, gfp);
> +	if (p)
> +		memcpy(p, src, len);
> +
> +	return p;
> +}
> +EXPORT_SYMBOL_GPL(devm_kmemdup);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index d1d1c05..ab87158 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -623,6 +623,8 @@ static inline void *devm_kcalloc(struct device *dev,
>   }
>   extern void devm_kfree(struct device *dev, void *p);
>   extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp);
> +extern void *devm_kmemdup(struct device *dev, const void *src, size_t len,
> +			  gfp_t gfp);
>
>   void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
>   void __iomem *devm_request_and_ioremap(struct device *dev,
>

