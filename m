Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558BF3C3C0E;
	Thu, 28 May 2026 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974894; cv=none; b=CYQxz7uehmU0XHb1iH97ZV3/rumc/2oioaDTt0SAIGYkMUiel7P3McqDSChPxoMtKICvaeZMpoJG+j/cZ3/6CwTD1fX8T4lEJLvC3V80J9v82PKs8iZa2K+XgOqLDdEvpm+ijCKlgRcdKRZG71PgeMcsRZtqnfihBlftvyRHCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974894; c=relaxed/simple;
	bh=2/79Xl9j6URhvHGJvox012U1c+nNuesozE5cNI9IjDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfnYVGJ/stU4U2yAF91SUDmMhiKfmXIHRDFGF+Hew/G2MCzOtnEb+vjZVXwi3nAWXh4i8OK7lk0Ae1vjoaAKlQ2pp0QuexgpJfE1VjJY9d2rAirI2EAmShVmnqMN1xzpUpVXracbPJUmdgla/DpdRNepTnGY3Xfpca0PeX2hj9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifqwe+UK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifqwe+UK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEF61F000E9;
	Thu, 28 May 2026 13:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779974893;
	bh=fVbHTcPUYD/TlD5jqvCK3yaWHdNW7U/NQpwQOV26rnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ifqwe+UK55I3YvgNmZztbCWFPDGSE6e9ZnW+JCsY+9u4tGAWvEqsib2n1LIQkFSBI
	 WKzVeJHlui91r/q/OurdprwiQLtxIlJRtzZxCCh5JoYc/DYWwox85ORGq5IlruTigy
	 CP0DHA4uju05nGKb+XaLOq1CpWt/60GXHMfMoHzAVD5nU370Xq1bgkQD4w0Mo4kvFu
	 Ho5QdJuHyZ8js936Ts1qfJx8IybF9+KhXg8q3COe7F3jkgYynaoG8jBiYtjBlJlLH0
	 f3QEJyt59u0Fj0nKVHxmhf5SjxVGcVufB7RTYET1/aSUsxVvtsZQstLuidHmiomSHV
	 vOEwSLgvWpyLQ==
Date: Thu, 28 May 2026 14:28:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/7] Documentation: iio: add Open Sensor Fusion
 protocol v0 reference
Message-ID: <20260528142803.15e3ff83@jic23-huawei>
In-Reply-To: <20260524085312.15369-3-kimjinseob88@gmail.com>
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
	<20260524085312.15369-3-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 17:53:07 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Document the OSF0 frame format and payloads used by the driver.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---
>  .../iio/open-sensor-fusion-protocol-v0.rst    | 267 ++++++++++++++++++
>  1 file changed, 267 insertions(+)
>  create mode 100644 Documentation/iio/open-sensor-fusion-protocol-v0.rst
> 
> diff --git a/Documentation/iio/open-sensor-fusion-protocol-v0.rst b/Documentation/iio/open-sensor-fusion-protocol-v0.rst
> new file mode 100644
> index 000000000..4800a3ce6
> --- /dev/null
> +++ b/Documentation/iio/open-sensor-fusion-protocol-v0.rst
> @@ -0,0 +1,267 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Open Sensor Fusion protocol v0
> +==============================
> +
> +This document describes the OSF0 UART wire format used by the Linux IIO
> +driver. It is not a firmware programming interface.

Can we have some background information. Where does this OSF thing come from?
Is it a general standard or something you are personally developing?
Some links would definitely help.

> +
> +Device model
> +------------
> +
> +An Open Sensor Fusion UART device is a sensor aggregation device. It sends
> +binary frames from the device to the host. The host driver decodes the frames
> +and maps supported sensors to IIO devices.
> +
> +The hardware used for smoke testing is an OSF GREEN prototype with an
> +STM32F405RGT6 MCU, an ICM42688P-class IMU, and an MMC5983MA magnetometer. That
> +hardware is a test target, not part of the binding ABI.
> +
> +Transport
> +---------
> +
> +The transport is UART at 115200 baud, 8 data bits, no parity, and 1 stop bit.
> +The Linux transport is serdev. The v0 upstream driver covers device-to-host
> +frames. Flow control is not used by the tested stream.
> +
> +Byte order
> +----------
> +
> +All multi-byte integer fields are little-endian. Samples use signed 32-bit
> +little-endian integers when ``sample_format`` is ``S32``.

