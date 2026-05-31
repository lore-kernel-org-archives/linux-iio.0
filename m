Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957635A933;
	Sun, 31 May 2026 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780223143; cv=none; b=D6DFs+A86/4J0Z9BPdtE/ftXP8nJGNET9bCj/yd6fXX7OezJGpKzyUHniLvL00P6na+XUNdjjV8XTHc+xEzxhRPy8RJIbAoshSD9SzCSLmOslML4eYnAQYS1xJiBzU1MQd2Pdbc8Dn/aKgo3dYGRxQctKX2n2WikyVHlImVT3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780223143; c=relaxed/simple;
	bh=nmlD8b4mABkM8w7jAAYsBldGNHZjXvQxy5Rv2vQRZNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjsFn1jEQhJi+0n/r6R3TcGoQTQbSdolnQ2jrTQetfZKNACpTcfAyaF42DaRv5qoqvk801lrBrL1yNMedXDj+mTC+BrGs5PFYsWQbzOeV1ntEIU0cRTwi/W/ozSrtRgk68UGs23/L7Me2mB2lZ5fD9bANS7R92kX8tbISeKqVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faYiWjOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faYiWjOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78E01F00893;
	Sun, 31 May 2026 10:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780223141;
	bh=3upI/mQOlmdy5cvAoTeS69UQ4MgfY8IOzqChycj5s6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=faYiWjOOulS8TK66KoT61JeilMXqlHnkHOUldex4lbCIW8L2d2L/uDu8xHd1OBsEL
	 uJERDob73ogbjkkOyuR65L9n/1osNb0yPRSwwWprI3XoZdYqp7uupzyUVR/6WuE/MO
	 xq56MQXYwkO+zfVkQwQ05u9WQ8/D811dNbbYgkGXz9rkck2gfa1g0s80IwB+z/35P0
	 NpEGhlBXlja3fqeE1k52QoXpINwyF2vhpQiYF1uF+zpZZ/DzuURRh7zpX/oFxGCM/N
	 UhFCc3LYc6XH6luUjxLOglxhRHJOFyWT0Y7tTuz00GTD5k9kZof4FJS0sJgJ8uU7aa
	 ebU26BRgvIe0Q==
Date: Sun, 31 May 2026 11:25:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/6] iio: add Open Sensor Fusion OSF0 UART driver
Message-ID: <20260531112533.78d321d1@jic23-huawei>
In-Reply-To: <20260529121005.1470-1-kimjinseob88@gmail.com>
References: <20260529121005.1470-1-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 21:09:59 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> This RFC series adds an Industrial I/O driver for Open Sensor Fusion
> OSF0 UART devices.

This misses a clear statement of why it is an RFC.  Are their open questions?
Is the protocol still evolving?  Are you waiting for testing?

> 
> Open Sensor Fusion is an open hardware project for sensor aggregation
> devices and Linux IIO host support. OSF0 is not a general standard; it is
> the current wire format used by this project and by the RFC driver in this
> series. The first concrete hardware target is OSF GREEN, an STM32F405-based
> sensor aggregation board that streams sensor samples to a Linux host.
> 
> Project links:
> https://www.opensensorfusion.org/
> https://github.com/opensensorfusion
> https://github.com/opensensorfusion/opensensorfusion-linux
> 
> The driver receives OSF0 frames over a serdev UART, validates the stream,
> decodes capability and sample frames, and registers IIO devices for the
> supported sensor types. The current RFC driver covers the device-to-host
> path used for accelerometer, gyroscope, magnetometer, and temperature
> samples.
> 
> Changes since v2:
> 
> * Reworked the binding around the concrete OSF GREEN hardware target.
> * Changed the compatible from opensensorfusion,osf-uart to
>   opensensorfusion,osf-green.
> * Renamed the binding file to opensensorfusion,osf-green.yaml.
> * Updated the example node name to generic sensor.
> * Added serial-peripheral-props.yaml and unevaluatedProperties: false.
> * Added public project links and clarified that OSF0 is not a general
>   standard.
> * Separated the OSF0 wire format from the subset currently supported by
>   this RFC driver.
> * Clarified SENSOR_SAMPLE as a 16-byte payload header followed by
>   4 * channel_count bytes of s32 channel data.
> * Clarified device-side timestamp limitations.
> * Spelled out Attitude and Heading Reference System (AHRS).
> * Added sensor_type, sample_format, channel_count, reserved-field, and
>   payload length overflow validation.
> * Changed reserved fields to validate-only handling.
> * Fixed IIO_BUFFER / IIO_KFIFO_BUF dependency handling.
> * Added channel_count checks before pushing samples to IIO buffers.
> * Added locking for cached latest samples.
> * Removed explicit linux-iio and devicetree list entries from
>   MAINTAINERS.
> * Folded MAINTAINERS updates into the patches that add the corresponding
>   files.
> * Addressed Sashiko feedback from v2.
> 
> The runtime smoke test used for the previous revision was performed with an
> OSF GREEN prototype connected to a Raspberry Pi 4 over UART/serdev. This v3
> series was also checked with dt_binding_check, checkpatch, and a W=1 target
> build in the local full-tree environment.
> 
> 
> Jinseob Kim (6):
>   dt-bindings: iio: add OSF GREEN sensor aggregation device
>   Documentation: iio: add Open Sensor Fusion protocol v0 reference
>   iio: osf: add protocol v0 decoding
>   iio: osf: add stream parser
>   iio: osf: add UART serdev transport
>   iio: osf: register IIO devices from capabilities
> 
>  .../iio/imu/opensensorfusion,osf-green.yaml   |  43 +++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  .../iio/open-sensor-fusion-protocol-v0.rst    | 308 ++++++++++++++++++
>  MAINTAINERS                                   |  13 +
>  drivers/iio/Kconfig                           |   1 +
>  drivers/iio/Makefile                          |   1 +
>  drivers/iio/opensensorfusion/Kconfig          |  14 +
>  drivers/iio/opensensorfusion/Makefile         |   6 +
>  drivers/iio/opensensorfusion/osf_core.c       | 305 +++++++++++++++++
>  drivers/iio/opensensorfusion/osf_core.h       |  70 ++++
>  drivers/iio/opensensorfusion/osf_iio.c        | 285 ++++++++++++++++
>  drivers/iio/opensensorfusion/osf_iio.h        |  22 ++
>  drivers/iio/opensensorfusion/osf_protocol.c   | 247 ++++++++++++++
>  drivers/iio/opensensorfusion/osf_protocol.h   |  95 ++++++
>  drivers/iio/opensensorfusion/osf_serdev.c     | 111 +++++++
>  drivers/iio/opensensorfusion/osf_stream.c     | 207 ++++++++++++
>  drivers/iio/opensensorfusion/osf_stream.h     |  31 ++
>  17 files changed, 1761 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
>  create mode 100644 Documentation/iio/open-sensor-fusion-protocol-v0.rst
>  create mode 100644 drivers/iio/opensensorfusion/Kconfig
>  create mode 100644 drivers/iio/opensensorfusion/Makefile
>  create mode 100644 drivers/iio/opensensorfusion/osf_core.c
>  create mode 100644 drivers/iio/opensensorfusion/osf_core.h
>  create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
>  create mode 100644 drivers/iio/opensensorfusion/osf_iio.h
>  create mode 100644 drivers/iio/opensensorfusion/osf_protocol.c
>  create mode 100644 drivers/iio/opensensorfusion/osf_protocol.h
>  create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c
>  create mode 100644 drivers/iio/opensensorfusion/osf_stream.c
>  create mode 100644 drivers/iio/opensensorfusion/osf_stream.h
> 

