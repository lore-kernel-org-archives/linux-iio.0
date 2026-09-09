Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D371B376A0C
	for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2026 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980267; cv=pass; b=YnOoq/p7BFFBu7WY+Ho6xh5nJ47uxwDgqkwtZ680iFhORhTbrmaTfZLZfNNywkiiewcPIX97D6r2OUZR6Qob4jbhbX5DEOaZAOp0NVcIkxXuZGbf4pjxoBpySju7VOd+uGcneg9wBbvfdDxSFlBFKUsSToJjJP85b0+pIj/Qi3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980267; c=relaxed/simple;
	bh=WbeG64AorhHsTdCsQYdSDMzovN06CfdjHTIjqvGTqSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA6jMgMhSk/mZ4VROaUpqu0L0LzIY0EiF71pvwPrwssNUZyQ10U18Km9wYVtCJa2W3xP0UJPCV3apmQrXDLhX/QlopIdyPs6ea4DZhAI4WV+ZScK3lH3AaRbjl5KCbCdDVhldXyKwU2A2j2P8fp+uPcGHHRsQsy1Yxbzn1gmzyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDKyLBwQ; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDKyLBwQ"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c96c92c0980so3428703a12.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 11:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788980265; cv=none;
        d=google.com; s=arc-20260327;
        b=gJSJAO9Y6kllWGxRGMn95h3qBU5wsM3wE4zPNL/aD7nH+GthlV5G83RkGLZFaIRmY+
         qACwY3M3kTD4T4D1Ix9toPdt8WRd+pUU2BQ+Tz/7O9L0U7eZ0Urt9BzBRRTyktKTTz3w
         XZSSq3tXgkRwWxxUb9BcDd8P9h0u3rDMWCYylQMTyRsyDGzwZSeEhR5G+HopBg53ZqgB
         pEOOOn2s/iGo9gAHQUnARpnl/n8TJ5KpyGgRVVAs7NaQjSKI5imPxLeYVIPhN7J4O705
         gh07plGpiSNqGCHrJN43gfydix8UC6qc2UtB2Ld6ii/M1Xr9QRyPOWcmx3qp21u1OPXX
         3YJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/exTjUH+gs9Yy4hX5uQ5ycgwaqSVDjVmti5Tk/GIvvg=;
        fh=e59MIBWQLBFazOpmZJjHpbrjut61xDh4Wvv4yU7J6yU=;
        b=NTUxyIZIETy3AmP/rdzc7miE3X7BDJPG/F+Xz40+Kati7TzIcHxhWFOLT41R6QbTwF
         p3BtFnaKaiBFj4LYgi8Huzydw96yrBLLm152wMdCfOiLcjOrVAUyLQH4lqD3MSpVmRJB
         pGKCQylLkTf+knedVcmmNLPuYPyaRUzgOzT1KFME/nK2SMzfAEmRZI56QMeQrZlxSvzK
         9DHCsTjUapL04r4khA7RzXBotG86/10F+FLAyZiKxDMQ8EFNVvWAhckEjAyXwAgqu/5c
         LcHgL4nshx36vul6tKED61qJGcc4iDAxxZ+jhdkUjTVcWwhlSkfTqR3OlC2UlHr/0koh
         0v2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788980265; x=1789585065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/exTjUH+gs9Yy4hX5uQ5ycgwaqSVDjVmti5Tk/GIvvg=;
        b=PDKyLBwQ1Ltlto3n9u8zqpjedLyUi29J078n7QvqUySB/ud3zs4pyErTLxLRwYtcn8
         LEmOkc7QFrGamNJrFpZeMHJGPsmbB+K3g77bTiX1Oh/9rquJJerEhyzjzjYkxbgrsETt
         h61Ov8/2OFZ4CK5hKNoW2kvc2O7DeEdA+ap/kNfnPt8mM4mqmzdPu0MZa0Oyz2ebUgJX
         iFMZXpUyEBvFaxT7E7WEL6kwmOjcOKuygqtRECO42dzGKUmIiUfPFZOyWCxI1+05YSCw
         2oMHJeeypCfxCV0oeTneqqpg6Ln6TUg1p9mQmBvLifjzua4SLfQDa827c7u0/Mc0Iq1K
         +Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788980265; x=1789585065;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/exTjUH+gs9Yy4hX5uQ5ycgwaqSVDjVmti5Tk/GIvvg=;
        b=jD5Lqh2L06/s1rXXPXUVULR1jx3kSqio8D6Ax4Dc2HYOxbSOpAl5kcRArGZKDB5/yg
         ylbHMInMOwpsHchS9cAwT0YmLl312Ll2i8F0UBwFv3MOPvk3lsMucnhuovv7fqNp0PzL
         6vojh6XfsnOr44c4hLqjd5IGFG3URNyghFDQEdsmswzpDP+J9H9RVENXZU6foctA57nO
         /kyvNrbpuigx62d14MHJCqr8imgwITfdHtLinYVB1A34ZKG29G4do5vap6gzIGcDd7kH
         yd1Xal1KsJd8WAmgLV3Yj0TAzblljI9U45wM4Q/Eec7DEhMwWLMAxoktp0A35c8L+9uS
         vucg==
