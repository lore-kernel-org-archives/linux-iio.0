Return-Path: <SRS0=0YuF=H3=canonical.com=shrirang.bagul@kernel.org>
Message-ID: <1525748110.3891.8.camel@canonical.com>
Subject: Re: [PATCH] iio: humidity: hts221: Fix sensor reads after resume
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	mario.tesi@st.com
Date: Tue, 08 May 2018 10:55:10 +0800
In-Reply-To: <CAA2SeNJRridUUjb01SjCfpg31ZbWiMLzD+ZeRqRDEmK-uEcZug@mail.gmail.com>
References: <20180430042546.8801-1-shrirang.bagul@canonical.com>
	 <20180506171942.0a4802d7@archlinux> <1525659688.4030.5.camel@canonical.com>
	 <CAA2SeNJRridUUjb01SjCfpg31ZbWiMLzD+ZeRqRDEmK-uEcZug@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-vp0Cm8K2cezEtlnR32IL"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


--=-vp0Cm8K2cezEtlnR32IL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-05-07 at 23:34 +0200, Lorenzo Bianconi wrote:
> > On Sun, 2018-05-06 at 17:19 +0100, Jonathan Cameron wrote:
> > > On Mon, 30 Apr 2018 12:25:46 +0800
> > > Shrirang Bagul <shrirang.bagul@canonical.com> wrote:
> > >=20
> > > > CTRL1 register (ODR & BDU settings) gets reset after system comes b=
ack
> > > > from suspend, causing subsequent reads from the sensor to fail.
> > > >=20
> > > > This patch restores the CTRL1 register after resume.
> > > >=20
> > > > Based on:
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-fix=
es-for-4.14b
> > > >=20
> > > > Since 4.17.rc1, this driver uses REGMAP; I'll send a separate patch=
 to
