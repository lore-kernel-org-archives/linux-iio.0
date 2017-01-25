Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36152 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbdAYKzP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jan 2017 05:55:15 -0500
Date: Wed, 25 Jan 2017 11:55:11 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Olof Johansson <olof@lixom.net>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [GIT PULL] Immutable branch between MFD, ARM, IIO and PWM due
 for the v4.10 merge window
Message-ID: <20170125105511.GA9344@ulmo.ba.sec>
References: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
 <20170123121222.GJ16020@dell>
 <CAOesGMhx6ZWekgW01-7GRcMiWtAohcfGdcu1FhkP=bTfsjBCmQ@mail.gmail.com>
 <20170124081244.GP16020@dell>
 <CAOesGMhauUd0mPuUsRZnEWrAfQZj3Di_YwvxtD1rXr7B9fgqdw@mail.gmail.com>
 <20170125100858.GA16202@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <20170125100858.GA16202@dell>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2017 at 10:08:58AM +0000, Lee Jones wrote:
> Jonathan, Thierry,
>=20
> On Tue, 24 Jan 2017, Olof Johansson wrote:
> > On Tue, Jan 24, 2017 at 12:12 AM, Lee Jones <lee.jones@linaro.org> wrot=
e:
> > > On Mon, 23 Jan 2017, Olof Johansson wrote:
> > >> On Mon, Jan 23, 2017 at 4:12 AM, Lee Jones <lee.jones@linaro.org> wr=
ote:
> > >> > Arm, IIO and PWM Maintainers,
> > >> >
> > >> > Enjoy!
> > >> >
> > >> > The following changes since commit 7ce7d89f48834cefece7804d38fc5d8=
5382edf77:
> > >> >
> > >> >   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> > >> >
> > >> > are available in the git repository at:
> > >> >
> > >> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd=
-arm-iio-pwm-v4.10
> > >> >
> > >> > for you to fetch changes up to 94df449273475980a39f1bf47f1e3d2b07c=
e6577:
> > >> >
> > >> >   ARM: dts: stm32: Enable pwm1 and pwm3 for stm32f469-disco (2017-=
01-23 12:06:28 +0000)
> > >> >
> > >> > ----------------------------------------------------------------
> > >> > Immutable branch between MFD, ARM, IIO and PWM due for the v4.10 m=
erge window
> > >> >
> > >> > ----------------------------------------------------------------
> > >> > Benjamin Gaignard (8):
> > >> >       dt-bindings: mfd: Add bindings for STM32 Timers driver
> > >> >       mfd: Add STM32 Timers driver
> > >> >       dt-bindings: pwm: Add STM32 bindings
> > >> >       pwm: Add driver for STM32 plaftorm
> > >> >       iio: Add bindings for STM32 timer trigger driver
> > >> >       iio: Add STM32 timer trigger driver
> > >> >       ARM: dts: stm32: add Timers driver for stm32f429 MCU
> > >> >       ARM: dts: stm32: Enable pwm1 and pwm3 for stm32f469-disco
> > >> >
> > >> >  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  29 ++
> > >> >  .../bindings/iio/timer/stm32-timer-trigger.txt     |  23 ++
> > >> >  .../devicetree/bindings/mfd/stm32-timers.txt       |  46 +++
> > >> >  .../devicetree/bindings/pwm/pwm-stm32.txt          |  35 ++
> > >> >  arch/arm/boot/dts/stm32f429.dtsi                   | 275 ++++++++=
++++++
> > >> >  arch/arm/boot/dts/stm32f469-disco.dts              |  28 ++
> > >> >  drivers/iio/trigger/Kconfig                        |   9 +
> > >> >  drivers/iio/trigger/Makefile                       |   1 +
> > >> >  drivers/iio/trigger/stm32-timer-trigger.c          | 342 ++++++++=
++++++++++
> > >> >  drivers/mfd/Kconfig                                |  11 +
> > >> >  drivers/mfd/Makefile                               |   2 +
> > >> >  drivers/mfd/stm32-timers.c                         |  80 +++++
> > >> >  drivers/pwm/Kconfig                                |   9 +
> > >> >  drivers/pwm/Makefile                               |   1 +
> > >> >  drivers/pwm/pwm-stm32.c                            | 398 ++++++++=
+++++++++++++
> > >> >  include/linux/iio/timer/stm32-timer-trigger.h      |  62 ++++
> > >> >  include/linux/mfd/stm32-timers.h                   |  71 ++++
> > >> >  17 files changed, 1422 insertions(+)
> > >> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-timer-=
stm32
> > >> >  create mode 100644 Documentation/devicetree/bindings/iio/timer/st=
m32-timer-trigger.txt
> > >> >  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-ti=
mers.txt
> > >> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm3=
2.txt
> > >> >  create mode 100644 drivers/iio/trigger/stm32-timer-trigger.c
> > >> >  create mode 100644 drivers/mfd/stm32-timers.c
> > >> >  create mode 100644 drivers/pwm/pwm-stm32.c
> > >> >  create mode 100644 include/linux/iio/timer/stm32-timer-trigger.h
> > >> >  create mode 100644 include/linux/mfd/stm32-timers.h
> > >>
> > >> May I ask why you're creating an immutable branch of all this conten=
ts?
> > >>
> > >> We should get the dts/dtsi contents like usual from any maintainer;
> > >> just the DT updates in a branch.
> > >>
> > >> Sometimes (but less and less due to us discouraging the use) we need
> > >> an immutable branch that includes dt-include updates. But I don't see
> > >> any of those in this contents.
> > >>
> > >> I.e. I guess I can see the need between mfd and downstream trees
> > >> (iio/pwm), but not the DTS contents at this time. Or am I missing
> > >> something here?
> > >
> > > I agree with you.  However, since one of the STM32 Maintainers Acked
> > > the DTS patches, and the other one hasn't been heard from for months,
> > > I took that to mean he wanted me to apply and take them through the
> > > MFD tree.
> > >
> > > A misunderstanding or misaction perhaps, but this is the normal
> > > assumption.
> >=20
> > It seems to be a misunderstanding in this case, since there are other
> > additions in the stm32 tree this release cycle so we should only pick
> > up DTS changes through our tree.
> >=20
> > By now, I think it should be pretty well known that we nearly never
> > want DTS contents merged through any other tree. Ever.
> >=20
> > So, please revoke your branch and take those out. We'll take them
> > through the normal flow. Thanks!
>=20
> That okay with you?

