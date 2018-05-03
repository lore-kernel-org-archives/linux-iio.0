Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40572 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeECKtQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 May 2018 06:49:16 -0400
Received: from mail-pg0-f72.google.com ([74.125.83.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <shrirang.bagul@canonical.com>)
        id 1fEBnX-0007qv-76
        for linux-iio@vger.kernel.org; Thu, 03 May 2018 10:49:15 +0000
Received: by mail-pg0-f72.google.com with SMTP id w9-v6so1171109pgq.21
        for <linux-iio@vger.kernel.org>; Thu, 03 May 2018 03:49:15 -0700 (PDT)
Message-ID: <1525344548.4358.36.camel@canonical.com>
Subject: Re: [PATCH][for iio-for-4.17b] iio: humidity: hts221: Fix sensor
 reads after resume
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org
Date: Thu, 03 May 2018 18:49:08 +0800
In-Reply-To: <CAA2SeNJYAd_XbSU-MohZxP-7h2Jpwb_f6ho+9Z2Yc3pPg6jnVw@mail.gmail.com>
References: <20180430051658.9856-1-shrirang.bagul@canonical.com>
         <CAA2SeNKTjVO7JBVV3qJMJhdM-j=r+igd_nADe+NH3Rux0oW1qA@mail.gmail.com>
         <1525078153.10678.9.camel@canonical.com>
         <CAA2SeNKn6mavKBa8=pU5sPLWpLKY=A5GGnwRZcn65Mhzd-8jqQ@mail.gmail.com>
         <1525079565.10678.10.camel@canonical.com>
         <1525333190.4358.20.camel@canonical.com>
         <CAA2SeNJYAd_XbSU-MohZxP-7h2Jpwb_f6ho+9Z2Yc3pPg6jnVw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-n3sFrIdrJFRSe6UCgrWJ"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--=-n3sFrIdrJFRSe6UCgrWJ
Content-Type: multipart/mixed; boundary="=-DT0lsDCi9T294da76LCX"


--=-DT0lsDCi9T294da76LCX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-05-03 at 11:30 +0200, Lorenzo Bianconi wrote:
> On Thu, May 3, 2018 at 9:39 AM, Shrirang Bagul
> <shrirang.bagul@canonical.com> wrote:
> > On Mon, 2018-04-30 at 17:12 +0800, Shrirang Bagul wrote:
> > > On Mon, 2018-04-30 at 11:05 +0200, Lorenzo Bianconi wrote:
> > > > > On Mon, 2018-04-30 at 09:48 +0200, Lorenzo Bianconi wrote:
> > > > > > > CTRL1 register (ODR & BDU settings) gets reset after system c=
omes back
> > > > > > > from suspend, causing subsequent reads from the sensor to fai=
l.
> > > > > > >=20
> > > > > > > This patch restores the CTRL1 register after resume.
> > > > > > >=20
> > > > > >=20
> > > > > > Hi Shrirang,
> > > > > >=20
> > > > > > is just CTRL1 reset after suspend/resume or also other register=
s? are
> > > > > > IIO triggers enabled before the suspend or
> > > > > > are you reading data from sysfs?
> > > > > >=20
> > > > > > > Based on:
> > > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git i=
io-for-4.17b
> > > > > > >=20
> > > > > > > Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR=
 reconfiguration)
> > > > > > > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> > > > > > > ---
> > > > > > >  drivers/iio/humidity/hts221_core.c | 13 +++++++------
> > > > > > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio=
/humidity/hts221_core.c
> > > > > > > index 166946d4978d..5d7a652aa6d9 100644
> > > > > > > --- a/drivers/iio/humidity/hts221_core.c
> > > > > > > +++ b/drivers/iio/humidity/hts221_core.c
> > > > > > > @@ -658,12 +658,13 @@ static int __maybe_unused hts221_resume=
(struct device *dev)
> > > > > > >         struct hts221_hw *hw =3D iio_priv(iio_dev);
> > > > > > >         int err =3D 0;
> > > > > > >=20
> > > > > > > -       if (hw->enabled)
> > > > > > > -               err =3D regmap_update_bits(hw->regmap, HTS221=
_REG_CNTRL1_ADDR,
> > > > > > > -                                        HTS221_ENABLE_MASK,
> > > > > > > -                                        FIELD_PREP(HTS221_EN=
ABLE_MASK,
> > > > > > > -                                                   true));
> > > > > > > -       return err;
> > > > > > > +       err =3D regmap_update_bits(hw->regmap, HTS221_REG_CNT=
RL1_ADDR,
> > > > > > > +                                HTS221_BDU_MASK,
> > > > > > > +                                FIELD_PREP(HTS221_BDU_MASK, =
1));
> > > > > > > +       if (err < 0)
> > > > > > > +               return err;
> > > > > > > +
> > > > > > > +       return hts221_update_odr(hw, hw->odr);
> > > > > > >  }
> > > > > > >=20
> > > > >=20
> > > > > No need to re-enable the sensor here. hts221_read_oneshot() [call=
ed from hts221_read_raw()] does that every time before read:
> > > > >=20
> > > >=20
> > > > Could please try to change other registers (e.g. rh or temp gain) a=
nd
> > > > double check values are properly configured resuming the sensor?
> >=20
> > Further testing revealed that the contents of AV_CONF register value ge=
ts
> > overwritten (set to 0x3F) every time system comes out of suspend.
>=20
> Do you mean register HTS221_REG_AVG_ADDR (0x10)? 0x3f means oversampling_=
ratio
Yes, HTS221_REG_AVG_ADDR (0x10) register which controls the sensor resoluti=
on modes.
> is set to max allowed value. It is a little bit weird since I tested
> the sensor with an oscilloscope
> before and after the suspend/resume operations and it seemed to work prop=
erly.
> Could you please double-check the sensor is properly powered-up during
> the suspend phase
> (VDD line)?
Unfortunately, I don't have the equipment required to test the hardware.
Your observation is correct, the minimum change required is restoring CTRL1=
 register after
suspend/resume to get the sensor reads working.

The discrepancy with HTS221_REG_AVG_ADDR (0x10)  is that the HW register va=
lues (read
over i2c) are no longer in sync with the corresponding config. when compare=
d with related fields
of hts221_hw struct (see attached console log with output from i2cdump).

Regards,
Shrirang.
>=20
> Regards,
> Lorenzo
>=20
> > > > It is necessary to re-enable the sensor if you use IIO triggers and
> > > > the sensor was enabled before the suspend operation
> >=20
> > Yes, I understand this is required, will handle this and restoring the =
AV_CONF
> > register in the next version.
> >=20
> > I've tried using sysfs_trig_iio to test reading the sensor output from =
devfs
> > (using iio_generic_buffer) but looks like this is not supported in the =
current
> > driver. HW interrupts cannot be used on my system.
> > Please suggest if there are other alternatives?
> > >=20
> > > Sure. I'll do some more testing and share the results.
> > > >=20
> > > > > static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int=
 *val)