X-Forwarded-Encrypted: i=1; AKwUvBzQ/akSF0qorE8do9/lf6E9cc56hQy7XigkADKOcnL8vCt4fqHBMqkUVcyAnLafF4U8ZWksdkuuGlw=@vger.kernel.org
X-Gm-Message-State: AFuF++m0EFM/3/Xc6sz8It1w/yCSc7rTSXIDLPtejE0nuHfWF5CYTZoX
	vKjH1/mQb2zpC25IEdDi4x8fG+q8LMQ1M+PA/d8ox3gLQ5LGWWexPPFO7oP8FZImUavj2Dx7SX0
	dvQP+rv+HAiozs8vglMHMfjYsFwvaF0M=
X-Gm-Gg: AYBFou2HIFsOD2Mn4+g2sjhjzaVwYrCX0Y6sV1vnes6varwTCpOMYjpFL03Fuh50sxv
	YsNzEG6ueJWOMaCg1ukVGkGHVeozGKeTv9MfeUjp55KG8Ylbss7hBJiA9y1pSv0bkz7GPQpgU8Y
	EWbBC/7x2t1iLMZcHBQ/T4CTZSSaNW8sAUUwV/xBVcnMtA3eNfROS9rSlsP4HpUMHQ6McELfhJ4
	Zt8RAbDyJZ5HZOuRslqQUhJO9fdIv6ZcehzsmSj+GaSBYhFdKW6AigIItZKw0B/Z5MiKL7JlDl5
	4CxMe0W5cah67yz8dNE67C9W4MMeNf4JDf8OUcsRQG1Mkh9SGapH9MUZIf/NVZnk/QIOsq1ksgv
	BDa0AGt1fsaWmIi5jFfAQuHkM6ioFhGt00D3jKV2P
X-Received: by 2002:a17:90b:274c:b0:398:9be9:ab92 with SMTP id
 98e67ed59e1d1-39b2629b27fmr57161061a91.23.1788980264796; Wed, 09 Sep 2026
 11:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
 <CALMSewK17jG3MXTHv4Rj+tFVriw9+tqNuAMcX4KGQGy5NQP_MQ@mail.gmail.com> <c0fb5a98-436b-42a5-8e2d-2ffdc6e53e25@infradead.org>
In-Reply-To: <c0fb5a98-436b-42a5-8e2d-2ffdc6e53e25@infradead.org>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Thu, 10 Sep 2026 03:57:32 +0900
X-Gm-Features: AcwNN1UGFTJqKofzEk9iPH0HSBbnTV2M63ynTpBswdUwBjrcLA_4VXVSLlRRTGo
Message-ID: <CALMSewJ2oAVBicSTNbfKU42UEwg24w4L0QNmSx5tQ0v=y9vb9Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] Documentation: iio: add Open Sensor Fusion driver overview
To: Randy Dunlap <rdunlap@infradead.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org, 
	joshua.crofts1@gmail.com, u.kleine-koenig@baylibre.com, julianbraha@gmail.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randy,

> What email client did you use to send this patch?

I used a tool that sends through the Gmail API.

I'll check the received raw messages to investigate the line wrapping.

Thanks,

Jinseob


2026=EB=85=84 9=EC=9B=94 10=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 1:02, R=
andy Dunlap <rdunlap@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi,
>
> On 9/9/26 8:05 AM, Jinseob Kim wrote:
> > Document the Linux IIO mapping for Open Sensor Fusion devices.
> >
> > The overview explains that sensor channels are discovered at runtime
> > from mandatory capability reports. It also documents that OSF0 is a
> > wire-format detail and that protocol_major and protocol_minor carry
> > protocol compatibility information.
> >
> > Assisted-by: LLM
> > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> > ---
> >  Documentation/iio/index.rst              |  1 +
> >  Documentation/iio/open-sensor-fusion.rst | 84 ++++++++++++++++++++++++
> >  MAINTAINERS                              |  1 +
> >  3 files changed, 86 insertions(+)
> >  create mode 100644 Documentation/iio/open-sensor-fusion.rst
> >
>
> What email client did you use to send this patch?
> It is wrapping (longer) lines for you, in a way that's not good.
> It causes malformed patches.
> You can see it below or at
> https://lore.kernel.org/linux-doc/CALMSewK17jG3MXTHv4Rj+tFVriw9+tqNuAMcX4=
KGQGy5NQP_MQ@mail.gmail.com/T/#u
>
>
> > diff --git a/Documentation/iio/open-sensor-fusion.rst
> > b/Documentation/iio/open-sensor-fusion.rst
> > new file mode 100644
> > index 000000000000..15d41202eb66
> > --- /dev/null
> > +++ b/Documentation/iio/open-sensor-fusion.rst
> > @@ -0,0 +1,84 @@
> > +.. SPDX-License-Identifier: GPL-2.0-only
> > +
> > +Open Sensor Fusion
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Open Sensor Fusion is a sensor aggregation hub interface. The Linux II=
O driver
> > +receives OSF protocol frames from an attached device and registers mat=
ching IIO
> > +devices for the sensor classes supported by the driver. The actual sen=
sor
> > +channels are discovered at runtime from mandatory OSF capability repor=
ts.
> > +
> > +This document is a driver-facing overview for the Linux IIO mapping. T=
he full
> > +wire protocol, firmware behavior, and hardware model details belong in=
 the Open
