Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE86410D00;
	Wed,  4 Feb 2026 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227927; cv=none; b=C91F96yiT38liMMZKivv13f3Nk3IB9KkA/+w5EN76mKfHx2vBC2lUBy1qSC7ywiORpkyTRSR8awTX76QEr/2+vGZVd5xTC2mBSXD2IeEF+zqkuaZR2n0T5E1RVQRU0yDhtgvHW37JK7EANm/KRvM7DwFDj4UpH5ee7sd324JPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227927; c=relaxed/simple;
	bh=+eBsVHFxgk0JuYz+1uZly5/ls/F38mAL9xKyfR62KIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTO4b1pvQxZmi3dJ+SdjqxwDnDIQF8A+nLVwlLbqkEAqNRta9Zc4Bk4TzSkDW8GBmYEkfrkTsBjVNtDOg2nmI+dariKkzEJ5Ks4KfrLLSARuw//Lw0euICembN7Sfap/b8bbMDSYa9nPkrCkotD9OMjURQtN0hTJuo/NQxQ+JI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIOAOQ9P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIOAOQ9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F7CC4CEF7;
	Wed,  4 Feb 2026 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770227926;
	bh=+eBsVHFxgk0JuYz+1uZly5/ls/F38mAL9xKyfR62KIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LIOAOQ9PcmalDGfBGg+ksI1AZj6Ugy0rcallxYXTmTJ3cxnks93WEyN7+2TwB7Tq0
	 CaSKHBtvCj8qjJg2T7ij0sa6wIwgUzSHuU5TjnFca34GxEBEb3T1VyeKaOfEur62UY
	 fQIZ6xqH6iz5bIgiHWSnYbr22NCvfiO5gs+u3tHj+/+/cUblp+bxPHvcPNOUzLAszt
	 vS1tcSxWL0xzF1iG1y7UplzP1D72Xdnx0AKE+Ht4CfpayR73P8A5qi0W0+J3GADD8n
	 wu84ddGCB49m58paD3FYSVlkQZT7U2N8oev6LsDhStsDQdgAyijOq2C/H21kh3Inqb
	 VG8XxUtxLfjWg==
Date: Wed, 4 Feb 2026 17:58:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linusw@kernel.org, stephan@gerhold.net, hns@goldelico.com,
	jic23@kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: gyroscope: bosch,bmg160: add
 bmx055 gyroscope binding
Message-ID: <20260204-hardness-viral-30943ee02607@spud>
References: <20260203143946.301233-1-jerrysteve1101@gmail.com>
 <20260203143946.301233-4-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dTkKT8TezLyM4Mdr"
Content-Disposition: inline
In-Reply-To: <20260203143946.301233-4-jerrysteve1101@gmail.com>


--dTkKT8TezLyM4Mdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 10:39:43PM +0800, Jun Yan wrote:
> Add the device-tree binding for the bosch BMX055 IMU (gyroscope part),
> which is compatible with bmg160.
>=20
> Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_dat=
asheet.pdf
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> ---
>  .../bindings/iio/gyroscope/bosch,bmg160.yaml         | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160=
=2Eyaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> index 3c6fe74af0b8..e19aa1797f14 100644
> --- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> @@ -11,10 +11,14 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - bosch,bmg160
> -      - bosch,bmi055_gyro
> -      - bosch,bmi088_gyro
> +    oneOf:
> +      - enum:
> +          - bosch,bmg160
> +          - bosch,bmi055_gyro
> +          - bosch,bmi088_gyro
> +      - items:
> +          - const: bosch,bmx055_gyro

Same here, please.
pw-bot: changes-requested

> +          - const: bosch,bmg160
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.52.0
>=20
>=20

--dTkKT8TezLyM4Mdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaYOI0wAKCRB4tDGHoIJi
0umpAQCCIQoLO6u81T6bWAjz4J/AxpV+YoOYws/HRHALOXrDVAD9E7+m39U19VBH
H7Fks7x6Vwodl99YPMQ7tgxmpqiBtw4=
=Oy5T
-----END PGP SIGNATURE-----

--dTkKT8TezLyM4Mdr--
