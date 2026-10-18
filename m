Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD8428F5;
	Sun, 18 Oct 2026 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792281730; cv=none; b=N2JJEH0NWgSQd4a1VtR1suTIJ7Iw3OeP2VbzGsR5IBSst87OES6ApDGqDn0Xu1XJwBaS9NmU9MKHycv2AdTjZ40FccamSy5M0lF7idzIKbU6cxRr2P+c6f/ib9fK70Rxp9j1stkaE8XTQOfrLmdeoIH+aqNFzXEIcfE+pmls1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792281730; c=relaxed/simple;
	bh=CocyJeqESSlXdcsogY0gEET4v05AIONrQ/fdPDkkW48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSsciZDHPuPMpZxJEAsKNIT2jutTnlAT7U1v33bO0uSI5HKHUT28v1F/Rjr/hchzYxfiW3v1hkNBpwBr2N7iGixj9X1M0zb8lRCahBAJCS5jSHN+EtjiO7McNUliH+eINluSXB6UA+vPT69Y0pFfY8VbYsr8iPZEnVO/dh6mOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR3BMzdK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR3BMzdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064CA1F000C4;
	Sun, 18 Oct 2026 00:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792281728;
	bh=wDalcGE+RL3D+XTMe0Y/0GX2kz7SUnvloIO7TLUQbB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GR3BMzdKqQdGtnDuST1Rlw7UmxFEb9WtGHAc7l9RjrJyoNz3SjAlRNQ9z8zEQeq8v
	 4bVw45OMnZrB7eia6tM8ar3MNFKeOA5sl5Ur16/zocCG0SIyQOUdnV7U+vdIhKsJrr
	 WqjCVQm6W4sHV3Xi9XixWf8/EOJ58O0Pju+rhTZAVHIfJKZmd68vey712p+h1sBqz+
	 n+wjweVZj8Yfehyo2/v0zY23TuFEOLuIRBwj0qmGjxGnwUE1OaTmyzb4Lq8PvBIzJp
	 bNKq9wZ3VoJA2TdJa5DQbSN57B4ZzcHPeTeb3VxjquzUIe5ssfbSkidEpzR8/7ws0l
	 XDeTZ10rv2ETw==
Date: Sun, 18 Oct 2026 01:02:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, andersson@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 0/8] iio: add Open Sensor Fusion UART support
Message-ID: <20261018010201.4b427c3c@jic23-hlaptop>
In-Reply-To: <20261011231340.42885-1-kimjinseob88@gmail.com>
References: <20261011231340.42885-1-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 08:13:32 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> This series adds a UART/serdev receiver for the project's fixed OSF
> Device-to-Host 0.0 protocol. Complete capability snapshots create IIO
> accelerometer, gyroscope, magnetometer and temperature devices with RAW,
> descriptor-derived SCALE and initialized buffered scans.
> 
> The receiver validates the fixed OSF0 envelope, CRC and exact known
> message lengths. Equivalent capability reports are idempotent; changes
> to a bound supported inventory fault the session until explicit rebind.
> IIO samples use host timestamps.
> 
Hi Jinseob,

I'm going to do something a little unusual which is more about the time
I have available today and desire to look more closely at your unit tests
to learn from them.  So for now I'm just going to apply the driver (so
patches 1-6) and leave the last two on list and in patchwork as still needing
review.  Hopefully I will get time to circle back to them later this
kernel cycle!  In general I'm keen to get broad testing into IIO so
want to learn from what you have done there.

Jonathan

