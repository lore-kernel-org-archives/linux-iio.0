Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719673CCFD8
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562236; cv=none; b=Kr+wNb96YSpnEDz3JZzPyf1LCWnaqDjiqVxIhWGsF0eSFqbf2t6uSH8YaQJqzhEOiAax1v745BhMZxHEU00M82gcURwZuAdnJMoxuQMdmxgSoJ68qOGJwt5uHa6qDpaKg2Aw9UI29UDCo7btNa8OrUYEf/7rC1SjEuteRlHoE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562236; c=relaxed/simple;
	bh=4A60ZJF68O75HaI9fmXQk/Fc3hON81sL/R70Q8mv9oU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFyIJbTsVMAz7D3RwwzJNmveGoKzVjWDrhEH51jsameUcqHFO84kBGG3zaFOkA7nli7d6CINV76W31xcCVV4LsYh0e0EdPVbdTJMhQKrmuOEY7Tffqnk1yNe8LvfsTtPdTp/Ek9ZtmCkupMCcCbExKOrlHF0Bl/E5uCnh2Nl+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAOxHfGI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAOxHfGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070141F00893;
	Thu,  4 Jun 2026 08:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562235;
	bh=3p3QgNrlbLyp2UezB/sY3KcHfbXhwi/rbANXftf+rHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KAOxHfGIHqD1CBhZb3Jsj11RR8xrD8jWft3zD2z3GDyo0VSfRCInjO/xm47UBROUE
	 i5n6xqprH01QrFIXlbaSFF0+5wsuBUVpFm4MbVDVmT+3OJ44aR6126b783Nv9ntmpp
	 p78vm6UdrVmwGZeV37Z/aEhoI2url4Wu3FRWawQdqMTsmZKtDo4fFsmWmORoxqSz4L
	 ZDY72pEixD89+49D7Qkwea2vpv7d55yEieMdwZ9FaMazf7gWwQrLGTu26SHNWMaRp6
	 BTRk1z5xGIR8leWFDY/H4emMCebDLgrIVUjTi4B+LiMUdxEhyBdp6i6YCr6jXTuR9c
	 00gHBMuWh3sKA==
Date: Thu, 4 Jun 2026 09:37:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, linux-iio@vger.kernel.org,
 Jinseob Kim <kimjinseob88@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "Reported-by: Sashiko"
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH] iio: buffer: Ensure bounce buffer used for unaligned
 case is zeroed.
Message-ID: <20260604093706.1f02eba4@jic23-huawei>
In-Reply-To: <CALoEA-yQrjLyt3vwMKxMy+dj4f43Cj8PfZFtkGPBBP41oz3Myw@mail.gmail.com>
References: <20260531111605.2411980-1-jic23@kernel.org>
	<2417EDFF-1ADA-42CC-8D52-C93E90EC4953@gmail.com>
	<20260603145551.3f97ed31@jic23-huawei>
	<CALoEA-yQrjLyt3vwMKxMy+dj4f43Cj8PfZFtkGPBBP41oz3Myw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Jun 2026 16:11:15 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 3 Jun 2026 at 16:04, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sun, 31 May 2026 23:58:25 +0530
> > Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> > =20
> > > On 31 May 2026 4:46:05=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=
.org> wrote: =20
> > > >iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap mem=
ory
> > > >to userspace if the data passed in is not a multiple of 8 bytes and =
the
> > > >timestamp is enabled.  Use memset() to zero it after resizing.
> > > >
> > > >Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_=
ts_unaligned()")
> > > >Reported-by: Reported-by: Sashiko <sashiko-bot@kernel.org> =20
> > >
> > > Hi Jonathan,
> > >
> > > Looks like "Reported-by:" is duplicated. =20
> > I'll tweak that whilst applying.
> >
> > I would like a few more eyes on this though just to confirm I didn't me=
ss it up! =20
>=20
> Sashiko had some remarks about the wrong member being memset, however
> it seems relatively standard... human 1, Sashiko 0?
>=20
> Does this memset operate on the wrong pointer?
> When iio_push_to_buffers_with_ts_unaligned() is called for the first time,
> iio_dev_opaque->bounce_buffer is NULL. devm_krealloc() allocates a new bu=
ffer
> and returns it in bb, but this memset uses the old pointer, which would r=
esult
> in a NULL pointer dereference.
> Additionally, if scan_bytes increases on subsequent calls, devm_krealloc()
> might free the old block. This would cause memset to write into freed mem=
ory
> using the new, larger size, resulting in a use-after-free and out-of-boun=
ds
> write.
>=20

doh. It is right - the patch is garbage.  1 to sashiko 0 to idiot developer.

I messed up the line ordering.  Memset should be at least one line later.


--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2466,6 +2466,7 @@ int iio_push_to_buffers_with_ts_unaligned(struct iio_=
dev *indio_dev,
 				   indio_dev->scan_bytes, GFP_KERNEL);
 		if (!bb)
 			return -ENOMEM;
 		iio_dev_opaque->bounce_buffer =3D bb; // the buffering being zeroed is s=
et here.
 		iio_dev_opaque->bounce_buffer_size =3D indio_dev->scan_bytes;
+		memset(iio_dev_opaque->bounce_buffer, 0, indio_dev->scan_bytes);
 	}

Or better as
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2466,6 +2466,7 @@ int iio_push_to_buffers_with_ts_unaligned(struct iio_=
dev *indio_dev,
 				   indio_dev->scan_bytes, GFP_KERNEL);
 		if (!bb)
 			return -ENOMEM;
		memset(bb, 0, indio_dev->scan_bytes);
 		iio_dev_opaque->bounce_buffer =3D bb; // the buffering being zeroed is s=
et here.
 		iio_dev_opaque->bounce_buffer_size =3D indio_dev->scan_bytes;

 	}


Jonathan


