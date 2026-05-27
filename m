Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591C3F166A;
	Wed, 27 May 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877309; cv=none; b=tk5XJN0ONh0JACiANfGVa+0ELi8cLFMSARdxNVmzTHopzfEFyBh/GaRZYW1/xgzneISB3yPZkeLRQj5Ybl9gHtDyWjjDVVSPh3gelWks4IvsudC1BQUt5RgCO8BIr8/Wf5Ywdy7Us/b4/0Q9W89hN07DnhgztgkecJXgA1krUzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877309; c=relaxed/simple;
	bh=BhDR7SJ+lj3ODZpUvhT1i3JA2ie6YMns7Ca+jIz0Ju0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zgnkj0hjqKi9Tu62Ac1wFLcOihRseAWzZOsOKwfmr6srltoAvI8LSrmkQvPAr6+BA3Eymd1bzit0Y8wUTUYbJVguiGdQE9FFu3cya5SmNKnTItQM0qu4e8AuBTVwoXkeQmCdGfB4thqN1wNTW9yTiH7VZ7btVqMJ6jvyJCerxVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZLaeWhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZLaeWhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECB41F00A3D;
	Wed, 27 May 2026 10:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779877307;
	bh=Tym42R3q2Tu3zoLk3HIT6CzcOVE7L9gdH258Q+zda70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bZLaeWhKnx4pmmficSbd4UqWnPBhOwqQowoWlXOjujqPvHVF9GoY/lxshY9Ezi9wO
	 eqZ9D8VhoHR426mAQcBfRH1dzX4W7RvDgtyNo4lcxirSCev02cxNhfktt/MvgOhPfk
	 vftGKTqKCzggzleEiUzgScndM+dDk2zuXnMecKmNNVHhpcRMbpdBWA6jqau2Abc6oY
	 q/kI2L2fv8cVk/ws4yCRjslRp6Op3R1wLAKOUU2yRGA1Cn34sGZV1akZqfgvX6r1gL
	 cKkjHtqAw74+0Mbkh5e26zp1Huhww8A6HtbCTTZIk5zmdDu5yvr7ftXTqBcuREtjch
	 I37dlrTr4KQfg==
Date: Wed, 27 May 2026 11:21:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 ~lkcamp/patches@lists.sr.ht, linux-kernel-mentees@lists.linux.dev,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: spear_adc: align headers with IWYU
 principle
Message-ID: <20260527112139.18f285fe@jic23-huawei>
In-Reply-To: <20260527014058.35265-3-rodrigo.gobbi.7@gmail.com>
References: <20260527014058.35265-1-rodrigo.gobbi.7@gmail.com>
	<20260527014058.35265-3-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 22:36:40 -0300
Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:

> Remove unused includes and add what is being used:
> 
> #include <linux/array_size.h> // for ARRAY_SIZE
> #include <linux/bits.h>  // for GENMASKxx
> #include <linux/dev_printk.h> // for dev_err_probe, dev_info
> #include <linux/math.h>  // for DIV_ROUND_UP
> #include <linux/mutex.h> // for struct mutex
> #include <linux/types.h> // for uXX definitions
> #include <linux/iio/types.h> // for IIO_CHAN_INFO_*
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
>  drivers/iio/adc/spear_adc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index efde6afc54fd..4be722406bb5 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -5,22 +5,25 @@
>   * Copyright 2012 Stefan Roese <sr@denx.de>
>   */
>  
> +#include <linux/array_size.h>
>  #include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> -#include <linux/device.h>
> +#include <linux/dev_printk.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> -#include <linux/kernel.h>
> +#include <linux/math.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> -#include <linux/slab.h>
> +#include <linux/types.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> +#include <linux/iio/types.h>

This one is in my 'maybe' list.  I'm fairly confident that
the main iio.h header will always include it. However that's
not necessarily obvious so I don't much mind including here anyway.

Anyhow, series applied to the testing branch of iio.git

Thanks,

Jonathan



>  
>  /* SPEAR registers definitions */
>  #define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)