> Changes since v10:
> - Move OSF under drivers/iio/sensorhubs/osf/ following review.
> - Use the OSF GREEN compatible with the generic OSF fallback.
> - Clarify complete capability-report snapshot semantics.
> - Use designated decoded-frame initialization and drop decoded reserved
>   fields while retaining reserved wire-byte tolerance.
> - Reuse stream reset and simplify core/serdev locking and lifecycle.
> - Use IIO buffer-mode claims instead of a private buffer lock.
> - Simplify scan storage and channel declarations.
> - Fix KUnit worker/device/mutex/resource/completion lifetimes.
>   Generic IIO self-test extraction remains deferred.
> - Synchronize KUnit fault observation and configuration completion with
>   completions and thread joins instead of short polling/deadline windows.
> 
> The IIO buffer teardown serialization issue found during the v10 review
> was fixed separately and is now in mainline as commit 84bb0fc46ccf
> ("iio: buffer: serialize buffer teardown with mode claims").
> 
> This series is based on the IIO testing snapshot fetched for this submission:
> a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
> Runtime validation used this testing base plus the eight OSF patches
> and the exact mainline IIO core fix 84bb0fc46ccf6a545b8fdf57cda83770186ed8dd.
> The core fix is not included in this series and must be present when
> running the series on this testing base.
> 
> Fresh validation of this source:
> - GCC and Clang W=1 kernel builds; module builds.
> - osf-core (16 tests) and osf-iio (2 tests), with KASAN, lockdep,
>   DEBUG_MUTEXES, DEBUG_LOCK_ALLOC, DEBUG_OBJECTS and DEBUG_OBJECTS_FREE.
> - 200 production module load/unload cycles and 200 test-enriched module
>   load/unload cycles using identical driver/test C sources, exercising
>   20,000 IIO buffer toggles, scan subsets, timestamps and unregister.
> - DT binding/style/example/schema checks and IIO Sphinx build.
> - Clean sequential application and relevant builds of all eight patches.
> Physical board tests were not repeated for this revision.
> 
> Canonical specification (fixed revision):
> https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca9cdea1ae550c2b4d6f29f87877adae99470744/spec/osf-d2h-0.0.md
> 
> The fixed public specification is maintained and adopted by the OSF
> project. This does not imply Linux maintainer approval of the
> specification or driver.
> 
> Jinseob Kim (8):
>   dt-bindings: iio: add Open Sensor Fusion device
>   Documentation: iio: add Open Sensor Fusion driver overview
>   iio: osf: add protocol decoding
>   iio: osf: add validated stream parser
>   iio: osf: add UART transport and core receive path
>   iio: osf: add IIO devices from capability reports
>   iio: osf: add core KUnit tests
>   iio: osf: add IIO KUnit tests
> 
>  .../bindings/iio/opensensorfusion,osf.yaml    |   55 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>  Documentation/iio/index.rst                   |    1 +
>  Documentation/iio/open-sensor-fusion.rst      |   81 ++
>  MAINTAINERS                                   |    8 +
>  drivers/iio/Kconfig                           |    1 +
>  drivers/iio/Makefile                          |    1 +
>  drivers/iio/sensorhubs/Kconfig                |    7 +
>  drivers/iio/sensorhubs/Makefile               |    3 +
>  drivers/iio/sensorhubs/osf/Kconfig            |   27 +
>  drivers/iio/sensorhubs/osf/Makefile           |    7 +
>  drivers/iio/sensorhubs/osf/osf_core.c         |  460 +++++++
>  drivers/iio/sensorhubs/osf/osf_core.h         |   75 ++
>  drivers/iio/sensorhubs/osf/osf_core_test.c    | 1056 +++++++++++++++++
>  drivers/iio/sensorhubs/osf/osf_iio.c          |  288 +++++
>  drivers/iio/sensorhubs/osf/osf_iio.h          |   22 +
>  drivers/iio/sensorhubs/osf/osf_iio_test.c     |  386 ++++++
>  drivers/iio/sensorhubs/osf/osf_protocol.c     |  215 ++++
>  drivers/iio/sensorhubs/osf/osf_protocol.h     |   99 ++
>  drivers/iio/sensorhubs/osf/osf_serdev.c       |  151 +++
>  drivers/iio/sensorhubs/osf/osf_stream.c       |  230 ++++
>  drivers/iio/sensorhubs/osf/osf_stream.h       |   53 +
>  22 files changed, 3228 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
>  create mode 100644 Documentation/iio/open-sensor-fusion.rst
>  create mode 100644 drivers/iio/sensorhubs/Kconfig
>  create mode 100644 drivers/iio/sensorhubs/Makefile
>  create mode 100644 drivers/iio/sensorhubs/osf/Kconfig
>  create mode 100644 drivers/iio/sensorhubs/osf/Makefile
>  create mode 100644 drivers/iio/sensorhubs/osf/osf_core.c
>  create mode 100644 drivers/iio/sensorhubs/osf/osf_core.h
>  create mode 100644 drivers/iio/sensorhubs/osf/osf_core_test.c
>  create mode 100644 drivers/iio/sensorhubs/osf/osf_iio.c
>  create mode 100644 drivers/iio/sensorhubs/osf/osf_iio.h
>  create mode 100644 drivers/iio/sensorhubs/osf/osf_iio_test.c
>  create mode 100644 drivers/iio/sensorhubs/osf/osf_protocol.c
>  create mode 100644 drivers/iio/sensorhubs/osf/osf_protocol.h
>  create mode 100644 drivers/iio/sensorhubs/osf/osf_serdev.c
>  create mode 100644 drivers/iio/sensorhubs/osf/osf_stream.c
>  create mode 100644 drivers/iio/sensorhubs/osf/osf_stream.h
> 
> 
> base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
> 

