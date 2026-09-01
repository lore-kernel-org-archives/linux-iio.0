Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE83806D6;
	Tue,  1 Sep 2026 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225063; cv=none; b=pjcQl5MbewP4Tw+jCtUEHvO/Q0RWn+u6obIUkeeWt5HFe6a2xK8LlRJfitIVkc3R2e8qdeOo3u7AOCSSV43GBMEEbWLZNeW8GCVrxLrSmL13ECnCokavIhS1wGqRzb3+RikUgzoFN31y2far+s6Z3GoGnvKJDxNYpn95C3ANi0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225063; c=relaxed/simple;
	bh=0ziwbXVvDByMOxnROMdlOL2td3Po88GNdFEjUfLDp6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyXR1NvZnlBxmS2qno1WyU3sP9TT07Tz7S9NRLUi2hJ5IM9RosCvc28OxcTbyV6wlf1Tqv99WdBduShA5YHNEbbGC4UMaEWIAo6A89WoudRMZ67/hgHMwtbHbaCm6fyvbBNSZvtDpqqPdjmZZKNSRd/orHnaKWT0JrQ5n31/P/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKGnZ6/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKGnZ6/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09751F00A3D;
	Tue,  1 Sep 2026 01:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225059;
	bh=Mox303Pdpou1cUvaJnui7WP6S+jeLI/A2ZYo0woZKgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DKGnZ6/SI4kCSEs4CMAy6vatVhx6DWp5i3DIoI+SKaSqn9JJ6PqUYroySB33TOUkQ
	 7eleCtEW1LcRzK2L3PwnZw+gddbb/yOt/fsjiDtVbSUcLxAc1xULZZOEOv1j2bf76G
	 AhMl+6tB0CpPcnvLnjTR2KdUL9MKddXRA2YZZM+akbrqvfJBHXd0TBIQn5QBmf9Gyd
	 r6k+wL4W/vFzvGXNMBF/tSkfZ+NdItdDGNN+yXwRcU2h1i5PhmTpqgSn9qR/7l69ja
	 ERZefz1kpRf+/qzVaE5XoiDvIFuFnFuImr9leJH9/AQVHbj0ZXWITKA0QZ3VexpdzW
	 iXiYuQeK4hKig==
Date: Tue, 1 Sep 2026 02:10:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org,
 andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org,
 dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com,
 brucer42@gmail.com
Subject: Re: [RFC PATCH v5 1/3] i2c: rust: implement SMBus access via
 IoBackend and FallibleIoCapable
Message-ID: <20260901021054.057aab97@jic23-huawei>
In-Reply-To: <CAO26r3QwUZ1QeO3PYNPoYQrbKpzfhttYAi0kNNB+QumAN=vZkQ@mail.gmail.com>
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
	<20260822062725.60519-2-muchamadcoirulanwar@gmail.com>
	<20260824004103.54eb2f7b@jic23-huawei>
	<CAO26r3QwUZ1QeO3PYNPoYQrbKpzfhttYAi0kNNB+QumAN=vZkQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=20
> > > +impl I2cClient<device::Bound> {
> > > +    /// Returns an I/O handle for SMBus register access on this I2C =
client.
> > > +    ///
> > > +    /// The returned handle provides fallible read/write methods for=
 the
> > > +    /// 256-byte SMBus command address space (0x00=E2=80=930xFF). Th=
is is the SMBus
> > > +    /// command byte range, NOT the 7-bit device address, which is h=
andled
> > > +    /// by the I2C core at the adapter level. =20
> >
> > That rather feels like you are correcting my confusion in the earlier v=
ersion!
> > I'd assume people are more awake than me and skip the NOT part ;) =20
>=20
> Sorry for the tone. I didn't mean to correct you. I'll drop that line.

No problem. It wasn't the tone (which was fine!) - just the excess detail.

So dropping it works for me!

Jonathan

