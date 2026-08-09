Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AE125A321;
	Sun,  9 Aug 2026 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786319628; cv=none; b=S7UF4dbglIbcYZOxLEWgnlTdyRqY+ma+ISiwXYZVTm5BYebIBulK12ryxXt+cbkw1eLufUTrQaHdmYlNoYzTv011qAvTELslUGjsd18l5B+rK+Aps1UDuMNoBWm4N9tveOpwIs6VYk17eAJFSnhh+urgtHPr0tbt86vaW4PKvXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786319628; c=relaxed/simple;
	bh=XJnXglM9VAov07Q1LKJ/Dm0Qo5/2/vHqNqz+iQ5YEWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ku2Y0j262Cv3V5Hv7lzR+bbuwkvJQzJ2geE7ExPnViqvysTXioQmLvEug+0SBCCBpWay9I2ckHjWp1yQdg8V690TtyjPP2opWiGWFoHmCYt7Thk9mrDPGHGGGWT5gKgyCvRAdT5RMN5q3y6GQ3it7YUIh26m4MMjpogBnUr6wrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIrzE05B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIrzE05B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118D21F000E9;
	Sun,  9 Aug 2026 23:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786319626;
	bh=LyKqWc3Je9E24a7EMPHeRWMh9LhZWQy9z7WQ8ohgBP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OIrzE05BEt3Ct9Rg5a5BkKnq7SBevJ+PKyI+V4Hz3mG53qJsTxJKFL9mQhRi+pAEF
	 Uotza/p3Ub49/Nfb0qSs4LOsnSh5MR/vrWiL/i1FuDLFYJ0QXBH9TmLm9o58jx9zQC
	 9jXI0D1Zb7vmAOkZecCCCzaRVJqN7HrIxnZgZWqdfKstWNwsZGVXdiMbIkYb22wbSp
	 ejhynlLPbjHdAnLJBeCldJNuIrXahLmvNBn5HyNGVzmEGGiPQVlP3QAHKbZ0iIbfiF
	 KOPgaBo9tN0Tjb1/myNpzljuEnZArgZTHEZdTIih7D+ird9SOHuOGkO8pc8PeaW1Eb
	 GnXxyGnRJjrqQ==
Date: Mon, 10 Aug 2026 00:53:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marco Chen <marcochen.dev@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 pmeerw@pmeerw.net, matt@ranostay.sg, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v4] iio: health: max30102: fix NULL dereference in
 interrupt handler
Message-ID: <20260810005340.638d6b1b@jic23-huawei>
In-Reply-To: <20260808195450.25420-1-marcochen.dev@gmail.com>
References: <20260808195450.25420-1-marcochen.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Aug 2026 15:54:50 -0400
Marco Chen <marcochen.dev@gmail.com> wrote:

> The interrupt is requested in max30102_probe() and stays enabled
> for the lifetime of the device, but indio_dev->active_scan_mask is only
> valid while a buffer is enabled. When an interrupt arrives while no
> buffer is enabled, the handler dereferences the NULL active_scan_mask:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>   Call trace:
>    __bitmap_weight+0x64/0x98 (P)
>    max30102_interrupt_handler+0x48/0x160 [max30102]
> 
> Call max30102_fifo_count() at the top of the handler and return early
> unless it reports a FIFO sample is ready. Because FIFO_RDY is the only
> interrupt source enabled in max30102_chip_init(), an invocation of
> max30102_interrupt_handler() without the FIFO_RDY interrupt status bit
> set carries no data to read and can return before touching
> active_scan_mask. A negative return from max30102_fifo_count()
> indicates a failed interrupt status read and is treated the same way.
> 
> Fixes: 90579b69e94b ("iio: health: max30102: Add MAX30105 support")
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
Applied to the fixes-togreg branch of iio.git.

Note however that this has missed my last pull request for this cycle
so won't go anywhere until after rc1 which is in about 3 weeks time.

thanks,

Jonathan

> ---
> Changes in v4:
> - Trim the backtrace to only relevant frames and unwrap the first line
>   as suggested by Andy.
> 
> max30102_fifo_count() still has the odd name and int return you mentioned
> in v2, so I will send a follow-up patch once this lands.
> 
> Tested on a MAX30102 on Raspberry Pi 4 over I2C.
> 
> v1: https://lore.kernel.org/linux-iio/20260731184124.112124-1-marcochen.dev@gmail.com/
> v2: https://lore.kernel.org/linux-iio/20260804234355.65319-1-marcochen.dev@gmail.com/
> v3: https://lore.kernel.org/linux-iio/20260805040621.84843-1-marcochen.dev@gmail.com/
> 
>  drivers/iio/health/max30102.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index c37316c86f14..aee96167f01e 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -290,9 +290,15 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
>  	struct max30102_data *data = iio_priv(indio_dev);
> -	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
> -						  iio_get_masklength(indio_dev));
> -	int ret, cnt = 0;
> +	unsigned int measurements;
> +	int ret, cnt;
> +
> +	cnt = max30102_fifo_count(data);
> +	if (cnt <= 0)
> +		return IRQ_HANDLED;
> +
> +	measurements = bitmap_weight(indio_dev->active_scan_mask,
> +				     iio_get_masklength(indio_dev));
>  
>  	mutex_lock(&data->lock);
>  

