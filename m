Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0C3655E7;
	Sun, 31 May 2026 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780223761; cv=none; b=j8+ivN0Sg/iPqEa3GEMzZTtEOZlybe6KraZjwrHW3xJSnERu8OfhvlMwZqz3BV7wKXNA0ptcHqa5Dgrv8FLwLP2jPffVKdfnTPE9gSM8QuT0b0TdwVkCwclB3YbLTBrrch/yzm2vcFShQYB9Xc2o2ZxrRw0fJES1wg/vCP2B7R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780223761; c=relaxed/simple;
	bh=1G0nkc+Iw2tT50tx9w61tNIQi9z4eUpxLWyfhWy17Co=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edIpO9isV63AqAvEsRpMzFAPSYQaFGdaXC4epTtRDxcyaR85Sx6W/eJ7HbxtL3mWcg+Qb04ItAKxjGL8HUrRJ7GUpa97CCGkd603VVaTScIfYCNEx3uyCtuzrKqd1jOgX636L3yjGu3litO0C47vZ94R8QNspHEVEoZnWLqApQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB/JBubl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB/JBubl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431C41F00893;
	Sun, 31 May 2026 10:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780223760;
	bh=FGOfpTaLFBbwbz4bJZuuCKZCPC87QxvhCHR9YsReOng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mB/JBubl+WCmeFx0E1o12IrletqnIxf1XLPP5wktLcNAgu/0ukwQAdgDJSWwyt8f8
	 AXZqOcEbGqMv/9Amn71A2R+YdqYEHN/4zTNrpdToVhANtr58Yv9Wybnxl0FcNwdGJn
	 cWBJLoUDGqH2NfR0FXb5Li9MVO3aaXq4MIeUdPcshSoeV8bh24lQyJ2RIuIjLd04bO
	 EePJFRVyIucbyfV73qkN4aFvdUNq0etKd6NKrKyEH8M8ifU7MMUcu4iFWpaWnNienh
	 h/1As7leUb8gMLg97YvvG/cE2khU7kXJk1lvkqhZfhh/4ipkVMLBHRuq/tiT7b3N/n
	 8cTfq2caJsjOA==
Date: Sun, 31 May 2026 11:35:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/6] Documentation: iio: add Open Sensor Fusion
 protocol v0 reference
Message-ID: <20260531113550.2b1852f8@jic23-huawei>
In-Reply-To: <20260529121005.1470-3-kimjinseob88@gmail.com>
References: <20260529121005.1470-1-kimjinseob88@gmail.com>
	<20260529121005.1470-3-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 21:10:01 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Document OSF0 UART frames and the supported RFC driver subset.
> 
> Extend MAINTAINERS to cover the protocol reference.

Some of this perhaps should just be cross references to project docs.
Other things that repeat:
- Avoid lists of what isn't supported. They become wrong fast, just list what
  is supported.
- Don't reference driver versions (definitely not RFC ones!) in docs.

Mostly a case of ensuing you have one canonical source for the protocol
docs and that what you have here doesn't become 'wrong' if new features
are added either to the sensor platform, or to the driver - it just becomes
potentially out of date.

Jonathan

> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---
>  .../iio/open-sensor-fusion-protocol-v0.rst    | 308 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 309 insertions(+)
>  create mode 100644 Documentation/iio/open-sensor-fusion-protocol-v0.rst
> 
> diff --git a/Documentation/iio/open-sensor-fusion-protocol-v0.rst b/Documentation/iio/open-sensor-fusion-protocol-v0.rst
> new file mode 100644
> index 000000000..80852f4cf
> --- /dev/null
> +++ b/Documentation/iio/open-sensor-fusion-protocol-v0.rst
> @@ -0,0 +1,308 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Open Sensor Fusion protocol v0
> +==============================
> +
> +This document describes the OSF0 UART wire format used by the Open Sensor
> +Fusion Linux IIO driver. It is a wire format reference for the host driver. It

I'd argue this is spinning it wrong.  It is the wire format used by the device
implementing your protocol.  Linux is just one "customer".

> +is not a firmware programming interface.
> +
> +Background
> +----------
> +
> +Open Sensor Fusion is an open hardware project for sensor aggregation devices
> +and Linux IIO host support. It is not a generic sensor protocol standard. The

Again, why Linux specific?  Nothing wrong with starting there, but if this is
successful seems unlikely this will be the only host OS.

I'd talk about the Linux/IIO driver as a reference stack or something like that.

