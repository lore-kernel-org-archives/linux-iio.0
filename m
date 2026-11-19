Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108861;
	b=HKxHJmsi5MjL2PoN7seeVc0wsR/EOj8LilI2xeNVMUASZUi/GODknkIadSSCaL7lPvkQ
	 5mTp7vLntNwrFafYBOxYn4LfMZ5awFDL8lSc240dyQhxJKpUM3O5EK2Q9Gdwg6dCw8lkX
	 vXW1QnnrqtlIeLIMeKfj77x8EoCzXJWlmMWagzCH3QDhSVkp0wzq6tKtGG4fDADi9pip3
	 MmYMJ4UaByU3N4ZvXC2Rt1WSM+fVCLkM1mRVuo9oyoQDHPpkM4NptfkxWvWXW8DgEmFVf
	 FLVcL/dekgjySS4wpbUcAfOpeEvwKBC5o83AvTQhRVyXqH9QnOTPjOl1QEDrqXGbwWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108861;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ar8eBp8diSquDEdCBz+I6QBgz2BOys/9q4xn81j1mAs=;
	b=Vr+hqDinnK5Wh/EH6XE5023jkOLsQkeJv6KqHzpkeV4CoiKe1o5mPujdePVIMx9FP1pe
	 URIwFAjffHYt+mvucL9++1DfkQEFue1cEeotA+F8S9ddeL7nAsdWyjECAOG/xsy8YdGZJ
	 T9Wy/LDCK3DNiqznOUfBXi98SDBx4H93fSTJL+STVBlEhxe2GEg5GgxAGJvzkwM7nTpwS
	 PFNiy6/lri3k7AsmEzcc3BnP99r26Yhx7xMic2WItUIUjuoq1vsQxIomv+jefXTriUGWP
	 8mCeKUq2cmTYsFiVB0o8MLDQExlyrwXeXxfaP1QEiPsjm/itaV2Xp84UBaKJt/yNyDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=NLKtsbqY;
	arc=none smtp.remote-ip=109.224.244.122
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715B606A324
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 17:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5715B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=NLKtsbqY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795108857; x=1795368057;
	bh=ar8eBp8diSquDEdCBz+I6QBgz2BOys/9q4xn81j1mAs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NLKtsbqYOR6LP2AV37dxHGWkMVoxawvG/tGlNXJh6xRzNzPq8UJWOXfUF+BzM+Xoa
	 wILhq+fxgB5uFcrAU92CM7njNjUkIjr17KELH4PY8dvEAdw5X1Lhp9m/hGDXrze6O0
	 4c9by1XZ7Te2TqMhgdIg/5B9Cg8lXPXnYBwqzjN1YrsQNlKbzNtKvKZssXiYu3z1EA
	 QYPdc5AzX/rkm8e2Tqb0wtcnzkmtPm96w3V86t7CFLl+9lLKGPFx244dhXMxLwFphe
	 5KYzKxUmew4ebEaDgHvD0GFo9H5iKwKap+utDbvAwvdUG0tW63yp3a+VG10/TmZ7oV
	 XueNrfiPYtt1g==
Date: Thu, 19 Nov 2026 17:20:53 +0000
To: Conor Dooley <conor@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: light: stk33xx: add power supply support
Message-ID: <rCA4M9_Cq5I454sOmHgrTZ4vHFIBNgY-cfUz4wkZVVWJDhACNFHf6CPFRSJgGMwP-ntUxJ_osLG4heh6byvcqRtGwBuu1sOPnptsFXBWD8o=@protonmail.com>
In-Reply-To: <20261119-giblet-epilogue-45f554c009ce@spud>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com> <20261117-6768-stk3337-v2-1-92f4c7be3bc6@protonmail.com> <20261118-coyness-luminance-6d0c07e843b7@spud> <20261119032903.4a0d3bf6@jic23-hlaptop> <20261119-giblet-epilogue-45f554c009ce@spud>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: ec3344a3eb440fe842362b75fcc4153ea9a7b721
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Thursday, November 19th, 2026 at 6:37 PM, Conor Dooley <conor@kernel.org=
> wrote:

> On Thu, Nov 19, 2026 at 03:29:03AM +0000, Jonathan Cameron wrote:
> > On Wed, 18 Nov 2026 18:12:30 +0000
> > Conor Dooley <conor@kernel.org> wrote:
> >=20
> > > On Tue, Nov 17, 2026 at 08:08:35PM +0200, Roman Vivchar via B4 Relay =
wrote:
> > > > From: Roman Vivchar <rva333@protonmail.com>
> > > >=20
> > > > On some boards, the chip shares a power rail with other components.=
 If
> > > > that rail is turned off, the chip can't function. =20
> > >=20
> > > With these issues in mind, probably it should be made required, even
> > > though new required properties are an ABI break.
> >=20
> > I raised the same on v1.  Seems it is used by various boards
> > in tree where we don't know which supply it is.  So whilst nice
> > to fix we might just be creating some painful build warnings.
>=20
> Yeah I don't really want to cause more warnings, but if it is actually
> the source of issues, warning may get them resolved.
>=20
> Up to Roman really I guess.

Sadly I don't have schematic for these boards in upstream, so I guess
the safest approach is leaving it as optional, since most devices have
power rail shared with almost always-on components (like eMMC or other
sensors).

Best regards,
Roman

>=20
> > Can go ahead and 'guess' I suppose or put a fixed supply on it
> > in the upstream dts.
> >=20
> > Jonathan
> >=20
> > >=20
> > > >=20
> > > > Add vdd-supply property to document the chip power supply.
> > > >=20
> > > > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.ya=
ml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> > > > index f655a570aac7..114cf87eb54d 100644
> > > > --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> > > > @@ -37,6 +37,8 @@ properties:
> > > > =20
> > > >    proximity-near-level: true
> > > > =20
> > > > +  vdd-supply: true
> > > > +
> > > >  required:
> > > >    - compatible
> > > >    - reg
> > > >=20
> > > > --=20
> > > > 2.56.1
> > > >=20
> > > >  =20
> >=20
> 
