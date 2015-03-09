Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35577 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553AbbCIRPd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 9 Mar 2015 13:15:33 -0400
Date: Mon, 9 Mar 2015 18:15:46 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vianney le =?utf-8?Q?Cl=C3=A9ment?= de Saint-Marcq
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH 5/7] iio: mlx90614: Allow tuning EEPROM configuration
Message-ID: <20150309171544.GC2320@katana>
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
 <1424879712-28304-6-git-send-email-vianney.leclement@essensium.com>
 <54FDBDCC.50204@kernel.org>
 <54FDBF2A.6010402@kernel.org>
 <20150309164536.GB2320@katana>
 <54FDD227.6020605@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
In-Reply-To: <54FDD227.6020605@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 05:02:31PM +0000, Jonathan Cameron wrote:
> On 09/03/15 16:45, Wolfram Sang wrote:
> > On Mon, Mar 09, 2015 at 03:41:30PM +0000, Jonathan Cameron wrote:
> >> On 09/03/15 15:35, Jonathan Cameron wrote:
> >>> On 25/02/15 15:55, Vianney le Cl=C3=A9ment de Saint-Marcq wrote:
> >>>> Add device attributes for getting/setting emissivity, IIR, and FIR
> >>>> coefficients, and getting the gain (which should not be modified in
> >>>> order to keep factory calibration).
> >>>>
> >>>> The attributes provide raw values whose meaning is described in the
> >>>> datasheet [1].
> >>>>
> >>>> Writing to EEPROM requires an explicit erase by writing zero.  In
> >>>> addition, it takes 20ms for the erase/write to complete.  During this
> >>>> time no EEPROM register should be accessed.  Therefore, two msleep()s
> >>>> are added to the write function and a mutex protects against concurr=
ent
> >>>> access.
> >>>>
> >>>> Since it is not expected to be updated frequently, the configuration
> >>>> register is read before modifying it rather than caching it.
> >>>>
> >>>> [1] http://melexis.com/Assets/IR-sensor-thermometer-MLX90614-Datashe=
et-5152.aspx
> >>>>
> >>>> Signed-off-by: Vianney le Cl=C3=A9ment de Saint-Marcq <vianney.lecle=
ment@essensium.com>
> >>>> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
> >>> Wolfram, bit of odd i2c usage inline I'd like you to take quick look =
at.
> >=20
> > What do you mean? The direct calls to i2c_smbus_xfer? Was there any
> > reason given to use it directly?
> Apparently the returned PEC is present but wrong.  However it requires
> a correct PEC to be transmitted to it.  Genious

Ouch. Well, in such a case I think it is okay to call i2c_smbus_transfer
directly, especially since it is described well in the comment. lm90
does this, too. But there, it is the writes that are broken. I don't
feel to add quirk flags for all possible permutations of this problem.


--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/dVAAAoJEBQN5MwUoCm2lXUP/jB0gaJJNp9AafyDk2A64xIz
Sr0AHkxIC49eUW859aa9eTUXuWSsk6j6ghK7vxAn0XwQ/9niHBvP4IG+5wyeVwOw
/r7P1XW/fwfdkXiZjdHpU9k28Xwh5RBg53Dx7RlBttHiN+H9ZBCIoYfVLzRMgBCx
pbWlBgA6XAhNsWnRz6vNVjoWSgW0VEwrum7hvPnjpSVQKw0YDyfUrEcmvrbbjfKm
UJOfvGzrDs5/Wrvy9nzQpPYzvdsv/SitjOS9BK5R9JoULVillCFcuI5ot49xWb2U
ImfTMJcDN2hrrEuGsKiQvZbI37QoH6LDoFzWyB7E7moRuY5uDUZYJB8bEvhMEi4S
Nf9Lx5peSUhCfp+ZyxsIlE6lwh93I8M4MI9TlFVhSzkmD19vKnFa1JMs8BEaACyq
mpzY51eTMTFq9w9qaPPtzqfYYgRleZm1udgMTMBwH7as8ldKQEXXrggAMX1pd3Dd
gyC/CJxE4dUaLFd+4zC7zqeu8lcPOiRYW7ep56fW5KNVceFcmtzHivrYWTfAk6mW
0256WxqREyao8GXlsS/81ni0tE2hoLJfqUXD6oD8JOi43c6jAY+1e1Hm53J8WNzU
UmB3HhByJIq3wSMRj0YYEoUvYldia1p0qTjfRsmOGizu8SHgsZq2uaoNIwbmp2Dh
jSw03qupnxAabs4EQpvr
=Y1/r
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
