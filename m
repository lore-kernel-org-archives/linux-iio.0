Return-Path: <SRS0=w6xg=6J=gmail.com=thierry.reding@kernel.org>
Date: Thu, 6 Jul 2017 07:49:15 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: lee.jones@linaro.org, benjamin.gaignard@linaro.org, jic23@kernel.org,
	robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
	mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: pwm: update STM32 timers clock names
Message-ID: <20170706054915.GB16144@ulmo.fritz.box>
References: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
 <1497453196-31470-4-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
In-Reply-To: <1497453196-31470-4-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 05:13:16PM +0200, Fabrice Gasnier wrote:
> Clock name has been updated during driver/DT binding review:
> https://lkml.org/lkml/2016/12/13/718
> Update DT binding doc to reflect this.
>=20
> Fixes: cd9a99c2f8e8 (dt-bindings: pwm: Add STM32 bindings)
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-stm32.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlldz1sACgkQ3SOs138+
s6GlERAAqizstPfL2AWZTMPWwHrg6Ag4ArgczreDTV5rqKF9t6CxQ51oFtdt7EzD
xAKnK+b6cbPmD5xkBJniTKqi8eSCPhs3S2XpzO9T9tSMCL1Mue0DhqOvlExm1+OZ
Zet9jTiPDDWOAW7PlSl7lkYTU/YbSx4Ngs3ttoaXdcZPz3gm+tJ+KmOb6i+ZgYjE
/YqdNUPidRA/zrw/0IxFRRd/1M91Mzy0hfXniK4Wx+doJ5yZeDA/GOijkzL5TIag
/0XqGQDUiVfr6pBa4imVjhET1kLBleJwgWC3Zn+QgeiYdWGLOh4ZCNBH0Ps01p+Y
orBfdmArUlSKVoYNutK/wcUiRVdB7sBPrOPtvVxJZoOwbpATTNOUYLQ6Ht+QuUB4
BvHmBLRYpMHFIGQRcLL+TUUjzuOqgSSXGZxFanUKhyKfcujHMMHvIjzsKGjK96k3
0AeTcdVwhmB4zOontfqcDuR/qB/m8YTnPOFVms5xvuNvozfXoavBMzIZI6Zw4Tjt
ErO0m5WrdhwpKsRrEwjwbBvIYa2YqNzwKEoeoiyYbazIs+DCeRip7ocQATjr/cR4
YXlHHfnnMBNeDo0jxrzVQV483LEqCtHKpTDQ9/pd4SQuAkXFxd8eH5NOZLj8mRJY
tJsTfwnfn4bURg9xIobkNd5hDt7TdPp/9OtN8FlSiK9guaB9mhY=
=7zbU
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