s32 given this is kernel code and i'm not sure what else this is referring to.



> +``SENSOR_SAMPLE`` payload
> +-------------------------
> +
> +The base payload size is 16 bytes.

Not sure that is meaninful given expectation that there will be channels.
I'd describe it as a payload header, or express this as 16 + 4 * channel_count

> +
> +.. list-table::
> +   :header-rows: 1
> +
> +   * - Offset
> +     - Size
> +     - Field
> +     - Description
> +   * - 0
> +     - 2
> +     - sensor_type
> +     - Sensor type ID
> +   * - 2
> +     - 2
> +     - sensor_index
> +     - Instance index
> +   * - 4
> +     - 2
> +     - channel_count
> +     - Number of S32 channels
> +   * - 6
> +     - 2
> +     - sample_format
> +     - Must be ``1`` (``S32``)

Is this spec defined, or just what the driver supports?
I think this doc needs to distinguish between those two cases
more clearly.

> +   * - 8
> +     - 4
> +     - scale_nano
> +     - Scale factor in nano-units
> +   * - 12
> +     - 4
> +     - reserved
> +     - Must be zero for v0
> +   * - 16
> +     - 4 * channel_count
> +     - samples
> +     - Signed 32-bit channel samples
> +
> +``DEVICE_STATUS`` payload
> +-------------------------
> +
> +The payload size is 20 bytes. Fields are ``uptime_s``, ``status_flags``,
> +``error_flags``, ``dropped_frames``, and a reserved field. Each field is
> +32 bits.
> +
> +``CAPABILITY_REPORT`` payload
> +-----------------------------
> +
> +The base payload size is 4 bytes. It contains ``capability_count`` and a
> +reserved field. Each capability entry is 20 bytes:

Probably want a separate table for that header.

> +
> +.. list-table::
> +   :header-rows: 1
> +
> +   * - Offset
> +     - Size
> +     - Field
> +     - Description
> +   * - 0
> +     - 2
> +     - sensor_type
> +     - Sensor type ID
> +   * - 2
> +     - 2
> +     - sensor_index
> +     - Instance index
> +   * - 4
> +     - 2
> +     - channel_count
> +     - Number of channels
> +   * - 6
> +     - 2
> +     - sample_format
> +     - Must be ``1`` (``S32``)
> +   * - 8
> +     - 4
> +     - scale_nano
> +     - Scale factor in nano-units
> +   * - 12
> +     - 4
> +     - flags
> +     - Capability flags
> +   * - 16
> +     - 4
> +     - reserved
> +     - Must be zero for v0
> +
> +Capability flag bit 0 means enabled by default. Bit 1 means calibrated data can
> +be provided by the device. Other bits are invalid for v0.
> +

> +Scaling
> +-------
> +
> +``scale_nano`` is the per-channel scale value in nano-units. The Linux driver
> +maps it to ``IIO_CHAN_INFO_SCALE`` as integer plus nano. The exact physical
> +unit depends on the IIO channel type.
> +
> +Timestamps
> +----------
> +
> +The frame header carries ``timestamp_us``, a device-side timestamp in
> +microseconds. v0 transports this value for ordering and diagnostics. The driver
> +does not use it as a production-grade host-correlated timestamp. Buffered IIO
> +timestamps follow IIO timestamp clock handling.

Is there likely to be a non trivial delay?  If so we should figure out how to use
that timestamp to get something more useful.

> +
> +Non-goals for v0 upstream
> +-------------------------
> +
> +The v0 upstream driver does not include USB transport, fusion output,
> +AHRS/Kalman output, calibration command ABI, custom sysfs control surface,

What is AHRS?  I'd spell it out.

> +production timestamp correlation, or runtime capability removal.
This is where an external link would be helpful. Lets us have some visibility
of what is coming.

Thanks,

Jonathan


