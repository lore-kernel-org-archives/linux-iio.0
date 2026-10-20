Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530371;
	b=TIuXMtdb2UO3VffxVT1bPL5FUlsb8PHHfPjBfhItPnOMd+zsETZKYkdUsqLGMpNZMo63
	 iOZtxfzkdBNHukDj0nErYqfr8cUmT5ujqxBK5KF0a8EKpobv8s+R0PCSiI0NXT8KUleh3
	 Pm4/+FTWAdZNxya4nGY8BCCbz4ISLKyuYYQaAXgdrZUZQPZ9f855vd7noQo4jeofpLbgV
	 6+BC5D17ntF9LRaKrgi1o5tuZIMspiKz0fjQV0zCAT2ELx7neH48/FzdfrtLneFNqq7WK
	 9Gaqe3oatJGrpd8zgvzTCTWbv2YDHy1bMmIwr095hCLxaoErj04ToqQbaFH0Qt2R1EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530371;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Okbwmm84zWuOe4euiyrXaliuQ5bQTF/Kj7LXwohSA00=;
	b=S2RHHhvP3rBlzu4mAnZykO+3z5rlnMsSFqITRFCWN0ryjf5kfGshLGHc9UVWLeoIm0yP
	 LYl3kQdgUR6UE41KUU385EkNBmJ+DELyGsJQBfAFIprSvbRoN21FaBRBioV8KtOhsr8vX
	 /PQK2PSi8Eo/Z7e3TbjID3qYeBU8L2+kNO7ZojPAshAbhg7IsbqDNVBYz2/8TcSeIQM15
	 2rniLX4ljTI3UqbLW8nmZFTXJAzh9Zzbjpwd37NDCNF5xQW66FSiYDljKB/USC+w4O/0m
	 we/fhBjMHsnWoU70GX8BCV7CvcesBe51IN7GFz2X8EJAUS0Y1i3CGyr7GW7jiihXuYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2k06brA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0864606A319;
	Tue, 20 Oct 2026 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2k06brA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C6C1F000C9;
	Tue, 20 Oct 2026 21:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530370;
	bh=Okbwmm84zWuOe4euiyrXaliuQ5bQTF/Kj7LXwohSA00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=o2k06brAvTVvieiztxnSUOhgnLqYQ9kQ+vUrlU574jBoe2u5jXcGbmjx5PZM7OF3p
	 foKa5aTGywK93Jw6dlFUCjHjiqVlHR5VDsXqipIFbwP1AN8Zjfw37kyvNUOg3ev0N/
	 U2aJEBzjHLWOQQUz+GLOexfioMpzNRyebEtlGyXjRUDg7ScsJypDMvJpnekZir0Cxy
	 2Y0RTOl4snRvogwJo1WkAmvECBUJBVXdOSeNNqBLcsQWvK4uTxAiJgUFoCbPur3BJx
	 UvC2BEeXS1hMh+Ke3rqpCEq1IaphX1XD0SeHCOTDgTFApWQwH9ICxAVfrIPf8ILHfF
	 g6R3n4cDHgaKg==
Date: Tue, 20 Oct 2026 22:06:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, mocker-mug-unwoven@duck.com,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Arka Mondal <arka@arkamondal.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add AMS TCS3472 and TCS3400
Message-ID: <20261020-protector-supper-1e9d019291a0@spud>
References: <20261016-tcs3400-v1-0-3d79d2a7f449@duck.com>
 <20261016-tcs3400-v1-1-3d79d2a7f449@duck.com>
 <af011ab8-b9ab-49d1-b9fe-4e87b3979bbd@kernel.org>
 <20261017013600.077fee36@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L6OcHM2yt5jenoCy"
Content-Disposition: inline
In-Reply-To: <20261017013600.077fee36@jic23-hlaptop>

--L6OcHM2yt5jenoCy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 01:36:00AM +0100, Jonathan Cameron wrote:
> On Fri, 16 Oct 2026 16:43:42 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>=20
> > On 16/10/2026 10:15, HuskerMinion via B4 Relay wrote:
> > > From: HuskerMinion <mocker-mug-unwoven@duck.com>
> > >=20
> > > The tcs3472 driver has no binding yet. It matches DT nodes only throu=
gh
> > > its I2C device ID.
> > >=20
> > > Document the TCS3472 family and the AMS TCS3400 family, which the next
> > > patch adds to the driver. Both are I2C color sensors with one thresho=
ld
> > > interrupt and a VDD supply.
> > >=20
> > > Signed-off-by: HuskerMinion <mocker-mug-unwoven@duck.com> =20
> >=20
> > Please read submitting patches how to properly attribute the work with
> > your real and known identity
> >=20
> >=20
> > > ---
> > >  .../devicetree/bindings/iio/light/ams,tcs3472.yaml | 57 ++++++++++++=
++++++++++
> > >  1 file changed, 57 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/light/ams,tcs3472.=
yaml b/Documentation/devicetree/bindings/iio/light/ams,tcs3472.yaml
> > > new file mode 100644
> > > index 000000000..cd4a0516e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/light/ams,tcs3472.yaml
> > > @@ -0,0 +1,57 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/light/ams,tcs3472.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: AMS TCS3472 and TCS3400 color light-to-digital converters
> > > +
> > > +maintainers:
> > > +  - HuskerMinion <mocker-mug-unwoven@duck.com>
> > > +
> > > +description: |
> > > +  Color light sensors with 16-bit clear, red, green and blue channel=
s, an
> > > +  I2C interface and a threshold interrupt.
> > > +
> > > +  The TCS3472 family covers the TCS34721, TCS34723, TCS34725 and TCS=
34727.
> > > +  The TCS3400 family covers the TCS34001, TCS34003, TCS34005 and TCS=
34007. =20
> >=20
> > We do not take families, but actual devices. TCS3400 seems to be a real
> > device, so I don't get why you call it a family.
> >=20
> >=20
> > > +  The variants differ in I2C address and interface voltage.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - ams,tcs3400
> > > +      - ams,tcs3472 =20
> >=20
> > Your driver cod suggests these are compatible, so it should be expresse=
d.
>=20
> That's only true because this driver hard rejects a whoami mismatch
> which is something we shouldn't really be doing. If we do a look
> up in driver and fail to match we should be using the data associated with
> the ID that the fallback compatible would have had.

