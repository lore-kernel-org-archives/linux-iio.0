Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Wed, 31 Aug 2011 12:47:17 +0100
Subject: RE: [PATCH 10/12] iio: ad7192: return len and fix out of range
 checking
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E6F63982@LIMKCMBX1.ad.analog.com>
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
 <1314788260-5791-10-git-send-email-michael.hennerich@analog.com>
 <4E5E1D07.70909@cam.ac.uk>
In-Reply-To: <4E5E1D07.70909@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-08-31:
> On 08/31/11 11:57, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>>
> Is 4096 a valid value?  I thought we only had 12 bits (hence the 0xFFF)
> That would make maximum 4095

Where do you see the 4096?
There was a invalid check for smaller 4096 causing a return EINVAL.

I removed the line and added the check for > 0xFFF....

>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>  drivers/staging/iio/adc/ad7291.c |   10 +++++++---
>>  1 files changed, 7 insertions(+), 3 deletions(-)
>> diff --git a/drivers/staging/iio/adc/ad7291.c
>> b/drivers/staging/iio/adc/ad7291.c index 1a2fa66..334951c 100644 ---
>> a/drivers/staging/iio/adc/ad7291.c +++
>> b/drivers/staging/iio/adc/ad7291.c @@ -240,10 +240,14 @@ static inline
>> ssize_t ad7291_set_hyst(struct device *dev,
>>
>>      if (ret < 0)
>>              return ret;
>> -    if (data < 4096)
>> +    if (data > AD7291_VALUE_MASK)
>>              return -EINVAL;
>> -    return ad7291_i2c_write(chip, this_attr->address, data);
>> +    ret =3D ad7291_i2c_write(chip, this_attr->address, data);
>> +    if (ret < 0)
>> +            return ret;
>> +
>> +    return len;
>>  }
>>
>>  static IIO_DEVICE_ATTR(in_temp0_thresh_both_hyst_raw,
>> @@ -351,7 +355,7 @@ static int ad7291_write_event_value(struct iio_dev
>> *indio_dev,
>>
>>      switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
>>      case IIO_VOLTAGE:
>> -            if (val > 0xFFF || val < 0)
>> +            if (val > AD7291_VALUE_MASK || val < 0)
>>                      return -EINVAL;                 reg =3D
>>  ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_NUM(event_code)]
>>                      [!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) =3D=3D
>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
