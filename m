Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3E389DF3;
	Thu, 28 May 2026 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958484; cv=none; b=YxS3u2+RsUqL1UPXFi5fpTDWec4ClWe5cEt1Te9vlV+lf2jHYd90vgW3oZT+/hxEy7P0CKsZZL0LwPdguKQNA4EYYvNLtzEAfFN/Jh8DykEYzQF1Eyfoe9Df3EiwZBuxzw6URy40xvn/c10aTO/R/6oi9InRzNylyyaTPicEiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958484; c=relaxed/simple;
	bh=7NhhHlxcgGPFkswkQHfH/VDa7O5O+2Udb2PPcfVQcdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXLWk8kh9HW+s7PER9LFV8RVprsWsG8T+ba8qHxZPpTMGgEvplmG1Ztnpr4GcCQpBX4RfxxaCQA8nHWY+RmwYRIyixLOPQXM4vtTV/moYKhNkKBGqUeHVDVV1/rkdwZCfbSnd2ohazktf9yFezxXH0mUMgs1GJF7rg/6Hg/uY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSKzkviZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSKzkviZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5B91F000E9;
	Thu, 28 May 2026 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779958483;
	bh=nU0qTwjxQM9h/pGaq5dN8pYK4LeX55jgU2KLGiVDKFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZSKzkviZYusLrorDG8fPlDdcEu6IxYn3CJOV0MRx5JAGAJ2JMHY2gfWC6ujJyp/nW
	 Ojh11O5hqKDREpcU6zWdw/ovFkmPAZYZr8dKfLo9ZVOygYVMc66XdfAzutor9zjEJ3
	 mijrcGGSthFl1SK/1LyKcthxgyUo5nC5sYOc66U+7kMRjyt8FEPjEA8XBQ8qr8digL
	 DX/m2nQ9iiKNi7b7MagjDw7HBKdmb+QoRa8C9SShoQz0MUuYNHv/9tlKQOsU32lESL
	 7FWJf+xgAeNkxWp2R+OnF5KnFTmYL/I48aEEry6C8plkATDiExySDH8jLo9PKD3+Rq
	 RvOJaHLHdZAhQ==
Date: Thu, 28 May 2026 09:54:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: sashiko-reviews@lists.linux.dev,
	Piyush Patle <piyushpatle228@gmail.com>, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v10 04/11] dt-bindings: iio: adc: hx711: add HX710B
 support
Message-ID: <20260528-payphone-alto-870198753d50@spud>
References: <20260525105127.180156-5-piyushpatle228@gmail.com>
 <20260525111144.CA7E71F000E9@smtp.kernel.org>
 <20260525-clanking-possum-4ba58b466854@spud>
 <20260527184128.2f5f02e5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T73lKfD3zkh7hWLa"
Content-Disposition: inline
In-Reply-To: <20260527184128.2f5f02e5@jic23-huawei>


--T73lKfD3zkh7hWLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 06:41:28PM +0100, Jonathan Cameron wrote:
> On Mon, 25 May 2026 18:01:41 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > Jonathan,
> >=20
> > Here's an example of the sort of stuff it complains about on every
> > iteration.
> >=20
> Thanks. +cc linux-iio@vger.kernel.org
>=20
> > On Mon, May 25, 2026 at 11:11:44AM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> > > - [Medium] The `dvdd-supply` property is utilized by the HX710B and m=
entioned in the commit message, but it is not enforced as a required proper=
ty for the new compatible or included in the example.
> Yup. This stuff needs fixing.
>=20
> > > - [Low] The `if` condition for the `avia,hx710b` compatible incorrect=
ly uses `const` instead of `contains: const`, causing schema validation to =
always fail for HX710B nodes.
>=20
> This one I'm not sure on. Is it right?  I tested by hacking
> the example to have a supply it shouldn't and the schema validation failed
> as expected making me think this is a false positive.
> I have zero natural feel for yaml so no idea :)

It's not the common pattern, but it does work.
IIRC the difference between it and "contains: const: ..." is that it doesn't
apply the condition when the compatible is used as a fallback.


--T73lKfD3zkh7hWLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahgCzwAKCRB4tDGHoIJi
0tbhAP9kd2SajVE5q9fe/IMI4CHtFuKZUpbaRNHCisap1WxMqQD8CXwBh7kVe9sK
5ephTrvQGg7TuHJQrD0EwKazaJ1yfQU=
=ByIP
-----END PGP SIGNATURE-----

--T73lKfD3zkh7hWLa--