> > > > address this issue.
> > > >=20
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR recon=
figuration)
> > >=20
> > > Looks like part of the problem was introduced in that patch, part wel=
l predated
> > > it (BDU).
> > >=20
> > > > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> > >=20
> > > As you way, this needs to be a bit different to take into account
> > > the change to regmap.  We'll need to have that upstream before we loo=
k
> > > at a back port.  One element inline surprises me and needs further
> > > explanation.
> >=20
> > I have sent a patch based on iio-for-4.17b [1], Lorenzo and I are still
> > discussing our findings. It's not just the CTRL1 reg, but also the AV_C=
ONF(0x10) reg.
> > which loses it's contents coming out of suspend.
> >=20
> > [1] https://marc.info/?l=3Dlinux-iio&m=3D152534455701742&w=3D2
> > >=20
> > >=20
> > > > ---
> > > >  drivers/iio/humidity/hts221_core.c | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humid=
ity/hts221_core.c
> > > > index 32524a8dc66f..fed2da64fa3b 100644
> > > > --- a/drivers/iio/humidity/hts221_core.c
> > > > +++ b/drivers/iio/humidity/hts221_core.c
> > > > @@ -674,11 +674,15 @@ static int __maybe_unused hts221_resume(struc=
t device *dev)
> > > >     struct hts221_hw *hw =3D iio_priv(iio_dev);
> > > >     int err =3D 0;
> > > >=20
> > > > -   if (hw->enabled)
> > > > -           err =3D hts221_write_with_mask(hw, HTS221_REG_CNTRL1_AD=
DR,
> > > > -                                        HTS221_ENABLE_MASK, true);
> > >=20
> > > Why drop the enable setting?  Seems that we want to do this 'as well'=
,
> > > if the device was previous enabled.
> >=20
> > Yes, will cover this in v2.
> > >=20
> > > > +   err =3D hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> > > > +                                HTS221_BDU_MASK, 1);
> > > > +   if (err < 0)
> > > > +           goto fail_err;
> > > >=20
> > > > -   return err;
> > > > +   err =3D hts221_update_odr(hw, hw->odr);
> > > > +
> > > > +fail_err:
> > > > +   return err < 0 ? err : 0;
> > > >  }
> > > >=20
> > > >  const struct dev_pm_ops hts221_pm_ops =3D {
> > >=20
> > >=20
>=20
> I guess we need to double-check the setup first since BDU is
> configured just at bootstrap and it is never reset during
> suspend/resume or normal operation.
> It seems an electrical issue (e.g. Vdd not stable during suspend).
> Shrirang could you please double check the device is powered up during
> the suspend phase?
> Is device connected through I2C or SPI? Could you please paste
> register map before and after the suspend/resume operation?
The sensor is mounted on the main board of Dell Edge Gateway 300x [1].
As I've mentioned before, I have no resources to test the HW. These devices
are already in production.
I have already shared the register contents of hts221 in [2], but in case y=
ou've
missed it, here they are:

root@caracalla:/sys/bus/iio/devices/iio:device0# cat in_*_raw
-2032
1023
root@caracalla:/sys/bus/iio/devices/iio:device0# cat in_*_raw
-2024
1022
root@caracalla:/sys/bus/iio/devices/iio:device0# /home/admin/i2c-tools-4.0/=
tools/i2cdump -f -y 0 0x5f b
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bc    ...............?
10: 1b 00 65 32 99 be 32 a2 9e b2 fb 00 e8 01 00 82    ?.e2??2????.??.?
20: 05 00 00 00 00 00 00 02 db f7 fe 03 c7 fb 16 04    ?......?????????
30: 37 85 a8 1b 00 c4 e8 ff 86 03 80 ce ff ff 19 03    7???.??.????..??
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bc    ...............?
90: 1b 00 65 32 99 be 32 a2 9e b2 fb 00 e8 01 00 82    ?.e2??2????.??.?
a0: 05 00 00 00 00 00 00 00 db f7 fe 03 c7 fb 16 04    ?.......????????
b0: 37 85 a8 1b 00 c4 e8 ff 86 03 80 ce ff ff 19 03    7???.??.????..??
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
root@caracalla:/sys/bus/iio/devices/iio:device0# rtcwake -a -v -s 40 -m mem
rtcwake: assuming RTC uses UTC ...
Using UTC time.
        delta   =3D 0
        tzone   =3D 0
        tzname  =3D UTC
        systime =3D 1525343782, (UTC) Thu May  3 10:36:22 2018
        rtctime =3D 1525343782, (UTC) Thu May  3 10:36:22 2018
alarm 0, sys_time 1525343782, rtc_time 1525343782, seconds 40
rtcwake: wakeup from "mem" using /dev/rtc0 at Thu May  3 10:37:03 2018
suspend mode: mem; suspending system
root@caracalla:/sys/bus/iio/devices/iio:device0# /home/admin/i2c-tools-4.0/=
tools/i2cdump -f -y 0 0x5f b
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bc    ...............?
10: 3f 00 65 32 99 be 32 a2 9e b2 fb 00 e8 01 80 82    ?.e2??2????.????
20: 00 00 00 00 00 00 00 03 7e f6 78 03 f4 f9 90 03    .......?~?x?????
30: 37 85 a8 1b 00 c4 e8 ff 86 03 80 ce ff ff 19 03    7???.??.????..??
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bc    ...............?
90: 3f 00 65 32 99 be 32 a2 9e b2 fb 00 e8 01 80 82    ?.e2??2????.????
a0: 00 00 00 00 00 00 00 00 7e f6 78 03 f4 f9 90 03    ........~?x?????
b0: 37 85 a8 1b 00 c4 e8 ff 86 03 80 ce ff ff 19 03    7???.??.????..??
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
root@caracalla:/sys/bus/iio/devices/iio:device0# cat in_*_raw
-2434
888
root@caracalla:/sys/bus/iio/devices/iio:device0# cat in_*_raw
-2434
888
root@caracalla:/sys/bus/iio/devices/iio:device0# cat in_humidityrelative_ov=
ersampling_ratio
32
root@caracalla:/sys/bus/iio/devices/iio:device0# cat in_temp_oversampling_r=
atio
16

Regards,
Shrirang.

[1] http://i.dell.com/sites/doccontent/shared-content/data-sheets/en/Docume=
nts/Dell_Edge_Gateway_3000_Series_spec_sheet.pdf?newtab=3Dtrue
[2] https://marc.info/?l=3Dlinux-iio&m=3D152534455701742&w=3D2
>=20
> Regards,
> Lorenzo
>=20
--=-vp0Cm8K2cezEtlnR32IL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJa8RGPAAoJELlj3b/+u+hk2agQAJGyhk3aB+uesUgOym2vrCnp
Q5eDiWE+n7CAIAHeHeX4iiTcJYZt8cMu1ihIBRP4VB3S6asmyOxedZWvhoDPjdTy
0O+0QPjYQLQhlH2A3sLr0rnqx0CVOJHKT3aBNGT8yaGfsHfOfr1V3qAVh+SteRS+
y5mj/Rj3iexVpUtRBSNWcy57WA1gkkxeYs0P51U8mHAUDdeSHbH54iesUeqPHSU2
Izm6rV62T3/miVR6/LQZ6cSoq11epGqJY8GXexmCSWMmRw66Tw+PPquH3bv5g5oF
lGTEgozoOK9iHXQw1iRL+QT+yFoOe1ZlhR9m3LuOe0MgOb1UVIJKoGUZW194M6QR
xhL1jT734qS/rDKPGevsErMFM8vAwXO4u8wNKAHF3IJoVyTAZQwy07V9ckoH/h6C
PPAUJWOmRvdjJJ55wZTwRLfp/9E3atj93E4SaMndRpvb/e5li6dZVXg42/wSKx6S
/MB/bw1lBY2SL/e1PhFuIVSLhzQrZFudNx0p7+ZA330QG8mNYi/PAD+DzD/OawrR
2XUTTVy2Yn3G65YWXPrJtqzhNhIdHUSZQLSGH6qpIBQ8m6G+pBGYsIkcJC9phR1s
aleXKeqkDQCXbH+Sifg1YdZMK2cAHGXFZNVNl/7RTgwJlpRDAJ+KlpXl3hknO2MV
ZwV+ZGTCo+Uo55S9PFjw
=yLLu
-----END PGP SIGNATURE-----

--=-vp0Cm8K2cezEtlnR32IL--
