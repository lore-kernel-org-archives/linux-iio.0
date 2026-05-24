Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959FD10F2
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779612829; cv=none; b=ZToczRXdz0YkCAncpujNduncqP46w0Syg9VRVBDbDKI1KGJWOH6oXHVd8PLbpxYsTyf4jJzFBS1rhjjTgxAdnFzqW7rxZgVyLKF6GlenQFj7w34/wDl1XBIHS4wmN1evl6/RtY8B2XX2zvdHsFb1TYlmpsaObnN74Hd8H08Kprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779612829; c=relaxed/simple;
	bh=g1+tHbgrYncMfc1QByZAwPDHezhvG35MPCiAjWaYTGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+SQGJC9fqfGrOHmPw0JpbfVR1V7kjEdDhAQal7hHTt9G208gBRcfSWo+Irmm0I4HRwp0L+tBCqRJlI9INmRRoy5YKhTWG0+2jzctUb8lwDcYrCL3QLnmybH0JdCxbRUL78yMARe+XBCOpwDWOsRTkx1qBtv75yynG45AUNfWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=obbUXyw+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obbUXyw+"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-841513664bbso1701464b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 01:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779612826; x=1780217626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cR6MVBWrx7Nf/YCvBY1+uoEtosj5P+qxsyQ19bAkpkk=;
        b=obbUXyw+QNUEGA0qAtV3GTjtQVMw2MbL+UeFF637n/4TcThGXTBleRmaDmRmhpMzJC
         Xyhdpudd0ZFw5vsunv1/fs0CjpJI89kLfPGK1eDjnOvA//nX12YeHhDz6wlFPqcypCVz
         44Stf1XKu0r9LqCBUcJKZjDwxjxrNikH368MQCOTUKWiqH75Wjq2oD+7W/laNN6d/NiE
         9YEuQRb+t43LVjoR+1IABptYxqHZARKK1vmZ2jzESF/CuWKXcIh7S6TffIJ6qGdmdGzl
         cGUV7GkZsFzNCcocCHqq67456Rtx9hvwt0925Lm0Qvg+ZTOioAsoa/n3Sm5t8kfBMGE2
         cTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779612826; x=1780217626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cR6MVBWrx7Nf/YCvBY1+uoEtosj5P+qxsyQ19bAkpkk=;
        b=ldzc+E9ckg+pXef/Qgmfz1oDZsFBzDK4IcH1ZuYGywm213lclOZdyTLLHhla/RSiqe
         MJEAgernW9IkngEji5vAwqeFajP4wQT/1auPsN8waFF3yfzE8Xz6coFm3zgBCnUL4c23
         1cQprCcaPrfEoSVd+KQ06efqjNt6MW319GVT5KyXI4IAX+o48QgIOPcZDZ3ou2wz1G0d
         QEhDNce9JT1GdvM45vBovuGgwgu7T6YjUmPFglJ7d8lDN3uW9tIfHNDvIOlRKFlLxa6v
         5L6ZyrrLtfJMMb5X93WC56H3eRVqGDt/WM+BfyxJ+aHVdST4HxRXLYt1xNHjYev3qU7z
         qr5w==
X-Forwarded-Encrypted: i=1; AFNElJ+qAUToSIgVEHnn8Yx0H8LH6mAWy2gWGDtW6/J5UDhqMQrRtOj0Mjoy9T9v+jrB+Y7ZC8sBWyWDbmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCh2r0+kXW4jaLlRqiLNvDV2yqlcHzKcbBCsRplBz/pPVKAEXO
	FZMFSQ5OETjg7RZGwSVGEfBkfrCMbqjXc95KgBAQpi1EBj+1cn6Fn+Ed
X-Gm-Gg: Acq92OGb7hN/fyz+hF+hnrJebvpCKRT4WZUROekc10Xjk9Zo2YiMGZdr/2Zky+aSJ3P
	IZxlEtgjWu2B3YIcW4FRITaJHssQvm+hKJ0crCRn1bf685yAs9o+L6j6xQWmbA5A3Y48HbQ+Qdv
	YAOQKXN/h91jZxFhMIvqh/ERubQSkFFJ34w6j6hWRgric0tOfz/bBcAPF1n+KqpzMKhWOW2g5p1
	94REc+pMNhJjdddU9ftQ07RJyWhLbjweypNAd8eAJL3MUUhe4srV6hMAARw0ppESgSu9jdbwoIP
	raMbuLJkjPUNhClvJEaBo4uZntsF6byyr4MwbtFDPBKarGCPjbHbPvsqkdJAOGjmHVhPyW6+Wgd
	gE+rSqPLBFvEU65mM0W5JyC16guHX06UB79Q44XUDbZTA60UP6eIEhE0bwaaT+j360hyIF2d8tT
	d6lqzdLOUrNV/va1e7Smv7WCmR5ikx+/VHvgq+s3FdqtBkk/Z8DWV7OUOthBv2/zkeFjekxvxrM
	jrJOlVqb19QltC3grPD8WTqlIlouiiRkskTZseQ/lSRT9qs
