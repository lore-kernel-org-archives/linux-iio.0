Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6D313E34;
	Fri, 29 May 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045095; cv=none; b=KCgxEtyuGMjk///UxZgLGrvEcCR5S+9hX4lPeoQ4WckNiAhOy6maqe7u5gvpeGaCz7PZoiF/YM77TlvV/yApvUeBeKzQOW1+tcAb35+qp5yPnmxbps1Rd6zdocC+Os4fY6rJdDkVVk50wXrQDGjtUr9DQVGxmbsdRIJNtfrFwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045095; c=relaxed/simple;
	bh=Wwl3G0NEyTWLJi93ml2Bt9YSDjdIBckfKL471VEDJ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIcJZRTj+xqHs7qHx+VyDzffBONDl5hu2VPx1ZDcPqK/YyE6oLsktrntFgK0b0otjrhPVTtqMgyrY9/EDDlOCvjoqzJNYEFHWOJg+osdIO8+9kprQBGpeivnApC+W9UDf73u0A88QTdxeKUmhuPRQPHnFm8zil+Y58B6foIfu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCUitCgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCUitCgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1E91F00893;
	Fri, 29 May 2026 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780045093;
	bh=XSBdpdXbBN3yntcXMXlx3wdNM37Do2MgtVr2gHTVAWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PCUitCgyrhRhMLNSPrJoGCQmbICgB1SDVBRenWIQkj5TQk/TpydqwvP4I3jtzsDbo
	 KWmLIOZyGdIwxFpxikD0TtAWiAzJAgBV+XD4QX6jsk/TxmWDd543AVFSHEOwYmDXnO
	 GBO1VpvU2TCWmpwfYIVXZQ3YeTNaax9Hw4nXVq6OerHvKIHcqAAAdc+OeXRNugj+Jh
	 4QjAAcXTUVrHHAErOoTsp5hAyjO4YKMQOBvZc8+7TX9cNvuZ+6sWhmocV6KtIjzv+p
	 Rvv80xfAq+fKtcyTQ2vpgczXsYhiQShdgzS3uJaYcm8BAeCvtuT2v7R1Hvi9L8x0eQ
	 o3VjJqgRvCUjw==
Date: Fri, 29 May 2026 09:58:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] iio: adc: ad_sigma_delta: fix CS assertion and
 registerless device handling
Message-ID: <20260529095803.072aa5b3@jic23-huawei>
In-Reply-To: <20260527121841.529b9b8c@jic23-huawei>
References: <20260527-ad_sigma_delta-fix-v5-0-446fd2bc7330@analog.com>
	<20260527121648.6cf31312@jic23-huawei>
	<20260527121841.529b9b8c@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 May 2026 12:18:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 27 May 2026 12:16:48 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Wed, 27 May 2026 12:38:37 +0300
> > Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrot=
e:
> >  =20
> > > This series fixes two independent bugs in the ad_sigma_delta framewor=
k.
> > >=20
> > > Patch 1 fixes CS being left permanently asserted after single convers=
ion
> > > and in the error path of ad_sd_buffer_postenable(). In
> > > ad_sigma_delta_single_conversion(), set_mode(AD_SD_MODE_IDLE) and
> > > disable_one() were executing while keep_cs_asserted was still true,
> > > causing any SPI transfer they issued to carry cs_change=3D1. The
> > > postenable() error path also failed to call set_mode(AD_SD_MODE_IDLE),
> > > leaving the device in continuous conversion mode with bus_locked
> > > incorrectly set, opening a window for concurrent SPI access.
> > >=20
> > > Patch 2 fixes ad_sigma_delta_clear_pending_event() for devices with  =
                                  =20
> > > has_registers =3D false and no rdy_gpiod (currently AD7191, AD7780, a=
nd
> > > MAX11205). These devices fall through to the status register read pat=
h,                                =20
> > > but since has_registers is false, ad_sd_read_reg() transmits no addre=
ss                              =20
> > > byte and blindly clocks raw MISO bytes =E2=80=94 indistinguishable fr=
om reading
> > > conversion data, partially consuming any pending result and corruptin=
g the
> > > stream. With num_resetclks =3D 0 on these devices a further hazard ex=
ists:
> > > if pending_event is set, the drain path attempts memset of SIZE_MAX b=
ytes,
> > > corrupting the heap. The fix returns 0 immediately for registerless
> > > devices. This is safe for all current instances: AD7191 and AD7780 (w=
ith
> > > powerdown GPIO) are reset between conversions by CS deassertion; AD77=
80
> > > (without powerdown GPIO) and MAX11205 are continuously-converting and
> > > cycle ~DRDY regardless, so the next falling edge fires naturally. A f=
uture
> > > registerless device that holds ~DRDY asserted until data is read would
> > > need num_resetclks set or a rdy-gpio instead. The same heap corruptio=
n can
> > > be triggered on any device with rdy_gpiod set but num_resetclks =3D 0=
, so
> > > an explicit data_read_len =3D=3D 0 guard is added independently.
> > >=20
> > > Signed-off-by: Radu Sabau <radu.sabau@analog.com>   =20
> > Hi Radu,
> >=20
> > Applied to the fixes-togreg branch of iio.git and marked for stable.
> >=20
> > Note that as this is all a bit fiddly in the ideal world I'd like some
> > more eyes on this and will be happy to add tags or indeed pull the patch
> > in response to any reviews in the next few days.
> >=20
> > Sashiko is now 'happy' I think and it found a lot more issues than I id=
entified
> > in earlier versions.
> >  =20
> Actually scratch that - these both need Fixes tags.  Please reply to each=
 email
> with whatever seems most likely.  I know it can be hard to find the point=
 where
> a complex bug got introduced but we should still be providing some guidan=
ce
> on how far to backport.
>=20
Thanks for the tags, applied to the fixes-togreg branch of iio.git and mark=
ed
for stable.

Jonathan

> Thanks,
>=20
> Jonathan
>=20
> > Thanks,
> >=20
> > Jonathan =20
>=20
>=20

