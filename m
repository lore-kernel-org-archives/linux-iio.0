Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Martin =?utf-8?q?Li=C5=A1ka?= <marxin.liska@gmail.com>
Subject: Re: ACPI ambient light sensor
Date: Sun, 21 Oct 2012 19:32:25 +0200
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
 platform-driver-x86@vger.kernel.org,
 linux-iio@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>,
 Corentin Chary <corentin.chary@gmail.com>,
 joeyli <jlee@suse.com>,
 Len Brown <len.brown@intel.com>,
 pavel@denx.de,
 Jonathan Cameron <jic23@kernel.org>,
 Jon Brenner <jbrenner@taosinc.com>,
 Peter Meerwald <pmeerw@pmeerw.net>
References: <CAObPJ3PctmLP56NvmLvJd+4w9e4xeOGSyz24FyBDXBQQVhDhxQ@mail.gmail.com> <201209111121.34205.marex@denx.de> <CAObPJ3PB0VYNE9vhrwJRA9jpWX6p7_Kw8T2eCMgj0M0zJ9feUA@mail.gmail.com>
In-Reply-To: <CAObPJ3PB0VYNE9vhrwJRA9jpWX6p7_Kw8T2eCMgj0M0zJ9feUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201210211932.26094.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Martin Li=C5=A1ka,

> Hello,
>    my kernel driver is still unable to start capturing in a proper way.
> First step for listening is
>=20
> * echo 1 >
> /sys/bus/iio/devices/iio\:device0/scan_elements/in_illuminance1_en*
> *
> *
> but
>=20
> *cat /sys/bus/iio/devices/iio\:device0/scan_elements/in_illuminance1_en*
> *-1*
> *
> *
> I tried to decorate all result codes with printf.
> Dmesg dump:
> *[    0.927335] XXX: trigger init called*
> *[    0.928148] XXX: acpi_als_allocate_trigger: 0*
> *[    0.928275] XXX: acpi_als_trigger_init: 0*
> *[    3.255305] XXX: getting data for filling buffer*
> *[    3.255352] XXX: buffer is ready*
> *[   27.423650] XXX: getting data for filling buffer*
> *[   27.423698] XXX: buffer is ready*
> *[   30.444120] XXX: getting data for filling buffer*
>=20
> Do you have any advices how to figure out where is problem?
>=20
> Thank you,
> Martin
>=20
>=20
> /*
>  * ACPI Ambient Light Sensor Driver
>  *
>  * This program is free software; you can redistribute it and/or modify it
>  * under the terms and conditions of the GNU General Public License,
>  * version 2, as published by the Free Software Foundation.
>  *
>  * This program is distributed in the hope it will be useful, but WITHOUT
>  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for * more details.
>  *
>  * You should have received a copy of the GNU General Public License
>  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>  */
>=20
> #include <linux/module.h>
> #include <linux/interrupt.h>
> #include <trace/events/printk.h>
> #include <acpi/acpi_bus.h>
> #include <acpi/acpi_drivers.h>
> #include <linux/err.h>
> #include <linux/mutex.h>
>=20
> #include <linux/iio/iio.h>
> #include <linux/iio/buffer.h>
> #include <linux/iio/sysfs.h>
> #include <linux/iio/trigger.h>
> #include <linux/iio/trigger_consumer.h>
> #include <linux/iio/triggered_buffer.h>
>=20
> #define PREFIX "ACPI: "
>=20
> #define ACPI_ALS_CLASS "als"
> #define ACPI_ALS_DEVICE_NAME "acpi-als"
> #define ACPI_ALS_NOTIFY_ILLUMINANCE 0x80
> #define ACPI_ALS_NOTIFY_COLOR_TEMP 0x81
> #define ACPI_ALS_NOTIFY_RESPONSE 0x82
>=20
> #define ACPI_ALS_OUTPUTS 3
>=20
> #define _COMPONENT ACPI_ALS_COMPONENT
> ACPI_MODULE_NAME("acpi-als");
>=20
> MODULE_AUTHOR("Martin Liska");
> MODULE_DESCRIPTION("ACPI Ambient Light Sensor Driver");
> MODULE_LICENSE("GPL");
>=20
> struct acpi_als_chip {
> struct acpi_device *device;
> struct acpi_als_device *acpi_als_sys;
> struct mutex lock;
> struct iio_trigger *trig;
>=20
> int illuminance;
> int temperature;
> int chromaticity;
> int polling;
>=20
> int count;
> struct acpi_als_mapping *mappings;
> };
>=20
> static int acpi_als_add(struct acpi_device *device);
> static int acpi_als_remove(struct acpi_device *device, int type);
> static void acpi_als_notify(struct acpi_device *device, u32 event);
>=20
> static const struct acpi_device_id acpi_als_device_ids[] =3D {
> {"ACPI0008", 0},
> {"", 0},
> };
>=20
> MODULE_DEVICE_TABLE(acpi, acpi_als_device_ids);
>=20
> static struct acpi_driver acpi_als_driver =3D {
> .name =3D "acpi_als",
> .class =3D ACPI_ALS_CLASS,
> .ids =3D acpi_als_device_ids,
> .ops =3D {
> .add =3D acpi_als_add,
> .remove =3D acpi_als_remove,
> .notify =3D acpi_als_notify,
> },
> };
[...]

=2E.. again ...

_Please_ fix your mailer if you want to submit files inline, the indent is=
=20
completely fucked. This behavior of yours definitelly does _NOT_ help anyon=
e, it=20
only puts unnecessary burden on the reader!
