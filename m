Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0071A184;
	Sun, 13 Sep 2026 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789259465; cv=none; b=o3LZ17lIN10KAW4Hls6Ofbe1aX+Zk7W1s7lxRwAStVQxVMbOoXn3P7VXFZAdot3+ZrH9+B2cM7VJ3PpBRLLcDTuRu1Z4pooZ176LQYCvmcnSdpi5SPjAlAeYQoac8amcVvANXwsMGB2xIpHjAf0coFZf6zM8mxKMMSicqutOkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789259465; c=relaxed/simple;
	bh=NekZusYYabyq5S1tsGwsMzmQajgylhWUzx2SPrn+vEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXIaPPhIVuBYxWxlJgy0m9VJbrzS3prUuqZn2CS8XpPQEgultqY5ljnuH/61fL7EV2pzX8qMLk3gHiDt9K0eULFQXpMiGZP/YqZ0oa4mMLY4iXBs0uWoiqm2MTqMfKBpzRSvmP3kN0schGsYQ07/GxxBvESG+AAL7Z0Thlfhuh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIOcaEGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIOcaEGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDB11F000FF;
	Sun, 13 Sep 2026 00:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789259463;
	bh=StqGImk2ppQcaVbfk8rFtaPEez7jfalIpJBjZ0eNoGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cIOcaEGrAUKbkAXWmIcwLjbqKXLZOQTHkjN8sECSh7x1xcVRiMDmprKjGccdy/d4v
	 8ZVy1Nim2bXUS6F668rsGGHs/leVBsi8TmtrydRlflixbOSRfiyzxT0qq3ivBiqYwU
	 DrYxqHnFtdxDLzYcUjIajeXmnqeqY1K9Uh5xxDynw9Nr4muCnEI/9tn2ppunnxSt3t
	 LguyRzyqMBiL2wHEhXG9lpoTFzuLwMAlJZkCPEgI0zDGRfowPit1VmsC7+Ib9SkxzJ
	 6a+kdaDfUIiS9ruMLiYHV15frFAokpl38kOW8fNNYYuiBlSUaxrhqyA136JBPhKFzR
	 SX8Gl7m3KU/+w==
Date: Sun, 13 Sep 2026 01:30:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, "Jose A.
 Perez de Azpillaga" <azpijr@gmail.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add support for AS7343 multi-spectral sensor
Message-ID: <20260913013056.1a7c98b8@jic23-hlaptop>
In-Reply-To: <20260912013912.51887-1-marcus.yu.56@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 18:39:10 -0700
Chang Yu <marcus.yu.56@gmail.com> wrote:

> This series adds initial support for the AMS AS7343 14-channel
> multi-spectral sensor.
> 
> The sensor has 14 optical channels (11 visible + NIR + clear +
> flicker) in total. This initial driver supports reading raw counts
> from all 12 spectral channels (11 visible + NIR) via sysfs and basic
> power management.

Hi Chang Yu,

We all appreciate enthusiasm but...

No idea if anyone called it out already but please slow down.
Typically reviewers only get to looking at IIO patches once every week
or so (in totality - they may review a few random ones more often whilst
waiting for something to happen).

So for a driver in early stages of review, once a week at most for
new versions.  That way we consolidate a bunch of feedback.  Key thing
is many folk looking at your code doe enough review that they don't
have the previous version in their head so each very takes roughly the
same amount of time to do - it doesn't get shorter until very near merging
when we know tiny stuff only is changing.

Jonathan
> 
> Not yet supported:
> - Configurable integration time and gain
> - Interrupt support
> - Clear (VIS) channel and flicker detection
> 
> Patch 1 adds device tree bindings.
> Patch 2 adds the driver.
> 
> Testing was performed on a Raspberry Pi 4.
> 
> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> 
> Changes in v4:
>   - Fix led-max-microamp property in dt bindings.
>   - Use REGCACHE_MAPLE and add volatile table.
>   - Use PM_RUNTIME_ACQUIRE* when resuming.
> 
> Changes in v3:
>   - Fix gpio description and example in dt.
>   - Only start measurements after suspend action has been registered.
>   - Add a mutex and pm_runtime_resume_and_get before reading measurements.
> 
> Changes in v2:
>   - Add the LDR, the interrupt pin, and the GPIO pin to the dt bindings.
>   - Adjust the default gain to x256 and integration time to 50.1ms as
>   recommended by the datasheet.
>   - Use read_label instead of .extend
>   - Remove all unused scan_index related constants.
> 
> Chang Yu (2):
>   dt-bindings: iio: light: add as7343
>   iio: light: add AS7343 multi-spectral sensor driver
> 
>  .../bindings/iio/light/ams,as7343.yaml        |  72 +++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/light/Kconfig                     |  11 +
>  drivers/iio/light/Makefile                    |   1 +
>  drivers/iio/light/as7343.c                    | 434 ++++++++++++++++++
>  5 files changed, 525 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
>  create mode 100644 drivers/iio/light/as7343.c
> 

