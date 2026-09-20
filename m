Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF93AEF3F
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 03:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789876660; cv=pass; b=N3hJ528TV6N0YdpTk4dsWXrcXfdmpydDFk6X6M+FszN3wpGLlqGSeJ2bTWLVnzidDSDfe1J7IlbwUfA40rRwAAXRGPi0dUzDR4OuGO3uHWdN/jB4jZ2ynrf2F61/areoFZ8UgGhWHfihOsKIY8tl2rvc/SRPM5YoaaNg9rip0aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789876660; c=relaxed/simple;
	bh=01GZU/jLIcXtdAKaeOdDyvEN/rN3WyW3iNdMo3ImlIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgPnfT0tDqYUkHAi0L8Oq0qCWmaN99qCccRXlmkNRYi9ldfx/KMF81Npm+mFjiiGdqxjdkrM4lv/BjvOgWLgJf4xiFiOHN13xLKgfb62tQd21TAsyrmQXldTH15aQp/s/y/qj+neYoWVjfH1rMxlUYgTzTWC0EXl5dz8fmXUtQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbGFvAwk; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbGFvAwk"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39647184c73so2536245a91.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 20:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789876658; cv=none;
        d=google.com; s=arc-20260327;
        b=hWGMwFboATxWm5OI5etr7AcGB1IRTclpxFejdFI3g/aeiKXMSNFBiACjy6Ks83mcL1
         BtVsIvnEP8QDKAgEwIF9h71XmGh8Vz/bQ05HP3TPI4rbvvTRFM/0MLtSVIQxrAEymBXX
         L7bp0cJ6X2W/vkrlAqFmh3Ry+Xjy40oYoxdmbKwiYWTwaSICftVjNS6e90/f5wSHxaIR
         iYS0Xc1XfQznuP60KAZk/F87NeE3zYvpitpT5js3XehrVt38N5kkIk/dCiPWw9Go7Ldy
         bbyy7qGPsMTh8hFA9zVupiOa3UlIxjRZED2mHYh4fHfmSlnxGQuLhOFa1IbSIfA8avB9
         BB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=znS7PwEw/HPsC2fBiIZ8UstZ+J7E6Fo1CbQIj0vmESY=;
        fh=SS/yhfOMBubnvlk9ISa/nQP49IC4RfojwqubkQZRFIY=;
        b=RgYFs/B9yHi3kFbCJvW7VO3312dd9MsPdP7itl2+ozPVn3LTDuwu5PbUeet1697OWS
         +QTBZpEj9jmowis/OuM+j8K6j799z9tcwVpcrwKJqGKNLXt/yIgqmi9JuI1B5ho898ko
         6gcVVQUXm6UF2y3wYlfyNvQ3yt/CnxrbhzOWfRqufOe8wSCa+ArS9UGOF9LynZ7a9AQk
         wBCAtKf4jDO+Ru5hU9LypFrnCZC3WR+tRlm9sFJ0SGhqu/eT0IKYhqIDr38bM5wTOKUp
         6DqLcESoWvFhlkPcwrmokIKKiMxG+RZj/Lsl7iiJ2PaxxSbPvawH/Hu3mOZOSFyaG33T
         1TWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789876658; x=1790481458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=znS7PwEw/HPsC2fBiIZ8UstZ+J7E6Fo1CbQIj0vmESY=;
        b=XbGFvAwk9TRvZypSbLtmQsdoVmpqESaeipr+sawUw9u+h4rVgjIFr2ClEtGMGEhKjx
         3B+PmYX/4XykJNm/cgFF0JPdn6hqFV7wJvvdK5XwgXJFP3rZL5MpNOQtOKF2hQhxlZBa
         ZDEmpDIUV61CreuLupw6kFzrkUAsVQo/hKVq9F1ig1crgh6S4o0peodCbxNV6smrq4DS
         1nzHBeGf4miPzcOgXy5IUlOmQJc9njWLqseSE+SmPFGTiw6o7z3K8/stUpxDgo+J0bTx
         gr2Y7HAxpaVkPuRuj16PDo4MTfXbxoPYFc70vJjW0u9r3ewmS/iwDqrKHyySvw1HMNSj
         qSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789876658; x=1790481458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=znS7PwEw/HPsC2fBiIZ8UstZ+J7E6Fo1CbQIj0vmESY=;
        b=Paky2sywuuOZE1RattvgZliVCaF8P2Q1g26e+UxGh3rHfrA5x1VzVU7ZEpbxXsQ5IG
         o+JcvMncJVHOHSB9+pgM5Vywgl4wOixMIlDrGm0Fwy3WNwmNESXGFKADVgfqqoFxId3D
         8powPTOgFqAVNrrf/sM/G4My74yNxJDV2DxDLoYQTY0xs9EIbFq9BtT5W0RaFf5Dpz/N
         cI8+mffbJLJRqlD1tpD0LqBLlbutMLWEv1zdLMpw7N/E2lgd8pZxq+kf4dLGf+ygwndt
         qBBTfEtVX2ZA8fWEUOfrlhoT2D5qbJmR/6Q1KYZ+3OBzRFuyMSFaL/my6k1NGzGyKvte
         i28Q==
