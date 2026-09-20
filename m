Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC0390999;
	Sun, 20 Sep 2026 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923936; cv=none; b=o1obNkbyx7NWy4HPrRmD5ZfMZcn5t/jyJL9bnT9s/iOpN8jSmiQOLa6cmDCn35uSYWdaYvzGH5B2AIpy7OhylMNWD9S1FrKFBNmiJW0nrxwuFrrXRV85aHcauhj+tg8TOhLLkNpu057mdy6ykYlBR2VWPbjeVb7TF/FWYbRYfR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923936; c=relaxed/simple;
	bh=9P7MYbhwh6wUyemh89f7DQ1SvlHWQbSD47gloWfxPVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAhjrkA0nEyDd3UQrgnojTcmS4Z+bKdIMVsKEZ9f4L7YqaVnfzFuZcvIr0+JWCqBTzPOwXATsN+RRUVD2aZKjQa/Tp93nwF2IIUEBkAg7CHXZwLJY4oRmo8zim4LuJ3BXhuHVqv6mslbgmTkkCrmN53eGpX3xqx/SacKetIpoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMmt9SpK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMmt9SpK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CCE1F000FF;
	Sun, 20 Sep 2026 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789923935;
	bh=haIzO1pAdV2cZZ2DvzEIWMRl+VDNhX2rc5xrz7+7Cg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mMmt9SpKBo0taBktUC2s2PqtSXvK/gOW9pcdPe8nyJj4HNJKjnWISm8RYURorlEPP
	 LBYjSujAJNGfKYl9bG0lwgwqbck7M1t6Y++4NWnpaXKPB037bl0LJASrAP87PoubnN
	 8SjmYrIFU8BOsMRQsPff9IYRlUWKX9lZSkwVreHeE44IR82PhmB3Ef5hKEBeGpGS+n
	 0+rkVODgdWQ+8RrTspBlPLy4bAQslVyin0DK7J7jLekd8j02rScouGi8/LWGgCuh3f
	 NT/5OWzTdE4WJVpv6Wa5/kmC4CPXgXQv/IklkQuWoko4pOz/ukXTqGAmTV/0yaqVPg
	 tdT9IFZRnS3bQ==
Date: Sun, 20 Sep 2026 18:05:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Jinseob <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 0/8] iio: add Open Sensor Fusion UART support
Message-ID: <20260920180524.6b18d644@jic23-hlaptop>
In-Reply-To: <CALMSewJ4ATy9eZ_GrHs-+Q+9yosiwhu3rtQUfxAbzOmR4R9cNQ@mail.gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
	<20260920030512.50f4f988@jic23-hlaptop>
	<CALMSewJ4ATy9eZ_GrHs-+Q+9yosiwhu3rtQUfxAbzOmR4R9cNQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Sep 2026 13:22:58 +0900
Kim Jinseob <kimjinseob88@gmail.com> wrote:

> > Any reason not to push it one level deeper and put it under IMUs?
> > I'm not that keen to grow the top level menu for this as all the
> > other entries are about type of sensor, not one specific sensor. =20
>=20
> Yes, I agree that adding an Open Sensor Fusion entry at the IIO top
> level is not ideal.
>=20
> My hesitation with putting it under imu/ is that Open Sensor Fusion is
> not intended to be an IMU. The current Linux profile exposes
> accelerometer, gyroscope, magnetometer and temperature data, but the
> hardware/firmware architecture is a general sensor hub and fusion
> device. Other OSF hardware variants can aggregate sources such as
> pressure sensors, GNSS/RTK-GNSS, motor encoders and LiDAR in addition
> to inertial sensors.
>=20
> Would drivers/iio/common/opensensorfusion/ be a better fit?
>=20
> There are already sensor-hub/common implementations such as the
> ChromeOS EC sensors and Samsung SSP sensor hub under
> drivers/iio/common/.
>=20
> That would avoid growing the IIO top-level menu without classifying
> the device itself as an IMU.

Lets just start a new directory (maybe move some others later) for
sensorhubs.  Common is meant for library type modules rather than
this purpose.  Often those are parts of sensorhubs.

