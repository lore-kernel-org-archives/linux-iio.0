Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17867146D53
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781466767; cv=none; b=NRNB/kr4qEKzkDLzy2Optr65Hza3yaCL8HTKfE1HRgPk7zyWDbJNkuID29d6mFXaNEyCHmD1iybQ+qWAOhm6v0z4XpKm3dO2koxjoLx4l2eVJuVXLVsOuw3n0nO+0qti0I083/rPPjMifhXmrv+6RtMiq8uR1tewVGX4rEZUto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781466767; c=relaxed/simple;
	bh=aT9cfMIwPdSoSV+jv2qe6LuaEsXgAqsf4QqVEJvvELU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKPq9Tazdn/Wuq677pyNxNIwjQD3+thBihuJ7GEwfG1SCGelANm8qP3qIrjkpaofkEwkhhIqQE6+scpj2kUwIoIRb/RwRrfDYNzgzoBFXQLfEYgC98LQgdDCO17DYfS+HUsysK7PeE44IG+xyHBHCMZF1I0aXny0R5+fbzEgZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R884Raun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R884Raun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB991F000E9;
	Sun, 14 Jun 2026 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781466765;
	bh=PBmzLAiG1kEhjSHD/FSWD4ud44ND/FFUtHYq5X/yWck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R884RaunxJ4AG6sOdLg22ilzl3qowOHEkqm9nFeBs4Q5HGhgQcdVDtqOr6/43aj0o
	 ldH3P7hAhTyUy1c/OIq1NOVWGME4YQ9qql+WeSP0AJwL1Wgt0s7qc1ViWhx6b7NpiY
	 bmK6sEwImH6Slg0EOHCadwK+LqTh6aXX9nHVDn7yJUY4XUcLpgVSmh3cl3dOmmaamh
	 D4zOhMe23cgWWp6d3qRX6RTqF7k5WwoSoSXMpUD93UIM7WAmQvpxotl/iptXTXu/wq
	 wntwU5XC5NHiQysATj1vtpqGN1/Yd3ZEcX37aOq8RsVxorDopfQl8fOuQLODYd9cZ8
	 NM4bQ2475jzJg==
Date: Sun, 14 Jun 2026 20:52:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-iio@vger.kernel.org, Jinseob Kim <kimjinseob88@gmail.com>, Joshua
 Crofts <joshua.crofts1@gmail.com>, Sanjay Chitroda
 <sanjayembeddedse@gmail.com>, David Lechner	 <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v2] iio: buffer: Ensure bounce buffer used for unaligned
 case is zeroed.
Message-ID: <20260614205236.117b669a@jic23-huawei>
In-Reply-To: <f1d569e66abbe0c065f0f4f889f82f8e9343a2c5.camel@gmail.com>
References: <20260604084307.640053-1-jic23@kernel.org>
	<aiFBEn_DKx5f6ekv@ashevche-desk.local>
	<20260605145000.0ae0356e@jic23-huawei>
	<aiMg71I2O6a94g3o@ashevche-desk.local>
	<f1d569e66abbe0c065f0f4f889f82f8e9343a2c5.camel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 08 Jun 2026 21:00:30 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2026-06-05 at 22:18 +0300, Andy Shevchenko wrote:
> > On Fri, Jun 05, 2026 at 02:50:00PM +0100, Jonathan Cameron wrote: =20
> > > On Thu, 4 Jun 2026 12:10:42 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> > > > On Thu, Jun 04, 2026 at 09:43:07AM +0100, Jonathan Cameron wrote: =
=20
> >=20
> > ...
> >  =20
> > > > > =C2=A0				=C2=A0=C2=A0 indio_dev->scan_bytes, GFP_KERNEL);
> > > > > =C2=A0		if (!bb)
> > > > > =C2=A0			return -ENOMEM;
> > > > > +		memset(bb, 0, indio_dev->scan_bytes);=C2=A0  =20
> > > >=20
> > > > May I suggest different approach, id est use __GFP_ZERO instead of =
hunting
> > > > correct pointers? =20
> > >=20
> > > That's a weird beast when combined with a krealloc so I was a bit
> > > nervous about readability (and less so whether it was correct).
> > > It should be fine in that we will either get stale data or zeros
> > > because we always use this path to allocate the buffer so if you
> > > think it is obviously fine then I don't mind.
> > >=20
> > > The oddities are that if an object grows within a slab but doesn't ne=
ed
> > > a new one we are relying on those bits happening to be zero based on =
the
> > > original allocation doing __GFP_ZERO as well (as it's the same call)
> > >=20
> > > I'm nervous though as that region off the end is sometimes used for
> > > debug objects and I really don't understand that bit of slab well eno=
ugh.
> > > If it actually does this, then seems like we'd end up with a lot of
> > > nasty corner cases so I assume it doesn't. =20
> >=20
> > Such a bug will be a serious issue in mm. I don't think it exists.
> > But, of course, chances are not completely 0.
> >=20
> > Current users (not a comprehensive list)
> >=20
> > arch/arm64/kvm/nested.c:92
> > drivers/firmware/efi/capsule-loader.c:61
> > drivers/gpio/gpiolib.c:5198
> > drivers/media/platform/amphion/vdec.c:329
> > drivers/net/ethernet/intel/ice/ice_lib.c:3044
> > drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c:785
> > drivers/net/wireless/ti/wl18xx/main.c:1582
> > drivers/nvme/target/pci-epf.c:708
> > drivers/spi/spi.c:1411
> > drivers/usb/gadget/function/uvc_configfs.c:880
> > fs/ceph/mdsmap.c:322
> > fs/smb/server/ksmbd_work.c:123
> > lib/tests/slub_kunit.c:273
> > sound/soc/meson/meson-card-utils.c:49
> >=20
> > Also note the kernel-doc for krealloc_array(). It has some note WRT __G=
FP_ZERO
> > and it means the flag must be supported. Also there is a note in mm/slu=
b.c.
> >  =20
> > > However, I couldn't convince myself enough not to just force a memset=
 of the
> > > whole thing. =20
> >=20
> > I personally would go with __GFP_ZERO. =20
>=20
> If I'm not missing anything, this should also be proof that the flag shou=
ld be fine:
>=20
> https://elixir.bootlin.com/linux/v7.1-rc7/source/lib/tests/slub_kunit.c#L=
275
>=20
Perfect!  Thanks. I'll hopefully spin an updated version in next few days

Jonathan

> - Nuno S=C3=A1

