Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 15 Apr 2011 14:00:10 +0100
Subject: RE: [PATCH] IIO-onwards: trigger: iio-trig-sysfs: Avoid double free.
Message-ID: <544AC56F16B56944AEC3BD4E3D591771375475E378@LIMKCMBX1.ad.analog.com>
References: <1302870582-14958-1-git-send-email-michael.hennerich@analog.com>
 <4DA83FB5.7000501@cam.ac.uk>
In-Reply-To: <4DA83FB5.7000501@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-04-15:
> On 04/15/11 13:29, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>>
> Good catch.
>
> Given I haven't 'officially' posted this lot yet, do you mind if I
> merge the fixes into the patch that caused the problem?
> (with crediting of course!)

No Problem - keep it simple.

> Could keep them separate but that will make for confusing reviewing
> once I haven't posted the patches.. (probably later today).
>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>  drivers/staging/iio/trigger/iio-trig-sysfs.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>> diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c
>> b/drivers/staging/iio/trigger/iio-trig-sysfs.c
>> index 5cd55ac..6d3dee3 100644
>> --- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
>> +++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
>> @@ -134,7 +134,6 @@ static int iio_sysfs_trigger_probe(int id)
>>      t->id =3D id;     t->trig =3D iio_allocate_trigger_named(name);    =
 if
>>  (!t->trig) { -              kfree(name);            ret =3D -ENOMEM;   =
       goto free_t;    }

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
