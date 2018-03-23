Return-Path: <SRS0=FfDz=GN=huawei.com=jonathan.cameron@kernel.org>
Date: Fri, 23 Mar 2018 13:04:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/11] Move ad7746 out of staging
Message-ID: <20180323140427.000018f3@huawei.com>
In-Reply-To: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On Wed, 21 Mar 2018 11:28:48 -0300
Hern=E1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> This patch series aims to move the cdc ad7746 driver out of staging. I ha=
ve some
> design questions though so I would introduce them here, along with a short
> description of each patch.
>=20
> *PATCH 0001 - Adjust arguments to match open parenthesis.
> There were a couple CHECKS that still remained, so I got rid of them.
Don't bother describing straight forward patches in the cover letter.
Adds noise to the interesting message.
>=20
> *PATCH 0002 - Fix multiple line dereference
> In this case, I opted for avoiding the multiple line derefence and having=
 a 80+
> characters line instead as I consider that it improves readability. I may=
 be
> wrong though, so this patch could just be discarded.
>=20
> *PATCH 0003 - Reorder includes alphabetically
>=20
> *PATCH 0004 - Reorder variable declarations in an inverser-pyramid way
>=20
> *PATCH 0005 - Remove unused defines
> There were a few too many #defines that were not used at all, so I just r=
emoved
> them. I guess if someone plans on extending the drivers functionality the=
y can
> be added again, but they were just wasting space as they were. Again, I c=
ould be
> wrong with this decision so this patch could just be discarded.
>=20
> *PATCH 0006 - Add dt-bindings
> This patch adds dt bindings by populating the old pdata struct. It suppor=
ts both
> platform_data and dt-bindings but uses only one depending on CONFIG_OF. I=
 chose
> this way to avoid modifying too much the code, and introduce no errors (o=
r as
> few as I could), keeping the same functionality and maintaining support o=
f the
> platform_data.
>=20
> *PATCH 0007 - Add remove()
> I added a remove function so I could test that the driver probed properly=
 when
> compiled as a module with the new dt-bindings.
>=20
> *PATCH 0008 - Add comments to clarify some of the calculations
> I had to go through most of the datasheet to understand some of the math =
in the
> code, so I added comments where I saw fit. (Comments on the comments are
> welcome).
>=20
> *PATCH 0009 - Add devicetree bindings documentation
> Add documentation on the devicetree bindings, explaining the properties o=
f it
> and describing a short example.
>=20
> *PATCH 0010 - Rename sysfs attrs to comply with the ABI
> Comments are welcome on this one.
> I shortened the names of the sysfs attrs to comply with the ABI:
> <type>[Y]_calibbias_calibration -> <type>[Y]_calibbias
> <type>[Y]_calibscale_calibration -> <type>[Y]_calibscale
Hmm. so this one is interesting (note I didn't read the cover letter
and most people don't so better to have put this discussion in that patches
own description.

>=20
> The device supports 2 ways of calibrating the gain (from the datasheet):
> 'The gain can be changed by executing a capacitance gain
> calibration mode, for which an external full-scale capacitance
> needs to be connected to the capacitance input, or by writing a
> user value to the capacitive gain register.'
So the second case is valid for the calibscale ABI, the second not.
>=20
> The same for the offset calibration:
> 'One method of adjusting the offset is to connect a zero-scale
> capacitance to the input and execute the capacitance offset
> calibration mode. The calibration sets the midpoint of the
> =B14.096 pF range (that is, Output Code 0x800000) to that
> zero-scale input.
> Another method would be to calculate and write the offset cali-
> bration register value, the LSB is value 31.25 aF (4.096 pF/2^17 ).'
>=20
> The driver only supports the first way in both cases, as it only writes t=
he
> register that starts the calibration mode and doesn't allow the user to w=
rite
> anything on other registers.
>=20
> What I understand from the ABI is not so different when explaining calibb=
ias and
> calibscale:
> 'Description:
> Hardware applied calibration {offset,scale factor} (assumed to fix produc=
tion
> inaccuracies).'
>=20
> Maybe I'm missing something and the renaming is not good. I would be real=
ly
> grateful if someone could shed some light on this for me.
You are correct - it isn't good.  We can't 'bend' the ABI like this as
userspace would have no idea what to do with it.

This needs new ABI defining to cover the use case.  Please have a go and
make sure to provide documentation of the new ABI
/Documentation/ABI/testing/sysfs-bus-iio-ad7746 (for now - we can move
to the shared docs if it makes sense later).

>=20
> *PATCH 0011 - Move cdc ad7746 driver out of staging to mainline iio
> Move the files, modify the proper Kconfigs and the documentation.
>=20
> That'd be all. Any feedback is welcome. I hope this gets out of staging :)
>=20
> Cheers,
>=20
> Hern=E1n
>=20
> Hern=E1n Gonzalez (11):
>   staging: iio: ad7746: Adjust arguments to match open parenthesis
>   staging: iio: ad7746: Fix multiple line dereference
>   staging: iio: ad7746: Reorder includes alphabetically
>   staging: iio: ad7746: Reorder variable declarations
>   staging: iio: ad7746: Remove unused defines
>   staging: iio: ad7746: Add dt-bindings
>   staging: iio: ad7746: Add remove()
>   staging: iio: ad7746: Add comments
>   staging: iio: ad7746: Add devicetree bindings documentation
>   staging: iio: ad7746: Rename sysfs attrs to comply with the ABI
>   Move cdc ad7746 driver out of staging to mainline iio
>=20
>  .../devicetree/bindings/iio/cdc/ad7746.txt         |  32 ++++
>  drivers/iio/Kconfig                                |   1 +
>  drivers/iio/cdc/Kconfig                            |  16 ++
>  drivers/{staging =3D> }/iio/cdc/ad7746.c             | 168 +++++++++++++=
++------
>  drivers/staging/iio/cdc/Kconfig                    |  10 --
>  .../staging =3D> include/linux}/iio/cdc/ad7746.h     |   9 --
>  6 files changed, 168 insertions(+), 68 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/cdc/ad7746.txt
>  create mode 100644 drivers/iio/cdc/Kconfig
>  rename drivers/{staging =3D> }/iio/cdc/ad7746.c (84%)
>  rename {drivers/staging =3D> include/linux}/iio/cdc/ad7746.h (70%)
>=20
