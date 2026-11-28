Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795837205;
	b=KRxfcK5ZJphu9Pkaka8cjX+63XKxgElInqYudVsszsQDh/97UGfVj7xEIQTtES2galZo
	 dyEsw414bbh1eLD2/BvEXFW8Yv/Ycb8iIrz3G5yeLkbFZnsUoxYaMOVwMqPH1qosmQCT6
	 o6Tw9oQ+JrHyCGEJHsUk0kLtYABLeDjJgoAPT6vrfIQ2rN03F4C4nVyums30LrjbQTdtT
	 i+VLyYAxdMaDhnxOhsZ31xI4znQSQu0XruIyg0l4xaNydq08fukHtW1WuCBUGCSxmDuzX
	 9tjOSQ8Rk3y6QVVeA/ZinNuc4Vn1cOKZjsy/pd6iu9T7tI1Gerh4/UTa6FhQHujFMQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795837205;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PnI407cLN3JAXEIL9EQXLgMIZWJNRFqbKSyWdVuKFIQ=;
	b=Xk0TYFcSO3mTh5oACf2C0ZdZqo6wpADxoi1Sq0aLVZ5HWmpD3imKBRMnghCbgrHwaRfS
	 1T7cFC0dTKbGUWfxAMXLFHwyz+P6TQWaq0oukQ359APcflQVEEO0ZQhTHxYWZITPVqpOE
	 YmMWSGYOztDlcjm2OqGf2mqhwnPXi3rhdX3y8pSU0OtKK1iZOzfa1O8ke5pTVEIH+LfPd
	 oHHiKwpBvZKQWk7Z6ew6F0cZgWA+KS2hc7e3Avg4tbk3qgMoFPXtdhp/hLX2jskuVO5gv
	 VUTWVxQ0bvnwnzO3/NTLjvEPl2ZZsFog91a5c57s94ukYtbSKIk6ZPpP+whM98JcQLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHYGwkiz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40B606A31C;
	Sat, 28 Nov 2026 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHYGwkiz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F181F00897;
	Sat, 28 Nov 2026 03:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795837204;
	bh=PnI407cLN3JAXEIL9EQXLgMIZWJNRFqbKSyWdVuKFIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jHYGwkizi+IaTCXe97Qhm4WzpxNfClTYijcTkBbkdgY2KLJrXd2GqGTzbmNInFkXA
	 +Px2FjG3gF8IVzIRN88hYp4E8XbCN1ZxCpyw1+U6IwfP+gVoaIvMuPh4tyGLxB4frW
	 U0pdldJwnp8Bkw8C9w5yobCTdqQqLYawQgfx7/vu9AGN01PFIt/BXS/fasala9cPNl
	 AYhFmKdyeaCsvyGbqIZB0VlLRKtKYTes5LNj31lo5b8ZhsCfZ7OzZg2vilyQiUH7Hi
	 lMUhvaxPWGcc5FUHpu/XHZzLjF9/2RiRqoOM/8PFti7gYBSZkBsny1a5FLj64obt9p
	 vhMdRAT0Y3kWw==
Date: Sat, 28 Nov 2026 03:39:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Yasin Lee <yasin.lee.x@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] iio: proximity: hx9023s: fix sampling frequency,
 resume and event value handling
Message-ID: <20261128033958.19377fdd@jic23-hlaptop>
In-Reply-To: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
References: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Nov 2026 03:06:45 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> Five fixes for the HX9023S capacitive proximity driver, and one cleanup.

I took a look as well and these seem fine to me (subject to the various
things Andy raised).  I would definitely like Yasin's input though
if possible.  This is a complex part and driver, so whilst these seem
unlikely to cause problems testing would be even better!

Jonathan

> 
> 1: writing 67108864 (or any value for which val * 10^6 + val2 is a
>    multiple of 2^32) to sampling_frequency divides by zero: div_u64()
>    takes a u32 divisor. The check added in a318cfc08537 only catches 0.
> 2: reading sampling_frequency indexes the 32-entry period table with
>    the PRF_CFG register value unchecked; the configuration file loaded
>    by hx9023s_bin_load() can put any 8-bit value there.
> 3: resume re-enables the chip interrupts only when the trigger is
>    enabled, so threshold events stop after the first suspend.
> 4: out-of-range threshold values are masked into the 10-bit field
>    instead of being rejected (-32 becomes the largest threshold).
> 5: same for the 4-bit debounce fields (16 becomes 0).
> 6: cleanup, no functional change: get_samp_freq() doesn't need a
>    64-bit division either.
> 
> Changes in v2:
> - 1: use val == 0 && val2 == 0 for consistency (Andy)
> - 1: reject 1 kHz and above (a period below the smallest table entry)
>   and use a plain 32-bit division instead of div64_u64() (Andy)
> - 4: check val >= BIT(15), keep the threshold with & ~GENMASK(4, 0)
>   and add a comment on why the low bits are dropped (Andy)
> - 6: new, drop the div_u64() in get_samp_freq() as well (Andy, on v1
>   2/5); last in the series as it isn't a fix
> - Rebase on the current fixes-togreg
> 
> v1: https://lore.kernel.org/all/20261123165255.239490-1-kapoorarnav43@gmail.com/
> 
> Patch 2 assumes the whole PRF_CFG register is the period index, as the
> driver already does; I don't have the datasheet to check whether it has
> other fields.
> 
> Applies to both fixes-togreg and testing.
> Compile-tested only (W=1 for every patch, checkpatch --strict clean); I
> don't have HX9023S hardware. The checks in 1 and 4 were tested with a
> userspace copy on 32-bit and 64-bit: all 32 table periods are still
> accepted, and the threshold check matches the v1 one for every value.
> 
> Arnav Kapoor (6):
>   iio: proximity: hx9023s: fix division by zero in set_samp_freq
>   iio: proximity: hx9023s: check the sampling frequency index
>   iio: proximity: hx9023s: re-enable interrupts on resume for events
>   iio: proximity: hx9023s: reject out-of-range threshold values
>   iio: proximity: hx9023s: reject out-of-range debounce values
>   iio: proximity: hx9023s: use plain division in get_samp_freq
> 
>  drivers/iio/proximity/hx9023s.c | 47 +++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 11 deletions(-)
> 
> 
> base-commit: 69bf7489f01ffa3c3269d09eb8a0668b1bdfa053

