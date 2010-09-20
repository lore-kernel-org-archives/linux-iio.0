Return-Path: <manuel.stahl9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4C97207D.8090109@iis.fraunhofer.de>
Date: Mon, 20 Sep 2010 10:51:09 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, drivers@analog.com
Subject: Re: [PATCH 00/10] staging:iio: implement _type attrs for scan elements
References: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

basically I like the patches. Just a few things:

- I know you prefer the IIO_CONST_ATTR instead of sophisticated macros.=20
But if we do want to change the format, we have to modify all drivers=20
again. So I'd like to see a macro like IIO_SCAN_EL_TYPE(_name_,=20
signed/unsigned, _actual_size_, _storage_size_).

- From "Proposal for sysfs attributes":
>> One additional point here.  What we currently have that the enable
>> > parameters are currently [m]_accel_x_en etc with m being an indicato=
r
>> > of the position of a parameter within the buffer.  Note not all chan=
nels
>> > are enabled at a time.  For all devices we have so far, the ordering
>> > is fixed, so this naming is constant.  Basically we roll the accel_x=
_index
>> > attribute into the naming of the enable attribute.  Manuel, could yo=
u summarize
>> > what you have against that approach? (I'm not particularly tied to i=
t, but
>> > it is in place and it does work).
> Any response to this question Manuel?  Basically this question asks whe=
ther
> we want to explicitly tell userspace what the ordering is, or instead p=
rovide
> it with sufficient info to trivially figure it out itself.  I'm incline=
d to leave
> this job to user space.
No input yet. After thinking again about the "one value per sysfs=20
attribute" mantra, I think people won't accept to read values from the=20
attribute's name instead of using read/write ops. I have no preference=20
wether we recalculate the index depending on the enabled status.



Am 19.09.2010 19:04, schrieb Jonathan Cameron:
> Implementation of Manuel Stahl's suggested interface to describe how
> a given scan element is stored in the buffer.
>
> The final patch removes the previous partial implementation of related
> functionality.
>
> This is done off a combination of what was marked in the drivers and
> datasheets.  Where the in driver elements disagree with the datasheet
> I have assumed a bug (be it one that did not previously have any affect=
)
> and gone with the datasheet.
>
> In one case, I don't believe the datasheet so have asked the manufactur=
er
> to confirm.
>
> This is applied on a clean version of staging-next as I would like to
> merge this asap and hence do not want to have it dependant on the
> two large adis related patch sets I have posted to the mailining list.
> Clearly those will both need to be rebased.
>
> Jonathan Cameron (10):
>    staging:iio:lis3l02dq add _type attributes for all scan elements
>    staging:iio:max1363 add _type attributes for all scan elements
>    staging:iio:adis16209 add _type attributes for all scan elements
>    staging:iio:adis16240 add _type attributes for all scan elements
>    staging:iio:sca3000 add _type attributes for all scan elements
>    staging:iio:adis16260 add _type attributes for all scan elements
>    staging:iio:adis16300 add _type attributes for all scan elements
>    staging:iio:adis16350 add _type attributes for all scan elements
>    staging:iio:adis16400 add _type attributes for all scan elements
>    staging:iio: Remove unused bit_count from struct iio_scan_el
>
>   drivers/staging/iio/accel/adis16209_ring.c |   36 ++++---
>   drivers/staging/iio/accel/adis16240_ring.c |   27 +++--
>   drivers/staging/iio/accel/lis3l02dq_ring.c |   10 ++-
>   drivers/staging/iio/accel/sca3000_ring.c   |   52 +++++-----
>   drivers/staging/iio/adc/max1363_core.c     |  154 +++++++++++++++++--=
---------
>   drivers/staging/iio/gyro/adis16260_ring.c  |   27 +++--
>   drivers/staging/iio/imu/adis16300_ring.c   |   39 +++++---
>   drivers/staging/iio/imu/adis16350_ring.c   |   44 ++++----
>   drivers/staging/iio/imu/adis16400_ring.c   |   50 +++++----
>   drivers/staging/iio/ring_generic.h         |   17 +--
>   10 files changed, 261 insertions(+), 195 deletions(-)
>


--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de
