Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8395371CEA;
	Wed, 13 May 2026 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707194; cv=none; b=C20v8ou/EEHamyut3VG+UEWLSScUZVWM3vDB4m6mKpu5R7kfVbOLYJ/xty1E8HWAUvdewU7y3yrqZ5/SkMeU/UVYX3/Gm7X5D8atv0gS/F2VdmHAE2ObsYeqgDsvv3Zf+kzvASYq3dQ1NXQvxwZEK8QhYY0LueGDvW0Vrla6AOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707194; c=relaxed/simple;
	bh=0Lebhxow8NENn55awGNqCenjr3a2y8mPr2YpEwm2E9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mB3gQcbHxvjzZAiY3mhcf04tkxYLLXIcDTMTCTB86cKwbqBYii90AN945JeAqZCcuju3NmdmeotYiHIEoTQAZAk0B6RMdbVfUnoj21rukK9q2bc2mtdBJ6YPu1Vpo9vLAIue85B/trxF4Gq37z/RV9Tc3r6NWVUdoXuaUAtuTHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aWn6yRsP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aWn6yRsP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1D591570;
	Wed, 13 May 2026 14:19:45 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E0253F836;
	Wed, 13 May 2026 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778707191; bh=0Lebhxow8NENn55awGNqCenjr3a2y8mPr2YpEwm2E9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aWn6yRsPrgj1szjsbnBgCXW++nb/Lx3T6nyTZrCqYcM08h00TKY6S2j0Bl0R9wpdy
	 jd1LkJ/DiUsek75w2fd1w7BXdhsy5V1rcMebOyYAYRu1ozk/UI7z+gDd5sYQHBQzp8
	 d+LEGdf4s8tbTvOZlMf3eACGJhG31OFXK74rCzUY=
Date: Wed, 13 May 2026 23:19:01 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, Michal Piekos
 <michal.piekos@mmpsystems.pl>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Maksim
 Kiselev <bigunclemax@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: sun20i-gpadc: add A523 gpadc support
Message-ID: <20260513231901.05dc9a82@ryzen.lan>
In-Reply-To: <agTbFbicv9yzTQb9@ashevche-desk.local>
References: <20260513-sunxi-a523-gpadc-v2-0-d5efde151dac@mmpsystems.pl>
	<20260513-sunxi-a523-gpadc-v2-2-d5efde151dac@mmpsystems.pl>
	<A7772824-E704-4BFD-A796-BCD81197E5A2@gmail.com>
	<4248ac7e-3cce-4db8-a2c1-710f2c903490@arm.com>
	<agTbFbicv9yzTQb9@ashevche-desk.local>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2026 23:12:05 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

Hi Andy,

> On Wed, May 13, 2026 at 01:53:49PM +0200, Andre Przywara wrote:
> > On 5/13/26 13:44, Sanjay Chitroda wrote: =20
> > > On 13 May 2026 10:29:43=E2=80=AFam IST, Michal Piekos <michal.piekos@=
mmpsystems.pl> wrote: =20
>=20
> > > > +	if (ret <=3D 0) =20
> > >=20
> > > Thank you Michal for the change.
> > >=20
> > > Have you validated the changes ?
> > > It looks while success ret would be 0 and it would give return error.

No, it doesn't. Returning 0 means no clocks found:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/clk/clk-devres.c#n300

>=20
> Good catch!
>=20
> > But devm_clk_bulk_get_all_enabled() returns the number of clocks found =
and
> > enabled. And since we need at least one, I think this is correct, and t=
he
> > error message below reflects that.
> >=20
> > To me that change looks good:
> >=20
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com> =20
>=20
> =3D=3D 0 ???
> Doesn't look like correct code.

Not sure I follow:
devm_clk_bulk_get_all_enabled() returns the number of clocks in that
node, or a negative error value. If it returns 0, that means no clocks
have been found, which is an error in our case, since we expect at
least one clock. This is what the second part of the error message
refers to.
So we want one or two as the return value, with the current bindings,
but really anything greater than 0 is fine, from the driver's
perspective, since we don't care about the clocks beyond them being
enabled.

So am I missing something?

Cheers,
Andre
