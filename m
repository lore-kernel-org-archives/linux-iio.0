Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168557;
	b=du8WP1EMYPN89XFcsEX9uJjvEJ+NdeEalNHVZ9ZVQT+MjkGfRrtd/NlA8gbxZRghV2qz
	 eexD4I0rrzxcEal8Z1GftEyc1hB1AXLqw9Apf0/EenIEpxMMVWBhRG+b6S88FXk3KustM
	 LaCfjxJTUni89Qj3OGQmeX9zujB9+o7l/wFxuMy+nnyERltRbJw+Sb9xxF+RuH3cn642R
	 wCnRoFUPV4IxYsJR+h6w1le1amwZ8kLPwKWhFFpsSbgjtGn8XYqQpY0VzaEzjCFgtLqyC
	 RIcCLlGm4vdMtJoGcaf2cVDstoDjZywcVdqmeAeb0M5pxz4+YGBw4wRAzIQwMiEm0xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168557;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eV3cNgmtztqusg58e2Vn3gSk9gAUXIA7BFl6TWbQVqE=;
	b=M/RFdzk2cdi1DPsJNajYLnvgz6FUOTqpXoXL13dGuaQOhIi9tuddkpsMa2VqC3mGQ6O0
	 lhtryir97+k94811aNrQ4LKysGS8f8w5fKb/MgOiO6JZpRAx63V5LMvDFjOwq607qRdW5
	 +OyZIvWYdK53jkh0Mt4UMgjAK2m3n6Qifg4i0Cxe340QjAie/ab5LRod9DRzsfJvDV5gJ
	 9XLeFODUlk0QoE3Ky9t7N4pn/AFsvzfb9uI0t50v/6kvLmdDQa7SC8GbpThDNntxWO9kr
	 CFEWrD/P1INpyUnbSSQ4nu0qgcAEED7q7CB5M4vz3jDOd5XGgFv07io8eUcRSigYFwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDNrUzpT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E191606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDNrUzpT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9366C1F008A1;
	Sun,  8 Nov 2026 20:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168557;
	bh=eV3cNgmtztqusg58e2Vn3gSk9gAUXIA7BFl6TWbQVqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jDNrUzpTh9rR2WEmi3C5A8qYwRNVdbEWFJaN+lRo1U4/o3g2SxU3pQNID1mB2Oqt+
	 O9xbddsxZ4ziAtksB4l09mxx4JdTiZ9WtqFUZhYHYTl8Rw4jTCThUMX0/p8c1txM4Q
	 uliwbCFcgvHYa2osCiKIs6XE1T1PiHf1+1+aTJgTmARFN6XTwaqB3mSxTWExpm9iOx
	 jFv7iEoGEhcUwHOsLIRbGa3LYzlxHbjr2wnw3ahdqbxaz8Qp1DdG1SNn7ZS7ej0pjv
	 oUAykk7WqYeP9FkQEMDlyKkvN10qmSUtKyFP9/tEaeN+5TRvyrT3lgD11kDGFFQnK3
	 J8wOIl8W41N2g==
Date: Sun, 8 Nov 2026 20:09:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?Tmljb2zDoXM=?= Antinori <nico.antinori.7@gmail.com>
Cc: <linux-iio@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>
Subject: Re: [PATCH 26/39] iio: humidity: am2315: use
 iio_push_to_buffers_with_ts() with a scan struct on stack
Message-ID: <20261108200910.6ed0ca0e@jic23-hlaptop>
In-Reply-To: <DMFR4YE7AKYX.MEG4N2UE2XID@gmail.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-26-8b136778eedf@oss.qualcomm.com>
	<DMFR4YE7AKYX.MEG4N2UE2XID@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 13:13:13 -0300
Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com> wrote:

> On Mon Oct 26, 2026 at 8:05 PM -03, Jonathan Cameron wrote:
> > Move the scan buffer out of struct am2315_data and make it local to
> > am2315_trigger_handler(), as it has no need to persist between calls.
> > This also removes the need to hold data->lock while filling it in.
> >
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> >
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> =20
>=20
> Hi! I tested this on an AM2320 sensor in a Raspberry Pi 3b+.
>=20
> Kernel version:
> Linux version 7.3.0-rc1-v8+ =20
> Debian clang version 19.1.7 (3+b1), Debian LLD 19.1.7
>=20
> Everything looks good (no warning or errors). This is the first time I
> test a patch, I'll add the Tested-by tag, but please tell me if I am
> doing something wrong.
>=20
> Tested-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
>=20

Thanks!

Applied

J
