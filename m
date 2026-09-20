Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE70175A95
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 04:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789878190; cv=pass; b=Cbd/U/MKlupYvHxXz2fGkf17ImhI2GXDb6JdwFx7q0y7ZDf+S7I7x5FHBlZawrHxH7ITi2tfTU2ikCzkakD2wnYMhgOnB8sGZRnFew2lR5P8OLJVvkuBp922dffNO5C4GwxnXl3TSeVOH3H2hkdWKZbWFp7Fzpy7e+tJaSWNHHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789878190; c=relaxed/simple;
	bh=AA68aMrswykmX+faf9hL7AMVgYZ0rqnpXfsUi4nLrBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSUZT06d+WmKExwkLPaIQP73jvaoTFqsFsc0BsM0b+VJRxkZPYv+zGTj/Fw0VOvu280bQudL8wrXL4pZumGiTJ36uJwoGO62yR8RGevHsATeE3TylZyYLVIFrdNtRzOkzL7Sb9G/xlixM+NIUWa66cECAUIBB1zyXfPIA1FoG8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/dl1CPN; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/dl1CPN"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso16185405ad.2
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 21:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789878188; cv=none;
        d=google.com; s=arc-20260327;
        b=JvVkdp846KRMqGF4pq1ewhPdathZ4l1iULngl8RG6OK15HippJ5RlD0k1w4WzgXGFJ
         vZM5NRpNX5YL7i3nc1/OqofoByUyT2QNQOFsMOVt6Mj2AY9NHnMYBUSxmh5cSfMfjwwa
         TGFbbQ7X5tMu21A3p4MtpnJH3HvganGRzpdEPLYHHBPox0O1Cgg52nUyXtU8diWN9ypN
         OCc2fDVPSLCerlS+wH/xMpfBTBlHI6A6N9TXYiuh2gRj3iLVMVR/fxvgwZYy6IF4tdIZ
         cnmPkNQVbXsEgn9nygi+SkdNz7/w+mEljtJVyrHwx0H3AkBGcrdHEMQXCI+VTYxVyGdy
         LJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CAqXU4QnYGB1y+rl3e3B29iEETQt0S+AEjq312CuHLI=;
        fh=SS/yhfOMBubnvlk9ISa/nQP49IC4RfojwqubkQZRFIY=;
        b=Vdwel7CZ2jXfS7+BJn+ANJvf+UtPw9gwFL2H+f2lrIMOI42ML8Z2N1RbFxlbxLQHvh
         fdn/RUU/ijgbFeRcfEbdu8B1JtLdCZ36RWw9FN7yiO0QdrtNhNSdRzAF7ppxPMu2hvbC
         QpMd4cysfTf6UG9qNvp0QFqxucE0s7g7j430HF3Gk4D+x34aWmiAphB/KX/iiLWswVIt
         nYF6XxTLTc73mpFgY6CVUPuOw/P+HtxAlj+3s8246bSOIyr5VnU92sO6ysXP4oZb/bQ/
         /FosIedPjWkk9t28Wp702QCRwWJC8c+HyyDWJWui1VMRhjI3Z+kiZHg/ocAataVAjilL
         EfOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789878188; x=1790482988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CAqXU4QnYGB1y+rl3e3B29iEETQt0S+AEjq312CuHLI=;
        b=W/dl1CPNEowRGf3nXAA45lGXiL+KQ2ugCE38ruHDEMLcYVVQPpQzXcuqDFD8LwpYqx
         L7TJKTCvDRnzusRUkblgZHoeNDscG1CNN+4ijSWJ40OrId1h9TLKeSiUaeqYYHaXDiw8
         u7mlSY14AH4OoiLQJBnDOTFbVQdHhBHsplvfA77JVicBXc6JJj9vClQ2yExMSjRMBGcN
         FTcSmii9uep5OxF9os7/m4eCF7ADQ9QHBNTEoJ6gVCr3srDQuooKYyEl1KkzT6Q0ZFSj
         IfJnDmZnJa4qkS8kfB936vR/JVVUyf1KZPBFy5ZW54JA3H+kEInMT1pEHhuQTQqXnL9U
         CmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789878188; x=1790482988;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CAqXU4QnYGB1y+rl3e3B29iEETQt0S+AEjq312CuHLI=;
        b=cUGzIZZLJ1lM6B9thWFWEgEccMX1QghGCXdWGbU6w00NOzRS73JprUiW8EESg6OpNj
         PdfIVLrUSVtOr7kauf9FETIq6xmhpYI/S7nFPg7ER1oMjgLT6g3/tMKLpUcRqzwHjlV/
         jOlwvudpbLbuP/AAkOPiGRL2cYnngNZxojlPRBHvu0zVqwI5BinTVQQsrRhdjUq81xSg
         HvJFfmMv4jyx414kwsafijL7I25sngxF/N3kQd8rcFQF1coRgQy21y3HnFWI/3whh7BJ
         XyqGU8QHajtManhc9v1wd6jZv2WKnmymzgmI9T246QRdClS4KEcv8w1Gclw7xvYf5gEY
         xGuQ==