X-Gm-Message-State: AFuF++mFC3U64kPtuTvkFjx5qcYay3X2cXsGFWD4AxRcDFXvoj9zSMNJ
	GdQjs5uPoYa8xIAc+47YmFP1WHTEPeKObbkgLazjCfpUZPDkoC7O0f5Zsd35mArvcdh0xMh3tyO
	pRW4qN/0Hl8Q+h05AgX2ONnChCC6MJ+w=
X-Gm-Gg: AYBFou3T9pJVi46nPZlFCCQPJB+5Ku9Y+cHnhc54UU2T9/bFC7kMXm23b+RlCiS2qEY
	O8QguQCGLcaPHfpoj7T+KVnO0m2QYkbDoFRXxfCzkBPtGsAdg2OiI5sMcS8ttLMDlsw8hua8p+w
	fE1CqvSmoyzVFZQJy6XAMyX46sc1zessj9IpE2MJhHWfVc7QKacgzwkTJVfZd2eAPHsyaIzPtL6
	JCKPjh20JmluDVBIk8evEblK9YeX62htmuAowkHHOlfErEffHani1d3Plmdf6+f2ZNaCMSU6tg4
	xppUafzkcYmdhX8rdWqB1+R5z6tBVzJQxjdo1S1hkGy5lKn5VmtXfYUIlMnNqs0Sa+EE5kSK7iw
	/tByl/2GtWoo8TrCr+fXOLE28eD4bCDAci0yI87gu
X-Received: by 2002:a17:90a:e7c7:b0:3a0:25f0:d89b with SMTP id
 98e67ed59e1d1-3a025f0de30mr3043839a91.50.1789876657661; Sat, 19 Sep 2026
 20:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789753020.git.kimjinseob88@gmail.com> <9fdbc924bf3387a4d33d1258ea21ac33abef65bb.1789753020.git.kimjinseob88@gmail.com>
 <20260920021238.6d4ff353@jic23-hlaptop>
In-Reply-To: <20260920021238.6d4ff353@jic23-hlaptop>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Sun, 20 Sep 2026 12:57:28 +0900
X-Gm-Features: AcwNN1WtBlzfWX0n4kCCth-9RIkby4yGdvgGCxFz3ox1yJaRl3ZK2zZ0hMZoeTg
Message-ID: <CALMSewJqj6UseoMg-Cpi4C1kd7E83SinE_WJj=nMEVhy1hNgSQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/8] Documentation: iio: add Open Sensor Fusion driver overview
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org, 
	rdunlap@infradead.org, joshua.crofts1@gmail.com, u.kleine-koenig@baylibre.com, 
	julianbraha@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

both points make sense.

The capability reports are complete inventory snapshots rather than
incremental fragments. An empty or unsupported-only initial report
does not establish a supported inventory, so discovery remains open.
Once a complete report with supported descriptors establishes the
inventory for the host session, later reports are still processed:
equivalent inventories are idempotent, while a supported key
appearing/disappearing or changing its shape, format, or scale is
treated as an inventory change and faults the session.

I'll clarify that distinction in the next revision, and also change
=E2=80=9CUnsupported majors=E2=80=9D to =E2=80=9CUnsupported major versions=
=E2=80=9D.

Thanks,

Jinseob

2026=EB=85=84 9=EC=9B=94 20=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 10:12, =
Jonathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, 19 Sep 2026 03:24:40 +0900
> Jinseob Kim <kimjinseob88@gmail.com> wrote:
>
> > Document the supported OSF receiver profile, runtime sensor discovery,
> > IIO channel units, scale validation and session lifetime.
> >
> > Link the project-maintained fixed wire specification instead of
> > duplicating its layouts and compatibility policy. Explain host IIO
> > timestamps and the explicit rebind needed after a changed inventory.
> >
> > Assisted-by: LLM
> > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
>
> Hi Jinseob,
>
> Just a couple of minor things inline.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  Documentation/iio/index.rst              |  1 +
> >  Documentation/iio/open-sensor-fusion.rst | 77 ++++++++++++++++++++++++
> >  MAINTAINERS                              |  1 +
> >  3 files changed, 79 insertions(+)
> >  create mode 100644 Documentation/iio/open-sensor-fusion.rst
> >
> > diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> > index b02b879b053a..c2b7963348fd 100644
> > --- a/Documentation/iio/index.rst
> > +++ b/Documentation/iio/index.rst
> > @@ -40,4 +40,5 @@ Industrial I/O Kernel Drivers
> >     adxl345
> >     bno055
> >     ep93xx_adc
> > +   open-sensor-fusion
> >     opt4060
> > diff --git a/Documentation/iio/open-sensor-fusion.rst b/Documentation/i=
io/open-sensor-fusion.rst
> > new file mode 100644
> > index 000000000000..03ab36aca5f8
> > --- /dev/null
> > +++ b/Documentation/iio/open-sensor-fusion.rst
> > @@ -0,0 +1,77 @@
> > +.. SPDX-License-Identifier: GPL-2.0-only
> > +
> > +Open Sensor Fusion
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Open Sensor Fusion is a sensor aggregation hub interface. The Linux II=
O driver
> > +receives device-to-host frames over UART and discovers sensor channels=
 from
