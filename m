Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA31E9906;
	Sun, 14 Jun 2026 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781444627; cv=none; b=DO7SyyBaO3SbHjlGbseJ/cuU93EIOn3rejIJAuRmEmkHVx3CcVGYHWO8L9s6NKeCBWq6mCn+AuxNO5QRB3uYEOx+GdxRKvEjjviAuW3wC3Ch7LoKcVMKB2WHWpMsof5E2Hh37Ie797+nrgPHi9CjHjl458dgXeOprUc7+jonoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781444627; c=relaxed/simple;
	bh=1CZk57uWiTNkvoe9qoZCkq9HwRvWgXl5T03N4WMUFes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R771IEl+y7Kvoy3jW/YHk5ipV3Y2hNCBDZyGRuKpcvv6Va+AnlPc1+clu9CXhO2/zrn/+/4T/NsOuIzIof+Ck3h4xfG0MYxa3czH+upiJ3rcJYv4lsuOf9dTVuNeBRBhgEH45x0A/rgZ2dDk2BsC45mogNpqVjOjmrmwKJQzeYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJl00PWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJl00PWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BB81F000E9;
	Sun, 14 Jun 2026 13:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781444625;
	bh=XqOvS20kQQt1NLy1h7pBComeb+T88c1sfGmRi4KqfUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kJl00PWAF5qB4RB7I+je9Ud376P7Q6lPjaruw4u8MLVp9TSYT+5ABL4OGe9QAuRCF
	 08wGnoOaT52O5ZGCqOv2PmjG6v9ElMq0pmImqHDYGExZgt0DNsAvM3KTqVKmAirsqF
	 pOn5cDsO0TaXk5LAW+rA2WtfQo0cgbtXfmYum1RdIV8YE7kMjCLIKYpTz/D/fqxOQh
	 MNf7EoAzu6Qz0zWGtjbOhke4Cws6cWk3IxoYuzaelzQThBc0+bjzwcAlh7JaPhA9MA
	 /aqggyJy0Cr1S7mQgiB/49FlLTqIc3dWiRIt8mNviQGHV7B6grDhUZJz2F7RTXxL9x
	 A4awaeA0BXG+w==
Date: Sun, 14 Jun 2026 14:43:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: hexlabsecurity@proton.me, linux-iio@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Sean Nyekjaer <sean@geanix.com>, linux-kernel@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: clamp the device-reported FIFO
 sample count
Message-ID: <20260614144337.3b3dab1a@jic23-huawei>
In-Reply-To: <20260613-b4-disp-22362900-v1-1-c5e49f6af027@proton.me>
References: <20260613-b4-disp-22362900-v1-1-c5e49f6af027@proton.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 03:13:19 -0500
Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org> wrote:

> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> fxls8962af_fifo_flush() copies the number of samples the device reports
> in its hardware FIFO into an on-stack buffer
> 
> 	u16 buffer[FXLS8962AF_FIFO_LENGTH * 3];
> 
> which is sized for at most FXLS8962AF_FIFO_LENGTH (32) samples. The count
> is read from the BUF_STATUS register and masked with a 6-bit field:
> 
> 	count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;
> 
> where FXLS8962AF_BUF_STATUS_BUF_CNT is GENMASK(5, 0), so count can be
> 0..63 - nearly double the 32-deep FIFO the buffer is sized for. The only
> check applied to it is the zero test; unlike the bmc150 flush there is no
> caller-supplied bound at all. count samples are then transferred into
> buffer[]:
> 
> 	fxls8962af_fifo_transfer(data, buffer, count);
> 
> fxls8962af_fifo_transfer() reads count * 3 * sizeof(u16) = count * 6
> bytes through regmap, so a malfunctioning, malicious or counterfeit
> accelerometer (or an attacker tampering with the I2C/SPI bus) that
> reports a count of 33..63 writes up to 63 * 6 = 378 bytes into the
> 192-byte buffer: a stack out-of-bounds write of up to 186 bytes that
> clobbers the stack canary, saved registers and the return address.
> 
> Clamp count to FXLS8962AF_FIFO_LENGTH, the number of samples buffer[] is
> sized for, before the transfer, mirroring the watermark clamp already
> done in fxls8962af_set_watermark(). A well-formed flush reports at most
> FXLS8962AF_FIFO_LENGTH samples, so legitimate devices are unaffected.
> 
> Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")

This is hardening against broken devices. Nice to have, but not a fix and
not back port material. In general we do harden against the simple cases
but to catch the more complex interactions would require both a hard to do
audit and significant extra code.

So nice to have this but not a fix.

One comment inline.

> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> This is a different bug from CVE-2025-38485, the use-after-free in the same
> function fixed by commit 1fe16dc1a2f5 ("iio: accel: fxls8962af: Fix use after
> free in fxls8962af_fifo_flush"): that commit added a synchronize_irq() in
> fxls8962af_buffer_predisable and did not bound the FIFO sample count, so this
> stack overflow is still present at mainline HEAD.
> 
> I reproduced the out-of-bounds write with an in-kernel test that drives
> the fxls8962af_fifo_flush() buffer geometry verbatim under KASAN
> (CONFIG_KASAN_STACK=y), with the device-supplied sample count:
> 
>   count=36, no clamp:
>     BUG: KASAN: stack-out-of-bounds in ...fifo_flush
>     Write of size 216 ... [32, 224) 'buffer'   (the 192-byte buffer)
>   with this patch (clamp to FXLS8962AF_FIFO_LENGTH): the transfer is
>     bounded to 32 samples, no KASAN report.
>   a well-formed (<= 32 sample) flush is unaffected, no KASAN report.
> 
> The full device range - count=63, a 378-byte write = 186 bytes past the
> buffer, smashing the stack canary and the return address - reproduces the
> same way under userspace AddressSanitizer on both -m32 and -m64.
> 
> The FIFO sample count is read over I2C/SPI from the accelerometer, so
> triggering this requires a malicious or defective device, or tampering
> on the bus.
> ---
>  drivers/iio/accel/fxls8962af-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 8763e91c63d2..fdd049223006 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -970,6 +970,8 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
>  	if (!count)
>  		return 0;
>  
> +	count = min_t(u8, count, FXLS8962AF_FIFO_LENGTH);
As in the other patch, why not min()?

> +
>  	data->old_timestamp = data->timestamp;
>  	data->timestamp = iio_get_time_ns(indio_dev);
>  
> 
> ---
> base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
> change-id: 20260613-b4-disp-22362900-f6014bd0594e
> 
> Best regards,

