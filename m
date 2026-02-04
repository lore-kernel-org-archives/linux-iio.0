Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA140B6C7;
	Wed,  4 Feb 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227899; cv=none; b=t0/c8KhILmcEiJckqB4HFxu/r23gMLootovlWyXI6v+IyHTtOPfX5BLK+P5qeDrFEI5kZZjEiR9JFlrydo1m1RYfIWINpHErDtYZvDHrSSXteEKm3Y32ci/1OtqZx6DS0+BHilie/8Kp35bzzfyZnQfcCGdrktDKze2dhvLvAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227899; c=relaxed/simple;
	bh=NFK/VXazE9I4PyMp38G1mtlxHKrfrCBfnDC0ociRQqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3KFRUIrPXYLZIm/G8jGfcp/IdRH9j/snHi3Zb763CgD4efipLtXr49B4wvrnMZGbuj4YrWR9hHxn+Ojb81hGTBl2Z+lI2jSQGEOMEkjUQcGYsZL7rqs5vWvSuy7RAN0RLKK40NVQ/886g609dG3/e1puYaDiE+QJ0nRLGc8YPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4TXSCGV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4TXSCGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9815FC4CEF7;
	Wed,  4 Feb 2026 17:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770227899;
	bh=NFK/VXazE9I4PyMp38G1mtlxHKrfrCBfnDC0ociRQqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4TXSCGVRfHWL+R2hAQ/lkS2QHTDHBg7KoU4FvmE5mTkQIXByh86l7YrfMUhGqZSl
	 Jp5YWYVPDVX/mZy056g4LTuo1afwkFURA5bdzyxMU6JrLyAV7UZ/GOvfPVtMx6W5O2
	 Rde/xv69sSuPeEJ+pag6mcXegkwMxW6PsD4BvQ0GLgRswHaHDYUTnKL9vIy1S0zybE
	 rn72wkoy/C9ysInCFmy3H12dQPZXVH4FHu/qZRs6PnxckZCUMm9UEH2dsC5n26Nt93
	 AzYo7zSRYGFRhnuiDMBN8fT5s0pVbEcgglzl80EA5Xztoeu88YQjn8beGTeaMoKHM3
	 QaYIbwLffoadQ==
Date: Wed, 4 Feb 2026 17:58:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linusw@kernel.org, stephan@gerhold.net, hns@goldelico.com,
	jic23@kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: magnetometer:
 bosch,bmc150_magn: add bmx055 magnetometer binding
Message-ID: <20260204-venus-dweller-20e2c228acc4@spud>
References: <20260203143946.301233-1-jerrysteve1101@gmail.com>
 <20260203143946.301233-3-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eyyo8kwg8r8augNX"
Content-Disposition: inline
In-Reply-To: <20260203143946.301233-3-jerrysteve1101@gmail.com>


--eyyo8kwg8r8augNX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 10:39:42PM +0800, Jun Yan wrote:
> Add the device-tree binding for the bosch BMX055 IMU (magnetometer
> part), which is compatible with bmc150_magn.
>=20
> Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_dat=
asheet.pdf
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> ---
>  .../iio/magnetometer/bosch,bmc150_magn.yaml        | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc=
150_magn.yaml b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bm=
c150_magn.yaml
> index a3838ab0c524..09d1dc861d4f 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_mag=
n.yaml
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_mag=
n.yaml
> @@ -21,11 +21,15 @@ properties:
>      description:
>        Note the bmm150_magn is a deprecated compatible as this part conta=
ins only
>        a magnetometer.
> -    enum:
> -      - bosch,bmc150_magn
> -      - bosch,bmc156_magn
> -      - bosch,bmm150
> -      - bosch,bmm150_magn
> +    oneOf:
> +      - enum:
> +          - bosch,bmc150_magn
> +          - bosch,bmc156_magn
> +          - bosch,bmm150
> +          - bosch,bmm150_magn
> +      - items:

> +          - const: bosch,bmx055_magn

s/_/-/ here please, we don't permit _s in new compatibles.
pw-bot: changes-requested

> +          - const: bosch,bmc150_magn
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.52.0
>=20
>=20

--eyyo8kwg8r8augNX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaYOItwAKCRB4tDGHoIJi
0ihtAQCsBa9mHk67v2k923KIK9/Xm5pC+74WKIJoSHxrT9xYqwEAnR3RkDiecxzn
Wl1ylkttE8P2iDtgMn1M53Gwa89pYA0=
=/zbP
-----END PGP SIGNATURE-----

--eyyo8kwg8r8augNX--