> +first concrete hardware target is OSF GREEN, an STM32F405-based board that
> +streams OSF0 frames to a Linux host.
> +
> +Public project documentation is available at:
> +
> +- https://www.opensensorfusion.org/
> +- https://github.com/opensensorfusion
> +- https://github.com/opensensorfusion/opensensorfusion-hardware
> +- https://github.com/opensensorfusion/opensensorfusion-linux

> +
> +Wire format and driver subset
> +-----------------------------
> +
> +OSF0 defines a small device-to-host UART frame format. The current RFC driver

Don't talk about "RFC" in here because that's just text that will become wrong
and might get missed when you move on from RFCs.

> +supports only the subset needed to expose OSF GREEN raw sensor data through
> +IIO:
> +
> +- ``SENSOR_SAMPLE`` frames for accelerometer, gyroscope, magnetometer, and
> +  temperature samples.
> +- ``CAPABILITY_REPORT`` frames used to create the supported IIO devices.
> +- ``DEVICE_STATUS`` frames cached for diagnostics.
> +
> +The driver ignores vendor private message types and does not implement command
> +transport, calibration controls, USB transport, fusion output, or runtime
> +capability removal.

Generally I'd avoid adding notes in documentation for what is 'not' supported.
That stuff tends to become wrong fast :) Just focus on what is supported and by
all means say that it is a subset of functionality, just don't list what that
'other' is.

> +
> +Device model
> +------------
> +
> +An OSF0 device is a sensor aggregation device. It sends binary frames from the

What does the 0 in OSF0 mean?

> +device to the host. The host driver decodes the frames and maps supported
> +sensors to IIO devices.
> +
> +The hardware used for smoke testing is an OSF GREEN prototype with an
> +STM32F405RGT6 MCU, an ICM42688P-class IMU, and an MMC5983MA magnetometer. That
> +hardware is the first supported target for the RFC driver.

Keep that for the cover letter. Don't say what you tested in on this doc as
it'll likely become wrong very fast.

> +
> +Transport
> +---------
> +
> +The transport is UART at 115200 baud, 8 data bits, no parity, and 1 stop bit.
> +The Linux transport is serdev. The v0 upstream driver covers device-to-host

I'd skip serdev reference, that is an implementation detail we don't need in this
doc.

> +frames. Flow control is not used by the tested stream.
> +
> +Byte order
> +----------
> +
> +All multi-byte integer fields are little-endian. Samples use signed 32-bit
> +little-endian integers when ``sample_format`` is ``s32``.

If this is always the case, it's a detail that belongs in your project
docs. If you are calling out the subset that Linux is supporting then make
that clear.

"The driver supports the signed 32-bit little endian sample format."

That s32 things is a little confusing as it's __le32 in Linux if it is
little endian.  Maybe don't use that and just spell out what it is.

> +
> +Frame format
> +------------
> +
> +Each frame has a fixed 38-byte header, a payload, and a 4-byte CRC.
> +
> +.. list-table::
> +   :header-rows: 1
> +
> +   * - Offset
> +     - Size
> +     - Field
> +     - Description
> +   * - 0
> +     - 4
> +     - magic
> +     - ASCII ``OSF0``
> +   * - 4
> +     - 1
> +     - protocol_major
> +     - Must be ``0``
> +   * - 5
> +     - 1
> +     - protocol_minor
> +     - Minor version
> +   * - 6
> +     - 2
> +     - header_len
> +     - Must be ``38``
> +   * - 8
> +     - 2
> +     - message_type
> +     - Message type
> +   * - 10
> +     - 4
> +     - payload_len
> +     - Payload length in bytes
> +   * - 14
> +     - 8
> +     - sequence
> +     - Monotonic device sequence
> +   * - 22
> +     - 8
> +     - timestamp_us
> +     - Device timestamp in microseconds
> +   * - 30
> +     - 4
> +     - flags
> +     - Message flags
> +   * - 34
> +     - 4
> +     - reserved
> +     - Must be zero for v0
> +   * - 38
> +     - payload_len
> +     - payload
> +     - Message payload
> +   * - 38 + payload_len
> +     - 4
> +     - crc32
> +     - CRC32 over header and payload
> +
> +The frame CRC is IEEE CRC32 as implemented by ``crc32_le()`` with initial
> +value ``0xffffffff`` and final XOR value ``0xffffffff``. The CRC field is not
> +included in the CRC input.

Feels like details that belong in project docs, not here.