> > +capability reports. Device Tree describes the hub using the
> > +``opensensorfusion,osf`` compatible; individual sensors are discovered=
 at
> > +runtime. See the binding in
> > +``Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml``.
> > +
> > +The OSF Device-to-Host 0.0 specification is maintained by the Open Sen=
sor Fusion
> > +project. The canonical specification_ defines the wire layout, compati=
bility
> > +rules, reserved fields and physical units. This document describes the=
 Linux
> > +receiver profile and its mapping to IIO.
> > +
> > +.. _specification: https://github.com/opensensorfusion/opensensorfusio=
n-protocol/blob/ca9cdea1ae550c2b4d6f29f87877adae99470744/spec/osf-d2h-0.0.m=
d
> > +
> > +Supported receive profile
> > +-------------------------
> > +
> > +The driver supports the fixed OSF0 frame layout with protocol major ve=
rsion 0.
> > +Compatible minor versions use the same known message layouts. The deco=
der
> > +requires exact lengths for known messages, validates CRC and bounds be=
fore
> > +interpreting payloads, and tolerates reserved padding. Unsupported maj=
ors and
>
> If you spin again "Unsupported major versions and.."
>
> > +unknown message types are ignored. Unsupported capability entries are =
skipped
> > +individually. A CRC-valid application rejection consumes the complete =
frame;
> > +an invalid frame candidate is resynchronized without trusting its payl=
oad length.
> > +
> > +The receive path handles sensor samples, complete capability reports a=
nd
> > +device status. Its limits are 4096 bytes per frame and 16 supported se=
nsor
> > +descriptors. These are implementation limits, not protocol-wide maxima=
.
> > +
> > +IIO mapping
> > +-----------
> > +
> > +The supported sensor classes map to:
> > +
> > +* accelerometer: ``IIO_ACCEL`` X/Y/Z, in m/s^2;
> > +* gyroscope: ``IIO_ANGL_VEL`` X/Y/Z, in rad/s;
> > +* magnetometer: ``IIO_MAGN`` X/Y/Z, in gauss;
> > +* temperature: ``IIO_TEMP``, in millidegrees Celsius.
> > +
> > +Each registered channel exposes signed ``RAW`` data and descriptor-der=
ived
> > +``SCALE``. Multiplying RAW by SCALE gives a value in the channel's IIO=
 unit.
> > +Buffered samples use signed 32-bit values with native CPU endianness. =
Active
> > +channels are packed into the scan, with initialized padding before an =
optional
> > +64-bit timestamp.
> > +
> > +Discovery and session lifetime
> > +------------------------------
> > +
> > +The driver validates all supported descriptors before registering IIO =
devices.
> > +An empty or entirely unsupported initial report leaves discovery open =
for a
> > +later supported report.
>
> So if the device can send multiple discovery reports, this implies if we
> recognise something in the first one we will stop looking at later ones?
> That seems odd given if we don't recognise anything we keep looking.
> If I'm reading too much into this text, then please tweak it to make
> it clear why this doesn't matter.
>
> > Supported descriptors must advertise a nonzero scale.
> > +A sample's channel count, format and scale must match its registered d=
escriptor
> > +before it can update the latest RAW cache or be published to a buffer.=
 A
> > +rejected sample preserves previously accepted data.
> > +
> > +Repeated reports are compared by sensor type and index, independently =
of entry
> > +order. Reserved padding, advisory flags and unsupported additions do n=
ot change
> > +the supported inventory. A supported key appearing or disappearing, or=
 a
> > +change in its channel count, format or scale, faults the bound session=
.
> > +
> > +After a session fault, new cache updates and buffer publication stop, =
and
> > +direct RAW reads fail. Existing IIO devices remain until driver teardo=
wn.
> > +An equivalent report does not clear the fault; explicit unbind/rebind =
starts
> > +fresh discovery. No fault-specific userspace ABI is exposed.
> > +
> > +Timestamps
> > +----------
> > +
> > +Buffered samples use the selected IIO host clock when they are pushed =
into
> > +the buffer. The device timestamp is not correlated with that clock and=
 is not
> > +used as the IIO buffer timestamp. Device timestamp or sequence discont=
inuities
> > +alone do not start a new host session.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9463b8111d52..26b9b2862724 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20515,6 +20515,7 @@ OPEN SENSOR FUSION
> >  M:   Jinseob Kim <kimjinseob88@gmail.com>
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> > +F:   Documentation/iio/open-sensor-fusion.rst
> >  K:   opensensorfusion
> >
> >  OPENCOMPUTE PTP CLOCK DRIVER
>
