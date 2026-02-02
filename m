Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AA2BF3DB;
	Mon,  2 Feb 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.15.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065970; cv=none; b=TxSJB+esTrtK9S+yhrs8P4BBqQQhU/cN6A26e39f15lC9yWXBvheBpE0SqsVj6vOsJxCFVBr9QmU+eWInuNW/GDrWWtYNHkzewmtpTtzVTkJMUUwQBqo3bGdl5+z8f+GarKq9vwWLmTj2suqSf7X+gQwgf7fl6Q0EmODrkNEtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065970; c=relaxed/simple;
	bh=SapVD1eqYZMi98Q1+V/7hG9i1NCc9eCIGVzLh3mO7XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozd0BnHd/sQlOE0IpuNZQ06qtb11Zh86TmwbELjGyqmkPm648agGFmfdBcxJdF2Bhr6Gt4TwUnoeqhtJL/2xr4SBm1b+pzHsRv6iMwu3h0dD0wFzygt0KzA9hjmgtIOMfRstUuYnxapPO6zFc5SPbhIdfwA1Vuon1YeFN9DzTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li; spf=pass smtp.mailfrom=netcube.li; dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b=YVhj0+ui; arc=none smtp.client-ip=173.249.15.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcube.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b="YVhj0+ui"
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
	bh=RsqQNlKN90P328/QSpABWvbFZ7OBs+DiXTEAjfi9/38=;
	b=YVhj0+uiwa1QRmKKeqz9BCQb3o2PuDM4evXiWFeffeX1auCt7FpJU40WcKNoXJs4Kltc+U1w2XHyIKoy4hYnXOzu4ZRKHOt4WigvpM9vKAFS1j6+QVmHTmbO3QvBZQK3xfCAlkpgCYZtLFPFwyDifadqkh9Au8bxxZM2+CG84FU=
Received: from lukas-hpz440workstation.localnet (192-164-142-11.hdsl.highway.telekom.at [192.164.142.11])
	by mail.netcube.li with ESMTPSA
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
	; Mon, 2 Feb 2026 21:59:21 +0100
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: RESEND [PATCH v1] iio: potentiometer: mcp4131: fix double application of
 wiper shift
Date: Mon, 02 Feb 2026 21:59:20 +0100
Message-ID: <4588657.ElGaqSPkdT@lukas-hpz440workstation>
In-Reply-To: <20260202203443.607eb65a@jic23-huawei>
References:
 <20260202201537.2194476-1-lukas.schmid@netcube.li>
 <20260202202920.1d45fa8a@jic23-huawei> <20260202203443.607eb65a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7236362.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart7236362.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 02 Feb 2026 21:59:20 +0100
Message-ID: <4588657.ElGaqSPkdT@lukas-hpz440workstation>
In-Reply-To: <20260202203443.607eb65a@jic23-huawei>
MIME-Version: 1.0

On Montag, 2. Februar 2026 21:34:43 Mitteleurop=C3=A4ische Normalzeit Jonat=
han=20
Cameron wrote:
> On Mon, 2 Feb 2026 20:29:20 +0000
>=20
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon,  2 Feb 2026 21:15:35 +0100
> >=20
> > Lukas Schmid <lukas.schmid@netcube.li> wrote:
> > > The MCP4131 wiper address is shifted twice when preparing the SPI
> > > command in mcp4131_write_raw().
> > >=20
> > > The address is already shifted when assigned to the local variable
> > > "address", but is then shifted again when written to data->buf[0].
> > > This results in an incorrect command being sent to the device and
> > > breaks wiper writes to the second channel.
> > >=20
> > > Remove the second shift and use the pre-shifted address directly
> > > when composing the SPI transfer.
> > >=20
> > > Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> >=20
> > Hi Lukas,
> >=20
> > Good find.
> > Needs a fixes tag though so that we can know how far to backport it.
> > looks like this one goes all the way, so I'll just reply here and
> > pick this up in a minute once my email reaches lore.
> >=20
> > Fixes: 22d199a53910 ("iio: potentiometer: add driver for Microchip
> > MCP413X/414X/415X/416X/423X/424X/425X/426X")
> I picked it up by hand.  A few things to note for next time.
> If you do add RESEND then inside the [] so that the tooling maintainers
> tend to use to pick stuff up (b4 / git am etc) doesn't included the
> RESEND [PATCH v1] in the title of the commit.
>=20
> Also, if you resend, please include a comment below the --- on why you
> did so.
>=20
> Now applied to my local tree as I'll be rebasing the fixes branch after
> the release next weekend and am not planning to do a pull request before
> then.
>=20
Hi Jonathan,

thank you for your hints. Will make sure to follow them next time.

Best regards,
Lukas

> Thanks,
>=20
> Jonathan
>=20
> > Thanks,
> >=20
> > Jonathan
> >=20
> > > ---
> > >=20
> > >  drivers/iio/potentiometer/mcp4131.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/potentiometer/mcp4131.c
> > > b/drivers/iio/potentiometer/mcp4131.c index ad082827aad5..56c9111ef5e8
> > > 100644
> > > --- a/drivers/iio/potentiometer/mcp4131.c
> > > +++ b/drivers/iio/potentiometer/mcp4131.c
> > > @@ -221,7 +221,7 @@ static int mcp4131_write_raw(struct iio_dev
> > > *indio_dev,
> > >=20
> > >  	mutex_lock(&data->lock);
> > >=20
> > > -	data->buf[0] =3D address << MCP4131_WIPER_SHIFT;
> > > +	data->buf[0] =3D address;
> > >=20
> > >  	data->buf[0] |=3D MCP4131_WRITE | (val >> 8);
> > >  	data->buf[1] =3D val & 0xFF; /* 8 bits here */


--nextPart7236362.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEPv6dcBmn59ssZMkSJnN+drMVRtgFAmmBECgACgkQJnN+drMV
RtinEAf+M9epSUfwiSxkL56OlDenxmvKfm5/6ENidygyiT4NN2pE3bNxWYjq1rZi
V7icSKNt4FVWOPyT6abS0R7RkrPLe1vpyCI4eN+q1gcVt/IXyrrOEtBinnmuvHWN
231X7jp+HxjZLRYWo9JqOv9AZMpcHkxbDP5Qfg+aBh5Z+fugXmYQ7UNapVRyPctv
wuCl2apEPEU7dI4M8+yxSVNtlM8cMuCBNxOpZZ/AaVmq6H/XgEsSTF9+TfXylsLr
1aoNrMrrmCCJtwbE0VEuQ6SW1Y8u4t5/DosLU8vmiCuEF1lCOEz4hFLXu3Yhfv1V
rX+MBlrqvWbE/ZKSBTesTMcG6cCB/g==
=LwNk
-----END PGP SIGNATURE-----

--nextPart7236362.GXAFRqVoOG--




