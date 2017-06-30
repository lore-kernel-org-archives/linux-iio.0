Return-Path: <SRS0=Egi1=6D=ams.com=Jon.Brenner@kernel.org>
From: Jon Brenner <Jon.Brenner@ams.com>
To: Brian Masney <masneyb@onstation.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"lars@metafoo.de" <lars@metafoo.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: RE: [PATCH 0/6] staging: iio: tsl2x7x: staging cleanups
Date: Fri, 30 Jun 2017 16:08:09 +0000
Message-ID: <5735c3fe53e34c23a8f6fdd80d5e87b5@SUX5072.office.amsiag.com>
References: <20170629170352.11264-1-masneyb@onstation.org>
 <20170630152114.4biwkzt43w52lalp@basecamp>
In-Reply-To: <20170630152114.4biwkzt43w52lalp@basecamp>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Brian,
Not sure about the DTS interrupt setting you mentioned but would like to kn=
ow how you resolve - as I am planning on getting a Pi0w for some 'home pers=
onal projects'.

Anyway (and I am sure you probably already know this - but just in case) WR=
T the device registers (on the TSL2771 for example);
If you enable interrupts (ie. Reg#0x00=3D 0x37) and set the persistence reg=
ister to 0x00 (is. Reg# 0x0C =3D 0x00), you should see interrupts occurring=
 every integration period.
That way you can see if you're at least getting them.

You probably know this too - on earlier parts such as these, interrupts wer=
e cleared via use of the "command register" special function bits.  (see da=
ta sheets for details).
Now a day - interrupts are cleared in a more conventional manner=20

Jon

-----Original Message-----
From: Brian Masney [mailto:masneyb@onstation.org]=20
Sent: Friday, June 30, 2017 10:21 AM
To: jic23@kernel.org; linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org; lars@metafoo.de; gregkh@linuxfoundation.org=
; linux-kernel@vger.kernel.org; Jon Brenner <Jon.Brenner@ams.com>; pmeerw@p=
meerw.net; knaack.h@gmx.de
Subject: Re: [PATCH 0/6] staging: iio: tsl2x7x: staging cleanups

On Thu, Jun 29, 2017 at 01:03:46PM -0400, Brian Masney wrote:
> This begins my work to clean this driver up and eventually move it out=20
> of staging. Driver changes were tested using a TSL2771 hooked up to a=20
> Raspberry Pi 2.
>=20
> Thanks to Jon Brenner at AMS/TAOS for loaning me some hardware samples=20
> to test my driver changes.
>=20
> Brian Masney (6):
>   staging: iio: tsl2x7x: add of_match table for device tree support
>   staging: iio: tsl2x7x: remove redundant power_state sysfs attribute
>   staging: iio: tsl2x7x: remove tsl2x7x_i2c_read()
>   staging: iio: tsl2x7x: cleaned up i2c calls in tsl2x7x_als_calibrate()
>   staging: iio: tsl2x7x: refactor {read,write}_event_value to allow
>     handling multiple iio_event_infos
>   staging: iio: tsl2x7x: use usleep_range() instead of mdelay()
>=20
>  .../devicetree/bindings/trivial-devices.txt        |  10 +
>  drivers/staging/iio/light/tsl2x7x.c                | 316 ++++++++++-----=
------
>  2 files changed, 153 insertions(+), 173 deletions(-)

Hi Jonathon,

Hold off on applying this series. There are several other formatting warnin=
gs from checkpatch with this series that I need to fix. Sorry about the noi=
se. I'd appreciate it if you could at least look at the functionality of my=
 changes and I'll resubmit next week.

I held back several other changes related to the event subsystem until I'm =
able to properly test my changes. I'm having trouble getting the interrupts=
 to work. I wired the interrupt pin on the sensor to GPIO pin 17 on my Rasp=
berry Pi 2 and added the following section to arch/arm/boot/dts/bcm2836-rpi=
-2-b.dts for my sensor:

&i2c1 {
        tsl2771@29 {
                compatible =3D "amstaos,tsl2771";
                reg =3D <0x39>;
                interrupt-parent =3D <&gpio>;
                interrupts =3D <17 2>;
        };
};

I start up iio_event_monitor, and run these commands:

echo 1 > events/in_intensity0_thresh_rising_en
echo 256 > events/in_intensity0_thresh_rising_value

When I shine a light on the ALS sensor, and the reading goes above 256, I d=
o not get any events back from iio_event_monitor.

I'm honestly not sure about the 2 in the 'interrupts =3D <17 2>;' line.
I looked at how interrupts were setup in device tree overlays in the offici=
al Raspberry Pi kernel and tried several variations from there.
I have more reading to do. :)

Thanks,

Brian
