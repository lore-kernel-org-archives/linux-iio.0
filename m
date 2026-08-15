Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A96D3218BA;
	Sat, 15 Aug 2026 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786832478; cv=none; b=QU2UPb1ZjojSpblUYBb+7vVGj7v/lWVtUpPsi14WGUP2cSh7faVbtcLj0yjPVRIDZ+pO+V5aVbsLiW2/eSh0rSlOlOQvMWtSmKIsWPpi19AALdMFi8KQGS+wRGYwBSMub2G0gyhAsMBT8j6jfWNNCiVjfVmRy3CbCvAO2mwOFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786832478; c=relaxed/simple;
	bh=V1XfZu6AEzWxL6/fao+FZ50UGbzisKLKsfc6/E+Ab8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOldQBOxs/3LxNHpIIKF3z4G8L+99iQaW3uu9/2cVv1YlMweYkq41rQblo11ChDM1/UWKE0M3rFYWt3PmV4QRtXPFUy8GoJdhACJsS6Og0f4BNGfuuyVpePrdkhOc16gHtsoLMKFHlaFin/YD21sO1abwx6fk8QLqpHAmPl/BI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtusAiLT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtusAiLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779A01F000E9;
	Sat, 15 Aug 2026 22:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786832477;
	bh=NtYxTbItTNoFSKGy4T8ItsBmcI7Bu8RTMSq54EVtic8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gtusAiLTx4bgQ02xxl4CgbWL7UWnvfsIrdz9m7WPf/s0GN3Jz+PL9DzBDK/5BEQbc
	 +nLP0vWi68+FBHe72uDrdEhGV+eqMTjKYJaCafN73NbCXOWRMPfPmrryaB2k06fdI7
	 DQXy+mDmRzArOC2gcKOFjix0LHZkGQ0QyDDdgLlsnRaZDHfz7yHFDmMzTKBEGAZgCh
	 FbRO8PDXLIgDV5XC6XtrPwOJmBKQi7N6JrNOctSJpAuk3Hf+08CfhYoA114WxjYzZf
	 VJhiUWHcj0tswp1MXbWwph027QX48mzFvWg6HbAIw3grRIEbdsRqq9kdEvWty5civI
	 VQfhstAGhmo4g==
Date: Sat, 15 Aug 2026 23:21:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Beguin <liambeguin@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: adc: ltc2497: add 2x conversion speed mode
Message-ID: <20260815232111.268ec438@jic23-huawei>
In-Reply-To: <20260813160139.70000-4-andrei.stancovici@analog.com>
References: <20260813160139.70000-1-andrei.stancovici@analog.com>
	<20260813160139.70000-4-andrei.stancovici@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 19:01:37 +0300
Andrei Stancovici <andrei.stancovici@analog.com> wrote:

> The LTC2499 supports a 2x output rate (SPD bit in the second
> configuration byte).  In 2x mode the offset auto-calibration is
> disabled, roughly doubling the conversion rate (~13.6Hz vs ~6.8Hz in
> simultaneous 50/60Hz rejection) while leaving linearity and full-scale
> errors unchanged (datasheet).  During a temperature measurement the part
> always converts at 1x regardless of SPD.
> 
> Expose the rate through the standard sampling_frequency /
> sampling_frequency_available ABI on the voltage channels only: SPD is
> ignored for temperature conversions, so the temperature channel
> deliberately carries no SAMP_FREQ attribute.  A new has_speed_mode
> capability flag gates the feature (LTC2499); the two-byte command path
> is now taken for has_temp || has_speed_mode, since both features need the
> second config byte.
> 
> The conversion-time wait becomes mode dependent: 150ms at 1x, 76ms at 2x
> (datasheet t_CONV max, simultaneous rejection, rounded up).  The wait is
> keyed on the conversion currently in flight, whose duration is fixed by
> the mode that was active when it started - not by the newly selected
> mode.  This matters on a 1x->2x switch: a 1x conversion may still be
> running when the first 2x read arrives, and reprogramming the device
> before it finishes would be NACKed with -EIO.  Timing is centralized in
> ltc2497core_conv_time_ms() so a future FA/FB rejection-mode selection
> can extend it into a [rejection][speed] lookup without touching callers.
> 
> LTC2496/LTC2497 (no speed mode) keep the single-byte path and the
> unchanged 150ms wait.
> 
> Validated on a live LTC2499: 20 reads take ~3.1s at 1x and ~1.6s at 2x
> (~0.5x, no -EIO), voltage and temperature readings stay sane in both
> modes, and the temperature/voltage interleave (sticky-PTAT) regression
> still passes at 1x and 2x.
> 
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
This looks fine to me

J
