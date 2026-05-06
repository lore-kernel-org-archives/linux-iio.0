Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6B2E2286;
	Wed,  6 May 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082682; cv=none; b=tHm1zjTzufjCR/3ZgCO/VU86npQSe3rXL8CiKwmEwZ2FH4pgCatFFon92inKRu+SAYUETDTa/m5GMF6HIA1t3Wwf2PJcoREuZGA/PkbU7uaCfE+/m0zUJHEU0VFdfhjOZcSMe7mpZIzKWSQD5QES6JFWCPCGiuBBWeQZdCuWzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082682; c=relaxed/simple;
	bh=75aSId5PszDYrjNHLi2AdXxsU5A0sZq9jWBMLBfqK6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsEo3AFznoUpZTjZa/yemP0RXRHs1ozPLOn3EvCaDwC0t6I4JCK82PQvab3Nk/c8rg0mxeCcbtAtGZZltFaYHGxMS1OZI5rfrOp1QMphMLNOwa4zF2siYDT/0xiBxfJPRU8afTip4frsWQgHh0Uxa3bUxgsnV9lLdfuv5FzAJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia5DiQDn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia5DiQDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8644CC2BCB0;
	Wed,  6 May 2026 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778082681;
	bh=75aSId5PszDYrjNHLi2AdXxsU5A0sZq9jWBMLBfqK6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ia5DiQDn0TWi9nXzq+V4BFoPt0g7X7307mPicIlIj4+iXuKOASbU1iiywRt8Qs89C
	 td5GTUtO/NvELJQE+X8dx2MMyxSblkunNRkgltEYl6LkcrB4eYOO2ByE88imaF2v4P
	 2UxiKcrDUevOEej+221AlAqz/kCHlWlqjtYuHGzGSWbZ8IhevlowM4CfdfELC3BANC
	 IWXYwtUXABMoP/ef7VY6KG4221T6jb2WpxXY1MG/wkefHdPgvHStJeczCvFh2UtwT6
	 PdrfmEj4nAbhBahJi8hTTVuzcuQ8tXOggbkqpO665Fm4WHdCdxdoLihBjemSGpD3Wa
	 lL1FgyB1YdvQA==
Date: Wed, 6 May 2026 16:51:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: salih.erim@amd.com, conall.ogriofa@amd.com, michal.simek@amd.com, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org (open list:XILINX AMS DRIVER),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ
 ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] iio: adc: xilinx-ams: Replace spin_lock() and unlock()
 calls with guard(spinlock*)()
Message-ID: <20260506165112.4425c378@jic23-huawei>
In-Reply-To: <20260504214613.121283-1-m32285159@gmail.com>
References: <20260504214613.121283-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 May 2026 16:46:12 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Include linux/cleanup.h to take advantage of RAII macros.
> 
> Replace spin_lock() and unlock() calls with their RAII macro
> counterparts. This will help modernize the code and increase readability.
> 
> Remove "flags" variables where spin_lock_irqsave() has been replaced
> with guard(spinlock_irqsave)()
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>

Hi Maxwell

One thing inline.

Thanks,

Jonathan

>  static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
> @@ -1060,9 +1058,8 @@ static void ams_unmask_worker(struct work_struct *work)
>  {
>  	struct ams *ams = container_of(work, struct ams, ams_unmask_work.work);
>  
> -	spin_lock_irq(&ams->intr_lock);
> +	guard(spinlock_irq)(&ams->intr_lock);

This increases the scope to include scheduling delayed work. Seems unwise
in general and should definitely be mentioned in the commit message.
Use a scoped_guard() here probably or leave it alone. 

>  	ams_unmask(ams);
> -	spin_unlock_irq(&ams->intr_lock);
>  
>  	/* If still pending some alarm re-trigger the timer */
>  	if (ams->current_masked_alarm)


