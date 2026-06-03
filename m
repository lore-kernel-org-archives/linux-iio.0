Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019B376BEC
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494962; cv=none; b=bhZGXzkn7Wr+FgZJpPmxx55JLfVxFy3E7h8kRj3o5dIuaurZPMBJjQFDLxqtr4CI7fgRkAgr3vcF4wvvqUQ+lotTO5m/cgdb6LXo/7L2tf0QToUdVgdnEgt+clhDaHa7CbOQHzL/IiG2wMLX0IoqmqGss6dRBr5G39mkY8DSVdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494962; c=relaxed/simple;
	bh=kaUFJyBwAKUN1D3kq2+b6V8jIbpr9zjLBjl0j7uT0O0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7IX7LRV+qJJFeWcGBA/KV9sOSHbluESM73SuWEHh5wLI79pszDOhDxU4ERYYp8gYJ0RaIk+LZXfAzy2rJ8344dQ3AcakO16P7A7ASax/F+JgBJIYSzGKw4HZMYpePAw+Fr4VGFWPbyrQfbskSVqrkq2ykcXXsYS38MDH2BhS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyu8Y0wO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyu8Y0wO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96781F00893;
	Wed,  3 Jun 2026 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780494959;
	bh=F7iAVn9cyDRusEwSAE18qdQOJLLWmbVI+kgw3kgFQSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jyu8Y0wOy1l9Bu06MQqhLofvtp1Fv7lEL2EwiTSKvK8uR16+6NI2Y46Q1KHwbycvd
	 2dNRZ08Jz/n/JvsJy3msi3KVxmNWDqQvb45lTAd4yxK+blgrw2bKvqCKyJ+lcmHokh
	 uF9RtBbw1Ly3DI7F+MuVf2cpaUdUWtHhq0t5+gqGCyG9GkIt20d65DiRfJa/UatzDS
	 VJibeDQu/uqVvm40KKVcyVSCIIxLgkih7YSHTBgLQ3fDKtCiRWBC/QZ0zZ2Q89b+es
	 it3yAzeix1EUSE6VzkKwHfNuMuGoi8rHsiDE2wwsQXMuayuSO5zqeJJkzXVDowwB0T
	 nlFLYuiRRtlUw==
Date: Wed, 3 Jun 2026 14:55:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: linux-iio@vger.kernel.org, Jinseob Kim <kimjinseob88@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, "Reported-by:
 Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH] iio: buffer: Ensure bounce buffer used for unaligned
 case is zeroed.
Message-ID: <20260603145551.3f97ed31@jic23-huawei>
In-Reply-To: <2417EDFF-1ADA-42CC-8D52-C93E90EC4953@gmail.com>
References: <20260531111605.2411980-1-jic23@kernel.org>
	<2417EDFF-1ADA-42CC-8D52-C93E90EC4953@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 May 2026 23:58:25 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> On 31 May 2026 4:46:05=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel.org=
> wrote:
> >iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
> >to userspace if the data passed in is not a multiple of 8 bytes and the
> >timestamp is enabled.  Use memset() to zero it after resizing.
> >
> >Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_u=
naligned()")
> >Reported-by: Reported-by: Sashiko <sashiko-bot@kernel.org> =20
>=20
> Hi Jonathan,
>=20
> Looks like "Reported-by:" is duplicated.
I'll tweak that whilst applying.

I would like a few more eyes on this though just to confirm I didn't mess i=
t up!

Thanks,

Jonathan
>=20
> Thanks, Sanjay
>=20
> >Closes: https://sashiko.dev/#/patchset/20260529121005.1470-1-kimjinseob8=
8%40gmail.com
> >Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> >---
> >Cc: Jinseob Kim <kimjinseob88@gmail.com>
> >
> >This is untested as I don't have any devices that use this and long
> >ago dropped whatever hacks I used to test it originally.
> >
> >Jinseob, could you please test this with your OSF driver - at least
> >make sure it doesn't stop the data coming out!
> >---
> > drivers/iio/industrialio-buffer.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industriali=
o-buffer.c
> >index 9d66510a1d49..d930e70e12ff 100644
> >--- a/drivers/iio/industrialio-buffer.c
> >+++ b/drivers/iio/industrialio-buffer.c
> >@@ -2466,6 +2466,7 @@ int iio_push_to_buffers_with_ts_unaligned(struct i=
io_dev *indio_dev,
> > 				   indio_dev->scan_bytes, GFP_KERNEL);
> > 		if (!bb)
> > 			return -ENOMEM;
> >+		memset(iio_dev_opaque->bounce_buffer, 0, indio_dev->scan_bytes);
> > 		iio_dev_opaque->bounce_buffer =3D bb;
> > 		iio_dev_opaque->bounce_buffer_size =3D indio_dev->scan_bytes;
> > 	} =20

