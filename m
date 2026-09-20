Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE59E17B50F;
	Sun, 20 Sep 2026 01:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789866766; cv=none; b=KcXh0SBabXu0sBUcA6OnCuzcw3Rm41CYLYTwyi5y30lJYWMSBv5hRO4tbexTsvP9p13v7l0Wi0yCZ9Nsn1uWHrhHpj2MY5BKkgtgMedOK4tiTpUBO4BSrAs4M4tv+N9SJ5XciVnF77OEs15q1GnFoQn8wdgT4cNE1XC9Iiqtf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789866766; c=relaxed/simple;
	bh=+N6J1LZ6CBdc1zIhV3kOvDxoPJ1p6hB1SMwEMNaeBe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gm9dQe/MNfl7MYk5MFFg96xRbUC3bCRqh2qTiq9zXX2MDjontEyfOfW8szxRC4z9Sbc8X0dcquo4HH2Qu5x8PgRsEg5cdzBMsaJGCUQmcZUygnIdAGaGrDZP0PD2pTmHias3rACBSC7pynZfs9QjXQN4oPKl7d9FmleeEEiP1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxLcGd/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxLcGd/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3FB1F000FF;
	Sun, 20 Sep 2026 01:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789866764;
	bh=vWhFuwQAE7RhwWDtnIUTLdbJqKiTWXC8oO4CWXKEvQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kxLcGd/Z04DRTdyXv8CkazBPRQ1V55ZcrTtzbpFHutBk6yhqAD0mUQmiUYARbtchM
	 mA8mVVXZ5RieCw2NoyTFG63rvRM0PKU4CvEEtRyV/iPZWrOlV+ZsL2fcwLhkNuotcm
	 CwF+tf0GIzi2DL1vfB6atN9JJLOo/Ktnn57PJ9yRgYUfUrTxuPyhlpj3qBKw91olqE
	 5zRsnfucypcjVmgRqczqCszq7Yddgx+nqXyBN9DDFA6ErfPj+50oFaXJn6PCPx52Ky
	 NvghFb4OTUa0vwfqHOkbPsLC74ZpCCNUuXUqN3mGafAlLOi/QGRidTL2yNQhIL5Rxj
	 VTnjuS4H8eqxA==
Date: Sun, 20 Sep 2026 02:12:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 2/8] Documentation: iio: add Open Sensor Fusion
 driver overview
Message-ID: <20260920021238.6d4ff353@jic23-hlaptop>
In-Reply-To: <9fdbc924bf3387a4d33d1258ea21ac33abef65bb.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
	<9fdbc924bf3387a4d33d1258ea21ac33abef65bb.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 03:24:40 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Document the supported OSF receiver profile, runtime sensor discovery,
> IIO channel units, scale validation and session lifetime.
> 
> Link the project-maintained fixed wire specification instead of
> duplicating its layouts and compatibility policy. Explain host IIO
> timestamps and the explicit rebind needed after a changed inventory.
> 
> Assisted-by: LLM
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

Hi Jinseob,

Just a couple of minor things inline.

Thanks,

Jonathan

> ---
>  Documentation/iio/index.rst              |  1 +
>  Documentation/iio/open-sensor-fusion.rst | 77 ++++++++++++++++++++++++
>  MAINTAINERS                              |  1 +
>  3 files changed, 79 insertions(+)
>  create mode 100644 Documentation/iio/open-sensor-fusion.rst
> 
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index b02b879b053a..c2b7963348fd 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -40,4 +40,5 @@ Industrial I/O Kernel Drivers
>     adxl345
>     bno055
>     ep93xx_adc
> +   open-sensor-fusion
>     opt4060
> diff --git a/Documentation/iio/open-sensor-fusion.rst b/Documentation/iio/open-sensor-fusion.rst
> new file mode 100644
> index 000000000000..03ab36aca5f8
> --- /dev/null
> +++ b/Documentation/iio/open-sensor-fusion.rst
> @@ -0,0 +1,77 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Open Sensor Fusion
> +==================
> +
> +Open Sensor Fusion is a sensor aggregation hub interface. The Linux IIO driver
> +receives device-to-host frames over UART and discovers sensor channels from
> +capability reports. Device Tree describes the hub using the
> +``opensensorfusion,osf`` compatible; individual sensors are discovered at
> +runtime. See the binding in
> +``Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml``.
> +
> +The OSF Device-to-Host 0.0 specification is maintained by the Open Sensor Fusion
> +project. The canonical specification_ defines the wire layout, compatibility
> +rules, reserved fields and physical units. This document describes the Linux
> +receiver profile and its mapping to IIO.
> +
> +.. _specification: https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca9cdea1ae550c2b4d6f29f87877adae99470744/spec/osf-d2h-0.0.md
> +
> +Supported receive profile
> +-------------------------
> +
> +The driver supports the fixed OSF0 frame layout with protocol major version 0.
> +Compatible minor versions use the same known message layouts. The decoder
> +requires exact lengths for known messages, validates CRC and bounds before
> +interpreting payloads, and tolerates reserved padding. Unsupported majors and

