Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A05391E51;
	Sat, 17 Oct 2026 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264632; cv=none; b=PR0xojT2WSDQkBoGppFlQqHH6bCsOkV5aef0w52p/2w1AeSsclEzMoJL7rA7lHXD5mfpi9j+zJw+5zTNmeoRMvG8oB0I5WMz8XWmYn24pG2KuteIxhOMND5uUpDliMqEKeaMtc5eVy4f98whgSJ7bLwEBPNqcElLaXmbEHhnKaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264632; c=relaxed/simple;
	bh=B0S+wZ9j/+uDeLeKw5x2uTP8BM7fjVJGsieyFHo2XXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZz4HeS/6/qd1HUbkB6Ih0jnUMs7VtIpJb9kwj884be1a8o6Rg3c7Uf8qeEN3IZqJXLSC6prXdU9dj8o/vQCEYQYxUEzN7GpHT5axLJXiSsraqpKBobc/XOgPrDlUelDKNJKTuNW6sEjDnJpgT//mPKAJhMhGQirK5BdGIxxOcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUY5le4k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUY5le4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF8D1F000C4;
	Sat, 17 Oct 2026 19:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792264631;
	bh=L25T1TeXcVBawDrw9ktK7UKnthFZSospNX7XlM/OSz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VUY5le4kg8qYzUrp8VajhFGISwc/v/z11z6bmlonF6CBooPm5IvcG+RbsxQ1DaDqL
	 Zlo4oY9ymqmwhabYANsFg3mWi70fMseGjyypwV6+eejxQ1ABdAr3aZgfOwukWzW2zn
	 Bv7uKCsc4VSZe6b5pFmh9k1sJsPDBqFIyXPZHwqO2wDWJF328kHJd7PkyVShBmtnIs
	 aWGLm13d1OaNahjQrEfNlaMM7VD4bcYuJGBhlCZvG9BUO3bmk9XDjoxv6BHKVSvhUp
	 tt3t8BWHDj5QWGGXlcVgec8ulsEg2m2kF5mPPesvQsd5zF2kCVJfNqjgkdFXpzKPuh
	 jOje9KDR87I3A==
Date: Sat, 17 Oct 2026 20:17:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <Michael.Hennerich@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v5 00/15] iio: adc: ad4134: Enable greater sample rate
 data capture
Message-ID: <20261017201707.4179671b@jic23-hlaptop>
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 22:56:00 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Extend AD4134 support to enable greater sample rate data capture. To achieve
> that, provide control of digital filter type selection. The default filter
> type on device power up only supports sample rates up to 374 kSPS. In addition
> to that, enable interfacing with AD4134 in SPI 4-wire mode that can support
> reading ADC sample data through multiple wires. Finally, use SPI offloading
> to speed up data transfers at up to 1.49 MSPS.
> 
> Features being added:
> - Data filter type selection.
> - Triggered buffer data read.
> - SPI 4-wire mode.
> - High speed data capture with SPI offloading.
> - Device tree doc updates.
> 
> Minor improvements (introduced before the new features):
> - Sign extend sample data.
> - Apply reset recovery wait time.
> - Update include list to comply with IWYU principles.
> - Serialize single-read operations.
> - Run shorter transfers when CRC is disabled.
> - Protect conventional device access from debug accesses [NEW PATCH]
> 
Mostly looks fine to me.  I'll assume you will take a look
at sashiko feedback before doing v6.
I may well start picking up parts of this series if it looks
like they are ready and the tail of the series needs more work.

I gave a couple of late replies to your earlier postings before
catching up with this one.

Jonathan

> 
> Change log v4 -> v5:
> [device tree]
> - No changes in dt-doc.
> [IIO]
> - Initialized local variable with 0 to avoid build warns.
> - Set max_register according to AD4134_NUM_CHANNELS.
> - Apply reset recovery wait time. [NEW FIX PATCH]
> - Protect conventional device access from debug accesses. [NEW PATCH]
> - Re-arranged code so early function prototype declaration is no longer needed.
> - Now using iio_for_each_active_channel() to iterate over IIO channels.
> - Updated adi,spi-mode property handling.
> - No longer selecting/deselecting multiplexer states when in minimum I/O mode.
> 
> 
> Previous submissions:
>   v1: https://lore.kernel.org/linux-iio/cover.1788368334.git.marcelo.schmitt@analog.com/
>   v2: https://lore.kernel.org/linux-iio/cover.1789494473.git.marcelo.schmitt@analog.com/
>   v3: https://lore.kernel.org/linux-iio/cover.1790719424.git.marcelo.schmitt@analog.com/
>   v4: https://lore.kernel.org/linux-iio/cover.1791309733.git.marcelo.schmitt@analog.com/
> 
> 
> Marcelo Schmitt (15):
>   iio: adc: ad4134: Adjust register map range
>   iio: adc: ad4134: Sign extend sample data
>   iio: adc: ad4134: Apply reset recovery wait time
>   iio: adc: ad4134: Update include list to comply with IWYU principles
>   iio: adc: ad4134: Serialize single-read operations
>   iio: adc: ad4134: Protect conventional device access from debug
>     accesses
>   iio: adc: ad4134: Run shorter transfers when CRC is disabled
>   iio: adc: ad4134: Add support for digital filter type selection
>   iio: adc: ad4134: Support buffered data read
>   dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
>   dt-bindings: iio: adc: adi,ad4134: Document external multiplexer usage
>   iio: adc: ad4134: Support SPI 4-wire mode
>   dt-bindings: iio: adc: adi,ad4134: Document PWM usage
>   iio: adc: ad4134: Support high-speed data capture
>   Docs: iio: Add AD4134
> 
>  .../bindings/iio/adc/adi,ad4134.yaml          | 110 ++-
>  Documentation/iio/ad4134.rst                  | 127 +++
>  Documentation/iio/index.rst                   |   1 +
>  MAINTAINERS                                   |   1 +
>  drivers/iio/adc/Kconfig                       |   8 +
>  drivers/iio/adc/ad4134.c                      | 793 +++++++++++++++++-
>  6 files changed, 987 insertions(+), 53 deletions(-)
>  create mode 100644 Documentation/iio/ad4134.rst
> 
> 
> base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7

