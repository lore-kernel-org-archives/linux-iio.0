Return-Path: <SRS0=V3L2=2C=gmail.com=pali.rohar@kernel.org>
Date: Tue, 21 Feb 2017 10:09:40 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Michael Welling <mwelling@ieee.org>,
	Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Igor Grinberg <grinberg@compulab.co.il>,
	"Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Alexander Stein <alexander.stein@systec-electronic.com>,
	Eric Engestrom <eric@engestrom.ch>,
	Hans de Goede <hdegoede@redhat.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Petr Cvek <petr.cvek@tul.cz>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Nick Dyer <nick@shmanahar.org>,
	Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
	Michel Verlaan <michel.verl@gmail.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	linux-iio@vger.kernel.org, kernel@pyra-handheld.com,
	Aaro Koskinen <aaro.koskinen@nokia.com>,
	Pavel Machek <pavel@ucw.cz>,
	Andrey Gelman <andrey.gelman@compulab.co.il>,
	Haibo Chen <haibo.chen@freescale.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Message-ID: <20170221090940.GD9795@pali>
References: <cover.1482936802.git.hns@goldelico.com>
 <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com>
 <201702202042.15878@pali>
 <201702202208.50498@pali>
 <C2E7AC24-75AB-442F-94A2-84904723EE41@goldelico.com>
 <CAKdAkRRZa-fpv_TKRdY=hFV3GdKxQ3muQORquvV_bTrDzQAhCw@mail.gmail.com>
 <0A33CCEA-448C-4C1D-9563-FDA54743BD01@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0A33CCEA-448C-4C1D-9563-FDA54743BD01@goldelico.com>
List-ID: <linux-iio@vger.kernel.org>

On Tuesday 21 February 2017 07:36:17 H. Nikolaus Schaller wrote:
> Hi,
> 
> > Am 20.02.2017 um 22:50 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > 
> > On Mon, Feb 20, 2017 at 1:27 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >> 
> >>> Am 20.02.2017 um 22:08 schrieb Pali Rohár <pali.rohar@gmail.com>:
> >>> 
> >>> On Monday 20 February 2017 20:42:15 Pali Rohár wrote:
> >>>> Hi Nikolaus!
> >>>> 
> >>>> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
> >>>>> Hi Dmitry,
> >>>>> 
> >>>>>> Input driver may set resolution for given axis in units per mm
> >>>>>> (or units per radian for rotational axis ABS_RX, ABS_RY,
> >>>>>> ABS_RZ), and if you check the binding, you can use
> >>>>>> "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size of
> >>>>>> entire touch surface and set resolution from it so that
> >>>>>> userspace can calculate the proper scaling factor.
> >>>>> 
> >>>>> How is this information exposed by the kernel to user-space? By
> >>>>> scanning the DT file or tree?
> >>>> 
> >>>> Set input_abs_set_res() from kernel. And in userspace call EVIOCGABS
> >>>> ioctl() on input device. Look at struct input_absinfo, you should
> >>>> have all needed information here. This is generic input interface,
> >>>> no DT is needed.
> >>> 
> >>> Looking at kernel code... via EVIOCSABS ioctl() you can even set
> >>> resolution from userspace for specified input device.
> >>> 
> >>> So this could be potentially used for calibrating input device from
> >>> userspace? (In case DT data will not fully match current HW)
> >>> 
> >>>> I hope that XServer is already using it for evdev devices...
> >>>> 
> >>>> For whole implementation look at evtest program. That should be good
> >>>> starting point for your userspace implementation.
> >>>> 
> >>>> While I'm watching this discussion... in my opinion kernel should
> >>>> just invert input axes (when needed)
> >> 
> >> It is questionable why it should do that at all then.
> > 
> > Because the task of the kernel is to provide unified view of the
> > hardware. Axis swapping and inversion is needed to that "up" is always
> > "up" and "right" is always "right".
> 
> Hm. Why not touching pixel (0,0) on the touch is always pixel (0,0) on the
> screen and touching pixel (639,479) is always (639,479)?

Important is that there is no 1:1 mapping between input evdev device and
drm/fb output device. These are two independent devices. There is no
connection between screen and touch. So such presumption should not be
done in kernel. You can do that in userspace.

Lets take e.g. touchpad. It acts similarly as touchscreen input device
(both reports absolute positioned touch events), but touchpad is not
connected with screen. And from kernel point of view these devices are
both input and absolute positioned.

It looks like the whole problem is there that you wanted to do this
mapping for your hardware in kernel. And this is not what is kernel
doing or should do. Moreover I know people who are using integrated
touchscreen on laptop as (touch) input device for external monitor. And
in this configuration it does not make any sense to map touchscreen
input to pixels of integrated LCD touchscreen (as external monitor could
have different resolution as integrated LCD touchcreen).

> I think it is time to end this discussion.
> 
> It has show me how much a mess and half-baked area this is, which I did
> not expect. I read contradicting messages from different people:
> 
> * don't break user space because it is carved in stone
> * fix users space if you want to do it properly
> * scaling by +/-1 and shifting by full range is ok
> * scaling by ts-size/adc-range and shifting by adc_min is not ok
> * full numeric ADC resolution is required but subpixel coordinates is not acceptable
> 
> I will monitor this to see if this becomes sorted out before submitting anything
> new.
> 
> BR and thanks,
> Nikolaus

-- 
Pali Rohár
pali.rohar@gmail.com
