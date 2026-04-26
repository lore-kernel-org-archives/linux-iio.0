Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291D3624B9;
	Sun, 26 Apr 2026 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777210203; cv=none; b=YB/ba2mlS2dvriaWeBhfwopTRR37o0QHofbVS9qCCfqQJaJoMLCrsbayQq5T+ZmvtNsdFAnLYxWidKkWXazXIQpfSqINemXIPf7KmeHo4OPFOtjWtZqpwhkAByS0k0XCiRVpd9CJPhLoSH/vb09cmA7L12eAK7/iTOpu8rJBgwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777210203; c=relaxed/simple;
	bh=v+/LUeHl16iSF9icTJvAkdEyUuvVf29w5oyghvSIlRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqhFMIN59xujXMnecVtXbXEzyP7U39fCfkrZMIquoCqM6gROJ8x3XWaOXfV+Sar+fhUMqDAU1F3wGvISoCZeyvurxAX7JHZ6qYFfwo7fEoMCf+3BjQ8pYtUeiAn1nRYO4Bc819pMndLpUpJyHcCFs0YE5JRTMTZ9fHHg/Mft+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNBx1sez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNBx1sez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2463AC2BCAF;
	Sun, 26 Apr 2026 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777210202;
	bh=v+/LUeHl16iSF9icTJvAkdEyUuvVf29w5oyghvSIlRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oNBx1sez2aixaFap2hSdVfQElG/5Xl8Q621cI5axMIPJQa049fIcyD5X1f6XoNx54
	 /+gBvCCew2QiZjt6UFYU0rb8V9eiHcVqJ3G05q5JGy81FFCwWiwqICEFnTC4Ly3PBQ
	 X02uK20a4zmEhKbPF0aF6no/suTNUFGhKBqUOQL9afC+QuLxLxFK8/M3FVr3/ABbe3
	 ChukrxhBdDWAj5bCd7oDMYq1i0+QTHkagH94rwGhrjNL1RoBMPoRagcGTdon7fz4oq
	 QnYl+wXn2p1WfiaKbg5Hzo+uofhjDFV9EW8KG3P/XkbU+hT4UEc3+dL33mGtz2cqRv
	 L3wlb9gRqHDcA==
Date: Sun, 26 Apr 2026 14:29:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 01/10] iio: dac: ad5686: refactor include headers
Message-ID: <20260426142952.7fb2d340@jic23-huawei>
In-Reply-To: <20260426-ad5686-fixes-v1-1-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
	<20260426-ad5686-fixes-v1-1-7c946a77794e@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 09:38:02 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Apply IWYU principle, replacing unused/generic headers for
> specific/missing headers. The resulting include directive list is sorted
> accordingly.

As below, I would expect some headers to be included in the c file
even if they are also in the local header.

> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686-spi.c |  9 +++++++--
>  drivers/iio/dac/ad5686.c     | 13 ++++---------
>  drivers/iio/dac/ad5686.h     |  5 ++---
>  drivers/iio/dac/ad5696-i2c.c | 10 +++++++---
>  4 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index df8619e0c092..695125238633 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -8,11 +8,16 @@
>   * Copyright 2018 Analog Devices Inc.
>   */
>  
> -#include "ad5686.h"
> -
> +#include <linux/array_size.h>
> +#include <linux/err.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
>  
> +#include <asm/byteorder.h>
> +
> +#include "ad5686.h"
> +
>  static int ad5686_spi_write(struct ad5686_state *st,
>  			    u8 cmd, u8 addr, u16 val)
>  {
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 9a384c50929b..1a6eb3832f22 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -5,17 +5,12 @@
>   * Copyright 2011 Analog Devices Inc.
>   */
>  
> -#include <linux/interrupt.h>
> -#include <linux/fs.h>
> -#include <linux/device.h>
> +#include <linux/array_size.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
>  #include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/regulator/consumer.h>
> -
> -#include <linux/iio/iio.h>

Keep this one in the c files. IWYU does not allow for removing
includes just because they are in another header.  The fact this
one is included in ad5686.h is down to using IIO_DMA_MINALIGN
which is not 'obvious' from point of view of the c files including it.

> -#include <linux/iio/sysfs.h>
> +#include <linux/sysfs.h>
>  
>  #include "ad5686.h"
>  
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index e7d36bae3e59..3fcc792ea656 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -8,10 +8,9 @@
>  #ifndef __DRIVERS_IIO_DAC_AD5686_H__
>  #define __DRIVERS_IIO_DAC_AD5686_H__
>  
> -#include <linux/types.h>
> -#include <linux/cache.h>
> +#include <linux/bits.h>
>  #include <linux/mutex.h>
> -#include <linux/kernel.h>
> +#include <linux/types.h>
>  
>  #include <linux/iio/iio.h>

>  
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index d3327bca0e07..e7e1b8a6fc71 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -7,10 +7,14 @@
>   * Copyright 2018 Analog Devices Inc.
>   */
>  
> -#include "ad5686.h"
> -
> -#include <linux/module.h>
> +#include <linux/err.h>
>  #include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +
> +#include <asm/byteorder.h>
> +
> +#include "ad5686.h"
>  
>  static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
>  {
> 