So how about
driver/iio/sensorhubs/osf/
?
>=20
> Thanks,
> Jinseob
>=20
> 2026=EB=85=84 9=EC=9B=94 20=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 11:05=
, Jonathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Sat, 19 Sep 2026 03:24:38 +0900
> > Jinseob Kim <kimjinseob88@gmail.com> wrote:
> > =20
> > > Specification status: OSF-D2H 0.0 spec-1 has completed project techni=
cal
> > > stability review, has been adopted by the project owner, and is publi=
shed
> > > as a fixed specification.
> > >
> > > Canonical specification:
> > > https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca=
9cdea1ae550c2b4d6f29f87877adae99470744/spec/osf-d2h-0.0.md
> > >
> > > Errata process:
> > > https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca=
9cdea1ae550c2b4d6f29f87877adae99470744/errata/README.md
> > >
> > > Current adoption/publication record:
> > > https://github.com/opensensorfusion/opensensorfusion-protocol/blob/0c=
abccf63ac01d0eb82dd9882739ff58eed4a76c/reviews/publication-record-20260918.=
md
> > >
> > > The specification was frozen before adoption/publication, so its embe=
dded
> > > status snapshot is intentionally historical. The dated publication re=
cord
> > > above establishes the current adopted/public state. This is project r=
eview
> > > and adoption, not an external maintainer approval.
> > >
> > > This series adds the Open Sensor Fusion UART receive path and IIO dev=
ices
> > > discovered from capability reports. It exposes accelerometer, gyrosco=
pe,
> > > magnetometer and temperature data through RAW/SCALE and buffered scan=
s.
> > > Device Tree describes the sensor hub; its individual streams are disc=
overed
> > > at runtime.
> > >
> > > The receiver validates supported descriptors and sample scales, keeps
> > > discovery open after empty or unsupported initial inventories, and ch=
ecks
> > > repeated inventories before allowing new data to use registered metad=
ata.
> > > A supported descriptor changing meaning faults the session until an
> > > explicit teardown and rebind. Existing v9 cache, scan-layout and buff=
er
> > > lifetime fixes are retained.
> > >
> > > Based on Jonathan Cameron's IIO testing branch:
> > > 69fa76f0af3414cc189c3b0b807cb59e327ecc00
> > >
> > > Changes since v9:
> > > - Publish and reference the reviewed/adopted OSF-D2H 0.0 specificatio=
n,
> > >   errata process and dated publication evidence.
> > > - Tolerate reserved padding, validate descriptor/sample scales, keep
> > >   discovery open after empty/unsupported reports, and compare repeated
> > >   capability reports.
> > > - Fail closed on changed descriptor meaning instead of publishing data
> > >   with stale metadata.
> > > - Add focused KUnit coverage for these lifecycle and validation cases.
> > > - Use managed UART/IIO/power teardown and dev_warn_probe() for the
> > >   controller baud-rate warning, addressing Andy's probe-path feedback.
> > > - Split the former combined UART/core/IIO driver patch into transport=
/core,
> > >   IIO registration, core KUnit, and IIO KUnit patches following revie=
w.
> > > - Use validated/unvalidated terminology for framing/CRC results throu=
ghout
> > >   the stream/core/transport code, tests and diagnostics. CRC detects
> > >   accidental corruption; it does not provide cryptographic authentica=
tion.
> > >
> > > Prior validation on the identical source tree:
> > > identical source tree evidence reused; no builds rerun for DCO packag=
ing.
> > > - All eight intermediate apply/config/relevant builds.
> > > - Independent transport/core and IIO module link/MODPOST.
> > > - GCC/Clang W=3D1 vmlinux and modules.
> > > - GCC and Clang KUnit: core 16 + IIO 2, all 18 pass in each run.
> > > - Core-only intermediate KUnit: all 16 pass.
> > > - ARM64 Image, selected OSF module and Pi4 DTB.
> > > - Targeted DT binding/style and IIO documentation.
> > >
> > > The terminology-only diff was verified mechanically. Wire semantics a=
nd
> > > data-path behavior are unchanged; the receive diagnostic key is valid=
ated=3D.
> > > Hardware testing was not repeated for this terminology revision or th=
is
> > > post-DCO packaging audit; previous hardware evidence remains historic=
al.
> > >
> > > Human DCO is complete. No email has been sent.
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
> > >  .../bindings/iio/opensensorfusion,osf.yaml    |   52 +
> > >  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
> > >  Documentation/iio/index.rst                   |    1 +
> > >  Documentation/iio/open-sensor-fusion.rst      |   77 ++
> > >  MAINTAINERS                                   |    8 +
> > >  drivers/iio/Kconfig                           |    1 +
> > >  drivers/iio/Makefile                          |    1 +
> > >  drivers/iio/opensensorfusion/Kconfig          |   27 + =20
> > Any reason not to push it one level deeper and put it under IMUs?
> > I'm not that keen to grow the top level menu for this as all the
> > other entries are about type of sensor, not one specific sensor.
> > =20

