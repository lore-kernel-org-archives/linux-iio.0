Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4A457981B;
	Wed,  9 Sep 2026 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969728; cv=none; b=D4ElAyme8t0p4jDplluyAQVxzEN91rpU3ZUsnD+BtNEEOwkJCo/DOvbriSTj7SkMA/8Eg/7CR6kBEaM2XgaiPPh2Efq4qUxXd5lNPN6vW0jx/ozRyJA8ATvHW1iEC3Tl3t/38/WTFa9pvIo/guSZ8CAAoK/o3vje7ovUqp+JipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969728; c=relaxed/simple;
	bh=7wdl22HPRdCzS/A82zidu8QMWhNyXyiUpgzVSBsOVeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4lV0poVItGzKhWMeE9cPUG+In8EbcSrJZhsT2LkWyNYY70dZJJTs9ix9RN+SECio+vfcNFOf1QzwWbCV+qGMVIJEpOxdSDTW9n3mbQNPTo4DxMJC0c8T3a+7fFyn1lEtH1a9Ds+M0Cqf61VE+AV0CZ525XdfV2aNz6N8o/8Src=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BeCk+g4t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BeCk+g4t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9iMAAvJrvdrcL+VrKnVolhulu7ltCx1RhkOqwZuXLfc=; b=BeCk+g4tO9AMRD/rNn+5zaW9mx
	KCAsNOu9NW3r5G2Bea3lwmuINSXFIKYR96VEmXoYaXNIxanll1SB6K387fhiZ8Rx2MxEZXPW4XQeq
	D9u2BuSNuMWKzX3jC/tOVE09QpZ9lKFzEcp3SvxHHe3v5xiWv46ZShP4hyFImfS7vyeY7EqV6DJlK
	fyt7KRQzK3zOS145E8ylD7KdrVYaLKamPHnrOBz0Vy+j9r3M8wbqFVPc+rVNs/wZD2hNjHAz/Lx8d
	CxGUtGVTOEvkoJ2h7lkO6DpdFhd/SfOXhDSASyTz3AWTcZf9A5+z9GSshLimLHFS9BOiIi6KPT3ep
	DBQOPXdQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4KkO-0000000CGHx-2u4L;
	Wed, 09 Sep 2026 16:02:04 +0000
Message-ID: <c0fb5a98-436b-42a5-8e2d-2ffdc6e53e25@infradead.org>
Date: Wed, 9 Sep 2026 09:02:04 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/5] Documentation: iio: add Open Sensor Fusion driver
 overview
To: Jinseob Kim <kimjinseob88@gmail.com>, jic23@kernel.org,
 linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org
References: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
 <CALMSewK17jG3MXTHv4Rj+tFVriw9+tqNuAMcX4KGQGy5NQP_MQ@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CALMSewK17jG3MXTHv4Rj+tFVriw9+tqNuAMcX4KGQGy5NQP_MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/9/26 8:05 AM, Jinseob Kim wrote:
> Document the Linux IIO mapping for Open Sensor Fusion devices.
> 
> The overview explains that sensor channels are discovered at runtime
> from mandatory capability reports. It also documents that OSF0 is a
> wire-format detail and that protocol_major and protocol_minor carry
> protocol compatibility information.
> 
> Assisted-by: LLM
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---
>  Documentation/iio/index.rst              |  1 +
>  Documentation/iio/open-sensor-fusion.rst | 84 ++++++++++++++++++++++++
>  MAINTAINERS                              |  1 +
>  3 files changed, 86 insertions(+)
>  create mode 100644 Documentation/iio/open-sensor-fusion.rst
> 

What email client did you use to send this patch?
It is wrapping (longer) lines for you, in a way that's not good.
It causes malformed patches.
You can see it below or at
https://lore.kernel.org/linux-doc/CALMSewK17jG3MXTHv4Rj+tFVriw9+tqNuAMcX4KGQGy5NQP_MQ@mail.gmail.com/T/#u


> diff --git a/Documentation/iio/open-sensor-fusion.rst
> b/Documentation/iio/open-sensor-fusion.rst
> new file mode 100644
> index 000000000000..15d41202eb66
> --- /dev/null
> +++ b/Documentation/iio/open-sensor-fusion.rst
> @@ -0,0 +1,84 @@
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
> +An OSF device sends binary frames from the device to the host.
> Devices using the

^^^ Should be one line, not two.

> +``opensensorfusion,osf`` compatible are expected to provide
> +``CAPABILITY_REPORT`` messages so the host can discover which sensor
> streams are

Same.

> +available. Device Tree describes the attached OSF sensor aggregation
> hub; it does

Same.

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
> +OSF frames include a device-side ``timestamp_us`` field. Buffered IIO
> samples use

Same.

> +an IIO timestamp captured on the host when samples are pushed to IIO buffers.
> +The driver does not correlate the device timestamp with the host IIO
> +clock.
> +
> +Compatibility Notes
> +-------------------
> +
> +This overview describes the implemented receive path, not a normative wire
> +specification. A publicly versioned specification covering reserved fields,
> +extensions and physical scale units remains needed for interoperability review.
> +
> +The decoder requires the fixed header size and the exact payload lengths of
> +known messages. It ignores unsupported protocol majors, unknown message types
> +and frames with nonzero header reserved fields. Unsupported capability entries
> +are skipped individually; malformed known payloads are rejected. Appending data
> +to an existing known message is therefore not a compatible extension for this
> +receiver.
> +
> +IIO scale is taken from the initial capability report and is not updated by
> +sample frames. Devices must supply scales in the units required by each IIO
> +channel type, including gauss for magnetometers. Historical OSF draft documents
> +differ on reserved-field handling, trailing extensions and magnetometer units;
> +those drafts do not establish a canonical specification for this driver.

There is some help for various email clients in Documentation/process/email-clients.rst
that may help you (or not).

-- 
~Randy

