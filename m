Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787CF26AC5;
	Sun, 23 Aug 2026 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787506937; cv=none; b=ptrzrPicPU4zkw26tN86ibOgmR7Ju+Noin0/twz71lGsAThlLc1vt+CUwgwzjmNKNFFc6IuemEBz8LuLKITTPfNLUPWvFfg40r2HZqNBkMCwEycedO9WT7pqV59I72/6GKTG36mATLdcSkFB84LC44aDTr45VxNADVJoDor/Nls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787506937; c=relaxed/simple;
	bh=jXgXbA74tEscqLUxfDVxYqN+VfUVH4vowlXwsVyaDlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bABr5gdp4mR7lK2M2s0aodEO2Q2NYWzHit5Do7KBBlC40G0VlCAxctMD4SEovD5Nb+2nR3ngTZhQX5fWo9LksBGmL4h+FLOhdUlpw+Vj+K64qTF4/fiGeJIKcgb8izuhNGsgx2OVgmLyiyy8L9jVuA5+vtxpyeLjUgPR0ZrZaJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrVbsQHZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrVbsQHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6771F000E9;
	Sun, 23 Aug 2026 17:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787506936;
	bh=PBGN5RB1WlGGWGFknAVboP5b11EGYzOwflCsooHotM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nrVbsQHZ99PKRE5GFfwiO+yQEh/IAxU7n1eEdPqw2+9RPwd6/kmDSbxzD+sxyhHDL
	 fO80XmY9Cu/XoDMEvSPcN/HkSvvmN0ckhwpzCGYZSoxYM5BHuHJTmOOQ3Wqh3fgA92
	 NZGNRfMfiPPtAziLH6H48+cdQUDDfyH4qeAlK6lW24v8n6J5pd0YQJHAsn77BK3hPC
	 H5h6hlubChjRT8fKFVENHIYb8YXHcLFRLguaGJAzG8hnC1PLu0fXe7xWTEUcLeb+N9
	 kgr+vVHVYdI+Iy8v6+CHd/q8XMMQfY5Rt3ObEpt3qAxgySeToB5uIjtYN6I5WcXcDj
	 dsxXEVHsZLrqg==
Date: Sun, 23 Aug 2026 18:42:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] iio: imu: inv_icm42600: add support for icm42630
Message-ID: <20260823184211.1bc951b1@jic23-huawei>
In-Reply-To: <20260823003320.62192-1-jorijnvdgraaf@catcrafts.net>
References: <20260823003320.62192-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 02:33:17 +0200
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
> used in the Fairphone 6. It needs no part-specific driver code: TDK
> confirmed it can be supported by inv_icm42600 without modification.
> 
> The binding documents the new compatible with an invensense,icm42631
> fallback, and a WHOAMI mismatch no longer fails probe, so that a
> fallback-matched part can probe; one informational line records the
> mismatch, and a whoami of 0x00/0xff (no response) still fails. No
> driver id entries are added: the part binds through the fallback.
> 
> Tested on the Fairphone 6 with the fallback pair in the devicetree,
> via a backport to its 7.1-based kernel: matched as icm42631 through
> the fallback, the part probes with the one informational line, and
> accelerometer, gyroscope and temperature reads work.
> 
> Changes in v5:
> - patch 2: the no-response guard moves before the whoami-mismatch
>   comparison as its own check (Andy); it does not depend on
>   hw->whoami, since no supported part uses either value
> - patch 2: the four Link trailers are dropped (Andy, Jonathan); the
>   Suggested-by tags carry the attribution
> 
> v4: https://lore.kernel.org/all/20260810191157.125550-1-jorijnvdgraaf@catcrafts.net/
> v3: https://lore.kernel.org/all/20260728184351.75015-1-jorijnvdgraaf@catcrafts.net/
> v2: https://lore.kernel.org/all/20260724202708.128267-1-jorijnvdgraaf@catcrafts.net/
> v1: https://lore.kernel.org/all/20260720173411.82979-1-jorijnvdgraaf@catcrafts.net/
> 
> Jorijn van der Graaf (3):
>   iio: imu: inv_icm42600: sort device id tables numerically
>   iio: imu: inv_icm42600: log whoami mismatch instead of failing probe
>   dt-bindings: iio: imu: icm42600: add icm42630

Applied to the testing branch of iio.git.  Note I'll be rebasing on rc1 once
available (in about 1 week) so until then I'm fine adding tags or with changes
on top if any review feedback comes in.

Thanks,

Jonathan

> 
>  .../bindings/iio/imu/invensense,icm42600.yaml | 24 +++++++++++--------
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 17 ++++++++++---
>  .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 16 ++++++-------
>  .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 16 ++++++-------
>  4 files changed, 44 insertions(+), 29 deletions(-)
> 
> 
> base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425

