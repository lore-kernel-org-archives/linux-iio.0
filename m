Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767733254BB;
	Sun, 14 Jun 2026 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781444768; cv=none; b=iEtAnt91TTQNHCxvySeUuIMY98F6z75WI4+67tk5I2w6omx4nUm8z6gxZYUwMxW3u21LzaOJK9+3hJwOEnGijd+PdG8OfTYuTjglVAEd89AIN3aQ1OJXLWBc4iZPsJPkvwpPTUhav5hhUx3SuAc58ihwPZ1xbRpfEzttX1VhLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781444768; c=relaxed/simple;
	bh=CCz3/HWhXafUNdizzInn8loXGosyI/oqe0WHSJ/xQsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgrtX0bo7uQUPgLZMue/hTBLt2aXSn3ujaBlQ8sa/5RPQY4JPzwi6OktiqgoKicKzL9WVjqfH9wnxqDRfi46KxZ1SPNv0uJalWdNk3Rk7qajLsHkcMo/Iu8Z9XHBVfpG97GZxups/IEk6m1J87YnJJPTpy8m/BipLZ+ukPzcjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GICC2s7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GICC2s7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB581F000E9;
	Sun, 14 Jun 2026 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781444767;
	bh=bVqsWawdrS47Qg/2iPcKmJJOn1ah47LP9PNis2XNtSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GICC2s7wxGrn6W4mbGU/XI8xFsPFgbCXzwRVV459j+wFdyyduj9lPubp2W+cHqxPu
	 tAiZGmVKT3ylTyAOwlvZjm5f99+BYr3rbC1BsXfpjOCvfJXA80tODRA/rZJEVUvl4T
	 JvXE6IdmhUqNXu3gLMTfEXAHSE+LaKMcnHxHGjUO8YpCDJPqaBpmFp7NjtmYCftOj8
	 vbs0pYh1Sr0TDXAODnopz06TZxpSxidDloXCFgtL9oEndtPFug4VJ5wUkngsvaklDp
	 ujVMm7X7mQ1aUuLrAzgDqfhjquYQ4LbheQXT4EnGjw/DRSPaLaQPJg3JL++D+sCFui
	 ZDXxrJGyvR/RA==
Date: Sun, 14 Jun 2026 14:45:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: hexlabsecurity@proton.me, Remi Buisson <remi.buisson@tdk.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm45600: clamp the device-reported FIFO
 sample count
Message-ID: <20260614144557.196a5c4c@jic23-huawei>
In-Reply-To: <20260613-b4-disp-58b984f3-v1-1-352b2f925f58@proton.me>
References: <20260613-b4-disp-58b984f3-v1-1-352b2f925f58@proton.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 17:46:47 -0500
Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org> wrote:

> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> inv_icm45600_buffer_fifo_read() takes the number of samples to fetch from
> the device's FIFO_COUNT register and uses it, unclamped, as the length of a
> regmap_noinc_read() into the fixed 8 KiB st->fifo.data buffer:
> 
> 	fifo_nb = le16_to_cpup(raw_fifo_count);
> 	...
> 	if (max > 0 && fifo_nb > max)
> 		fifo_nb = max;
> 	st->fifo.count = fifo_nb * packet_size;
> 	regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
> 			  st->fifo.data, st->fifo.count);
> 
> The only bound on fifo_nb is "max", but the interrupt handler calls
> inv_icm45600_buffer_fifo_read(st, 0), so on that path the clamp is
> skipped. A malfunctioning or malicious device (a counterfeit or
> compromised IMU, or a bus interposer) can then report up to 65535 in
> FIFO_COUNT, making fifo_nb * packet_size (16 bytes per packet) as large
> as ~1 MiB and overflowing the 8 KiB st->fifo.data heap buffer with
> device-controlled data.
> 
> Clamp fifo_nb to the buffer capacity (INV_ICM45600_FIFO_SIZE_MAX /
> packet_size), mirroring the existing watermark cap in
> inv_icm45600_wm_truncate() and the sibling inv_icm42600 driver, which
> bounds its FIFO count to the buffer size. The clamp is a no-op for
> well-behaved hardware, whose FIFO never exceeds the buffer size.
> 
> Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
> Cc: stable@vger.kernel.org

Similar comments to the earlier patch.  Not a fix - rather this is nice to have
hardening against devices doing something odd.  I don't want to open the can of
worms that would be suggesting we fully audit drivers against this stuff
(particularly as I suspect that AI bots will be very good at finding complex
chains of things that happen if the hardware replies with garbage).

Same thing about min() rather than min_t() below.  It is pretty rare in
modern times to need min_t()

Jonathan

> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> Reproduced with an in-kernel KASAN litmus mirroring the exact allocation and
> the FIFO_COUNT -> regmap_noinc_read() length computation, plus a userspace
> AddressSanitizer model for the full magnitude:
> 
>   Without this patch (device FIFO_COUNT = 0x208 = 520 packets -> 8320 bytes):
>     BUG: KASAN: slab-out-of-bounds ... Write of size 8320
>     ... the buggy address belongs to the cache kmalloc-8k of size 8192
>     ... located 0 bytes inside of allocated 8192-byte region
>   With this patch (count clamped to 8192 bytes): clean, no KASAN report.
>   ASan model at the full magnitude (FIFO_COUNT = 0xFFFF -> 1048560 bytes):
>     AddressSanitizer: heap-buffer-overflow WRITE of size 1048560,
>     0 bytes after the 8192-byte region (reproduces on 64- and 32-bit).
> 
> The sibling inv_icm42600 driver bounds its FIFO count to the buffer size on
> the same interrupt path (max == 0 -> max_count = sizeof(st->fifo.data)); this
> restores the equivalent guard for inv_icm45600.
> 
> Reproducer and full logs available on request.
> ---
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> index 2b9ea317385c..0021c3dc0888 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> @@ -422,6 +422,9 @@ int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
>  	if (max > 0 && fifo_nb > max)
>  		fifo_nb = max;
>  
> +	/* Limit to the internal buffer capacity; the count is device-provided. */
> +	fifo_nb = min_t(size_t, fifo_nb, INV_ICM45600_FIFO_SIZE_MAX / packet_size);
> +
>  	/* Try to read all FIFO data in internal buffer. */
>  	st->fifo.count = fifo_nb * packet_size;
>  	ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
> 
> ---
> base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
> change-id: 20260613-b4-disp-58b984f3-3eef009c483c
> 
> Best regards,

