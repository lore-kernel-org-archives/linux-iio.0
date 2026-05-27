Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F4A381B10;
	Wed, 27 May 2026 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903172; cv=none; b=SGoPbWIblqMTuBl9758wW31PbdmPuNwUEGBWGoRwA8lYa8BhX3op+9d97aXUrn6rFILEiQX1pli7DXOj8Q4aQD3Izak1T1wkmu/jqvEzL80tE2HSxX3+MHBZTKAtuUfuvD6h1qZLbZR8YmJ/PgNCaJLkxshuZMPGvjJ+IPX0Vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903172; c=relaxed/simple;
	bh=zC+S7OgENAfZavMI8AVkfel0hcY+qmDmxJh4dRu/d/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnYSwP9y3NWqmeYJcAetqt/2hm1IkmDb51R7/BnTqjwEnApPUlGsL53FlT7CA+OMB8DHwGXrg1jJi64vcVafGl3ifnzWgEzDSylSEdZBj8tRJbJiMlxLB69JwZKU8e8OIZZCzW3x/JgAH0+gBmw5PDgzofhCtnKmldsW7eFdLCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zguu6+U9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zguu6+U9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC971F000E9;
	Wed, 27 May 2026 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779903170;
	bh=HpkGaKY3FpB86R0nlZnONWBEpAHb/bKL1EK+AGRBmng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zguu6+U9H4wuP4N97vNEXuSa846uShL6AS7qHkZLSX8euB9cxabkrX/1qW1l1FC3v
	 hNZF1bQwf3WNdHMKIldE9bdcq61peCd5a3EZhuYRzjBTmJdv7EYY8gogLpucRBvYpD
	 o1HB+6j672qCzXInSuWMCCPXbQZ/4mo4sRxW4bNvsHufI/dZjpj2X4OuiDOYZq2poM
	 qMjliQZovOyphC4v4iV7Lhogwqj+brwJmzHbWYFT9gRpvIJNkRa51WtZEAU66sCGLz
	 c3F9huDAXZCKaEMgB+J3RROwoqO1oE2GBf1sj4ByRWs/CPQjljR5FQqEddU9Yow4m9
	 eUnErCBPzuKGQ==
Date: Wed, 27 May 2026 18:32:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ak@it-klinger.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH v10 00/11] iio: adc: Add support for AVIA HX710B ADC
Message-ID: <20260527183241.5e48e378@jic23-huawei>
In-Reply-To: <20260525105127.180156-1-piyushpatle228@gmail.com>
References: <20260525105127.180156-1-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 16:21:16 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> The HX710B is a 24-bit ADC from AVIA Semiconductor, related to the
> HX711 already supported in this driver.  Unlike the HX711 (which has
> selectable gain and two input channels), the HX710B has a fixed gain
> of 128 and two operating modes selected by the trailing PD_SCK pulse
> count after each conversion:
> 
>   25 pulses (1 trailing): differential input at 10 SPS
>   26 pulses (2 trailing): DVDD-AVDD supply monitor at 40 SPS
>   27 pulses (3 trailing): differential input at 40 SPS
> 
> This series first extends the existing HX711 binding and driver with
> preparatory refactoring, then adds HX710B support on top.
> 
> The differential input is exposed as a single IIO channel with
> IIO_CHAN_INFO_SAMP_FREQ, allowing userspace to select 10 or 40 SPS
> without needing two separate channels for the same physical input.
> The supply monitor is a second channel at fixed 40 SPS.
> 
> Patches 01/11, 02/11, 03/11, and 05/11 have already been applied to
> the iio.git testing branch.  They are re-included here so the series
> applies cleanly as a unit.

Given the version I had of patch 2 was rather different from current
I've rebased my tree to drop it and patch 3.
Thankfully that didn't result in an sha hashes changing for the few
fixes I have queued up.  Hopefully not too painful for anyone
based on my togreg tree. Briefly that will be out of sync with testing
as I have other stuff being tested on there.

> 
> Changes from v9:
>   - 02/11: Added dvdd-supply alongside vsup-supply. Per the v8
>     discussion, DVDD is a board-supplied digital rail on the HX711
>     (figure 1 of the datasheet shows it as a separate input supply,
>     not merely a bypass capacitor point). It was missing from the
>     original binding. Moved its declaration from 04/11 to this earlier
>     shared-supply patch.
>   - 04/11: Removed dvdd-supply declaration (now in 02/11). Updated
>     commit message to reflect the patch now adds only vref-supply and
>     the allOf constraint.
>   - 06/11: No code change. Removed inaccurate below-the-line note
>     about __counted_by_ptr() commit reference.
>   - 08/11: Remove blank line between val = hx711_wait_for_ready() and
>     if (val) check in hx711_reset().
>   - 11/11: Revert IIO_DECLARE_BUFFER_WITH_TS() to explicit named
>     struct (both variants have exactly 2 channels). Add
>     iio_device_claim_direct_mode() in hx710b_write_raw() to prevent
>     concurrent hardware changes during triggered buffer capture; drop
>     channel_set = 0 reset (hx711_set_hx710b_channel() re-programs the
>     chip automatically on the next read). MODULE_DESCRIPTION: change
>     'compatible' to 'similar'.
> 
> Piyush Patle (11):
>   dt-bindings: iio: adc: hx711: clean up existing binding text
>   dt-bindings: iio: adc: hx711: add VSUP supply property
>   dt-bindings: iio: adc: hx711: add RATE GPIO property
>   dt-bindings: iio: adc: hx711: add HX710B support
>   iio: adc: hx711: move scale computation to per-device storage
>   iio: adc: hx711: introduce hx711_chip_info structure
>   iio: adc: hx711: pass trailing pulse count into hx711_read
>   iio: adc: hx711: split variable assignments in hx711_read and
>     hx711_reset
>   iio: adc: hx711: localize loop iterators in hx711_read
>   iio: adc: hx711: pass iio_chan_spec to hx711_reset_read
>   iio: adc: hx711: add support for HX710B
> 
>  .../bindings/iio/adc/avia-hx711.yaml          |  79 +++-
>  drivers/iio/adc/Kconfig                       |   8 +-
>  drivers/iio/adc/hx711.c                       | 351 +++++++++++++++---
>  3 files changed, 363 insertions(+), 75 deletions(-)
> 

