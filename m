Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E4B85B8.3010006@analog.com>
Date: Wed, 17 Aug 2011 11:11:20 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [RFC PATCH 0/6] IIO: capacitance ADC cleanup (ad7150)
References: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/17/2011 10:42 AM, Jonathan Cameron wrote:
> Hi All,
>
> Couple of bits in here that I'll push out into next set of main cleanups.
>
> Controversial bits (hence RFC) are the introduction of IIO_EV_TYPE_MAG_ADAPTIVE
> and IIO_EV_TYPE_THRESH_ADAPTIVE, to handle the 'mean' shifted thresholds
> of this device.  I'm far from convinced these are the right way to go,
> but best I have come up with just yet.
>
> Note this series is completely untested.  I haven't even verified that the
> new chan spec related bits work right yet (can do that with a dummy driver).
Hi Jonathan,

I have a EVAL-AD7156EBZ board, so I should be able to test the driver.
Can you please push these patches onto your iio-blue git?

Regards,
Michael

> Jonathan
>
> Jonathan Cameron (6):
>    staging:iio: Add capacitance type and average_raw chan info.
>    staging:iio:attrs - make address a u64 to allow event codes to be
>      used.
>    staging:iio:add adaptive event types and missing extract_type macro.
>    staging:iio:naming in the EV_BIT macro fix.
>    staging:iio:adc:ad7150: use i2c_smbus commands + drop unused poweroff
>      timeout control.
>    staging:iio:adc:ad7150 initial chan_spec conversion
>
>   drivers/staging/iio/adc/ad7150.c        |  837 ++++++++++++++-----------------
>   drivers/staging/iio/iio.h               |    3 +
>   drivers/staging/iio/industrialio-core.c |   26 +-
>   drivers/staging/iio/sysfs.h             |    9 +-
>   4 files changed, 411 insertions(+), 464 deletions(-)
>
> --
> 1.7.3.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
