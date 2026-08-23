Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439E2ECD1D;
	Sun, 23 Aug 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507545; cv=none; b=lk5QNHCW00v27vP37PjVWScKBRgh1CdzBvX/mAhgFHhjwBF9t/MxzZprZSQCwrKBjPnH+7rE5z/eZ1AW/fvGFSXNhVHIKg6aocvxhnAM1517ybZZaTlDb1d4Qv0XKgfAbXIpH0RwUMzZhmsPhomo5tDs7xoav8s5eHUPN7A9PqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507545; c=relaxed/simple;
	bh=8ePEbfMyH94vZUFnPsXEYu5MLGr8v5ZWKGDo3cYtKn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Syh0H0et4ZhiHdohYxKaSyB6AOv+FvC0vXbT8PPUtUy6k9Wgz9wk7djo9Rn6cAVoS5Qsb3YJUGzcYZ2uShnY85YHWiUcEjcgdXt+9GbU33bo+fJZyLXacuOszQTOgdJyJYnVeP2iETHnM2k30uJ2SXggVcKzwHU16dQEGzRP4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/KCWQOJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/KCWQOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5AD1F000E9;
	Sun, 23 Aug 2026 17:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787507544;
	bh=Y7vOJJ/7XLfOaeOnNRUeNZh7pUoIF1NQ5ncFg+H30L0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G/KCWQOJAzw0lNqjt78eyZsJmX+DJLxXdzr9yxt4Kp2hymuds6PSn6ZxFMNORyTMn
	 lNOKzcXevgJBV4gbqVdi1p76eNGKnpPlsOHCLtnie6RN/HtebPERTDDchUDBvQq4dh
	 tZmlTrM7N2pgrNqdBW7VrbHmaTfpVFvf4UxfdfcasiJL7fQQ6If3SKPOvX8c5g2294
	 6Wcp669T4XTQ3j28b7aHNzcKm6KmnAAL+cUc/AnTfBgM8Pq2KQuOl13zuvZk+1UN1s
	 0WsI4V6PoaGURP0XKxA9sxff5KgJnrjbNh4ixxLWo8rPLC1KPVzmdtXqXMntiTq1+I
	 3qUyglW5pZ1oQ==
Date: Sun, 23 Aug 2026 18:52:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Crt Mori
 <cmo@melexis.com>, Puranjay Mohan <puranjay@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] iio: temperature: ltc2983: make headers conform
 to IWYU
Message-ID: <20260823185219.222c7990@jic23-huawei>
In-Reply-To: <20260822-kernel-header-removal-v1-4-ee31b124be11@gmail.com>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
	<20260822-kernel-header-removal-v1-4-ee31b124be11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 10:02:31 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Remove the catch-all kernel.h header and add the missing headers to
> enforce IWYU.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> Header changes explained:
> Added:
> - <asm/div64.h>: for div64 functions
> - <linux/array_size.h>: for ARRAY_SIZE()
> - <linux/bits.h>: for GENMASK() and BIT() macros
> - <linux/mutex.h>: for struct mutex and mutex_lock/unlock
> - <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
> Removed:
> - <linux/errno.h>: not directly used in this driver
> - <linux/kernel.h>: catch-all header no longer needed
> ---
>  drivers/iio/temperature/ltc2983.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index fe9eec3058d4..0b1b442bb133 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -5,22 +5,26 @@
>   *
>   * Copyright 2019 Analog Devices Inc.
>   */
> +
> +#include <linux/array_size.h>
>  #include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/completion.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> -#include <linux/errno.h>
> -#include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> +#include <linux/types.h>
>  #include <linux/unaligned.h>
>  
>  #include <asm/byteorder.h>
> +#include <asm/div64.h>

I think we normally use linux/math64.h for that one.


>  
>  #include <linux/iio/iio.h>
>  
> 

