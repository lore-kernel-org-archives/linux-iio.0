Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358541443F;
	Sun, 18 Oct 2026 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792346703; cv=none; b=qBLm/8tKN4YpGRD30zQCmpfx2XUVIR+yBxJ73w16pLNgZFIs+fYykGAyFA1bJNiwEKzdiD9t4TJvFuil8AUCFtb0HxNOASlG4+HqeHVpNiz8Idq2rFeNpxMl1wCgAX6Kane5Nt4JDHGhKvSp46izdSDD86WR7OU5JnExXCE99Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792346703; c=relaxed/simple;
	bh=/Bxk4vAxLIX3U06yReasi67RpPbqLpnI3i2QnQJg3jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7rBe073OVBatg+Zw7RQsO6IF50tdHnJWvsHMTmsvTVT7W6NX2hPAj8AXTxmhvk+AOvwYaMfd60cVTirex45iJ/bL88r2VpgElJz0A8gRUwA7o7hCnZahpedArirHH2UM0Rn6b662WDotb378haSWJvagQD+2boilKpOC1pkboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSCPF5RP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSCPF5RP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9441F000C4;
	Sun, 18 Oct 2026 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792346702;
	bh=lbZDBkg0RPLoZEk0qy5QezILklZ3O58FuUWO6feszX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jSCPF5RP+XtGe3IzcSOSM+NOmv+BVsCkM9SI/m2lEfgRGI6gpD5ucAGYfdgD8McGO
	 WVTVkxTuEgFoI3yIRQ4rQyMbRghHYZjzZfKWY1Z2eMiaJRQJSC4X9zcuyNyxWyVR5x
	 36bUcWS2xA9qcToODWQt+XSobaeacvInS+4U7wqPwKEt4Y4EbrDkCE8yl9fi6zlLmn
	 V1NAZaOs6/hnIO/YCFdMM3e8BssEG7a8YvETN1BLJUj8KQk/WqdE8KBlSGsX49hUBS
	 BilyYka0yzGHw6+b/VXhO3Vd0f5ZnimaxOkxzW02tm/6snI968lEyL6GpDaQP/6Oeu
	 esUzK9F5PbBHQ==
Date: Sun, 18 Oct 2026 19:04:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Jinseob <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, andersson@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 0/8] iio: add Open Sensor Fusion UART support
Message-ID: <20261018190454.054d3385@jic23-hlaptop>
In-Reply-To: <CALMSewJZbDbEe28v9VJ7sfTTNVJfvfcryS=0gpARAvc7g3MP8w@mail.gmail.com>
References: <20261011231340.42885-1-kimjinseob88@gmail.com>
	<20261018010201.4b427c3c@jic23-hlaptop>
	<CALMSewJZbDbEe28v9VJ7sfTTNVJfvfcryS=0gpARAvc7g3MP8w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Oct 2026 18:46:56 +0900
Kim Jinseob <kimjinseob88@gmail.com> wrote:

> Hi Jonathan,
>=20
> I investigated the review comments on the two pending OSF KUnit patches.
>=20
> The revised Kconfig allows the tests to run when OSF is built as a
> module, using the existing composite driver without exporting internal
> symbols.
>=20
> I validated the following configurations:
>=20
> OSF=3Dy, KUNIT=3Dy
>=20
> OSF=3Dm, KUNIT=3Dy
>=20
> OSF=3Dm, KUNIT=3Dm
>=20
> All configurations used the enabled KUnit test selector. The existing
> 16 core and 2 IIO tests passed, including actual module load/unload
> testing.
>=20
> I also added deferred mutex cleanup for the pending-session, receive
> and IIO test fixtures, and strengthened the producer/configuration
> synchronization. The relevant cleanup paths were validated, including
> assertion-abort cases.
>=20
> The unregister concurrency test depends on mainline commit
> 84bb0fc46ccf, which is not yet in jic23/testing. I therefore ran that
> test on a separate integration tree containing the fix.
>=20
> I have prepared and validated an updated, signed two-patch KUnit-only
> series based on the already applied OSF driver patches.
>=20
> Since you mentioned wanting to review the KUnit tests further, would
> you prefer that I send the updated two-patch series now, or wait until
> you have completed your review?

