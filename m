Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50C2E0938;
	Tue,  7 Jul 2026 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783397278; cv=none; b=QBLKd7hywBnxKlcizWuyqEVnwtN31q6XgKgWRsMCaOv6tan5s2MNUb3u/YAgCCjKJMNsMXFKdhQ3kYCzIe9TKVkEnBQNWO37t3Wfl7Kc9+xIosIR4WMh+T5Mm9pmp7GevXBJPfhSU8QeQg9OPVGGENWT715U/GfLPfXlT7jDf4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783397278; c=relaxed/simple;
	bh=Mnm+QDM18jaBTnITZ8LhUvY8UH/uLkw8ljECX+Rp3Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+qtIA7yzetLs+VHxjS9o3ZPZTnImeKZTwQLKudZOCSu81L0k/2RAa0c7o2UM7Q5VQ/YBk36+wf0bpwuhI7GD0z6pdZbjCfUzN/txWBPq7stf3Xfw5UVsst9WYtxmey6MErySKo1CCX5HuCE5ikxloR/7GN0x5XSqNRrBo3tWDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZGmnpZJ1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZGmnpZJ1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/uUqvGVDn84bGWFIJxMYn8XYjtsG+6tV2VQh01XaWJ0=; b=ZGmnpZJ1BzF6Y29UwYPTMK1EuW
	jxwxhtVNvdmPPWiqAwdQYPT2QkcadWid073IGOlQ7yWsGs6JEZHuEZ3gGjC+pRbyq54nJ3kcjU1fv
	89ukb59XWzDqGTFF+SNxL6h1HL70nERuP9Aloy+8IFPvlQNFjQSt7vzThlhvtwISp7Xcqb9KvlgcP
	Np62EmuDKEJlGhvKzGtFEzwaGdaVpP/v1Ix4hsWLFzJtj6bHnLkWuYrV0nFjMEz4cVQ4jX5+bWZeM
	iJ9GZFGIVGys7kae+thMNO8+43bIrLZy1bacYEs5X9RRFhbKR0VVbZqQS268PWTDavbO5o7OEiuF1
	E5X5FLxQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgx68-0000000E3Hm-0Jlr;
	Tue, 07 Jul 2026 04:07:52 +0000
Message-ID: <42c9f129-2609-40ab-913c-56ebf9aeda1a@infradead.org>
Date: Mon, 6 Jul 2026 21:07:51 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] Documentation: iio: add Open Sensor Fusion driver
 overview
To: Jinseob Kim <kimjinseob88@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260707014525.1015-1-kimjinseob88@gmail.com>
 <20260707014525.1015-3-kimjinseob88@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260707014525.1015-3-kimjinseob88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/6/26 6:45 PM, Jinseob Kim wrote:
> Document the Linux IIO mapping for Open Sensor Fusion devices.
> 
> The overview explains that sensor channels are discovered at runtime
> from mandatory capability reports. It also documents that OSF0 is a
> wire-format detail and that protocol_major and protocol_minor carry
> protocol compatibility information.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>


Tested-by: Randy Dunlap <rdunlap@infradead.org> # docs build
Thanks.

> ---
>  Documentation/iio/index.rst              |  1 +
>  Documentation/iio/open-sensor-fusion.rst | 72 ++++++++++++++++++++++++
>  MAINTAINERS                              |  1 +
>  3 files changed, 74 insertions(+)
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
> index 000000000..c28886f3b
> --- /dev/null
> +++ b/Documentation/iio/open-sensor-fusion.rst
> @@ -0,0 +1,72 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Open Sensor Fusion
> +==================
> +
> +Open Sensor Fusion is a sensor aggregation hub interface. The Linux IIO driver
> +receives OSF protocol frames from an attached device and registers matching IIO
> +devices for the sensor classes supported by the driver. The actual sensor
> +channels are discovered at runtime from mandatory OSF capability reports.
> +
> +This document is a driver-facing overview for the Linux IIO mapping. The full
> +wire protocol, firmware behavior, and hardware model details belong in the Open
> +Sensor Fusion project documentation.
> +
> +Device Model
> +------------
> +
> +An OSF device sends binary frames from the device to the host. Devices using the
> +``opensensorfusion,osf`` compatible are expected to provide
> +``CAPABILITY_REPORT`` messages so the host can discover which sensor streams are
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
> +The driver supports OSF protocol major version 0 for the IIO receive path.
> +The current wire magic is ``OSF0``; that string is a wire-format detail and is
> +not the Linux driver identity. Device Tree keeps the generic
> +``opensensorfusion,osf`` compatible rather than naming a product such as OSF
> +GREEN or a wire magic value.
> +
> +Protocol versioning is carried by the ``protocol_major`` and ``protocol_minor``
> +fields at fixed offsets in the OSF frame header. The driver currently
> +supports ``protocol_major`` 0. ``protocol_minor`` changes within major version
> +0 are intended to remain backward-compatible within the fixed header layout.
> +Incompatible wire-format changes require a new ``protocol_major``. A future
> +device that cannot expose compatible version discovery through that fixed
> +header layout would need a different Device Tree compatible.
> +
> +The Linux driver handles device-to-host frames for:
> +
> +* ``SENSOR_SAMPLE`` buffered and direct-mode sample data,
> +* ``CAPABILITY_REPORT`` based IIO device registration, and
> +* ``DEVICE_STATUS`` cache updates.
> +
> +Vendor-private message types are ignored. Command transport, calibration
> +control ABI, fusion output ABI, and runtime capability removal are outside the
> +Linux IIO receive path.
> +
> +Timestamps
> +----------
> +
> +OSF frames include a device-side ``timestamp_us`` field. Buffered IIO samples use
> +an IIO timestamp captured on the host when samples are pushed to IIO buffers.
> +The driver does not correlate the device timestamp with the host IIO
> +clock.
> +
> +Compatibility Notes
> +-------------------
> +
> +The project protocol documentation should define the compatibility rules for
> +reserved fields, optional flags, and trailing extension data. Until those rules
> +are finalized, the Linux decoder keeps conservative bounds checks around the
> +currently supported message layouts.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4df9d8dc..17c80b55b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20015,6 +20015,7 @@ OPEN SENSOR FUSION
>  M:	Jinseob Kim <kimjinseob88@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> +F:	Documentation/iio/open-sensor-fusion.rst
>  K:	opensensorfusion
>  
>  OPENCOMPUTE PTP CLOCK DRIVER

-- 
~Randy
