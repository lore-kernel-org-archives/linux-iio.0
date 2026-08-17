Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE61EFF93;
	Mon, 17 Aug 2026 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786932317; cv=none; b=et08XyScW+/rZ7qbzs7/fXjXqfdaVwwDhpYbaLJZd8RaO1MscCfK/AHPfZWu37MweLnFxZ3eDuExnTemtL4zG91CqItpdoavDMW0UXFV7p8LBC7VkBL1SvB5yrVf6WdnzKaKRyuqKJL8+OD4F77TEI/f5TddZX8aEkow2Ba2XkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786932317; c=relaxed/simple;
	bh=7+AamDYPtJR/i9OTXfbGM8oEtsgABDSKPAIflbvpVCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6wU+BHXoqnuuIUcBhHK1kaSi3UfwkRkal+12ka0xHOT/I2Ptb63jpB0T/qQWP6oz23XuyWC9Led6Nw9S/PntrSdO+ydDcuC+CPxzBuBoPhyRzGIhkhSA0+VPt9InhPiLgfoZM0JNVU7elJSy+X4sSf6NN5QhzHbY1iS8BSYfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUbAO8Jj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUbAO8Jj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2DF1F000E9;
	Mon, 17 Aug 2026 02:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786932316;
	bh=6evGcDRt1cnLd4wQNFhfcjpjWiDiPvC7XiNjnBNuQiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JUbAO8Jj4xTOrPImFJSG8Z7EL8mqyJEzRKxvp5sMx8Rh6Z7s9R3ekwxERIbq9GfXp
	 MIEdzinb9mtPWl2Z76qAXnt2ycB8i+vuHQpp8EnwpK1Tg3yKdE7Q6+rFcVpqYK8pgk
	 TBcXz/yQT8mKsWgOweGSFzbvZNYNBDeUqcQEtv8BQCn51am9RAbyQvvEgBT6OBwtH4
	 w7sSfV1CCakiLv9pKrmwuLlA7LHs9eT69bQ+CNwwnbZF3hske0sMVZuq4VfAKsojlv
	 jL0vlicn4lKDReHGJBBsGtCy5tUj+P2J0zDVEI0MxDzZilthLY3dSrivJVgufp+IKx
	 mgOcfFj2a0BKw==
Date: Mon, 17 Aug 2026 03:05:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Weiss
 <luca.weiss@fairphone.com>
Subject: Re: [PATCH 2/3] iio: light: stk3310: add per-chip match data
Message-ID: <20260817030512.67ffeb50@jic23-huawei>
In-Reply-To: <anr5BeHK-dboSBl3@ashevche-desk.local>
References: <20260810110423.41697-1-jorijnvdgraaf@catcrafts.net>
	<20260810110423.41697-3-jorijnvdgraaf@catcrafts.net>
	<anoZwgq6ZO_VY064@ashevche-desk.local>
	<20260810215157.154384-1-jorijnvdgraaf@catcrafts.net>
	<anr5BeHK-dboSBl3@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Aug 2026 13:27:17 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 10, 2026 at 11:51:57PM +0200, Jorijn van der Graaf wrote:
> > On Mon, Aug 10, 2026 at 09:34:42PM +0300, Andy Shevchenko wrote: =20
> > > > +	chip_info =3D i2c_get_match_data(client);
> > > > +	if (!chip_info) {
> > > > +		/*
> > > > +		 * Clients instantiated through the sysfs new_device
> > > > +		 * interface under the lowercase compatible-derived name
> > > > +		 * have no firmware node and do not match the uppercase
> > > > +		 * id table entries.
> > > > +		 */
> > > > +		chip_info =3D &stk3310_chip_info; =20
> > >
> > > This is an interesting comment and approach.
> > > =20
> > > > +	} =20
> > >
> > > - Where does this lowercase come from? Is it Linux forced conversion?=
 =20
> >=20
> > No conversion - the client name is whatever is echoed into the sysfs
> > new_device file, and the lowercase spelling is the one that binds via
> > the OF table: for a client with no firmware node,
> > i2c_of_match_device() falls through to i2c_of_match_device_sysfs(),
> > which matches the client name against each compatible and its part
> > after the vendor prefix, so "stk3310" binds through
> > "sensortek,stk3310" - the same lowercase name a DT client gets from
> > of_alias_from_compatible(). The id table lookup stays case-sensitive,
> > which is why i2c_get_match_data() comes back NULL for such a client:
> > device_get_match_data() needs the firmware node it does not have, and
> > i2c_match_id() only knows the historic uppercase names.
> >  =20
> > > - What's wrong with simply failing the probe? =20
> >=20
> > It would break a path that works before this patch: probe consumed no
> > match data, so "echo stk3310 0x48 > new_device" bound and probed fine
> > (we used exactly that during bring-up, before the DT node existed).
> > Failing it would be a userspace-visible regression in a patch that
> > claims no functional change.
> >  =20
> > > As far as I understand the problem is preexisted. Or was there any de=
fault
> > > taken? How do we know that the chosen default is a good one? =20
> >=20
> > The path preexists; only this patch makes probe care about match
> > data. Before it the driver had no per-chip data at all - every client
> > got the same two channels and the hardcoded "stk3310" name however it
> > matched. The fallback selects stk3310_chip_info, which is exactly
> > that, so a client that probed before this patch behaves identically
> > after it. What the default cannot give is the new part's extra
> > channels: an STK36C61 instantiated under the lowercase name gets the
> > reduced legacy profile, and the id table spelling "STK36C61" selects
> > the full one. =20
>=20
> The problem preexists. I just looked into the Git history of this rather =
broken
> table IDs and what I have to say and state is the following:
>=20
> - the driver initially was written for ACPI and the author blindly (cargo=
 cult?)
>   used the same IDs as for ACPI _HID, while they have different rules
>=20
> - there is no existing in kernel driver that supports enumeration based
> on I2C ID table
>=20
> With that being said, I think we may just lower the case for the I=C2=B2C=
 ID
> table and fail enumeration when there is no chip_info provided.
> Yes, it will break very weird use case with capital letters via sysfs,
> but TBH it's a niche and people should know that most of the devices
> are enumerated as part number of OF compatible in that case.
>=20
> Also note that the DT users should also not use sysfs, and instead call
> DT overlay.
>=20
> I can take all the blame on very unlikely event of a breakage of somebody=
's
> setup in the future. TL;DR: just add a first patch to lower case the IDs
> with Suggested-by my name and I will give a Rb tag with full conscience a=
nd
> responsibility.
>=20

Hmm. I agree with fixing the capitals. However we have more options than
usual because we have a single part with which all supported are backwards
compatible.

For most / maybe all of the other drivers where similar has come up,
 there is no right answer to what data to use (so we break this path).
They have two or more parts supported but they are mutually incompatible.
Here we could at least have provided the subset for now. I would
be careful though as a future part addition might mean we had to drop
that default as it wasn't backwards compatible with it.

Hence it would be a bit of a gamble on whether failing probe on lower
case inputs is enough of a problem to paper over now, given we may
have to break it in the future anyway.

Jonathan

