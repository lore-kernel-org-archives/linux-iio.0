Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E52B9B7
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778942699; cv=none; b=NS1nZUmUyoLMXxUECwz6PwBAZaQJH83Y9INNqvA2njg4A2oOWl4CEIBPkMXRfpizadd+oFwA4LZNukEngsnw1cPQetkyMNQkO/jjXRKPcCQJ+sMY62TJ4MlgvRASOqqB5hsZuToW1A/QP8gWoV0z8XbUlIkr4S1NJBvQL9OwOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778942699; c=relaxed/simple;
	bh=9M+JrVmDTPYZED8J+E6XPZkY3GK7HDO1YZWVEkorACY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvM0/OrZESiZuXaPdGEsQQexgWgVMEn4Z5Gt6g/SNF8u8YAAnDvTh7qtxd82T5c8wfmLOVi1o7NWb4COeZh6HX8CgQv8RLIBuksIfDGZBhYXBFoqXO+6n1W+LJ2Xnf+TeqWY+h55pXRF6RGi9r8jx6KZQJbpw2O7qkxHUIE7lTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvnCv8Rc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvnCv8Rc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4BFC19425;
	Sat, 16 May 2026 14:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778942699;
	bh=9M+JrVmDTPYZED8J+E6XPZkY3GK7HDO1YZWVEkorACY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KvnCv8RcQD6ldeg1tu8qnK0vVpJ47+VS29SROgzZ1wB+nmDGt0KLYhNglmsLfPiMs
	 4Lfp5E26j+9zHzyJW7DYI5N+lCeK7m87DbDzQgRUb5c4ALpNC+4MylRs4dKsNuG5DB
	 GHvIwu7/RFx+sDWtk7+aJxNtcWKQlx/5hvKAFmPBIP7kWih5uCMIjU2qTHMsS4+2QJ
	 hMdLl38n8MFvTFMDMyvqGcBwO9LPrCmEPb7qr5lr/ETlnos7HGdy8RsjGJpwmJOrUK
	 UaONMB36w2EGf0LXBDEpT2/TZIJwS5UyXAnrz7PwZAl4Wa/WPwsfsz8XBab147/U+v
	 gnZ/M0mk4zTLg==
Date: Sat, 16 May 2026 15:44:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v2 0/2] iio: light: add support for Broadcom
 APDS9999
Message-ID: <20260516154452.193b51a0@jic23-huawei>
In-Reply-To: <cover.1778659152.git.azpijr@gmail.com>
References: <cover.1778659152.git.azpijr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 10:09:02 +0200
"Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:

> Add IIO driver and DT binding for the Broadcom APDS9999 ambient light
> and proximity sensor. The green channel uses optical coating technology
> to approximate the human eye spectral response for ALS/lux measurements.
> IIO_INTENSITY channels are also provided for red, green, blue, and
> clear/IR so userspace can compute its own weighted lux.
> 
> Questions for reviewers:
>   1. Is the green channel as an ALS/lux approximation acceptable given
>      the datasheet's claim of optical coating to emulate V(lambda)?

It's the best we can do and the datasheet does say to do this. So whilst
I'll express some doubts, it's fine. I think you shout about it enough that
we shouldn't get that copied into other places.

>   2. Is the IIO_INTENSITY channel layout correct? (red, green, blue,
>      clear with modifiers, no scale)

They sometimes still have scale if there is a variable gain amplifier
we need to control / express the value of.  Looks like that might apply here.

However, it's the one channel where the ABI docs make it clear there is not
meaningful unit from _raw * _scale.  Just that if raw doubles and scale
halves we should get the same value.

>   3. Should the binding be merged with avago,apds9300.yaml or kept
>      separate given the extra vled-supply?

I'm fine with this either way. Marginal case.

With those answered, you can drop the RFC for v3 ;)

Jonathan

> 
> v2:
>   - Added IIO_INTENSITY channels for R, G, B, clear
>   - Switched to guard(mutex)(), devm_mutex_init(), dev_err_probe()
>   - Replaced remove() with devm_add_action_or_reset()
>   - Don't fail probe on PART_ID mismatch (fallback compatibles)
>   - Replaced manual shifts with FIELD_PREP() / GENMASK
>   - Used get_unaligned_le24(), sizeof(buf), NSEC_PER_SEC, fsleep()
>   - Named gain register values, explicit resolution enum values
>   - Removed section comments, grouped bit defines under registers
>   - Squashed Kconfig/Makefile into driver patch
>   - Split MAINTAINERS entry across patches
>   - DT binding: added vled-supply, interrupts, required vdd-supply
>   - DT binding: fixed title, added blank lines, full description
>   - Dropped "DT binding" duplication from binding commit subject
> 
> Link to v1: https://lore.kernel.org/linux-iio/cover.1778491503.git.azpijr@gmail.com/
> 
> Jose A. Perez de Azpillaga (2):
>   dt-bindings: iio: light: add Broadcom APDS9999
>   iio: light: add support for APDS9999 sensor
> 
>  .../bindings/iio/light/brcm,apds9999.yaml     |  53 +++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/light/Kconfig                     |  10 +
>  drivers/iio/light/Makefile                    |   1 +
>  drivers/iio/light/apds9999.c                  | 344 ++++++++++++++++++
>  5 files changed, 415 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
>  create mode 100644 drivers/iio/light/apds9999.c
> 
> 