> +
> +Message types
> +-------------
> +
> +.. list-table::
> +   :header-rows: 1
> +
> +   * - Value
> +     - Name
> +     - Direction
> +   * - ``0x0001``
> +     - ``SENSOR_SAMPLE``
> +     - device to host
> +   * - ``0x0002``
> +     - ``DEVICE_STATUS``
> +     - device to host
> +   * - ``0x0003``
> +     - ``CAPABILITY_REPORT``
> +     - device to host
> +
> +Message types ``0x7f00`` through ``0x7fff`` are reserved. Values at or above
> +``0x8000`` are vendor private and are ignored by the current RFC driver.
> +

Likewise, project docs.

> +``SENSOR_SAMPLE`` payload
> +-------------------------
> +
> +The payload is a 16-byte payload header followed by ``4 * channel_count`` bytes
> +of sample data.
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
> +     - Number of ``s32`` channels
> +   * - 6
> +     - 2
> +     - sample_format
> +     - Must be ``1`` (``s32``)
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
> +The current RFC driver accepts only ``sample_format = s32`` and only the fixed
> +channel counts used by its supported IIO devices.

Also project docs.

> +
> +``DEVICE_STATUS`` payload
> +-------------------------
> +
> +The payload size is 20 bytes. Fields are ``uptime_s``, ``status_flags``,
> +``error_flags``, ``dropped_frames``, and a reserved field. Each field is
> +32 bits. The reserved field must be zero for v0.
> +
As a side note, if you've built your protocol well then it should be backwards
compatible. So you shouldn't care what the payload size is for messages like
this other than it is >= 20 and for now the driver only understands 20 bytes.

However, I'd just not say it here - keep it for project docs.

> +``CAPABILITY_REPORT`` payload
> +-----------------------------
> +
> +The base payload size is 4 bytes. It contains ``capability_count`` and a
> +reserved field. The reserved field must be zero for v0. Each capability entry
> +is 20 bytes:
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
> +     - Must be ``1`` (``s32``)
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
Likewise, project docs.

> +Sensor type IDs
> +---------------
> +
> +.. list-table::
> +   :header-rows: 1
> +
> +   * - Value
> +     - Sensor
> +     - Current RFC driver mapping
> +   * - ``0x0001``
> +     - accelerometer
> +     - ``IIO_ACCEL``, X/Y/Z
> +   * - ``0x0002``
> +     - gyroscope
> +     - ``IIO_ANGL_VEL``, X/Y/Z
> +   * - ``0x0003``
> +     - magnetometer
> +     - ``IIO_MAGN``, X/Y/Z
> +   * - ``0x0004``
> +     - barometer
> +     - not mapped
> +   * - ``0x0005``
> +     - temperature
> +     - ``IIO_TEMP``
> +   * - ``0x0006``
> +     - humidity
> +     - not mapped
> +   * - ``0x0007``
> +     - ambient light
> +     - not mapped
> +   * - ``0x0008``
> +     - proximity
> +     - not mapped

This is potentially interesting, but I don't think we care about the IDs, just what
device types are supported and the fact they are either 1D or 3D depending on device
type.

> +
> +Scaling
> +-------
> +
> +``scale_nano`` is the per-channel scale value in nano-units. The Linux driver
> +maps it to ``IIO_CHAN_INFO_SCALE`` as integer plus nano. The exact physical
> +unit depends on the IIO channel type.

This basically says Linux presents it right. Not needed.

> +
> +Timestamps
> +----------
> +
> +The frame header carries ``timestamp_us``, a device-side timestamp in
> +microseconds. UART buffering and host scheduling can add delay before a frame
> +is processed by the host.
> +
> +The current RFC driver does not claim production-grade host/device timestamp
> +correlation. Buffered IIO timestamps are taken from IIO timestamp clock handling
> +when samples are pushed to IIO buffers.

This bit is worth capturing in the Docs, but avoid RFC reference.

> +
> +Non-goals for v0 upstream

Not in here.  Just list what is supported.

> +-------------------------
> +
> +The v0 upstream driver does not include USB transport, fusion output, Attitude
> +and Heading Reference System (AHRS) output, Kalman output, calibration command
> +ABI, custom sysfs control surface, production timestamp correlation, or runtime
> +capability removal.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26bbdf8d3..6ccaaa738 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19981,6 +19981,7 @@ OPEN SENSOR FUSION IIO DRIVER
>  M:	Jinseob Kim <kimjinseob88@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
> +F:	Documentation/iio/open-sensor-fusion-protocol-v0.rst
>  
>  OPEN FIRMWARE AND FLATTENED DEVICE TREE
>  M:	Rob Herring <robh@kernel.org>

