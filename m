Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48725B09D;
	Sun, 21 Jun 2026 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782064524; cv=none; b=gUADGVqYsvm7L+0TsDa9QLqFYZNvUBnqzUp27YnOcPxnQf7SGpdcpHGL+GfDiddoWBQSZRf5eTnjE6t4EBPtzuGMExwC5vVwBSgAB6DECrQ28yGDgt3t9BivcTMIXBWmVDakEoaPBn1KqAC9Sl7tjeAGY01PeDfXunT6HX+bkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782064524; c=relaxed/simple;
	bh=R1p2i8T9fobYfjLn7MNjOtxU0/UI3jiT9j+0RhsmSVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtXrF86AQeMrF4bUE7hdkaKcUpC6uybr1LtbA6vZqUzSunx+IFRTFGwbF4AxXFg/9bV/ZY8aq+V+7mlcMFhIYOqhGIM2VeAvUcA4KAV2RY4yoCR2WYrqijgbTDiAlnJy/b+yhw/EjclJ0qm7DSLrGEz6eIThXgiAP1rggpz7pZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd83tb9S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd83tb9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE371F000E9;
	Sun, 21 Jun 2026 17:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782064522;
	bh=Fb4dUOiJ7SqvjrfHPS2Y/yRW1Y80P2NCg22R8V4I7Xw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vd83tb9SgcT2wKO7F7wSpSFY0lJ8lCezZq+rOba+8o8hyndLDN5M/uW8ZcUvQ5nU6
	 HLM0diQ01J1g6fypnMwXfY/MIHSt6VMyBaF+AXwBSE42O8yc3WfbHcMI00RYWlgv94
	 O574IUSXPxMoR3CSbLHynlXQH2nS4+9QTCGYUcTGk3X5Z/XMgLgYy5dXXSDRFsPvv0
	 tDg5zs8kQkCwyMd0MtILPE/pOrc153GhhVz/e0zmayOFgvEht72EelzlCCyM2HmH8U
	 bw+Zrc13LrP80NScHa+NPO1nUVmk9nI9Z2wlUjHvtdMmRvdhNF7QkewSaDnK70BXYr
	 suYBETGABJmfg==
Date: Sun, 21 Jun 2026 18:55:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: hexlabsecurity@proton.me, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: accel: bmc150: clamp the device-reported FIFO
 frame count
Message-ID: <20260621185517.5893e494@jic23-huawei>
In-Reply-To: <20260616-b4-disp-9546bfb4-v3-1-5acc59a06636@proton.me>
References: <20260616-b4-disp-9546bfb4-v3-1-5acc59a06636@proton.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 20:56:51 -0500
Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org> wrote:

> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> __bmc150_accel_fifo_flush() transfers the frame count the device reports
> in FIFO_STATUS into an on-stack buffer sized for BMC150_ACCEL_FIFO_LENGTH
> (32) samples, but the count is masked to 7 bits (0..127) and the optional
> caller budget does not bound the flush-all path. A device, or an attacker
> on the I2C/SPI bus, reporting up to 127 frames overflows the buffer by up
> to 570 bytes: a stack out-of-bounds write.
> 
> Clamp the count to BMC150_ACCEL_FIFO_LENGTH before the transfer, mirroring
> the clamp already applied in bmc150_accel_set_watermark(). Conforming
> hardware reports at most that many frames and is unaffected.
> 
> Fixes: 3bbec9773389 ("iio: bmc150_accel: add support for hardware fifo")
I thought we had an earlier discussion about this. However that
may well have been in a thread related to a similar patch from someone else!

As far as I'm concerned this is nice to have hardening of a driver
against buggy devices, not a fix that triggers all sorts of potential
processes.  So applied but to the testing branch of iio.git with this
and the stable tag dropped.  I don't see this as appropriate to backport
unless we have had reports of it occurring on real hardware for some
reason.

> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> v3 (Andy [2], [3]): shrink the commit message and move the register/byte
> detail below the cut; fold the caller budget and the clamp into min3()/min()
> per Andy [3] (no functional change; make W=1 clean).
> v2 (Jonathan [1]): clamp with min() instead of min_t(u8, ...).
> 
> [1] https://lore.kernel.org/all/20260614141146.697dde04@jic23-huawei/
> [2] https://lore.kernel.org/all/ajEMUChqvxGzSLl_@ashevche-desk.local/
> [3] https://lore.kernel.org/all/ajELw0x5DiyMuFYZ@ashevche-desk.local/
> v1: https://lore.kernel.org/all/20260613-b4-disp-24d6b15f-v1-1-f5c3fe7294fc@proton.me/
> v2: https://lore.kernel.org/all/20260615-b4-disp-ef4f7a59-v2-1-af5e980bcdd7@proton.me/
> 
> count = val & 0x7F is 0..127; the only other limit is the optional caller
> budget, which does not constrain the flush-all path (samples == 0).
> bmc150_accel_fifo_transfer() reads count * 6 bytes, so a count of up to 127
> writes up to 762 bytes into the 192-byte buffer (up to 570 past its end),
> clobbering the stack canary, saved registers and the return address.
> 
> Reachable on every FIFO flush (watermark IRQ or the sysfs buffer-disable
> path). Verified with an in-kernel KASAN litmus (CONFIG_KASAN_STACK=y) and a
> userspace ASan model on x86_64 and i386: without the clamp a device
> reporting 127 frames drives the transfer past the 192-byte buffer (stack
> out-of-bounds write, both ABIs); with the clamp it is bounded to 32.
> Reproducer and full logs available on request.
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 2398eb7e12cd..ecaa4782d847 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -988,8 +988,10 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>  	do_div(sample_period, count);
>  	tstamp = data->timestamp - (count - 1) * sample_period;
>  
> -	if (samples && count > samples)
> -		count = samples;
> +	if (samples)
> +		count = min3(count, samples, BMC150_ACCEL_FIFO_LENGTH);
> +	else
> +		count = min(count, BMC150_ACCEL_FIFO_LENGTH);
>  
>  	ret = bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
>  	if (ret)
> 
> ---
> base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
> change-id: 20260616-b4-disp-9546bfb4-a26c55f33efc
> 
> Best regards,