> > > > > {
> > > > >         __le16 data;
> > > > >         int err;
> > > > >=20
> > > > >         err =3D hts221_set_enable(hw, true);
> > > > >         if (err < 0)
> > > > >                 return err;
> > > > >=20
> > > > >         msleep(50);
> > > > >=20
> > > > >         err =3D regmap_bulk_read(hw->regmap, addr, &data, sizeof(=
data));
> > > > >         if (err < 0)
> > > > >                 return err;
> > > > >=20
> > > > >         hts221_set_enable(hw, false);
> > > > >=20
> > > > > Regards,
> > > > > Shrirang
> > > > > >=20
> > > > > > Here you need to re-enable the sensor if it was running before =
the
> > > > > > suspend operation.
> > > > > > Regards,
> > > > > >=20
> > > > > > Lorenzo
> > > > > >=20
> > > > > > >  const struct dev_pm_ops hts221_pm_ops =3D {
> > > > > > > --
> > > > > > > 2.14.1
> > > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > >=20
> > > >=20
>=20
>=20
>=20
--=-DT0lsDCi9T294da76LCX
Content-Disposition: attachment; filename="hts221_s3_fail.log"
Content-Type: text/x-log; name="hts221_s3_fail.log"; charset="UTF-8"
Content-Transfer-Encoding: base64

cm9vdEBjYXJhY2FsbGE6L3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmljZTAjIGNhdCBpbl8q
X3JhdwotMjAzMgoxMDIzCnJvb3RAY2FyYWNhbGxhOi9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpk
ZXZpY2UwIyBjYXQgaW5fKl9yYXcKLTIwMjQKMTAyMgpyb290QGNhcmFjYWxsYTovc3lzL2J1cy9p
aW8vZGV2aWNlcy9paW86ZGV2aWNlMCMgL2hvbWUvYWRtaW4vaTJjLXRvb2xzLTQuMC90b29scy9p
MmNkdW1wIC1mIC15IDAgMHg1ZiBiCiAgICAgMCAgMSAgMiAgMyAgNCAgNSAgNiAgNyAgOCAgOSAg
YSAgYiAgYyAgZCAgZSAgZiAgICAwMTIzNDU2Nzg5YWJjZGVmCjAwOiAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCBiYyAgICAuLi4uLi4uLi4uLi4uLi4/CjEwOiAx
YiAwMCA2NSAzMiA5OSBiZSAzMiBhMiA5ZSBiMiBmYiAwMCBlOCAwMSAwMCA4MiAgICA/LmUyPz8y
Pz8/Py4/Py4/CjIwOiAwNSAwMCAwMCAwMCAwMCAwMCAwMCAwMiBkYiBmNyBmZSAwMyBjNyBmYiAx
NiAwNCAgICA/Li4uLi4uPz8/Pz8/Pz8/CjMwOiAzNyA4NSBhOCAxYiAwMCBjNCBlOCBmZiA4NiAw
MyA4MCBjZSBmZiBmZiAxOSAwMyAgICA3Pz8/Lj8/Lj8/Pz8uLj8/CjQwOiAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgICAuLi4uLi4uLi4uLi4uLi4uCjUw
OiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgICAuLi4u
Li4uLi4uLi4uLi4uCjYwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAgICAuLi4uLi4uLi4uLi4uLi4uCjcwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgICAuLi4uLi4uLi4uLi4uLi4uCjgwOiAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCBiYyAgICAuLi4uLi4uLi4uLi4uLi4/
CjkwOiAxYiAwMCA2NSAzMiA5OSBiZSAzMiBhMiA5ZSBiMiBmYiAwMCBlOCAwMSAwMCA4MiAgICA/
LmUyPz8yPz8/Py4/Py4/CmEwOiAwNSAwMCAwMCAwMCAwMCAwMCAwMCAwMCBkYiBmNyBmZSAwMyBj
NyBmYiAxNiAwNCAgICA/Li4uLi4uLj8/Pz8/Pz8/CmIwOiAzNyA4NSBhOCAxYiAwMCBjNCBlOCBm
ZiA4NiAwMyA4MCBjZSBmZiBmZiAxOSAwMyAgICA3Pz8/Lj8/Lj8/Pz8uLj8/CmMwOiAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgICAuLi4uLi4uLi4uLi4u
Li4uCmQwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAg
ICAuLi4uLi4uLi4uLi4uLi4uCmUwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAgICAuLi4uLi4uLi4uLi4uLi4uCmYwOiAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgICAuLi4uLi4uLi4uLi4uLi4uCnJvb3RAY2Fy
YWNhbGxhOi9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2UwIyBydGN3YWtlIC1hIC12IC1z
IDQwIC1tIG1lbQpydGN3YWtlOiBhc3N1bWluZyBSVEMgdXNlcyBVVEMgLi4uClVzaW5nIFVUQyB0
aW1lLgogICAgICAgIGRlbHRhICAgPSAwCiAgICAgICAgdHpvbmUgICA9IDAKICAgICAgICB0em5h
bWUgID0gVVRDCiAgICAgICAgc3lzdGltZSA9IDE1MjUzNDM3ODIsIChVVEMpIFRodSBNYXkgIDMg
MTA6MzY6MjIgMjAxOAogICAgICAgIHJ0Y3RpbWUgPSAxNTI1MzQzNzgyLCAoVVRDKSBUaHUgTWF5
ICAzIDEwOjM2OjIyIDIwMTgKYWxhcm0gMCwgc3lzX3RpbWUgMTUyNTM0Mzc4MiwgcnRjX3RpbWUg
MTUyNTM0Mzc4Miwgc2Vjb25kcyA0MApydGN3YWtlOiB3YWtldXAgZnJvbSAibWVtIiB1c2luZyAv
ZGV2L3J0YzAgYXQgVGh1IE1heSAgMyAxMDozNzowMyAyMDE4CnN1c3BlbmQgbW9kZTogbWVtOyBz
dXNwZW5kaW5nIHN5c3RlbQpyb290QGNhcmFjYWxsYTovc3lzL2J1cy9paW8vZGV2aWNlcy9paW86
ZGV2aWNlMCMgL2hvbWUvYWRtaW4vaTJjLXRvb2xzLTQuMC90b29scy9pMmNkdW1wIC1mIC15IDAg
MHg1ZiBiCiAgICAgMCAgMSAgMiAgMyAgNCAgNSAgNiAgNyAgOCAgOSAgYSAgYiAgYyAgZCAgZSAg
ZiAgICAwMTIzNDU2Nzg5YWJjZGVmCjAwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCBiYyAgICAuLi4uLi4uLi4uLi4uLi4/CjEwOiAzZiAwMCA2NSAzMiA5OSBi
ZSAzMiBhMiA5ZSBiMiBmYiAwMCBlOCAwMSA4MCA4MiAgICA/LmUyPz8yPz8/Py4/Pz8/CjIwOiAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMyA3ZSBmNiA3OCAwMyBmNCBmOSA5MCAwMyAgICAuLi4uLi4u
P34/eD8/Pz8/CjMwOiAzNyA4NSBhOCAxYiAwMCBjNCBlOCBmZiA4NiAwMyA4MCBjZSBmZiBmZiAx
OSAwMyAgICA3Pz8/Lj8/Lj8/Pz8uLj8/CjQwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAgICAuLi4uLi4uLi4uLi4uLi4uCjUwOiAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgICAuLi4uLi4uLi4uLi4uLi4uCjYw
OiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgICAuLi4u
Li4uLi4uLi4uLi4uCjcwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAgICAuLi4uLi4uLi4uLi4uLi4uCjgwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCBiYyAgICAuLi4uLi4uLi4uLi4uLi4/CjkwOiAzZiAwMCA2NSAz
MiA5OSBiZSAzMiBhMiA5ZSBiMiBmYiAwMCBlOCAwMSA4MCA4MiAgICA/LmUyPz8yPz8/Py4/Pz8/
CmEwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCA3ZSBmNiA3OCAwMyBmNCBmOSA5MCAwMyAgICAu
Li4uLi4uLn4/eD8/Pz8/CmIwOiAzNyA4NSBhOCAxYiAwMCBjNCBlOCBmZiA4NiAwMyA4MCBjZSBm
ZiBmZiAxOSAwMyAgICA3Pz8/Lj8/Lj8/Pz8uLj8/CmMwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgICAuLi4uLi4uLi4uLi4uLi4uCmQwOiAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgICAuLi4uLi4uLi4uLi4u
Li4uCmUwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAg
ICAuLi4uLi4uLi4uLi4uLi4uCmYwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAgICAuLi4uLi4uLi4uLi4uLi4uCnJvb3RAY2FyYWNhbGxhOi9zeXMvYnVz
L2lpby9kZXZpY2VzL2lpbzpkZXZpY2UwIyBjYXQgaW5fKl9yYXcKLTI0MzQKODg4CnJvb3RAY2Fy
YWNhbGxhOi9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2UwIyBjYXQgaW5fKl9yYXcKLTI0
MzQKODg4CnJvb3RAY2FyYWNhbGxhOi9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2UwIyBj
YXQgaW5faHVtaWRpdHlyZWxhdGl2ZV9vdmVyc2FtcGxpbmdfcmF0aW8KMzIKcm9vdEBjYXJhY2Fs
bGE6L3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmljZTAjIGNhdCBpbl90ZW1wX292ZXJzYW1w
bGluZ19yYXRpbwoxNgo=


--=-DT0lsDCi9T294da76LCX--

--=-n3sFrIdrJFRSe6UCgrWJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJa6ukkAAoJELlj3b/+u+hkdGAP/18bYQJmImwd2Gp/L+PJEsSp
x73PNy/551MWIP8fkhFUV2Wkf62dTM/r8HjiY1u08wSfX0Rx9r/r4MToz82KdRtp
ShpK8cu82fGcRgunbDPOYzbDN7I0uUC7LeRiCUiRJLcTI5JPDiKW/P38tCGFRRNT
Xd+YMCh+E93CdaGJCCyCYQ/3aApbB35xOU8OZ0rRecyzdL8PC75v8GrT+W697z8y
zRigCcU/vurKiMOhxEY93uRjIWByK8KXDmxllWDLC+fEOstVoriqxYZrXU8+Ztix
OcJY8DbNTNpR7EGAKSTai7lt/SMUt4AnNzSrsfQFKAm5ATtJ6cvrcKSENhhAM+a2
hLex+zC5bKmgKdX7RStKyYUtyyMsnh0tMMqDOr8SurlKNmjWXF8bsRO52Qo/CIqu
j5ZzsAu1NEWq6xBLkJKXwMLgXMnO4oSnvn/SZOWIr7g7nb/cbK8vmarkNMIgF2Bi
3zKY/OVjwDZDaHaPAxw1tfjz9zUWha60ibWZbp9DAxe7+rYJg7/lUJ9z3faiqp8b
h8V9jXQFEmziTkE26X9ZuI1oGZAjKpccy7+PFPzN7TCaH3n//i29mPJ9rPodw3gV
fT6I9R+WlbVF4Tj2eCzYriOLdJQR4cLEDt6Knb6rd42JcxkOYCB+xsb9jb+ULdBY
unvI/j7cDzf73fW8/tlL
=dlae
-----END PGP SIGNATURE-----

--=-n3sFrIdrJFRSe6UCgrWJ--

