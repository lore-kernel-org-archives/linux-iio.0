Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1F42050;
	Sun, 21 Jun 2026 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782065291; cv=none; b=rqrgDk76CBOF7t7oQ8eC6+2kr9/xwNgnfdJTUX1YLjZv9dEW8cPQUJNv/vKY60pO8YCxPDmXNbxw120yi2dAbw+DErGPQnIbZdyCt9AUHT4p/KM1AsGtERqET4Gw7WtZtt3OQDt//dX4KRCv98q6Q9D/nCKk34oKKVBKsZUrZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782065291; c=relaxed/simple;
	bh=cG7nOhvF2K2FmPQEJ3w0qcibrKfH4r3OjvYmEZ3n4a0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxTnmR4WLmTxsQ6YAeW0b/QmqdaInuAVZd3eAZeVXbR2W25J9onRmVO2ufxIiRujcEBXiH66BexueajA9W7r3iLXaVdolYRd9AjfKOLnw1AMZJvAfnGgr0gtDRUolSw3DNSJOdinhWOQUajAq8E1iULCq62QwMc0txA3XIj9YQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY//uzAE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY//uzAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8444C1F000E9;
	Sun, 21 Jun 2026 18:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782065290;
	bh=Wf+NE34DC6hdShPXcTCUG4WG/CoMfqf3iDvjuIdGiYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cY//uzAELT6NtDHh8WhhCvlTJD2LIbGosrZuKoJxvEjiCCR8rV989HBgu33VAU0Dj
	 sXSYgF38rMrVCvd639BpBTZlpbqDWXkL6uMWLvEeKt+F4KXabylPeJd/1sl1Xn61Lc
	 rcgdVPfPrs+M9zp26xFCGO8uIDvw0r0UdYjX5rmc+3AbLC0R7o3fopnrQYanL3Sfog
	 F62oEmMVrurVm3gJ5/gf5kD0WQhrsQekOLpz/QdgjF4JrUa2C0CDZEiQ1ZUkp6veLY
	 kHGl4WdmC10WL/uboK3fhl2PRM8RPK9L4jgSJN7YwEp3lKuxGvCVycF3IPjbQS8clC
	 Q2c33gk2/CfKg==
Date: Sun, 21 Jun 2026 19:08:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: hexlabsecurity@proton.me, Remi Buisson <remi.buisson@tdk.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v3] iio: imu: inv_icm45600: clamp the device-reported
 FIFO sample count
Message-ID: <20260621190804.04894168@jic23-huawei>
In-Reply-To: <20260616-b4-disp-76e3f743-v3-1-c20930aaf1cb@proton.me>
References: <20260616-b4-disp-76e3f743-v3-1-c20930aaf1cb@proton.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 20:57:28 -0500
Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org> wrote:

> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> inv_icm45600_buffer_fifo_read() uses the FIFO_COUNT the device reports,
> unclamped, as the length of a regmap_noinc_read() into the fixed 8 KiB
> st->fifo.data buffer. The only bound is the caller's "max", which the
> interrupt path skips (it passes 0). A device, or an attacker on the bus,
> reporting up to 65535 makes the read as large as ~1 MiB: a heap
> out-of-bounds write of device-controlled data.
> 
> Clamp fifo_nb to the buffer capacity (INV_ICM45600_FIFO_SIZE_MAX /
> packet_size) before the read, mirroring the watermark cap in
> inv_icm45600_wm_truncate() and the sibling inv_icm42600 driver. The clamp
> is a no-op for conforming hardware.
> 
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> v3 (Andy [2]): shrink the commit message; the register/byte detail, the
> not-for-stable rationale and the introducing commit moved below the cut.
> v2 (Jonathan [1]): use min() instead of min_t(size_t, ...), and drop the
> backport tags -- this is hardening against a malformed device-reported
> count, not reachable with conforming hardware ("nice to have hardening",
> Jonathan).
> 
> [1] https://lore.kernel.org/all/20260614144557.196a5c4c@jic23-huawei/
> [2] https://lore.kernel.org/all/ajEMfH-_76M1OBqE@ashevche-desk.local/
> v1: https://lore.kernel.org/all/20260613-b4-disp-58b984f3-v1-1-352b2f925f58@proton.me/
> v2: https://lore.kernel.org/all/20260615-b4-disp-feb19207-v2-1-2d36f1e5fc54@proton.me/
> 
> fifo_nb = le16_to_cpup(raw_fifo_count) is 0..65535; the interrupt handler
> calls inv_icm45600_buffer_fifo_read(st, 0), so the "max" clamp is skipped,
> and fifo_nb * packet_size (16 bytes per packet) reaches ~1 MiB into the
> 8 KiB st->fifo.data buffer. Present since 06674a72cf7a ("iio: imu:
> inv_icm45600: add buffer support in iio devices"); not marked for stable as
> it needs a malicious or defective device, or bus tampering.
> 
> Reproduced with an in-kernel KASAN litmus and a userspace ASan model:
> without the clamp a FIFO_COUNT of 0x208 (520 packets -> 8320 bytes) gives a
> slab-out-of-bounds write past the 8192-byte region, and the full magnitude
> (0xFFFF -> 1048560 bytes) reproduces under ASan on x86_64 and i386; with the
> clamp the read is bounded to the buffer. Reproducer and full logs available
> on request.
> ---
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> index 2b9ea317385c..5cde42f70c2e 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> @@ -422,6 +422,9 @@ int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
>  	if (max > 0 && fifo_nb > max)
>  		fifo_nb = max;
>  
> +	/* Limit to the internal buffer capacity; the count is device-provided. */
> +	fifo_nb = min(fifo_nb, INV_ICM45600_FIFO_SIZE_MAX / packet_size);
> +
It is a little odd to clamp against a value / packet size just to multiply it
by packet size.  However there is an oddity here in that we might not have
a fully number of packets in the 8KiB buffer.

Hmm. It actually is a though as the packets are either 8 or 16 bytes
(only the bigger one relevant here).

So could we just do this instead?
	st->fifo.count = min(fifo_nb * packet_size, INV_ICM45600_FIFO_SIZE_MAX);

Also to make this much easier to spot, can we actually use the define in
the allocation in _core.c to allocate the buffer?  That can be in the same
patch as it's all related, but needs a tiny comment in the patch description.

st->fifo.data = devm_kzalloc(dev, INV_ICM45600_FIFO_SIZE_MAX, GFP_KERNEL);


>  	/* Try to read all FIFO data in internal buffer. */
>  	st->fifo.count = fifo_nb * packet_size;
>  	ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
> 
> ---
> base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
> change-id: 20260616-b4-disp-76e3f743-98d24c7e6ae4
> 
> Best regards,

