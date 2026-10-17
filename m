Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141BE4CF490;
	Sat, 17 Oct 2026 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792280656; cv=none; b=YUn5CNgrxDuSFBPAy5BuRpCkqjWJH5b3A2GMLhZ4tnHAzPz6Iwn/+5+4SW8lJaD04O2MlcdxHVRyum2yLDiwKJYTiCWOThuy+ntfPV1ruYskZWNUmyeDe8R+mQA70P4ui1Yso/RMehasAPiLIyXalyWfALjhvXMyygwArE6ZWJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792280656; c=relaxed/simple;
	bh=PvSBQX7HKyUc93YW7gjnK9DSlXLiZ4eayc3bRmERyLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDCJNUN8HwPLTB0XUtgXJdV7cpjJKVoYvSoXzl26wUivVgK1xp4OT08e+xGfAcLTRaQUlVp+VkFrC1DdqDz3EyJvVFT4fDPnUZwE0YoGjy4IyM8NQDmh2sgH7UbAPwk/adPPsMDyuckkJZkCoNq/SlmNNRbbxm9F5Wowrc506hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zeo+12Kd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zeo+12Kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8341F000C4;
	Sat, 17 Oct 2026 23:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792280654;
	bh=GdkUJBJXGvO1JP6r+c8oq/P+9Ri/jpQUrghS/tRabB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zeo+12Kd9xlUAbUSVqmuF129yu0usyK8TlsfMpnN5uxES/MIEEmWQHwX9+0l0LTff
	 OAgjeX1h505sAVit/YqMY/7gQDxCMR2Zvm4urtz23Hb/VuS/ku3X8n57KiAEuFYEWu
	 Jwh/J7eATiM0S9YfpftIYdTOSK9+oCvLTZlgDxrO8ESsWO0KfO1voPlhBZKtcIjMAn
	 VL+pGyfu/V2MOA+7lRwpT4jDAWjVMOvaq+aaKjY9lawuOXmGM/pJsgKzbbYbPx/M3O
	 OkPp2mNyS7X3F/F8qvVDzJLAbFPSFOOvsn98eAvBO6jolq0gUARb5R4JKkqm6XPz7+
	 Vwux5cHWP/JgA==
Date: Sun, 18 Oct 2026 00:44:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Radu Sabau <radu.sabau@analog.com>, Janani
 Sunil <janani.sunil@analog.com>, Salih Erim <salih.erim@amd.com>, Jishnu
 Prakash <jishnu.prakash@oss.qualcomm.com>, Jakub Szczudlo
 <jakubszczudlo40@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 4/4] docs: iio: ade9000: document ADE9039 support
Message-ID: <20261018004407.46d95228@jic23-hlaptop>
In-Reply-To: <20261012111342.48040-5-antoniu.miclaus@analog.com>
References: <20261012111342.48040-1-antoniu.miclaus@analog.com>
	<20261012111342.48040-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 14:13:40 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add the ADE9039 to the list of supported devices and note that, unlike the
> ADE9078 and ADE9430, it does provide the on-chip dip/swell events. Also
> document that it exposes no total reactive power attributes, since the part
> computes only fundamental reactive power.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/iio/ade9000.rst | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
> index 0c0a8ea8213b..13b7ecf83cb8 100644
> --- a/Documentation/iio/ade9000.rst
> +++ b/Documentation/iio/ade9000.rst
> @@ -1,12 +1,11 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -==============================
> -ADE9000/ADE9078/ADE9430 driver
> -==============================
> +======================================
> +ADE9000/ADE9078/ADE9430/ADE9039 driver
> +======================================

You can probably guess by now ;)  Numeric order.

>  
> -+This driver supports Analog Devices' ADE9000, ADE9078 and ADE9430 energy
> -+measurement ICs on SPI bus.
> -ICs on SPI bus.
> +This driver supports Analog Devices' ADE9000, ADE9078, ADE9430 and ADE9039

and this one.  Might be worth switching to bullet points to reduce churn
for the next device.

> +energy measurement ICs on SPI bus.
>  
>  1. Supported devices
>  ====================
> @@ -14,6 +13,7 @@ ICs on SPI bus.
>  * `ADE9000 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf>`_
>  * `ADE9078 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf>`_
>  * `ADE9430 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9430.pdf>`_
> +* `ADE9039 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9039.pdf>`_

Guess what :)


>  
>  The supported parts are highly accurate, fully integrated,
>  multiphase energy and power quality monitoring devices. Superior analog
> @@ -24,9 +24,15 @@ for the entire channel including a programmable gain amplifier (PGA) and an
>  analog-to-digital converter (ADC).
>  
>  The ADE9078 and ADE9430 do not provide the on-chip dip/swell (sag) detection
> -available on the ADE9000, so the RMS voltage swell/dip events described below are
> -only available on the ADE9000. The ADE9430 additionally has no on-chip digital
> -integrator and instead uses an external analog integrator for Rogowski coils.
> +available on the ADE9000 and the ADE9039, so the RMS voltage swell/dip events
> +described below are only available on those two parts. The ADE9430 additionally
> +has no on-chip digital integrator and instead uses an external analog integrator
> +for Rogowski coils.
> +
> +The ADE9039 computes only fundamental reactive power and has no total reactive
> +power register, so the ``in_power[0-2]_reactive_*`` files described below are
> +not present on that part. The reactive energy files are unaffected, as every
> +supported part accumulates fundamental reactive energy.
>  
>  2. Device attributes
>  ====================

