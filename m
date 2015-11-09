Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37481 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbbKIKd3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Nov 2015 05:33:29 -0500
From: Markus Pargmann <mpa@pengutronix.de>
To: Vesa =?ISO-8859-1?Q?J=E4=E4skel=E4inen?= <dachaac@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: IIO device indexing issue
Date: Mon, 09 Nov 2015 11:33:25 +0100
Message-ID: <9654108.po90mIDsEf@adelgunde>
In-Reply-To: <563DBE5E.6060307@gmail.com>
References: <5637AFC5.7080007@gmail.com> <5517276.dg3z7SpAvu@adelgunde> <563DBE5E.6060307@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1470166.nmQVbR6UIg"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--nextPart1470166.nmQVbR6UIg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 07 November 2015 11:03:26 Vesa J=E4=E4skel=E4inen wrote:
> On 06/11/15 11:49, Markus Pargmann wrote:
> > Hi,
> >
> > On Thursday, November 05, 2015 07:13:41 PM Jonathan Cameron wrote:
> >> On 04/11/15 18:53, Vesa J=E4=E4skel=E4inen wrote:
> >>> To continue from this "label" property idea I was wondering if we=

> >>> would add it as new optional(?) file node for IIO devices.>
> >>> One could then specify it like:
> >>>
> >>> tscadc: tscadc@44e0d000 {
> >>>      compatible =3D "ti,am3359-tscadc";
> >>> ...
> >>>      am335x_adc: adc {
> >>>          compatible =3D "ti,am3359-adc";
> >>> ...
> >>>          label =3D "Port A";
> >>>      };
> >>> };
> >>>
> >>> And this would generate file /sys/bus/iio/iio:deviceX/label with
> >>> contents of "Port A".
> >>>
> >>> Then during the application startup it would just need to scan al=
l
> >>> devices under /sys/bus/iio and determine what labelled device it
> >>> wants to use.
> >>>
> >>> It would be up to device's developer to determine what labels to =
use
> >>> in their designs. This would not break ABI and would be just an
> >>> extension for it.
> >>>
> >>> One could also auto-assign label "am335x_adc" in this case too. B=
ut
> >>> if you include existing arch device tree then changing label in t=
op
> >>> level is kinda a bit annoying as you would then need to duplicate=
 all
> >>> properties with another label and disable arch device tree's
> >>> settings. Could cause also conflict if there are references elsew=
here
> >>> to existing arch nodes.
> >>>
> >>> Having following in device's device tree file would allow one to
> >>> override label or just only specify that.
> >>>
> >>> #include "am33xx.dtsi"
> >>>
> >>> &tscadc {
> >>>      status =3D "okay";
> >>>
> >>>      adc {
> >>>          ti,adc-channels =3D <4 5 6 7>;
> >>>
> >>>          label =3D "Port A";
> >>>      };
> >>> };
> >>>
> >>> I think this "label" model would be simple to understand.
> >>>
> >>> Whether this needs to be implemented as per device driver feature=
 or
> >>> could be implemented as generic IIO functionality I do not know.
> >> The principal looks good to me.  It's not however only an IIO issu=
e
> >> so perhaps we should expand the discussion to include other subsys=
tems
> >> likely to have similar issues (though perhaps to a lesser degree) =
such as
> >> hwmon and input?  Any others?
> >>
> >> We could also autobuild the label from other sources such as ACPI
> >> to uniquely describe the instance of the device (afterall all we r=
eally
> >> care about is that it always has the same name on the same hardwar=
e,
> >> being able to assign meaningful simple names would just be the ici=
ng
> >> on the cake!)
> > There is a similar discussion for the new character device GPIO int=
erface.[1]
> >
> > Simple labels have the problem that they could be the same for two =
devicetree
> > overlays or chips that are connected via SPI.
> >
> As far as I understand the overlays, you always specify a hardware=20=

> hierarchy where you want to add additional information to device tree=
.=20
> This means that while adding device with overlays you have full contr=
ol=20
> what device it is and then can configure what label property device=20=

> should have.

I would expect at some point in the future that there is enough
tooling/hotplug/something else that you have some generic devicetrees t=
hat can
be 'hotplugged' to any bus. For example If you connect two identical sp=
i
sensors to two different spi busses I would really expect that we have =
only one
devicetree to describe this chip and some tooling to do the rest. Howev=
er this
is probably not right for the moment but perhaps in the future.

>=20
> If you would add two SPI devices those would be unique items in the=20=

> device tree this means that overlay adding those would be unique and=20=

