Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E72F3C0A;
	Sun, 17 May 2026 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779028304; cv=none; b=UOklp0rItZX7mSizseEWr0MqPMdU59ujoI0UC+CArc29O0j/BmaIOby6iiTlcmg44hR6yOvRzHi2EsjPoP12nXMtDIfIWAnGw629TPu941w9QOVCLaXlhnVdTxHHlxT+f1IQAZ5gmH3YYdSk0UsSL0alxjvy4ePCAWz4xGYROHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779028304; c=relaxed/simple;
	bh=loMgkJJ1NYy6WUTLUj0B8es4v7+BC5tl2gYO003HNSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxQIBr/DLk2AruBPQfWpyBwsdSHmCzpNSq2JGU9grLPDeniR2AUQuzC/x4BANNSrm3wGjKYFV0pKRY71vp5RmM8xBxz3L1aWsMR88PHrng7VnAMAuxWRBI0ht8qYIKtAmCLTJZE35TtQtSBcm7a2bVF5RBTZZBJA/j0Mmn/SK8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktjt36ZC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktjt36ZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97927C2BCB0;
	Sun, 17 May 2026 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779028303;
	bh=loMgkJJ1NYy6WUTLUj0B8es4v7+BC5tl2gYO003HNSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ktjt36ZCpqhTcGiJlPKv1kCNe9BpwvHxUvCuNfunM+F/GAhqSxMgf7g9fqg5CxZy8
	 m/oscbTT2jQzH+GLGywjWfUNv7t22bh+ZlccywiQ4HNprCfAER64jkZZX8XuxzSmV3
	 EDawwOLznvKCyNvblmF7QC8FjmOpbw55bE2TwC08i9gdspml3+jdoUuihk8qEg28YY
	 n1Eh3M4F3kahBaw5RWRAbFtetKXdBUONUcm56FRXbVKW3OsZ1wvyMSD+yMJ8F3IzD3
	 EqQCwsvt+RsvOJBpJ6UyaiVETiXjEtfSWNnRdAEaFWXOv02dwi4Fodf4ebuyZiu9Cs
	 GwNTPnu2nJ+wA==
Date: Sun, 17 May 2026 15:31:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, skhan@linuxfoundation.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: dac: ad5504: sort headers alphabetically
Message-ID: <20260517153133.3337489f@jic23-huawei>
In-Reply-To: <20260509142047.30302-3-0rayn.dev@gmail.com>
References: <20260509142047.30302-1-0rayn.dev@gmail.com>
	<20260509142047.30302-3-0rayn.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 15:20:40 +0100
Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:

> Rearrange the include headers in alphabetical order to follow the
> standard kernel coding style. This is a preparatory cleanup with
> no functional changes.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
I'm going to pick what I can from this series now - just to
reduce what we see in v4.

Applied this one.

> ---
>  drivers/iio/dac/ad5504.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index 355bcb6a8ba0..03ce37e2c616 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -5,21 +5,21 @@
>   * Copyright 2011 Analog Devices Inc.
>   */
>  
> -#include <linux/interrupt.h>
> -#include <linux/fs.h>
> +#include <linux/bitops.h>
>  #include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> +#include <linux/spi/spi.h>
>  #include <linux/sysfs.h>
> -#include <linux/regulator/consumer.h>
> -#include <linux/module.h>
> -#include <linux/bitops.h>
>  
> +#include <linux/iio/dac/ad5504.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/iio/events.h>
> -#include <linux/iio/dac/ad5504.h>
>  
>  #define AD5504_RES_MASK			GENMASK(11, 0)
>  #define AD5504_CMD_READ			BIT(15)