X-Gm-Message-State: AFuF++mnRkJb/s55g30z0g7GkKYqMcR8icA98Xywyq2VzqqeBTdqOqRF
	QTzbEPBtf9BxseJ8QHO5N4A4xUM2W/TD46TZCnGa3LSWKLiX8lN6AwwQBkg3L/TEGAsXyftV1Cn
	YsSLBWoGItUVUFObYxXMLqOFVmZCe6uo=
X-Gm-Gg: AYBFou3yKkHFeGPKduS5XzgKArxpJpHQXsxY4JdokcgKdWdp7UVQ3mt7kqZZH1pOVW9
	eW+qCY0fH/RjRG3TdXL+Ew13M8AyKX28fvcATKv22dD83QAAtCWmLSVJRFsWf6i/zWDAFwx7NQG
	wiVURwNcvYfnYmKm9VLciTwoBqTez+xJAqJHzpvuUZgZu+LvTkGFXWlDfutJl6WcCHrXRsPMZzM
	jg7N68oVd882ytVTdr/5UdUZXRGkEvGXQr2SgVgd8rHUrVBLfHI/W4V7EMJejECvytgPkY0dP2E
	gKFqrbv30tVC9yVkwWNEXN80ChNDFUYei1GwoZr6zhB/k2+NvKnr7fM0T7wrZLFyz3eEZNeVq9Y
	wXiIlWbSNU1KndooiffJUzFj2HPDy8wYEcFxs6SnM
X-Received: by 2002:a17:903:2349:b0:2dd:c100:424e with SMTP id
 d9443c01a7336-2ddc10044e2mr49362715ad.50.1789878187454; Sat, 19 Sep 2026
 21:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789753020.git.kimjinseob88@gmail.com> <20260920030512.50f4f988@jic23-hlaptop>
In-Reply-To: <20260920030512.50f4f988@jic23-hlaptop>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Sun, 20 Sep 2026 13:22:58 +0900
X-Gm-Features: AcwNN1VuWoGeMmwFK8SO3q72J6yDJn0kccWHOWzv4mbLn2uAKQlLLK8lfaxPlsY
Message-ID: <CALMSewJ4ATy9eZ_GrHs-+Q+9yosiwhu3rtQUfxAbzOmR4R9cNQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/8] iio: add Open Sensor Fusion UART support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org, 
	rdunlap@infradead.org, joshua.crofts1@gmail.com, u.kleine-koenig@baylibre.com, 
	julianbraha@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Any reason not to push it one level deeper and put it under IMUs?
> I'm not that keen to grow the top level menu for this as all the
> other entries are about type of sensor, not one specific sensor.

Yes, I agree that adding an Open Sensor Fusion entry at the IIO top
level is not ideal.

My hesitation with putting it under imu/ is that Open Sensor Fusion is
not intended to be an IMU. The current Linux profile exposes
accelerometer, gyroscope, magnetometer and temperature data, but the
hardware/firmware architecture is a general sensor hub and fusion
device. Other OSF hardware variants can aggregate sources such as
pressure sensors, GNSS/RTK-GNSS, motor encoders and LiDAR in addition
to inertial sensors.

Would drivers/iio/common/opensensorfusion/ be a better fit?

There are already sensor-hub/common implementations such as the
ChromeOS EC sensors and Samsung SSP sensor hub under
drivers/iio/common/.

That would avoid growing the IIO top-level menu without classifying
the device itself as an IMU.

Thanks,
Jinseob

