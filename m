Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F721CA03;
	Mon, 24 Aug 2026 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530674; cv=none; b=I5ZFCOerIvoJ6jzxD0jYUpFllpYdPVM3lhZhOZKv/BrLVbuWchmcy+uT5dZ4cZdn232gooDGGeoZi2Ip7C4TC3uFeYM3raFcuqDIz8cOzhUe26it55AW6Bg+3GN/FURmJg0CsbOYqTEUgKOnKza2DESJEyZF91IKcFYjPKuLUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530674; c=relaxed/simple;
	bh=GQ/Cl6IBlTtkHxcDgOn05oMpY1hDHABpsVyFfA/jkkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRQOoqf0592nFjbJecf8xuSrcB1KWIYPJUGuG517IgC2utL0fiZ1ghky6ZjYUm/tajYdBHe3L8poz8fzw7DDRBmc92WMExPBaT+ndzYr0pRSN39RaQlGYDRXtEr3xVDf0TfbfRPzu/buKZnZqQnI03xOEq2vgwLkfXLlUIz2L+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3bpeFJr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3bpeFJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E691F000E9;
	Mon, 24 Aug 2026 00:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530673;
	bh=79Id32beVBFTfnSqgBdCDwS1o60x2rHoMa+yIKNYwZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h3bpeFJr+VeUlDBbd5qnky8b0jyblcZrcn6GJXWME8WjuzMbDQ6KHu9FeCNTWxAa5
	 jDW+rtP5w1Wd1XbC6TucY5KVBDuSrEM2Or7fy5mRmPZmW4zSRdQeCpCfkX0pRo2Wtx
	 V2iJig4Yyo3wy+DVMNU1aqU+fbsoJwhwTALtYxzCfJduCXJKEdQrYHwVizlbSdBBmt
	 If6JY8ftQyBP1t8N/Hp8F6yDOt41qdTvslQN4YgvvKQNVm5gpsnewehExcd7Na8YpW
	 brd9U5TVlymqv3MGNYLEmIELcXLAB+bJbWQAqiHdplPrFffeqQxoTVN2f1pFd14GNe
	 P/lUCeXm8t+Pg==
Date: Mon, 24 Aug 2026 01:17:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andi.shyti@kernel.org,
 wsa+renesas@sang-engineering.com, ojeda@kernel.org, dakr@kernel.org,
 igor.korotin@linux.dev, branstj@gmail.com, brucer42@gmail.com
Subject: Re: [RFC PATCH v5 3/3] iio: position: add Rust driver for ams
 AS5600
Message-ID: <20260824011749.62322d99@jic23-huawei>
In-Reply-To: <20260822062725.60519-4-muchamadcoirulanwar@gmail.com>
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
	<20260822062725.60519-4-muchamadcoirulanwar@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 14:26:58 +0800
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> Add a Rust driver for the ams AS5600 12-bit magnetic rotary position
> sensor. The driver exposes in_angl_raw and in_angl_scale via the IIO
> sysfs interface.
> 
> Features:
> - ARef<I2cClient<Bound>> for safe refcounted I2C client access
> - Mutex-serialized status + angle read sequence
> - Static channel spec (module-level const)
> - No magnet validation at probe (deferred to read_raw per IIO convention)
> - Error propagation via ? operator (no recovery state machine)
> - Type-safe IioChanInfo enum dispatch in read_raw
> 
> The AS5600 stores the 12-bit raw angle big-endian across registers
> 0x0C-0x0D. smbus_read_word_swapped() handles the byte swap: SMBus
> always transmits the low byte first (little-endian wire), so an
> unconditional byte swap recovers the correct value regardless of CPU
> endianness. The long-term solution is regmap-rs where endianness is
> configured once at the transport level.
> 
> This driver uses INDIO_DIRECT_MODE without buffer or trigger support.

I'd only talk about what you do support.  There are always many things
that aren't in an initial driver so listing that bit doesn't provide much
value.

> All userspace access is through sysfs attributes, which ensures safe
> cleanup via kernfs_drain() synchronization in the IIO abstraction's
> PinnedDrop. See the module-level doc comment for details.


> 
> Tested on BeagleBone Black (AM335x) with AS5600 on i2c-2 (0x36).

Generally put things like testing info in the cover letter or below
the ---

> 
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>


The code itself looks fine to me - but as with earlier I'm looking
for rust expert review.

Thanks

Jonathan