If you spin again "Unsupported major versions and.."

> +unknown message types are ignored. Unsupported capability entries are skipped
> +individually. A CRC-valid application rejection consumes the complete frame;
> +an invalid frame candidate is resynchronized without trusting its payload length.
> +
> +The receive path handles sensor samples, complete capability reports and
> +device status. Its limits are 4096 bytes per frame and 16 supported sensor
> +descriptors. These are implementation limits, not protocol-wide maxima.
> +
> +IIO mapping
> +-----------
> +
> +The supported sensor classes map to:
> +
> +* accelerometer: ``IIO_ACCEL`` X/Y/Z, in m/s^2;
> +* gyroscope: ``IIO_ANGL_VEL`` X/Y/Z, in rad/s;
> +* magnetometer: ``IIO_MAGN`` X/Y/Z, in gauss;
> +* temperature: ``IIO_TEMP``, in millidegrees Celsius.
> +
> +Each registered channel exposes signed ``RAW`` data and descriptor-derived
> +``SCALE``. Multiplying RAW by SCALE gives a value in the channel's IIO unit.
> +Buffered samples use signed 32-bit values with native CPU endianness. Active
> +channels are packed into the scan, with initialized padding before an optional
> +64-bit timestamp.
> +
> +Discovery and session lifetime
> +------------------------------
> +
> +The driver validates all supported descriptors before registering IIO devices.
> +An empty or entirely unsupported initial report leaves discovery open for a
> +later supported report. 

So if the device can send multiple discovery reports, this implies if we
recognise something in the first one we will stop looking at later ones?
That seems odd given if we don't recognise anything we keep looking.
If I'm reading too much into this text, then please tweak it to make
it clear why this doesn't matter.

> Supported descriptors must advertise a nonzero scale.
> +A sample's channel count, format and scale must match its registered descriptor
> +before it can update the latest RAW cache or be published to a buffer. A
> +rejected sample preserves previously accepted data.
> +
> +Repeated reports are compared by sensor type and index, independently of entry
> +order. Reserved padding, advisory flags and unsupported additions do not change
> +the supported inventory. A supported key appearing or disappearing, or a
> +change in its channel count, format or scale, faults the bound session.
> +
> +After a session fault, new cache updates and buffer publication stop, and
> +direct RAW reads fail. Existing IIO devices remain until driver teardown.
> +An equivalent report does not clear the fault; explicit unbind/rebind starts
> +fresh discovery. No fault-specific userspace ABI is exposed.
> +
> +Timestamps
> +----------
> +
> +Buffered samples use the selected IIO host clock when they are pushed into
> +the buffer. The device timestamp is not correlated with that clock and is not
> +used as the IIO buffer timestamp. Device timestamp or sequence discontinuities
> +alone do not start a new host session.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9463b8111d52..26b9b2862724 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20515,6 +20515,7 @@ OPEN SENSOR FUSION
>  M:	Jinseob Kim <kimjinseob88@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> +F:	Documentation/iio/open-sensor-fusion.rst
>  K:	opensensorfusion
>  
>  OPENCOMPUTE PTP CLOCK DRIVER