Agreed. At most, the driver can emit at info level that the unknown ID is
being treated as xyz device instead.

> Our old fun of what should we do about fallback compatibles and
> devices with ID registers.  Some of which (in this driver) are actually
> compatible with each other and some of which are not (in the sense
> that the match the WHOAMI and do different things depending on that
> matching).
>=20
> I still prefer that we never claim devices that need different
> handling are compatible (even if detectable) because of that prevents
> new drop in parts being used (as they normally have different whoami
> values even as supposedly drop in replacements).

I think I've said this a few times, but I have no recollection if I said
it to you or elsewhere, but IMO how detection works is as follows:

If you can detect capabilities at runtime, then having some sort of
common compatible is fine, because you can figure out how to handle the
device based on what the capability discovery interface reports and this
works fine for new devices. Ideally the common compatible is a fallback in
case some issue with the integration crops up or to constrain things like
input clocks etc. The former is more of a problem for things like i2c
controller IPs and the latter probably isn't super relevant either to
different devices in a family of ADCs that likely all share the same
package. If there's some new bit, you have to change the driver to deal
with that feature, but you'd have to do that for any new feature no
matter the scheme used, so that's not a big deal. The designware SPI
controller works like this, for example. I don't know if there are any
IIO devices supported that have something like this.

On the other hand, detecting the device ID at runtime is no better in any
way than having a specific compatible. You effectively end up with match
data gated on a whoami value, which is basically the same thing as
gating it on a specific compatible except for how this blows up in your
face when someone comes along with drop-in replacements (which maybe are
made by another company) that, as you point out, can have different whoami
values meaning you need to modify the driver for every new device
despite having the ability to detect what device is being used.

Devices being declared compatible that need different handling, because
you can use whoami values to account for the behavioural differences I
would advise avoiding since it's equally easy to use match data to get
the same result and it's immediately obvious when looking at a
potentially 1000s of line driver spread across multiple files that
things are different when you can jump to the of/spi/i2c device id
array and see what the differences between devices actually are.

IOW, I am recommending removing decision making based on whoami values,
removing warnings about whoami mismatches, adding specific compatibles
for all devices to the bindings, using fallbacks to devices with
compatible programming models where applying identical handling to both
devices in the driver is functional and adding match data in place of
whoami-based decision making in drivers. The end result of that being
that your drop in replacement devices, be that from a different vendor
or the same one after a product refresh/manufacturing change etc can
work without any changes being needed to the code.

Personally, I think it's okay for an 8 channel device to fall back to a
4 channel one, if the extra 4 channels won't work since technically the
fallback is an exact subset of the 8 channel device - but I do
understand that people don't want to do that because 4 channels not
working is not really the same thing as a device where using the
fallback means a reduction in performance, e.g. using a fallback on an
ethernet controller that allows networking in U-Boot to function without
driver changes, but at a reduced bandwidth compared to using some new
feature only available in the new device. So I tend to ack stuff where
people say that an 8 channel and a 4 channel device aren't compatible,
even though technically a driver written for the 4 channel device would
work perfectly fine on the first 4 channels of the 8 channel device.

Hope that helps?

Conor.

> I don't mind enough to argue much about it however.
> Note that before this series all the supported parts were actually
> compatible and the only difference was a print on the id match. So
> if this patch hadn't turned up an I'd noticed, I have simply
> deleted the error return.

--L6OcHM2yt5jenoCy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatfXvQAKCRB4tDGHoIJi
0vRTAP9oW0xcpw9j7yCVc+5v3TSoVq3S5pVJ8nEjDMWG9S4sgwD/cr7KMifZ3OZe
zBvLBaJMwqCUWKGNFd11id10QJx6jwc=
=GMQ0
-----END PGP SIGNATURE-----

--L6OcHM2yt5jenoCy--