If you have them ready go ahead and send the updated ones.
I'll mark this versions as superceeded in patchwork.

Thanks

Jonathan

>=20
> Thanks,
>=20
> Jinseob
>=20
>=20
> 2026=EB=85=84 10=EC=9B=94 18=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 9:02=
, Jonathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Mon, 12 Oct 2026 08:13:32 +0900
> > Jinseob Kim <kimjinseob88@gmail.com> wrote:
> > =20
> > > This series adds a UART/serdev receiver for the project's fixed OSF
> > > Device-to-Host 0.0 protocol. Complete capability snapshots create IIO
> > > accelerometer, gyroscope, magnetometer and temperature devices with R=
AW,
> > > descriptor-derived SCALE and initialized buffered scans.
> > >
> > > The receiver validates the fixed OSF0 envelope, CRC and exact known
> > > message lengths. Equivalent capability reports are idempotent; changes
> > > to a bound supported inventory fault the session until explicit rebin=
d.
> > > IIO samples use host timestamps.
> > > =20
> > Hi Jinseob,
> >
> > I'm going to do something a little unusual which is more about the time
> > I have available today and desire to look more closely at your unit tes=
ts
> > to learn from them.  So for now I'm just going to apply the driver (so
> > patches 1-6) and leave the last two on list and in patchwork as still n=
eeding
> > review.  Hopefully I will get time to circle back to them later this
> > kernel cycle!  In general I'm keen to get broad testing into IIO so
> > want to learn from what you have done there.
> >
> > Jonathan
> > =20
> > > Changes since v10:
> > > - Move OSF under drivers/iio/sensorhubs/osf/ following review.
> > > - Use the OSF GREEN compatible with the generic OSF fallback.
> > > - Clarify complete capability-report snapshot semantics.
> > > - Use designated decoded-frame initialization and drop decoded reserv=
ed
> > >   fields while retaining reserved wire-byte tolerance.
> > > - Reuse stream reset and simplify core/serdev locking and lifecycle.
> > > - Use IIO buffer-mode claims instead of a private buffer lock.
> > > - Simplify scan storage and channel declarations.
> > > - Fix KUnit worker/device/mutex/resource/completion lifetimes.
> > >   Generic IIO self-test extraction remains deferred.
> > > - Synchronize KUnit fault observation and configuration completion wi=
th
> > >   completions and thread joins instead of short polling/deadline wind=
ows.
> > >
> > > The IIO buffer teardown serialization issue found during the v10 revi=
ew
> > > was fixed separately and is now in mainline as commit 84bb0fc46ccf
> > > ("iio: buffer: serialize buffer teardown with mode claims").
> > >
> > > This series is based on the IIO testing snapshot fetched for this sub=
mission:
> > > a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
> > > Runtime validation used this testing base plus the eight OSF patches
> > > and the exact mainline IIO core fix 84bb0fc46ccf6a545b8fdf57cda837701=
86ed8dd.
> > > The core fix is not included in this series and must be present when
> > > running the series on this testing base.
> > >
> > > Fresh validation of this source:
> > > - GCC and Clang W=3D1 kernel builds; module builds.
> > > - osf-core (16 tests) and osf-iio (2 tests), with KASAN, lockdep,
> > >   DEBUG_MUTEXES, DEBUG_LOCK_ALLOC, DEBUG_OBJECTS and DEBUG_OBJECTS_FR=
EE.
> > > - 200 production module load/unload cycles and 200 test-enriched modu=
le
> > >   load/unload cycles using identical driver/test C sources, exercising
> > >   20,000 IIO buffer toggles, scan subsets, timestamps and unregister.
> > > - DT binding/style/example/schema checks and IIO Sphinx build.
> > > - Clean sequential application and relevant builds of all eight patch=
es.
> > > Physical board tests were not repeated for this revision.
> > >
> > > Canonical specification (fixed revision):
> > > https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca=
9cdea1ae550c2b4d6f29f87877adae99470744/spec/osf-d2h-0.0.md
> > >
> > > The fixed public specification is maintained and adopted by the OSF
> > > project. This does not imply Linux maintainer approval of the
> > > specification or driver.
> > >
> > > Jinseob Kim (8):
> > >   dt-bindings: iio: add Open Sensor Fusion device
> > >   Documentation: iio: add Open Sensor Fusion driver overview
> > >   iio: osf: add protocol decoding
> > >   iio: osf: add validated stream parser
> > >   iio: osf: add UART transport and core receive path
> > >   iio: osf: add IIO devices from capability reports
> > >   iio: osf: add core KUnit tests
> > >   iio: osf: add IIO KUnit tests
> > >
> > >  .../bindings/iio/opensensorfusion,osf.yaml    |   55 +
> > >  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
> > >  Documentation/iio/index.rst                   |    1 +
> > >  Documentation/iio/open-sensor-fusion.rst      |   81 ++
> > >  MAINTAINERS                                   |    8 +
> > >  drivers/iio/Kconfig                           |    1 +
> > >  drivers/iio/Makefile                          |    1 +
> > >  drivers/iio/sensorhubs/Kconfig                |    7 +
> > >  drivers/iio/sensorhubs/Makefile               |    3 +
> > >  drivers/iio/sensorhubs/osf/Kconfig            |   27 +
> > >  drivers/iio/sensorhubs/osf/Makefile           |    7 +
> > >  drivers/iio/sensorhubs/osf/osf_core.c         |  460 +++++++
> > >  drivers/iio/sensorhubs/osf/osf_core.h         |   75 ++
> > >  drivers/iio/sensorhubs/osf/osf_core_test.c    | 1056 +++++++++++++++=
++
> > >  drivers/iio/sensorhubs/osf/osf_iio.c          |  288 +++++
> > >  drivers/iio/sensorhubs/osf/osf_iio.h          |   22 +
> > >  drivers/iio/sensorhubs/osf/osf_iio_test.c     |  386 ++++++
> > >  drivers/iio/sensorhubs/osf/osf_protocol.c     |  215 ++++
> > >  drivers/iio/sensorhubs/osf/osf_protocol.h     |   99 ++
> > >  drivers/iio/sensorhubs/osf/osf_serdev.c       |  151 +++
> > >  drivers/iio/sensorhubs/osf/osf_stream.c       |  230 ++++
> > >  drivers/iio/sensorhubs/osf/osf_stream.h       |   53 +
> > >  22 files changed, 3228 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/opensensorf=
usion,osf.yaml
> > >  create mode 100644 Documentation/iio/open-sensor-fusion.rst
> > >  create mode 100644 drivers/iio/sensorhubs/Kconfig
> > >  create mode 100644 drivers/iio/sensorhubs/Makefile
> > >  create mode 100644 drivers/iio/sensorhubs/osf/Kconfig
> > >  create mode 100644 drivers/iio/sensorhubs/osf/Makefile
> > >  create mode 100644 drivers/iio/sensorhubs/osf/osf_core.c
> > >  create mode 100644 drivers/iio/sensorhubs/osf/osf_core.h
> > >  create mode 100644 drivers/iio/sensorhubs/osf/osf_core_test.c
> > >  create mode 100644 drivers/iio/sensorhubs/osf/osf_iio.c
> > >  create mode 100644 drivers/iio/sensorhubs/osf/osf_iio.h
> > >  create mode 100644 drivers/iio/sensorhubs/osf/osf_iio_test.c
> > >  create mode 100644 drivers/iio/sensorhubs/osf/osf_protocol.c
> > >  create mode 100644 drivers/iio/sensorhubs/osf/osf_protocol.h
> > >  create mode 100644 drivers/iio/sensorhubs/osf/osf_serdev.c
> > >  create mode 100644 drivers/iio/sensorhubs/osf/osf_stream.c
> > >  create mode 100644 drivers/iio/sensorhubs/osf/osf_stream.h
> > >
> > >
> > > base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
> > > =20
> > =20