> > +Sensor Fusion project documentation.
> > +
> > +Device Model
> > +------------
> > +
> > +An OSF device sends binary frames from the device to the host.
> > Devices using the
>
> ^^^ Should be one line, not two.
>
> > +``opensensorfusion,osf`` compatible are expected to provide
> > +``CAPABILITY_REPORT`` messages so the host can discover which sensor
> > streams are
>
> Same.
>
> > +available. Device Tree describes the attached OSF sensor aggregation
> > hub; it does
>
> Same.
>
> > +not enumerate the individual sensors discovered at runtime.
> > +
> > +The currently supported Linux subset exposes:
> > +
> > +* accelerometer samples as ``IIO_ACCEL`` X/Y/Z channels,
> > +* gyroscope samples as ``IIO_ANGL_VEL`` X/Y/Z channels,
> > +* magnetometer samples as ``IIO_MAGN`` X/Y/Z channels, and
> > +* temperature samples as ``IIO_TEMP``.
> > +
> > +Protocol Scope
> > +---------------
> > +
> > +The driver supports OSF protocol major version 0 for the IIO receive p=
ath.
> > +The current wire magic is ``OSF0``; that string is a wire-format detai=
l and is
> > +not the Linux driver identity. Device Tree keeps the generic
> > +``opensensorfusion,osf`` compatible rather than naming a product such =
as OSF
> > +GREEN or a wire magic value.
> > +
> > +Protocol versioning is carried by the ``protocol_major`` and ``protoco=
l_minor``
> > +fields at fixed offsets in the OSF frame header. The driver currently
> > +supports ``protocol_major`` 0. ``protocol_minor`` changes within major=
 version
> > +0 are intended to remain backward-compatible within the fixed header l=
ayout.
> > +Incompatible wire-format changes require a new ``protocol_major``. A f=
uture
> > +device that cannot expose compatible version discovery through that fi=
xed
> > +header layout would need a different Device Tree compatible.
> > +
> > +The Linux driver handles device-to-host frames for:
> > +
> > +* ``SENSOR_SAMPLE`` buffered and direct-mode sample data,
> > +* ``CAPABILITY_REPORT`` based IIO device registration, and
> > +* ``DEVICE_STATUS`` cache updates.
> > +
> > +Vendor-private message types are ignored. Command transport, calibrati=
on
> > +control ABI, fusion output ABI, and runtime capability removal are out=
side the
> > +Linux IIO receive path.
> > +
> > +Timestamps
> > +----------
> > +
> > +OSF frames include a device-side ``timestamp_us`` field. Buffered IIO
> > samples use
>
> Same.
>
> > +an IIO timestamp captured on the host when samples are pushed to IIO b=
uffers.
> > +The driver does not correlate the device timestamp with the host IIO
> > +clock.
> > +
> > +Compatibility Notes
> > +-------------------
> > +
> > +This overview describes the implemented receive path, not a normative =
wire
> > +specification. A publicly versioned specification covering reserved fi=
elds,
> > +extensions and physical scale units remains needed for interoperabilit=
y review.
> > +
> > +The decoder requires the fixed header size and the exact payload lengt=
hs of
> > +known messages. It ignores unsupported protocol majors, unknown messag=
e types
> > +and frames with nonzero header reserved fields. Unsupported capability=
 entries
> > +are skipped individually; malformed known payloads are rejected. Appen=
ding data
> > +to an existing known message is therefore not a compatible extension f=
or this
> > +receiver.
> > +
> > +IIO scale is taken from the initial capability report and is not updat=
ed by
> > +sample frames. Devices must supply scales in the units required by eac=
h IIO
> > +channel type, including gauss for magnetometers. Historical OSF draft =
documents
> > +differ on reserved-field handling, trailing extensions and magnetomete=
r units;
> > +those drafts do not establish a canonical specification for this drive=
r.
>
> There is some help for various email clients in Documentation/process/ema=
il-clients.rst
> that may help you (or not).
>
> --
> ~Randy
>
