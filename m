Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B5282F39
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776766768; cv=none; b=JnR5ZLENY7okHFNER0zH3d+W6AT2Q8gR0YgWKDcSpBH1cTsmKtR67TCemwmw6OIfNuiAqLknuo8yq0/6M/goRjYCAPvjzNsTKPvp6bmsCG+gf+gRek/l1C4BLiM7eRnvNwoRWVGJE7QwlqtRUcXpnex6Ign3uAk17X0Sryyl7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776766768; c=relaxed/simple;
	bh=pdGypf6YcCZLIWNN0kgNCUMdreWvH9RJ4w4ScHAAhTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inTtpYeyhDl828YR06jDHRXRQnWFjOmCFRRy6L9r5wAaah+ZtvHtmORZ2PKIK3fhiz8Vat2pjWXygm58REAhQEnShTDnLoIQn5g04ZAqJOkbjj2fKJ5COwEJqzaWMkbn4wk0j81RsrFO1cb4fitITYl2FKsrGjxHCMUqdDZjG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjbHnmkh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjbHnmkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AD3C2BCB0;
	Tue, 21 Apr 2026 10:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776766768;
	bh=pdGypf6YcCZLIWNN0kgNCUMdreWvH9RJ4w4ScHAAhTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CjbHnmkh2vZ3fHBuDfRVYO/st1Jn9GwSl4s6mDWHdzYP17qRpRn7vtZqgUwNe96D6
	 S2MlCRNK+hMQuPtHVSjiNz7u3UJ83Fr65HaGTKQctz7l4jpJf3SXFN9jH9sQqVX9Z4
	 FK75HnNwClT5AGmeFDr+rdFb0eKGhU5K9/bmr+Mwx10BiBlG7CDQkb4F0naIMf61kb
	 ouYoeIVloNpoeIrZ5pU4f2gp0oqwhsmvrrYfzMAPpx8pag1NrCon89Jj128nOcgWnf
	 hG6OW6/jdhyLYYViu7yZTx8wX4HUzAFxe7ke1K+i0PdG/lfDz5l0qTOavROoYl14j0
	 cUs0EBkeWVV5A==
Date: Tue, 21 Apr 2026 11:19:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: rafasales@usp.br
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, "Gustavo C.
 Arakaki" <gustavo.arakaki@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: light: ltr501: update header inclusions
Message-ID: <20260421111919.5ad809fb@jic23-huawei>
In-Reply-To: <20260421021023.563290-2-rafasales@usp.br>
References: <20260421021023.563290-1-rafasales@usp.br>
	<20260421021023.563290-2-rafasales@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 23:10:00 -0300
rafasales@usp.br wrote:

> From: "Rafael B. Sales" <rafasales@usp.br>
> 
> Update header inclusions to follow IWYU (Include What You Use)
> principle
> 
> Signed-off-by: Rafael B. Sales <rafasales@usp.br>
> Co-developed-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
> Signed-off-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
Hi,

One of the issues with the kernel view of IWYU is it's a bit fuzzy
(and not well documented yet).
That means there are some headers we assume will always include
certain others. So if you need the 'outer' header the inner one
is not normally included as well.

So the comments below are very much my opinion on what should
and should not be there.  Others may have different views and
it is always a little flexible for some of them.

> ---
>  drivers/iio/light/ltr501.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 4d99ae336f61..75a49fd9bce0 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -9,20 +9,38 @@
>   * TODO: IR LED characteristics
>   */
>  
> -#include <linux/module.h>
> -#include <linux/mod_devicetable.h>
> -#include <linux/i2c.h>
> -#include <linux/err.h>
> +#include <asm/page.h>
asm headers if they are needed are always in a separate block
after all the linux/ ones

However, it is very rare to see asm/page.h in a driver. Why do
you need it here? 

I'm going to guess it is for PAGE_SIZE?

That bit of code needs a rework to use sysfs_emit_at()
instead. If you have time please could you make that change as well
as a precursor to this patch and then we won't need this one.

Alternative would be to convert to using read_avail().
That would be even better but is a more complex change.

> +#include <linux/array_size.h>
> +#include <linux/bitops.h>
I think it is always safe to assume bitops.h will include bits.h

> +#include <linux/bits.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/cleanup.h>

Is this used at this point?  I think this might want to be in the following patch.

>  #include <linux/delay.h>
> -#include <linux/regmap.h>
> -#include <linux/regulator/consumer.h>

> -
> -#include <linux/iio/iio.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>

It's a bit indirect but I think we can always assume err.h will include
errno.h

> +#include <linux/i2c.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/types.h>
Common practice (as this driver was previously doing) is to keep the
iio headers in a separate block at the end.  I don't tend to enforce this
but given the driver was already doing so, I think keeping it that way makes sense.

> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>

interrupt.h will always include irqreturn.h so don't need
irqreturn.h

> +#include <linux/math.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sprintf.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
>  
>  #define LTR501_ALS_CONTR 0x80 /* ALS operation mode, SW reset */
>  #define LTR501_PS_CONTR 0x81 /* PS operation mode */

