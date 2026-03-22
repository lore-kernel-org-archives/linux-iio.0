Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52238224B05;
	Sun, 22 Mar 2026 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774183401; cv=none; b=j8BFwIiNsKLHlgNtgdU68f/bj/qyQ/9lKxfvmnbwJoz1D1iToxM0HKmRprfMoJABYF4BKy6g1MBhBF1BYh1/T9QNTs5PexOT6Z9p0Agz2IsA4JKZUgHvZRMeA4dACPq2U9jJTIYyVv9iULeUh6LaDbnzOenoiyFYzDcR/HXaGuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774183401; c=relaxed/simple;
	bh=OycCSydrJX0OZ3WxURx9DK2BVZinkQ1O+4eBpgk4d2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ol6sBirAMgEBBo3L5ai2IV3tf5Ak1qLHrJKz4ZRQ3hOoVp7nvJ+HA/MX7kmUVFSPjlX28KEaVcjvNkl4zlpBlZmeawXZ7UyXK3pU6eQILk7bn2RgCoiiqTsNbRwC/cPXMN8xhYLMpzD7M10gWgauAX/xCgnw37o8jjcnhYz/YOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJk/x3SJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJk/x3SJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20A8C19424;
	Sun, 22 Mar 2026 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774183400;
	bh=OycCSydrJX0OZ3WxURx9DK2BVZinkQ1O+4eBpgk4d2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PJk/x3SJlGSRmqcMJXIRHfmU8ROG7OSL13Ea8LTgu5MRFhErA1UPhnwZb344xdlxB
	 fpRuI5tnWZ/aumUzwGpOI9NZGrtTu++6vK1a29R4rhBMzUdLm/BDCPJGh3Zcw1DY8M
	 UFY+VB/Maff4QViLuKzAXgUMW1RsYQaO20E6V93WzGTwCyd2QT9AMDyr3PPrIjMcML
	 2MTezinnxtFUcjH1ERi2XWWXnjjduVrOFHyfS3Bxixud6/4XDolV6SoIUBBRKc3SU6
	 PNxqlpF3AEKKhJYuUmADFHgUdrjzD7/IPkyO7OcVQgldyTi+J+FOAFAUHDfbRfqbQ2
	 Po/KRndxwxu8w==
Date: Sun, 22 Mar 2026 12:43:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Jander <david@protonic.nl>
Subject: Re: [PATCH v6 03/12] iio: dac: ds4424: sort headers alphabetically
Message-ID: <20260322124310.08e0541e@jic23-huawei>
In-Reply-To: <20260210135110.2027073-4-o.rempel@pengutronix.de>
References: <20260210135110.2027073-1-o.rempel@pengutronix.de>
	<20260210135110.2027073-4-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 14:51:01 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Sort the header inclusions alphabetically. This improves readability and
> simplifies adding new includes in the future.
> 
> Group subsystem-specific headers (linux/iio/*) separately at the end
> to clarify subsystem context.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

I applied this one by hand as iio/consumer.h isn't used and another
series had removed it in the meantime.

Thanks,

Jonathan

> ---
> changes v6:
> - no changes
> changes v5:
> - no changes
> changes v4:
> - no changes
> changes v3:
> - Keep linux/iio/* headers in a separate group at the end of the includes.
> changes v2:
> - new patch
> ---
>  drivers/iio/dac/ds4424.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> index 36286e4923af..c03051dc763e 100644
> --- a/drivers/iio/dac/ds4424.c
> +++ b/drivers/iio/dac/ds4424.c
> @@ -6,16 +6,17 @@
>   */
>  
>  #include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/i2c.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/err.h>
> -#include <linux/delay.h>
> -#include <linux/iio/iio.h>
> +
> +#include <linux/iio/consumer.h>
>  #include <linux/iio/driver.h>
> +#include <linux/iio/iio.h>
>  #include <linux/iio/machine.h>
> -#include <linux/iio/consumer.h>
>  
>  #define DS4422_MAX_DAC_CHANNELS		2
>  #define DS4424_MAX_DAC_CHANNELS		4

