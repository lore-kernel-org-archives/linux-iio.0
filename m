Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF1839184B;
	Sat, 17 Oct 2026 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792267213; cv=none; b=Xg5BP8Ps97dEkMq+MRE/N8aHdwq3UmmDc1upy4pXWX6Q4UHYuu6NQnA9seAesP5fFho32y1sCwpgO5rhWXyBPTWq0hA3t+FsTFt2I7z9ICk6wQS9+/kUeFiFAjfc0fH62t3/XKctkk3dKn0OmQKcXKuMyZG2Y3dwUT2BGk0L0wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792267213; c=relaxed/simple;
	bh=nyKi01ULEJMH5Y8pbW/BJjOGlMHbN/t1fcSUouRh6B4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVGEz32WwLOi6SBDijIuYDxvsc2xJsxvmiewmBIvuLoGkFie5C8bmn2QSaWhlbpf7mrvxAaGtW6/mp+JQmKqPOEpx++wpPEOVmmEn0nVO0ixwr7a9eMkbMWmmfPyg1h5ckPx5WemVDeGrvS8sPfE7+kXpht/1qXZifmHf9nCTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJleIf3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJleIf3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B711F000C4;
	Sat, 17 Oct 2026 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792267212;
	bh=zL8xdxVruWYdEdsNkF9GkTtgoJqQv0ozozSTRpy9Dgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EJleIf3B4A1yYi7lzbnpPGAS1GO2WRM/dutcgxzg3lCnw3XcgwO6mJsaW9zA68e/K
	 H8ibjStuMNPJdyOn7dgRpGLdy8Ue8dEMb0DCbxUphEyRhWxuFECbt8sav98j7Co8f5
	 4yTqaNrZAiNeeZAnCgI0+EJ8nsL93Qar8XrwthUL/br+nrqVSs0gvAO0f+GSU+VS+H
	 E+ImFMCwcCf8CvY6Csnqumim7mghWYQnBSd9qExM2JowP4FBSxTwOA+6ioLYrcllBl
	 uxNbxb2wp06Xt7oh6XpjlduDBFJiOlIPYYqgx2csw+Jewwefz/t4MrLxdUfBy9UmCy
	 oVJiQndN4VWkw==
Date: Sat, 17 Oct 2026 21:00:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liu Yufei <lyf98405@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: proximity: Add Vishay VCNL36829 driver
Message-ID: <20261017210005.07472854@jic23-hlaptop>
In-Reply-To: <20261016012218.40223-1-lyf98405@gmail.com>
References: <20261006100943.78971-1-lyf98405@gmail.com>
	<20261016012218.40223-1-lyf98405@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 09:22:16 +0800
Liu Yufei <lyf98405@gmail.com> wrote:

> From: Liu Yufei <lyf98405@gmail.com>
> 
> This series adds support for the Vishay VCNL36829, an I2C proximity
> sensor with an integrated VCSEL emitter.
> 
> Patch 1 adds the devicetree binding.
> Patch 2 adds the IIO driver, which exposes the proximity reading and
> a configurable integration time.
> 
> Tested on Orange Pi Zero 2W.

Hi Liu Yufei,

Small process thing first.  Start a fresh thread for each version.
This is to avoid the treads becoming complex to follow and has the side
effect that they actually turn up as 'recent' in reviewer's inboxes.

I'd have looked at this a lot later today (or perhaps not at all)
if I didn't happen to notice it in patch work after changing status
on another patch.

Jonathan

> 
> Changes in v3:
> - driver: Collect Reviewed-by from Joshua Crofts and Andy Shevchenko.
> - driver: Use dev_info() instead of dev_warn() for an unknown device
>   ID (Joshua Crofts).
> - driver: Wrap the write_raw() arguments on a logical boundary
>   (Andy Shevchenko).
> 
> Changes in v2:
> - dt-bindings: Collect Reviewed-by from Krzysztof.
> - driver: Address review comments from Andy:
>   - Use a Datasheet: tag in the commit message.
>   - Drop mod_devicetable.h, sort the includes and include what is used.
>   - Drop the i2c_client pointer from the private data and use
>     regmap_get_device() instead.
>   - Drop the unused i2c_set_clientdata().
>   - Enable a maple regmap cache, mark PS_DATA and DEV_ID volatile.
>   - Rework the integration time validation in write_raw().
>   - Use reverse xmas tree order for local variables.
>   - Document the power-up delay and use 3 * USEC_PER_MSEC.
>   - Warn and continue on an unknown device ID instead of failing.
>   - Join lines that fit within 100 columns.
>   - Simplify the Assisted-by tag.
> - driver: Drop the i2c_check_functionality() call, as
>   devm_regmap_init_i2c() already checks the adapter capabilities.
> 
> Link to v2: https://lore.kernel.org/linux-iio/20261006100943.78971-1-lyf98405@gmail.com/
> Link to v1: https://lore.kernel.org/linux-iio/20261003050453.413700-1-lyf98405@gmail.com/
> 
> Liu Yufei (2):
>   dt-bindings: iio: proximity: Add Vishay VCNL36829
>   iio: proximity: Add driver for Vishay VCNL36829
> 
>  .../iio/proximity/vishay,vcnl36829.yaml       |  55 ++++
>  MAINTAINERS                                   |   6 +
>  drivers/iio/proximity/Kconfig                 |  11 +
>  drivers/iio/proximity/Makefile                |   1 +
>  drivers/iio/proximity/vcnl36829.c             | 298 ++++++++++++++++++
>  5 files changed, 371 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
>  create mode 100644 drivers/iio/proximity/vcnl36829.c
> 
> base-commit: 52c36105f76e96b638152a42e735f2e7767ed946

