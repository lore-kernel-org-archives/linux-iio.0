Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0824D379C57;
	Sun, 31 May 2026 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229762; cv=none; b=RRI4WB5/o1C6Ou4iDSm226Q1wuwDsH33uTCC1HQnfaCQvDpxtpetekIXXyxJ/gCACCWi+vymMDQ6G92j+814pdkvs3JhGJL23KpqzHjSJeOyfhjuUHFrqtqJ4aoxksmDkcGtZjgFvEjfYhr5xm1yFfRnEIApfwxMkVKgJi02SXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229762; c=relaxed/simple;
	bh=lMpP1R9PGeXbR7FUTzWXr8wgREoAHl5oGc+Qhane5JA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZPGdtU9XVJuOfiEqzKcO8hjFs0PkGaAjz/ps6klq0qVk37ZdBGZ9sjxalsSxUYZfIYKRIJPdAWSBY+B7+fDzgub1bw/vUDcb8rrDTav6qNzu7OZHYTU2zpKcASG9AAnsvTdnw6Y053XGDK9VpMm9NtLq0LwgDgUYFbCtyMICZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUIaHaji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUIaHaji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B441F00893;
	Sun, 31 May 2026 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780229755;
	bh=1AJK9NOqujQZojyE5eeCKCC9oPTb+PzLR8+/dxCpOt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OUIaHaji5qwFkRwG44KWGSBCMQBXht8IokXSpBV5xwEk/hfveD1H0YJJCr0XJEM0o
	 mNDFx7qcgyUR621Mc5gHDKRVsT7EmvBb8z3r0siZnzu+dbW4bXO8KVHsaDR4MIv5eN
	 /k8/BfNVxl5i2fCBYr1YLbEnjhYnUYtiW0Giq23H0ytzC2tPhbsUZCiMMItg+5qQGO
	 DaJc/UbBuE5ymHDsJQkq27Af38Xl+66jH4q78wAA5oUOPSbeo5Fyk/rswcX2UzHKlG
	 cNVyitzobql3QJoaoNvrSvFgleR8M/2hxHKWfGRCeubkDKtnJIrjQdznsPTPWZ6f+t
	 kNUpQy5yWN+wg==
Date: Sun, 31 May 2026 13:15:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V9 04/11] iio: imu: inv_icm42607: Add I2C and SPI For
 icm42607
Message-ID: <20260531131543.2abf77e2@jic23-huawei>
In-Reply-To: <20260530031739.109063-5-macroalpha82@gmail.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
	<20260530031739.109063-5-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 22:17:31 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add I2C and SPI driver support for InvenSense ICM-42607 devices.
> Add necessary Kconfig and Makefile to allow building of (incomplete)
> driver.
> 
Sashiko suggested power sequencing timing might apply between vdd and vddio.
I took a quick look and didn't spot it on the datasheet. Perhaps they've
figured out how not to have that burden on the platforms using their chips!

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
LGTM
