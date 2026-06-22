Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6BE1A6825;
	Mon, 22 Jun 2026 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145281; cv=none; b=bsWl65UCmNB0hcpESB6ndwiEKHJmOoTya6rmRxX4oxeWiEfbeIvC2lO9WggeFAYBVgq2Y15qgQcLXKHhK8zpIbd0n+DfyJayt3seTQzLsKbLHCQ7J7y4DC5t5Ncdd0/wLIwjqJr+UHMEE+J/d2unMuILe/mY/XoC5hmJi2d0WNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145281; c=relaxed/simple;
	bh=4uA4wLu5tdzgPopqKKK/if4FaKtVz23tmLcHGXGAQTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FS//uAjK9W25E/FvsbdQ96cDZz5RZ4hHJU1Z7LOi2fz1ROasKlqgX8V5C8GJ1vftDPBC1EK3ew4TIweoWEBy0XeB8QUzdOm4RHKQmEqpEJWqaln75mmTHF0eTlFWb7XRLESs437p2zZ0qt4/9+kzrkHFbVk9tbOTdBm53ZUd2SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMnNM/G5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMnNM/G5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6899E1F000E9;
	Mon, 22 Jun 2026 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145279;
	bh=3foZlofiwSV9u+L9w1Xvf8xDTdk1R+hAr/YPZh3gqE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nMnNM/G573MOAY58W87nzysxH1rBHUfiFYPCK9hpYDypaym7JP3X0jZjpaFGPZ3Ov
	 af2bRs/41rZTVhJsK/LAAys+CN+6RU4wT/qFIwjDzpkxtI9FdII11Lc7EulL65QUbx
	 Kyvb2VYLL9vQi1Trlor2tcLjiZ6cSmN2B31hdwRd+JEPLVSYN/1FukW9YljZK5pmak
	 P2OzuVCfoFnLGgVG5huHzT+D6r4Ft4WOWumtajXXfYwON1XOUjH7k5Bi/z5fsjLGc9
	 AH2v023WmAByIimty4BtQaPgXPQaRdqmWa0KgM2+1hU3rD7glo2ShgQw+rML7rop7C
	 mEE7WdYvZMO9A==
Date: Mon, 22 Jun 2026 17:21:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v5 2/6] Documentation: iio: add Open Sensor Fusion
 driver overview
Message-ID: <20260622172110.087f875a@jic23-huawei>
In-Reply-To: <20260616072242.3942-3-kimjinseob88@gmail.com>
References: <20260616072242.3942-1-kimjinseob88@gmail.com>
 <20260616072242.3942-3-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 16:22:38 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Document the Linux IIO mapping for Open Sensor Fusion devices, including
> capability-driven IIO device registration and the initially supported
> receive path.
> 
> Call out that OSF0 is a wire magic value, while protocol_major and
> protocol_minor carry protocol compatibility inside frames. The Linux
> compatible remains the generic Open Sensor Fusion host interface.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
Just one small thing inline.
Otherwise this look good to me.

Thanks,

Jonathan

> ---
>  Documentation/iio/index.rst              |  1 +
>  Documentation/iio/open-sensor-fusion.rst | 71 ++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/iio/open-sensor-fusion.rst
> 
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index ba3e609c6..2713ec5e0 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -38,4 +38,5 @@ Industrial I/O Kernel Drivers
>     adxl345
>     bno055
>     ep93xx_adc
> +   open-sensor-fusion
>     opt4060
> diff --git a/Documentation/iio/open-sensor-fusion.rst b/Documentation/iio/open-sensor-fusion.rst
> new file mode 100644
> index 000000000..cf3bbd761
> --- /dev/null
> +++ b/Documentation/iio/open-sensor-fusion.rst
> @@ -0,0 +1,71 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Open Sensor Fusion
> +==================
> +
> +Open Sensor Fusion is a sensor aggregation hub interface. The Linux IIO driver
> +receives OSF protocol frames from an attached device, discovers supported sensor
> +streams through capability reports, and registers matching IIO devices for the
> +sensor classes supported by the driver.
> +
> +This document is a driver-facing overview for the Linux IIO mapping. The full
> +wire protocol, firmware behavior, and hardware model details belong in the Open
> +Sensor Fusion project documentation.
> +
> +Device Model
> +------------
> +
> +An OSF device sends binary frames from the device to the host. The host driver
> +uses ``CAPABILITY_REPORT`` messages to discover which sensor streams are
> +available. Device Tree describes the attached OSF sensor aggregation hub; it does
> +not enumerate the individual sensors discovered at runtime.
> +
> +The currently supported Linux subset exposes:
> +
> +* accelerometer samples as ``IIO_ACCEL`` X/Y/Z channels,
> +* gyroscope samples as ``IIO_ANGL_VEL`` X/Y/Z channels,
> +* magnetometer samples as ``IIO_MAGN`` X/Y/Z channels, and
> +* temperature samples as ``IIO_TEMP``.
> +
> +Protocol Scope
> +---------------
> +
> +The driver supports OSF protocol major version 0 for the initial IIO receive
> +path. The current wire magic is ``OSF0``; that string is a wire-format detail and
> +is not the Linux driver identity. Device Tree keeps the generic
> +``opensensorfusion,osf`` compatible rather than naming a product such as OSF
> +GREEN or a wire magic value.

I'd remove anything that is documented elsewhere (i.e. the dt-binding)
and instead use a cross reference to it.  That will reduce the chance of this getting
out of sync.

> +
> +Protocol versioning is carried by the ``protocol_major`` and ``protocol_minor``
> +fields at fixed offsets in the OSF frame header. The driver currently
> +supports ``protocol_major`` 0. ``protocol_minor`` changes within major version
> +0 are intended to remain backward-compatible within the fixed header layout.
> +Incompatible wire-format changes require a new ``protocol_major``. A future
> +device that cannot expose compatible version discovery through that fixed
> +header layout would need a different Device Tree compatible.
> +
> +The initial Linux driver handles device-to-host frames for:
> +
> +* ``SENSOR_SAMPLE`` buffered and direct-mode sample data,
> +* ``CAPABILITY_REPORT`` based IIO device registration, and
> +* ``DEVICE_STATUS`` cache updates.
> +
> +Vendor-private message types are ignored. Command transport, calibration
> +control ABI, fusion output ABI, and runtime capability removal are outside the
> +initial Linux IIO receive path.
> +
> +Timestamps
> +----------
> +
> +OSF frames include a device-side ``timestamp_us`` field. Buffered IIO samples use
> +an IIO timestamp captured on the host when samples are pushed to IIO buffers.
> +The initial driver does not correlate the device timestamp with the host IIO
> +clock.
> +
> +Compatibility Notes
> +-------------------
> +
> +The project protocol documentation should define the compatibility rules for
> +reserved fields, optional flags, and trailing extension data. Until those rules
> +are finalized, the Linux decoder keeps conservative bounds checks around the
> +currently supported message layouts.