> then you can assign unique label for the devices.

Yes these would be unique items but only if you consider the whole path=
 of the
device. If you limit it to the simple approach that was mentioned with =
only a
simple label property this wouldn't work. Generating/Assigning labels w=
ould
probably solve that but I just meant the mentioned 'simple' solution of=
 fixed
labels that are fixed in the devicetree.

>=20
> When you have full control for device tree and device tree overlays=20=

> added to your device then this should not be problem?
>=20
> Problem not addressed by device tree would be dynamically configured=20=

> buses like USB which could have user connected devices. But then agai=
n=20
> you probably do not configure this with device tree either? In this c=
ase=20
> if "label" would be read&write property then udev or such could then=20=

> fill it with details based on your configuration.
>=20
> As commented on the thread you pointed out was question should the la=
bel=20
> property have physical path components in there. There was comment th=
at=20
> symlink (in IIO case this would be symlinks under /sys/bus/iio/) shou=
ld=20
> have the details available if this is needed for decision.
>=20
> Basically application developer could have following tools to perform=
=20
> his decision:
>=20
> Scan /sys/bus/iio/ for iio:deviceN's.
>=20
> - Get "name" property (driver identification).
> - Do realpath for symlink to get physical address
> - Get "label" property to have cue what this device is for
>=20
> On other thread one idea was to have UUID for devices as a label (fst=
ab=20
> + partition UUID's was the idea behind it). How to make it stick for=20=

> every boot is the problem here however. You could use UUID in hash mo=
de=20
> (eg. version 5) and then just determine what details affect it. For U=
SB=20
> devices which could be moved to other slots this is still an issue as=
 on=20
> some cases it would be irrelevant on what slot it is and in some case=
s=20
> it could be relevant. There are also other properties that are device=
=20
> specific like should the UUID hash include serial number of the devic=
e=20
> or not? This same problem matches to other automatic label cases. So =
I=20
> suppose there is no one solution that fits for all cases.
>=20
> To setup label automatically you seem to need to have local configura=
tion.
>=20
> If the process would be something like:
>=20
> - Setup device tree with optional label property.
> - If label is not defined in device tree leave it as empty
> - When user space starts up it can have local configuration that adju=
sts=20
> labels
> - If there is a daemon in system like udev and new device is inserted=
=20
> then it could have rules for configuring labels.
>=20
> I think this would allow one to setup whatever identification one wan=
ts=20
> to use for label.

I personally would prefer a generic way so that it is identical on each=
 system
by default. Every user can always write udev rules to fulfill their nee=
ds.

But I think it would be good to merge both discussions.

Best Regards,

Markus

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart1470166.nmQVbR6UIg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWQHZ1AAoJEEpcgKtcEGQQKT0P/RLKSPC3KQr5LSNB6DMGR+3U
Pxz/Jzirb4dmOFfDNKrUrrGIFBDzTViKbDCmI4qcXZYjrHSwBnTzwVRnY16k2Kpv
CisaF7Jtt5IWdxY6B4HkoMzXSXUxCEcadSjeAybGohPaJas+7cfCbJde8biJybHs
SIiB/EguQdlt+UgdJ+Mx0f1hpA6hA3Jsm4GkCJ6Feu+LvTyShCR0P/tjjuSQvSA/
QfMRZ3c3e/AnBXdcA/MqZxqC/b/bfW9frALM/GnlKi8VuM2TOIxpTEbSckRDpYO+
MCIOWGzwoPWVWPD0vXxUtPP5srG2C4ILDZAo2nbN4EAgyTlN++ZpLigwJRR9uIIS
XQ0AgXkIuFtFADGmKTrQWkgaUHL/xQrLrMKP9AmyJJhRWPrkoe2mRhwPvLWUIKNA
w58dZZEwokd9E+xYZ0zYgIcbsGWUD+9FRUZit5zKTy8cSSSjMw257f0aPK//+qAM
PH3lRjPiZQE2bj/kxHjsB0oM3c+1yP6ga5Wr/7kzBb1pyr0EEY+OqVP5ckE3cjdT
iILuiuRyxUxOBSdeY1CvfdLMIS0LgTBjwSrN1TX6c2nAeXTE0oDi2hy2GSEaSwkP
XotLFo+TyMGugHHRvAkj9lHToCqkuBDsewV3Ag5nx2vjZyaajAJaMD/+x19i+KyX
SsAK8r7A5ShT3psRsndf
=83sR
-----END PGP SIGNATURE-----

--nextPart1470166.nmQVbR6UIg--