Do you still want to carry the PWM patches in your tree? Or should they
all just be picked up into the respective subsystem trees, then?

Either way is fine with me.

Thierry

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliIhAwACgkQ3SOs138+
s6HumQ/7BdR0pxa+yXkpvJKyy3LHi8DBw8rlObko9nRv2Pp2lvLy71QJjBpZRxfp
cdp8KRi8Y4d2+oSkrpJgTgatIkKtw7OECBUuJhsydPgb7FQkeEFe/0Q0bOFv/xsS
16g0wbM2k1ejktmN9SYTMSjWKWeHun3npea4oQ5tZYS05v9mh9yoI4dEY+oSHQid
wTzfknYeP/3s/uwW3A0o8qb4U1Dwl2SF1eSvwX/HIUOrhu7vXpBEtF4PZU2MIEDp
XtrVql1tqt4bNo6xW9d4pydtEWFrTAMbUZSpJEFcsj2ck8kcK+XKaKjAw9jTn3EC
l1ok6ScIiUk+Hnj5OZ7NBgeWQkps921WjfrS5Gq7Co63LTbz3njdIqwOZ4mI/nFt
vORUqVHRef6XL74nrCgzr9geXzWi0c2qbjuB6ImnJK7oc8iULEeahhQCq4Zc7Zer
ZWgfjwHcbnlxWMUGs/146nx+Yw2GqSAihMEPnSwBsLOO9L8/EgH5O+d/wcUCYrUC
CdoZitTwNJ4Djd4rw149+Bct3Wz79MJgwkAIXs9eW1v0VQ/XDwqAkdwxQk78EC5y
az0QTuXY44yNG5TFSTFE3KaL8DbEs/+CDL6pd1n6eJOvAiWGAPojh73KbLhJkQ/S
1OCnRTSKaOj2MRv2msATUt7uRAxe7sWHZ1J/sTnGd7sEEf16TxA=
=ktDC
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
