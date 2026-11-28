Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795831913;
	b=EY34nW7x8iSCNPbt+HFPtlCRbz8XDZA1KGt1d82pKAJnIrz3F+3zN9YZr1TAnpfyRN0y
	 QlTSjvVknRBdnhbVA08iXtrv5wmCsxfip+oxyn6SSBtvKnalU+TSKn/xqe+VB2uz5kplR
	 CPxLTDjEB+KIbmpZR0jVMCRv1XhExGGU/WFypvEvu0oF0+LrQsXDZX6GZPbwDV69/Zf2c
	 S1bT7Psy3B7+UkBT9K4LFpBpcnMmqYrPfVHOIl0J2pyq/SHn7QwobQPmHkvKTlVgmieCm
	 A+bAeCvx7CvpOPTpUFZ/YItyRnIr5o6WNgvEjdSAMMMGHf54wNsitlubo5D9BaftLcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795831913;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hEFPo6U1iCQb4pbKLYkGAkm38AyWvr0lKY/Xs7M5frM=;
	b=3RO83bn27u16l9L0wwtL3kB7jmImkZPjKGWsujNJOuFPL0JHLIV04MPo/HWSwFgwJ03K
	 rDky/5jxZrs8oEXeD0Df4vreY6/Cs2wFI32VLwhByDFsmmV1Hv+6d9rSOvkXijWHGnjXR
	 yqVk6cNZ9CW7fLXuVqr81BPToDZy8KLCS7db7vJfAI6dlrpsOXoqEHh6Rk2u0eM5bh2Z2
	 7yt/Kx4J/3ia7lzmaBUEHZN+AA7IaWZsXsPbAPIoYSOrrYeqxv+gsxct+u7+i6VFtV1Da
	 YqcnV9uyTYbdwKT8h8MuTHroE4TOfNrvk8KoMdIrRUmoF21oFLhWTltp8AWeKzBDUEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHw9VI6W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72418606A31C;
	Sat, 28 Nov 2026 02:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHw9VI6W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D541F00893;
	Sat, 28 Nov 2026 02:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795831913;
	bh=hEFPo6U1iCQb4pbKLYkGAkm38AyWvr0lKY/Xs7M5frM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DHw9VI6Wx3lH++eBGpLtb1iwcR+ga53NtsRWRIOTnlwbgzUSlmxldiQwS6cMHQHCa
	 5sWNyCrfAyD/R1EcLI2B1Dws9zBujSj6Q80vutVF17TSTAOb+FNM/ETsgFwEz6KfD6
	 JDWKfrA0KgQBhhsIJUHT4hGcaa1OcVygyOp9VmVoCv0MlrtOItql7hFN0vu850phta
	 Lrx7v8r+yAL8b+SnejC/7A4cglITTn4IPkTQwMms3ArVm8CeWGHDICUot7cwcHBApJ
	 QuAIVp+/O21ttKWxMYwocBR8SlJFomX399GlPV0TgucB+2kKYLpzXamJ/ECBPq0j/I
	 kNTqoQDNZPvMw==
Date: Sat, 28 Nov 2026 02:11:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Romain TISSERAND <romain.tisserand@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 0/4] iio: adc: Add the Miyoo A30 and PocketGo S30 analog
 stick MCUs
Message-ID: <20261128021144.67d1672f@jic23-hlaptop>
In-Reply-To: <awluLgvMt9BN1Aj8@ashevche-desk.local>
References: <20261127012612.1589039-1-romain.tisserand@gmail.com>
	<awluLgvMt9BN1Aj8@ashevche-desk.local>
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

On Fri, 27 Nov 2026 13:49:02 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Nov 27, 2026 at 02:26:08AM +0100, Romain TISSERAND wrote:
> > The Miyoo A30 and the PocketGo S30 are two Allwinner A33 handhelds
> > whose analog stick is read by a small microcontroller: the MCU samples
> > the stick potentiometers and hands the raw 8-bit readings to the SoC,
> > on a UART (A30, a stream of frames at 9600 baud) or over I2C (S30, a
> > four-byte read with complements). Neither MCU takes commands.  
> 
> Why a brand new driver for each of the cases?

I'd also ask whether we expect to ever see these as useful other than
for the joystick function.  If not maybe going directly to input makes
more sense than using the adc joystick bridge?

Basically more info needed.

> 
> > Both drivers expose the readings as raw IIO channels for the existing
> > adc-joystick driver. The A30 MCU pushes its frames on its own, so its
> > driver also feeds a software IIO buffer and adc-joystick takes the stick
> > from it without polling. The S30 MCU only answers when read and has no
> > data-ready line, so adc-joystick polls it, as on the Anbernic RGxx3
> > boards where the stick is behind a SARADC. There is no scale: the
> > readings are raw ADC codes of the MCU.  
> 
> > Patches 1 and 2 add the A30 binding and driver, patches 3 and 4 the S30
> > ones. Both use the existing "miyoo" vendor prefix (the PocketGo S30 is
> > a Miyoo/Bittboy product). The board devicetrees will be sent to the
> > sunxi tree.
> > 
> > Testing: each patch built with W=1 for arm (multi_v7_defconfig, both
> > drivers =y and =m) and arm64 (defconfig, =m), no warnings;
> > dt_binding_check clean for both bindings; the board devicetrees pass
> > dtbs_check with these bindings.
> > 
> > On a PocketGo S30 on 7.3.1: about one single read in four fails an exact
> > complement check (the value and its complement differ by a count or two
> > at rest, up to about thirty while the stick moves fast); with the +-2
> > tolerance and up to three tries, polling as adc-joystick does (two reads
> > every 10 ms), no read failed over 2 x 6000 reads at rest and moving, and
> > under 2% needed a second try (exact check: about 4% failed). The in-tree
> > adc-joystick driver on the S30 channels reported 365 and 374 events over
> > 15 s of full circles, 42..231 and 24..246.
> > 
> > On a Miyoo A30 on 7.3.1: rest 136/123; reading the channels from sysfs,
> > full circles 22..248 (X) and 11..221 (Y). The in-tree adc-joystick
> > driver, without poll-interval, takes the stick from the IIO buffer: 826
> > and 852 events over 15 s of full circles (the MCU sends about 67 frames
> > a second), 37..246 and 11..220.
> > 
> > Retested with this version on the A30 (7.3.1): with only one channel
> > enabled in the buffer, each channel gives its own axis (stick held
> > right: ch0 alone 141..242, ch1 alone 116..119); three unbind/bind rounds
> > with adc-joystick bound: no warning, the readings and the adc-joystick
> > device come back; at rest 139/118, +-1 over 50 sysfs reads.
> > On the S30 (7.3.1): at rest 152/126, no failed read; adc-joystick 1213
> > events over 15 s of full circles; three unbind/bind rounds: no warning,
> > readings and adc-joystick back.  
> 

