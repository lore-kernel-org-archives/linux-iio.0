Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910D1FC7FB;
	Sun, 14 Jun 2026 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781471050; cv=none; b=qEpgq5GzFSfh6P0lvYfu+laGlWkoogqsTwFAbEFwxFB0PO/Yvn3a8/f9Fvvq/admETHR6n3XNE9BmFUqKdFQSSOjwV8SSp/60vLPyq9CYZ1oOVdWmlRTeK/ehsCwIm+9jy2l4jzZbhyI/0P2CgLESuk+AkbXp37y275/9s4pCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781471050; c=relaxed/simple;
	bh=G8DltNBTaEHOTyxWPMMmHeT53U9g0GmnZz8QY9dJs50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0KKxWs3mX6ic2rbVZJI5YmxP/yj8UEPPru1wVoUtidslFKg+QU/10e7j2n8R6Tr5ZhZcCG9NV7HDjOdkXgCjK4WktAqbA/CDKOHGUAoE/Y5InGl0vGaJ79WM0aaRKw0CT785JcUHhQ11AtF+6ty4EzNBMf4KfZ7QAL/nlMYRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/7j+Eiw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/7j+Eiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160021F000E9;
	Sun, 14 Jun 2026 21:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781471049;
	bh=MGsdW7+lGFW14M+Vm6B7LTfiA6XZ6ZwPtyqD3IyDKtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S/7j+Eiw3CMuECcql5F7qEL+BLbb91CNTW7GgWdSo6bXs1Bni8dDp/sxCUfo7qywy
	 K+RUgPOfqr/75Le+SbrA75iUEGuih1N0JhFmnj5emA9FXDDJ28LmXNf685ikLnYJcL
	 +7BvriYok/qnJd/bKFuBleyq+eKnz5h6kwllVSvk0wCAu1MPc3qUqnoz+ABc2Z6Zgs
	 0oU2sT53jMg0aLN9FEDxvGKECURDKG43e1shXXonyW2+cIxTNcE9K6jyFwYnoA7P0X
	 3iUDo40QU/bjVdAcHMfkMJxtmtYamll4TlaKinJ7jewTTHLjFWJ8T+GURiAw056u1q
	 s4ZZgMb5RK4sw==
Date: Sun, 14 Jun 2026 22:04:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ak@it-klinger.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH v11 00/11] iio: adc: Add support for AVIA HX710B ADC
Message-ID: <20260614220400.106dd636@jic23-huawei>
In-Reply-To: <20260603184859.89693-1-piyushpatle228@gmail.com>
References: <20260603184859.89693-1-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 00:18:48 +0530
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
> This revision is rebased onto current mainline.  Note that
> iio_device_claim_direct_mode() / iio_device_release_direct_mode() were
> removed from the IIO core since v10, so 11/11 now uses the replacement
> iio_device_claim_direct() / iio_device_release_direct() API.
> 
> Tested on a PocketBeagle2 (TI AM625): the avia,hx710b node probes and
> the driver registers its two IIO channels.
> 
> Changes from v10:
>   - 02/11: Retitled to "add VSUP and DVDD supply properties"; the
>     commit message now documents both supplies (the patch already
>     added both; only the title/text were out of sync). [Jonathan]
>   - 04/11: Reworded commit message so DVDD is no longer described as
>     HX710B-specific (it is added for both parts in 02/11). The
>     compatible match now uses "contains: const: avia,hx710b" so the
>     constraints still apply if the compatible is later used as a
>     fallback. dvdd-supply is now required for HX710B (in the HX710B
>     branch only, so existing HX711 device trees are unaffected) and
>     added to the HX710B example. [Jonathan, Conor, Sashiko]
>   - 11/11: Kconfig title and file header use "similar" instead of
>     "compatible". Simplified the tail of hx711_set_hx710b_channel()
>     to "return hx711_wait_for_ready()". Dropped an unrelated
>     reindentation of the iio_push_to_buffers_with_timestamp() call.
>     Converted hx710b_write_raw() to the new
>     iio_device_claim_direct() API (see above). [Jonathan]
> 
> The Reviewed-by (Andy Shevchenko) and Acked-by (Conor Dooley) tags on
> 02/11 and 04/11 are carried over although those patches changed; please
> re-confirm if you disagree with the reworked constraints.
As the only comments I had (well mostly sashiko) were on the 710b patch
at the end and some patches were queued from previous patches, I now have
patches 1-3 and 5-10 applied to the testing branch of iio.git.

Thanks,

Jonathan

> 
> Patches 01/11, 03/11, and 05/11 are unchanged from v10.
> 
> Piyush Patle (11):
>   dt-bindings: iio: adc: hx711: clean up existing binding text
>   dt-bindings: iio: adc: hx711: add VSUP and DVDD supply properties
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
>  .../bindings/iio/adc/avia-hx711.yaml          |  82 ++++-
>  drivers/iio/adc/Kconfig                       |   8 +-
>  drivers/iio/adc/hx711.c                       | 343 +++++++++++++++---
>  3 files changed, 359 insertions(+), 74 deletions(-)
> 

