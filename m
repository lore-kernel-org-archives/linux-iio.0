Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DC72D7BF
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776601021; cv=none; b=spKE2G3D6vfcFxptGEmeLyqnm1OBKYbn7guAEtW1upE0Cb9jM0+4gcOXB1WZe6vJrtrXNQQcNsObQMNXnNtQ2A1H7x0vaLfU7aUtha3/R8JULMAh+LG6aI6vh+Hl46RrV0k9HgN0c/wgEYl3DyxAhk+KEsanIdcA2nHnSVLqLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776601021; c=relaxed/simple;
	bh=08IbGrUdY2jbuq0187mla2/22LiSOCmA0BrBjGZkm1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Myu1E9vDtLqyiMKcXf7q0ZdDeajSOup78J7EqDzSYteUdBFXW0ynaNfpuEtgRhwGCSQpqhMjwOqdit2eyqiU3d5sVw/wkzVyazEcaRT8LJ0yKgqBSB4qoQarqIkdTgtKjxvHJ2Atb9/gW4VqXoscXMX9pvXaehgFPcbrMkXDHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7dsn3k9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7dsn3k9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384C6C2BCAF;
	Sun, 19 Apr 2026 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776601020;
	bh=08IbGrUdY2jbuq0187mla2/22LiSOCmA0BrBjGZkm1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X7dsn3k9U+Q/+Ew1qJ2pnyzm8lSbobgDiylt9Hy606AmxiOKG2zDLNcTHk1odEDLs
	 g0EowI/T5OYWPfz/Fp83YJwWCiMiJIVcr+HZQ5SPh1Hhh7XwZsAa9Rw4BK8xFr0bXU
	 PTeu/YWH+nYpVWZbhi9oqm4aomG05e+z1KPxP9lLCjHONvNnxdCylol0rALHgrauxW
	 sRbus3E7ceHbD9ZLQndgETGTOTmgSV0fzbfuAaZYNGqbFDEwRQHZfHC+2w3xsbDcgS
	 zs9BmjodkMhRyQcPpFao/jNZUcJ6knpZ67YDaZMULwCxtEzdrzkZV0drKeWJQw/AAS
	 iIlHeQBMPjdiw==
Date: Sun, 19 Apr 2026 13:16:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 andriy.shevchenko@intel.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: dac: m62332: Clean up header includes
Message-ID: <20260419131653.7955c2d4@jic23-huawei>
In-Reply-To: <20260418130322.106769-2-erick.henrique.rodrigues@usp.br>
References: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
	<20260418130322.106769-1-erick.henrique.rodrigues@usp.br>
	<20260418130322.106769-2-erick.henrique.rodrigues@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2026 10:03:21 -0300
Erick Henrique <erick.henrique.rodrigues@usp.br> wrote:

> Follow IWYU principle: explicitly include headers for symbols used
> in this file, remove unused slab.h, and sort alphabetically.
> 
> This prepares the driver for adding new functionality that requires
> additional headers.
> 
> Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
Hi Erick,

A few comments inline.

Thanks!

Jonathan

> ---
>  drivers/iio/dac/m62332.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
> index 3497513854d7..4b139904e818 100644
> --- a/drivers/iio/dac/m62332.c
> +++ b/drivers/iio/dac/m62332.c
> @@ -8,13 +8,18 @@
>   *  Copyright (C) 2010, 2011 Roland Stigge <stigge@antcom.de>
>   */
>  
> -#include <linux/module.h>
> -#include <linux/slab.h>
> -#include <linux/i2c.h>

Resorting and new includes in one go does make it harder to see what
is done. Generally I'd prefer that as two patches when we have more than 
a very small number of includes. Sort first, then add / remove headers
as needed.

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/device.h>
This is one of the more complex corners of applying IWYU to kernel code.
device.h is a bit of a legacy 'catch all' and much like kernel.h the
general direction of travel is to include more specific headers instead.

You probably need a forwards definition of
struct device;
just after the includes however as the pointer type is used.
I'm not immediately spotting any other use of device.h rather various
more specific headers but I might be missing it.

>  #include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>

I'd expect to see
mod_devicetable.h in pretty much any IIO driver as that's where the ID
tables are coming from.

> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/types.h>
>  
> -#include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
> +#include <linux/iio/iio.h>
>  
>  #include <linux/regulator/consumer.h>
>  