2026=EB=85=84 9=EC=9B=94 20=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 11:05, =
Jonathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, 19 Sep 2026 03:24:38 +0900
> Jinseob Kim <kimjinseob88@gmail.com> wrote:
>
> > Specification status: OSF-D2H 0.0 spec-1 has completed project technica=
l
> > stability review, has been adopted by the project owner, and is publish=
ed
> > as a fixed specification.
> >
> > Canonical specification:
> > https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca9c=
dea1ae550c2b4d6f29f87877adae99470744/spec/osf-d2h-0.0.md
> >
> > Errata process:
> > https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca9c=
dea1ae550c2b4d6f29f87877adae99470744/errata/README.md
> >
> > Current adoption/publication record:
> > https://github.com/opensensorfusion/opensensorfusion-protocol/blob/0cab=
ccf63ac01d0eb82dd9882739ff58eed4a76c/reviews/publication-record-20260918.md
> >
> > The specification was frozen before adoption/publication, so its embedd=
ed
> > status snapshot is intentionally historical. The dated publication reco=
rd
> > above establishes the current adopted/public state. This is project rev=
iew
> > and adoption, not an external maintainer approval.
> >
> > This series adds the Open Sensor Fusion UART receive path and IIO devic=
es
> > discovered from capability reports. It exposes accelerometer, gyroscope=
,
> > magnetometer and temperature data through RAW/SCALE and buffered scans.
> > Device Tree describes the sensor hub; its individual streams are discov=
ered
> > at runtime.
> >
> > The receiver validates supported descriptors and sample scales, keeps
> > discovery open after empty or unsupported initial inventories, and chec=
ks
> > repeated inventories before allowing new data to use registered metadat=
a.
> > A supported descriptor changing meaning faults the session until an
> > explicit teardown and rebind. Existing v9 cache, scan-layout and buffer
> > lifetime fixes are retained.
> >
> > Based on Jonathan Cameron's IIO testing branch:
> > 69fa76f0af3414cc189c3b0b807cb59e327ecc00
> >
> > Changes since v9:
> > - Publish and reference the reviewed/adopted OSF-D2H 0.0 specification,
> >   errata process and dated publication evidence.
> > - Tolerate reserved padding, validate descriptor/sample scales, keep
> >   discovery open after empty/unsupported reports, and compare repeated
> >   capability reports.
> > - Fail closed on changed descriptor meaning instead of publishing data
> >   with stale metadata.
> > - Add focused KUnit coverage for these lifecycle and validation cases.
> > - Use managed UART/IIO/power teardown and dev_warn_probe() for the
> >   controller baud-rate warning, addressing Andy's probe-path feedback.
> > - Split the former combined UART/core/IIO driver patch into transport/c=
ore,
> >   IIO registration, core KUnit, and IIO KUnit patches following review.
> > - Use validated/unvalidated terminology for framing/CRC results through=
out
> >   the stream/core/transport code, tests and diagnostics. CRC detects
> >   accidental corruption; it does not provide cryptographic authenticati=
on.
> >
> > Prior validation on the identical source tree:
> > identical source tree evidence reused; no builds rerun for DCO packagin=
g.
> > - All eight intermediate apply/config/relevant builds.
> > - Independent transport/core and IIO module link/MODPOST.
> > - GCC/Clang W=3D1 vmlinux and modules.
> > - GCC and Clang KUnit: core 16 + IIO 2, all 18 pass in each run.
> > - Core-only intermediate KUnit: all 16 pass.
> > - ARM64 Image, selected OSF module and Pi4 DTB.
> > - Targeted DT binding/style and IIO documentation.
> >
> > The terminology-only diff was verified mechanically. Wire semantics and
> > data-path behavior are unchanged; the receive diagnostic key is validat=
ed=3D.
> > Hardware testing was not repeated for this terminology revision or this
> > post-DCO packaging audit; previous hardware evidence remains historical=
.
> >
> > Human DCO is complete. No email has been sent.
> >
> > Jinseob Kim (8):
> >   dt-bindings: iio: add Open Sensor Fusion device
> >   Documentation: iio: add Open Sensor Fusion driver overview
> >   iio: osf: add protocol decoding
> >   iio: osf: add validated stream parser
> >   iio: osf: add UART transport and core receive path
> >   iio: osf: add IIO devices from capability reports
> >   iio: osf: add core KUnit tests
> >   iio: osf: add IIO KUnit tests
> >
> >  .../bindings/iio/opensensorfusion,osf.yaml    |   52 +
> >  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
> >  Documentation/iio/index.rst                   |    1 +
> >  Documentation/iio/open-sensor-fusion.rst      |   77 ++
> >  MAINTAINERS                                   |    8 +
> >  drivers/iio/Kconfig                           |    1 +
> >  drivers/iio/Makefile                          |    1 +
> >  drivers/iio/opensensorfusion/Kconfig          |   27 +
> Any reason not to push it one level deeper and put it under IMUs?
> I'm not that keen to grow the top level menu for this as all the
> other entries are about type of sensor, not one specific sensor.
>
