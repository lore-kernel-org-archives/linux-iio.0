Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Wed, 2 Feb 2011 19:21:36 +0000
Subject: RE: [PATCH] IIO: TRIGGER: New sysfs based trigger
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324C1659B8@LIMKCMBX1.ad.analog.com>
References: <1296653448-10841-1-git-send-email-michael.hennerich@analog.com>
 <4D49A0F4.5040408@cam.ac.uk>
In-Reply-To: <4D49A0F4.5040408@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-02-02:
> On 02/02/11 13:30, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> This patch adds a new trigger that can be invoked by writing the sysfs
>> file: trigger_now. This approach can be valuable during automated
>> testing or in situations, where other trigger methods are not
>> applicable. For example no RTC or spare GPIOs. Last but not least we
>> can allow user space applications to produce
> triggers.
> Excellent.  Very handy for testing as you say.
>
> If we really want to commonly use this from userspace we will want a
> means of registering more than one such trigger but this does fine for
> test rigs. To do multiple triggers with this we could either just take
> a module parameter or have a 'request_trigger' attribute under some
> parent device.
> Still that's a question for another day.  The current functionality is
> enough to be getting on with.

Well - you can register as many triggers as you want.
This is what platform_device.id is for.

See example below -

static struct platform_device iio_sysfs_trigger =3D {
        .name           =3D "iio_sysfs_trigger",
        .id             =3D 0,
        .dev =3D {
                .platform_data =3D NULL,
        },
};

static struct platform_device iio_sysfs_trigger1 =3D {
        .name           =3D "iio_sysfs_trigger",
        .id             =3D 1,
        .dev =3D {
                .platform_data =3D NULL,
        },
};


        &bfin_dpmc,

static struct platform_device *my_devices[] __initdata =3D {

#if defined(CONFIG_IIO_SYSFS_TRIGGER) || defined(CONFIG_IIO_SYSFS_TRIGGER _=
MODULE)
        &iio_sysfs_trigger,
        &iio_sysfs_trigger1,
#endif
}

In the driver use:

> +     trig->name =3D kasprintf(GFP_KERNEL, "sysfstrig%d", pdev->id);

What the gpio trigger driver does is not necessary
- it only replicates functionality already provided by the platform device =
bus.

-Michael


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
