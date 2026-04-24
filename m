Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331617083C;
	Fri, 24 Apr 2026 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053489; cv=none; b=boZHtvk+HGF5rrcHdMfTcwYIx2hO29QyGgC5kgfZOmzYdPZGVzUtdBB/uCQtAWQsO7isx80Q6IxiofxW0Vrz71dERNuHAOaLaHO2kuk6I1b/a2U6hxnm29WQpJUHzhwxGSGk2Dvns1U1BYJWUQ4tBcJ3WpwSAmeuAiIQk0ENnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053489; c=relaxed/simple;
	bh=nStQfeo8dnY2YYExXK6CtFw+Y2+8/slo/8Dtz7AMQrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8jPG2Xxu9sT+Dgq109TdyyTgYv7qdwarihJ7o1GF7mOwYUDMcXiRFEMWfadFqvU6tjCpgYo0xn4sqqZgYhlLwtyEk6yjqTswsYlvjCjIkI5r4pmqPObAenYnbThtyhVbrA85vBn+irtxwQ211gmcK11fuc54t/GEkqLyJJ11G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tilBaqTt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tilBaqTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C87C19425;
	Fri, 24 Apr 2026 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777053488;
	bh=nStQfeo8dnY2YYExXK6CtFw+Y2+8/slo/8Dtz7AMQrw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tilBaqTtzA6pAQ+blFGM35Y4gItUauBzCzTX54WD8yumaTSzDPxi+m903sUAtsdKD
	 nJopcZXkU2qPuaLlZ21oLb9D0qCAwwrCAlaxqfYRVYfhJgRajGrYfPX8gEDfSKtMYY
	 AVDHp9LJQBvo5m+upfzs8uF5lZ4mjlPC/z2vqsUhD3uF+XD+OOxVMPcSbzsaYPulHb
	 B2tNSMR2BcvBkqADlOSboCXRBEL4cCuqp0N2n89PILituZxUuodi+kxd11EDKkCYmV
	 qNiSX2KGQfo4mhc1pKHYFSkkCb+0Ku/7xm4glE88UgM8yrhApdQpMctOihsOK8vwqr
	 arDcpvAdcICfA==
Date: Fri, 24 Apr 2026 18:58:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: magnetometer: ak8975: remove unused headers
Message-ID: <20260424185800.6038af06@jic23-huawei>
In-Reply-To: <20260422112207.1313-3-joshua.crofts1@gmail.com>
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
	<20260422112207.1313-3-joshua.crofts1@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 11:22:03 +0000
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Remove kernel.h proxy header and unused headers (slab.h, iio/sysfs.h,
> iio/trigger.h). Add missing headers to ensure atomicity (array_size.h,
> dev_printk.h, asm/byteorder.h, irqreturn.h, minmax.h, property.h,
> types.h, wait.h).
Patch title should not focus on just removing headers. Maybe
"update header to reflect what is actually used"

Otherwise LGTM
> 
> Audited using the include-what-you-use tool.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 569cd6fa839..2c2ed2063f8 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -7,24 +7,29 @@
>   * Copyright (c) 2010, NVIDIA Corporation.
>   */
>  
> +#include <linux/array_size.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/dev_printk.h>
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> -#include <linux/kernel.h>
> +#include <linux/irqreturn.h>
> +#include <linux/minmax.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +
> +#include <asm/byteorder.h>
>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  

