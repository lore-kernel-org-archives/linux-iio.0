Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8075B206;
	Sun, 11 Oct 2026 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715548; cv=none; b=a/VCN+aIV8Ebacp1VtfMHEir9dJesUkohjs5gGmcKPRURTE5aRozsP5yU8FaSo3sDYyixDhrq7/YZU9H2l7BplsJJTH3XFQ82E7KubzlVhCQWoqPzKBPd5oWR1heWrgHwgpYWLNsFj3ug0sKUz+klTUbkhzND5W5O2K44h+ZWwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715548; c=relaxed/simple;
	bh=AW8NKODHQ9uGVl/dxofOMFVTPthHtP98ig1EuK+werI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkfKelqXE6d2OCWUGvxVelrUzJ97I2ePkLnKb61WX8f4SWCxe2mX30qzl3p7qXZonyuiIrDfaEBFwSfa7eB/31Q7Gh5bAq+DYmxEeU2gNRY1TWEaztgFawEvCJSLwKoLkLhybf//AsmXRhbl/lbj6i2VGlvAZaIiv/yP3H9fNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKBGqpPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKBGqpPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7A91F0089B;
	Sun, 11 Oct 2026 10:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715547;
	bh=xt8nKne1ouvTY7wBBsRCk4/6TlDv+T5mG1nv8NKoAbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aKBGqpPxUv4wLzhW4mSFZgNctnjPu4lr6kFphDJMyGtloeSmDWULEr2nHpo6uN8RV
	 Hj9YJe/8IaYdHpa0l271dBawGXgIUgIrSGFGNUah9bEb4FXWsRGcsEisSOc9Yl/Aw2
	 +P1EjH9GfnKbip/1pHiSu9FV3HQfDCPkyWpblm54AFky5DOQ4OKb0rdRouwb5NTwGJ
	 2khIQUBkOx7fDdKx+j9EOkAjjrK3Fxf0/1w9xEdjZfyPZDJKnv2FmkmyjfwvJqH3wa
	 h1cQcLhDkCO7ytkENm1RD6rz/IMOsdTzYrcbW3rkQu/Soq9FHuv5AXi37Bh85lh3fa
	 86XDkk48//qrQ==
Date: Sun, 11 Oct 2026 11:45:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan	
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Radu Sabau	 <radu.sabau@analog.com>, Salih Erim
 <salih.erim@amd.com>, Jishnu Prakash	 <jishnu.prakash@oss.qualcomm.com>,
 Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
 linux@analog.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/6] iio: adc: ade9000: add ADE9430 support
Message-ID: <20261011114512.6a8403d4@jic23-hlaptop>
In-Reply-To: <20260921001246.72cf14ab@jic23-hlaptop>
References: <20260918073537.1572-1-antoniu.miclaus@analog.com>
	<9fc012985151b1b79b5d6e3f16738397ac9f837f.camel@gmail.com>
	<20260921001246.72cf14ab@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Sep 2026 00:12:46 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 18 Sep 2026 16:27:30 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Fri, 2026-09-18 at 10:35 +0300, Antoniu Miclaus wrote: =20
> > > The ADE9430 is a polyphase energy metering device from the same famil=
y as
> > > the ADE9000. It is register-compatible with the ADE9000 but omits the
> > > on-chip dip/swell detection and has no on-chip digital integrator; it
> > > relies on an external analog integrator for Rogowski coil current sen=
sors.
> > >=20
> > > This series adds ADE9430 support to the existing ade9000 driver, reus=
ing
> > > the dip/swell-less channel table introduced for the ADE9078 and addin=
g a
> > > matching chip_info for the ADE9430 full-scale codes. A precursor patch
> > > gates the DICOEFF register write behind a has_digital_integrator chip=
_info
> > > flag so it is skipped on parts without an on-chip digital integrator.
> > >=20
> > > Patches 1 and 2 are standalone fixes carried with this series. Patch 1
> > > corrects the ADE9000 full-scale RMS/PCF codes to the same family-A va=
lues
> > > the ADE9430 uses. Patch 2 fixes the DIPC event never being handled or
> > > cleared, found by the sashiko review of v1. Both carry Fixes: tags an=
d can
> > > be applied independently of the rest of the series.
> > >=20
> > > Changes in v2:
> > > - new patch: fix the DIPC event never being handled or cleared, found=
 by
> > > =C2=A0 the sashiko review of v1 (patch 2).
> > > - new precursor patch: gate the DICOEFF write behind a has_digital_in=
tegrator
> > > =C2=A0 chip_info flag, split out of the ADE9430 support patch.
> > > - reuse ade9078_channels for the ADE9430 instead of adding a duplicate
> > > =C2=A0 channel table.
> > > - reword the documentation intro to "The supported parts are..." so i=
t does
> > > =C2=A0 not need updating for each new part.
> > >=20
> > > v1:
> > > https://lore.kernel.org/linux-iio/20260907101623.8730-1-antoniu.micla=
us@analog.com/
> > >=20
> > > Antoniu Miclaus (6):
> > > =C2=A0 iio: adc: ade9000: fix ADE9000 full-scale RMS and PCF codes
> > > =C2=A0 iio: adc: ade9000: fix DIPC event never being handled or clear=
ed
> > > =C2=A0 dt-bindings: iio: adc: adi,ade9000: add adi,ade9430 compatible
> > > =C2=A0 iio: adc: ade9000: gate the DICOEFF write behind a chip_info f=
lag
> > > =C2=A0 iio: adc: ade9000: add support for ADE9430
> > > =C2=A0 docs: iio: ade9000: document ADE9430 support
> > >=20
> > > =C2=A0.../bindings/iio/adc/adi,ade9000.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++-----
> > > =C2=A0Documentation/iio/ade9000.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 36 ++++++=
+++--------
> > > =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > =C2=A0drivers/iio/adc/ade9000.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 39 ++++++++++++++++---
> > > =C2=A04 files changed, 67 insertions(+), 31 deletions(-)
> > >=20
> > >=20
> > > base-commit: edb91bc566576f6664a3efbad6bd4205aa1d5259   =20
> >=20
> > LGTM
> >=20
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> LGTM2.  Just need to give some time for dt-binding reviewers to
> take a look.

Applied to the testing branch of iio.git.  That'll get rebased on=20
rc1 once available.

Jonathan

>=20
> Thanks,
>=20
> J
>=20

