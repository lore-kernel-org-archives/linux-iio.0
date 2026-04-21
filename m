Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AC030E84B;
	Tue, 21 Apr 2026 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767765; cv=none; b=qBTurbrMJBMfE21IR0iPQ0vM0MCOPFf6xS5Wnm8MnY7pGiBb4YJXfoShgfv8FgfcyFrINsYbIBy+xdIY1PJf/RX09APUZ+MZw7cQL29qldH2D+Sf8ANKKweLY5uEj6WnWwZcsBjOKxMhxe5rhx09j7nmikkNNk8ivDXZITEaepM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767765; c=relaxed/simple;
	bh=cfOpk1LNYhTpD4PHqefrcej2+Zv4TWNtFflyHivTmrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT4rpQU/aHtE3kE0M/vNmTUeD9vpwsFIXcmSutCAai4R5y2M9Pv5m0MR+WdSmqt9hSEEN9rEKNxicJuo7Xv7QaGqIR9EaNIImp2a971liphAnqve4K0zxB8gDyrP0/nS9HIOuf8Jrj5lqVIjlUgcvPuLag99ieU5T4yvF4U1h4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFcAhw6r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFcAhw6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7D5C2BCB0;
	Tue, 21 Apr 2026 10:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776767765;
	bh=cfOpk1LNYhTpD4PHqefrcej2+Zv4TWNtFflyHivTmrw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NFcAhw6rlpM4fyLKPMWzrao5RG7cXX+AZTrZiRVHeBHzV0H4sG/Cgpl2uVvWQinBR
	 W9BV7jTOfPwt2CZtyrO/Iff3NZCOFh2oDx5yzKztBRslvMFPW5onjdljXVvIv9OUKS
	 FAj46wyESiy0oImFC/BTTSpbMDx0Fe9Ck4mCcTKdTQLbaddpI3G11yQ3NT21i3cOet
	 oRGVjrpbVeaAGVWzeYtZYMAgAB/Nm+RK5J3hf822RYo42eDyJJ6GqPhnp6DbAUow3s
	 1R7FRhiEV5zTQgPr5A4SdC4GnLwyanAXkR/nI9KH57TXmdYxvFAforzhwwVS7kiXGP
	 3sVyderOAUaUQ==
Date: Tue, 21 Apr 2026 11:35:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: magnetometer: ak8975: header cleanup
Message-ID: <20260421113557.49d12cb9@jic23-huawei>
In-Reply-To: <20260421100722.1296-2-joshua.crofts1@gmail.com>
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
	<20260421100722.1296-2-joshua.crofts1@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 10:07:19 +0000
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Clean up headers by removing proxy kernel.h header and adding new
> headers to ensure atomicity (array_size.h, dev_printk.h, types.h,
> asm/byteorder.h). Removed unused headers (slab.h, iio/sysfs.h,
> iio/trigger.h) and added minmax.h, property.h, wait.h, irqreturn.h to
> mitigate transient dependencies during compilation.
> 
> Audited using the include-what-you-use tool.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
I just saw your reply to v1 thread.  General advice would be slow down a bit.
Even if you have reviews, a new patch set should sit for at least a few days
to gather multiple reviews before a revision.

For this sort of change I'd expect two patches.
1. Sort headers as is, not changes.
2. Add and remove headers.

Both are good to do, but if you do them together as you had in v1
it is annoyingly hard to review.

> ---
>  drivers/iio/magnetometer/ak8975.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 44782c26698..a829bee4cf8 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -9,8 +9,6 @@
>  
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/err.h>
> @@ -20,11 +18,19 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/array_size.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/irqreturn.h>
> +#include <linux/minmax.h>
> +#include <linux/property.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
Even if you don't sort, these should be inserted as near
as possible to where they'd end up in a sorted list.

> +
> +#include <asm/byteorder.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  

