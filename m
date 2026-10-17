Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B23A7D82;
	Sat, 17 Oct 2026 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277842; cv=none; b=AYhRRUU9dp5cTYWzE2gWpe8aoYqKmpyvZgC5Py6AuJl3zY8mAhFMQBhbaYwXMd+XrHgxWAk/tsE9xE/8TUbsg1eBeccoULB98cgdkezgnAsyJgUNyrNiR5wT4t1NhQFB6/ElsDtKH0AAczTpT0JIv+z2TIyfLX9jhNWxYHO5rz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277842; c=relaxed/simple;
	bh=NWYUwpxQxyHwMXZfTXIN0yrFPGi+UIYMgVo/veMslVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKrbXZ2aWgVtNvJHUnSJI9QmYd5+uR6/Fyt89TmlZQy/qq0NSWQt2JaAlmSwUQUf+1YK2oKnaNml9INd849mfmCAMoFp5hDbVeT7Nfeel64cKjOC13hT8bNHnL5qrIRi6pU1/OxpmD6jeovD683+IHLiIhvrvovXaLAcYlpu1w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj3UnABp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj3UnABp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D5D1F000C6;
	Sat, 17 Oct 2026 22:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792277841;
	bh=j+a9X4nlAP4nXb2FaihxkbPvQN5zi597C+G9CEkENWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oj3UnABpiaCB3odZkQlu5id7PpFA0f0ez/IFySYE9a0OnEAyxPKrQ2PD3xQb7enzY
	 k1Kt+TnT5MFIT8ujGqT6z92d/Emj6fcM6PumHn53lOPjiqktH2wkKiUFx4Z+IN3SeA
	 j+baadjPMeLkEbVpmyrYOnDmCyzqwmXwwkqv7Tc3elw0SpXBwvWLD5q3/F6nibc6Ak
	 Y34hjmwakka+lgl88P5Q8moo7RGgW4ERlakcAlLN5Seb5i4ueI6YDPTV/u/cYnq+8w
	 pmWFjd+skUF5nAzDwwoassXxw3G8CqSK72efOLT6Wn6gcE8xmH0Nt0md3Le/wt7bqi
	 0C4if6nb42htA==
Date: Sat, 17 Oct 2026 23:57:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rodrigo Alencar <rodrigo.alencar@analog.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5686: fix channels member name in
 kernel-doc
Message-ID: <20261017235716.23df682e@jic23-hlaptop>
In-Reply-To: <atCSevvIuyomufQ5@nsa>
References: <20261011045149.353929-1-kapoorarnav43@gmail.com>
	<atCSevvIuyomufQ5@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Oct 2026 09:45:00 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Sun, Oct 11, 2026 at 10:21:47AM +0530, Arnav Kapoor wrote:
> > The kernel-doc for struct ad5686_chip_info describes a member called
> > @channel, but the member is named channels. W=3D1 builds report:
> >=20
> >   Warning: drivers/iio/dac/ad5686.h:95 struct member 'channels' not
> >   described in 'ad5686_chip_info'
> >   Warning: drivers/iio/dac/ad5686.h:95 Excess struct member 'channel'
> >   description in 'ad5686_chip_info'
> >=20
> > Rename the entry to match the struct member.
> >=20
> > Fixes: 0357e488b825 ("iio:dac:ad5686: Refactor the driver")
> > Assisted-by: LLM
> > Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.

>=20
> > Comment-only change, checked with scripts/kernel-doc -Wall.
> >=20
> >  drivers/iio/dac/ad5686.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> > index 482bc70515f7..4f2ac1e96643 100644
> > --- a/drivers/iio/dac/ad5686.h
> > +++ b/drivers/iio/dac/ad5686.h
> > @@ -85,7 +85,7 @@ struct ad5686_bus_ops {
> >   * struct ad5686_chip_info - chip specific information
> >   * @int_vref_mv:	the internal reference voltage
> >   * @num_channels:	number of channels
> > - * @channel:		channel specification
> > + * @channels:		channel specification
> >   * @regmap_type:	register map layout variant
> >   */
> >  struct ad5686_chip_info {
> > --=20
> > 2.53.0
> >  =20