X-Received: by 2002:a05:6a20:d80f:b0:3a3:128f:1c77 with SMTP id adf61e73a8af0-3b329541ab3mr8321476637.12.1779612825886;
        Sun, 24 May 2026 01:53:45 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ea4de4sm6353116b3a.35.2026.05.24.01.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 01:53:45 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinseob Kim <kimjinseob88@gmail.com>
Subject: [PATCH RFC v2 2/7] Documentation: iio: add Open Sensor Fusion protocol v0 reference
Date: Sun, 24 May 2026 17:53:07 +0900
Message-ID: <20260524085312.15369-3-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524085312.15369-1-kimjinseob88@gmail.com>
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the OSF0 frame format and payloads used by the driver.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 .../iio/open-sensor-fusion-protocol-v0.rst    | 267 ++++++++++++++++++
 1 file changed, 267 insertions(+)
 create mode 100644 Documentation/iio/open-sensor-fusion-protocol-v0.rst

diff --git a/Documentation/iio/open-sensor-fusion-protocol-v0.rst b/Documentation/iio/open-sensor-fusion-protocol-v0.rst
new file mode 100644
index 000000000..4800a3ce6
--- /dev/null
+++ b/Documentation/iio/open-sensor-fusion-protocol-v0.rst
@@ -0,0 +1,267 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Open Sensor Fusion protocol v0
+==============================
+
+This document describes the OSF0 UART wire format used by the Linux IIO
+driver. It is not a firmware programming interface.
+
+Device model
+------------
+
+An Open Sensor Fusion UART device is a sensor aggregation device. It sends
+binary frames from the device to the host. The host driver decodes the frames
+and maps supported sensors to IIO devices.
+
+The hardware used for smoke testing is an OSF GREEN prototype with an
+STM32F405RGT6 MCU, an ICM42688P-class IMU, and an MMC5983MA magnetometer. That
+hardware is a test target, not part of the binding ABI.
+
+Transport
+---------
+
+The transport is UART at 115200 baud, 8 data bits, no parity, and 1 stop bit.
+The Linux transport is serdev. The v0 upstream driver covers device-to-host
+frames. Flow control is not used by the tested stream.
+
+Byte order
+----------
+
+All multi-byte integer fields are little-endian. Samples use signed 32-bit
+little-endian integers when ``sample_format`` is ``S32``.
+
+Frame format
+------------
+
+Each frame has a fixed 38-byte header, a payload, and a 4-byte CRC.
+
+.. list-table::
+   :header-rows: 1
+
+   * - Offset
+     - Size
+     - Field
+     - Description
+   * - 0
+     - 4
+     - magic
+     - ASCII ``OSF0``
+   * - 4
+     - 1
+     - protocol_major
+     - Must be ``0``
+   * - 5
+     - 1
+     - protocol_minor
+     - Minor version
+   * - 6
+     - 2
+     - header_len
+     - Must be ``38``
+   * - 8
+     - 2
+     - message_type
+     - Message type
+   * - 10
+     - 4
+     - payload_len
+     - Payload length in bytes
+   * - 14
+     - 8
+     - sequence
+     - Monotonic device sequence
+   * - 22
+     - 8
+     - timestamp_us
+     - Device timestamp in microseconds
+   * - 30
+     - 4
+     - flags
+     - Message flags
+   * - 34
+     - 4
+     - reserved
+     - Must be zero for v0
+   * - 38
+     - payload_len
+     - payload
+     - Message payload
+   * - 38 + payload_len
+     - 4
+     - crc32
+     - CRC32 over header and payload
+
+The frame CRC is IEEE CRC32 as implemented by ``crc32_le()`` with initial
+value ``0xffffffff`` and final XOR value ``0xffffffff``. The CRC field is not
+included in the CRC input.
+
+Message types
+-------------
+
+.. list-table::
+   :header-rows: 1
+
+   * - Value
+     - Name
+     - Direction
+   * - ``0x0001``
+     - ``SENSOR_SAMPLE``
+     - device to host
+   * - ``0x0002``
+     - ``DEVICE_STATUS``
+     - device to host
+   * - ``0x0003``
+     - ``CAPABILITY_REPORT``
+     - device to host
+
+Message types ``0x7f00`` through ``0x7fff`` are reserved. Values at or above
+``0x8000`` are vendor private and are ignored by the upstream driver.
+
+``SENSOR_SAMPLE`` payload
+-------------------------
+
+The base payload size is 16 bytes.
+
+.. list-table::
+   :header-rows: 1
+
+   * - Offset
+     - Size
+     - Field
+     - Description
+   * - 0
+     - 2
+     - sensor_type
+     - Sensor type ID
+   * - 2
+     - 2
+     - sensor_index
+     - Instance index
+   * - 4
+     - 2
+     - channel_count
+     - Number of S32 channels
+   * - 6
+     - 2
+     - sample_format
+     - Must be ``1`` (``S32``)
+   * - 8
+     - 4
+     - scale_nano
+     - Scale factor in nano-units
+   * - 12
+     - 4
+     - reserved
+     - Must be zero for v0
+   * - 16
+     - 4 * channel_count
+     - samples
+     - Signed 32-bit channel samples
+
+``DEVICE_STATUS`` payload
+-------------------------
+
+The payload size is 20 bytes. Fields are ``uptime_s``, ``status_flags``,
+``error_flags``, ``dropped_frames``, and a reserved field. Each field is
+32 bits.
+
+``CAPABILITY_REPORT`` payload
+-----------------------------
+
+The base payload size is 4 bytes. It contains ``capability_count`` and a
+reserved field. Each capability entry is 20 bytes:
+
+.. list-table::
+   :header-rows: 1
+
+   * - Offset
+     - Size
+     - Field
+     - Description
+   * - 0
+     - 2
+     - sensor_type
+     - Sensor type ID
+   * - 2
+     - 2
+     - sensor_index
+     - Instance index
+   * - 4
+     - 2
+     - channel_count
+     - Number of channels
+   * - 6
+     - 2
+     - sample_format
+     - Must be ``1`` (``S32``)
+   * - 8
+     - 4
+     - scale_nano
+     - Scale factor in nano-units
+   * - 12
+     - 4
+     - flags
+     - Capability flags
+   * - 16
+     - 4
+     - reserved
+     - Must be zero for v0
+
+Capability flag bit 0 means enabled by default. Bit 1 means calibrated data can
+be provided by the device. Other bits are invalid for v0.
+
+Sensor type IDs
+---------------
+
+.. list-table::
+   :header-rows: 1
+
+   * - Value
+     - Sensor
+     - IIO mapping
+   * - ``0x0001``
+     - accelerometer
+     - ``IIO_ACCEL``, X/Y/Z
+   * - ``0x0002``
+     - gyroscope
+     - ``IIO_ANGL_VEL``, X/Y/Z
+   * - ``0x0003``
+     - magnetometer
+     - ``IIO_MAGN``, X/Y/Z
+   * - ``0x0004``
+     - barometer
+     - not mapped in the initial driver
+   * - ``0x0005``
+     - temperature
+     - ``IIO_TEMP``
+   * - ``0x0006``
+     - humidity
+     - not mapped in the initial driver
+   * - ``0x0007``
+     - ambient light
+     - not mapped in the initial driver
+   * - ``0x0008``
+     - proximity
+     - not mapped in the initial driver
+
+Scaling
+-------
+
+``scale_nano`` is the per-channel scale value in nano-units. The Linux driver
+maps it to ``IIO_CHAN_INFO_SCALE`` as integer plus nano. The exact physical
+unit depends on the IIO channel type.
+
+Timestamps
+----------
+
+The frame header carries ``timestamp_us``, a device-side timestamp in
+microseconds. v0 transports this value for ordering and diagnostics. The driver
+does not use it as a production-grade host-correlated timestamp. Buffered IIO
+timestamps follow IIO timestamp clock handling.
+
+Non-goals for v0 upstream
+-------------------------
+
+The v0 upstream driver does not include USB transport, fusion output,
+AHRS/Kalman output, calibration command ABI, custom sysfs control surface,
+production timestamp correlation, or runtime capability removal.
-- 
2.43.0

