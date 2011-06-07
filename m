Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4DEE226C.1020208@analog.com>
Date: Tue, 7 Jun 2011 15:06:52 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Subject: Re: [PATCH] iio: industrialio-core: iio_write_channel_info accept
 IIO_VAL_INT_PLUS_NANO
References: <1307445688-23126-1-git-send-email-michael.hennerich@analog.com> <4DEE21F7.6010202@cam.ac.uk>
In-Reply-To: <4DEE21F7.6010202@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/07/2011 03:04 PM, Jonathan Cameron wrote:
> On 06/07/11 12:21, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich<michael.hennerich@analog.com>
>>
>> Allow iio_write_channel_info() to accept IIO_VAL_INT_PLUS_NANO
> Hmm. I wonder if this is the right way around to do it.  This puts a hard
> requirement on the number of digits being what the driver expects.
>

Well - this requirement was there before - it was just limited to 6 digits.
Extra digits were simply cut off.
> Alternative would be an optional callback (not needed if everything is int_plus_micro)
> that allows the driver to be queried for what it wants and then reads data under
> the assumption that is what it has.

Ideally write_raw would take an additional argument. Just like read_raw 
returns what it has!


> Which do people think would work better?
>
> The approach here has the flaw that if someone writes a 9 decimal digit value
> to something expect 6 decimal digits the core will pass it on whereas it should
> have ignored the last 3 digits.

I don't think it's getting a big problem.
The driver itself knows the format what he expects.
If someone writes more digits than allowed it's simply not a match or fault.

In order to avoid faults - we could also say 6-8 digits are treated as 
mirco while 9 and more are treated as nano.

      switch (fract_digits) {
      case 6..8: /* IIO_VAL_INT_PLUS_MICRO */
              fract_mult = 100000;
              break;
      case 9..12: /* IIO_VAL_INT_PLUS_NANO */
              fract_mult = 100000000;
              break;
      default:
              return -EINVAL;
      }

>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
>> ---
>>   drivers/staging/iio/industrialio-core.c |   27 +++++++++++++++++++++------
>>   1 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
>> index e5a7663..74158c1 100644
>> --- a/drivers/staging/iio/industrialio-core.c
>> +++ b/drivers/staging/iio/industrialio-core.c
>> @@ -412,25 +412,40 @@ static ssize_t iio_write_channel_info(struct device *dev,
>>   {
>>        struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>        struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> -     int ret, integer = 0, micro = 0, micro_mult = 100000;
>> +     int ret, fract_digits, integer = 0, fract = 0, fract_mult;
>>        bool integer_part = true, negative = false;
>>
>>        /* Assumes decimal - precision based on number of digits */
>>        if (!indio_dev->info->write_raw)
>>                return -EINVAL;
>> +
>> +     fract_digits = strnchr(buf, len, '\n') - strnchr(buf, len, '.') - 1;
>> +
>> +     switch (fract_digits) {
>> +     case 6: /* IIO_VAL_INT_PLUS_MICRO */
>> +             fract_mult = 100000;
>> +             break;
>> +     case 9: /* IIO_VAL_INT_PLUS_NANO */
>> +             fract_mult = 100000000;
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>>        if (buf[0] == '-') {
>>                negative = true;
>>                buf++;
>>        }
>> +
>>        while (*buf) {
>>                if ('0'<= *buf&&  *buf<= '9') {
>>                        if (integer_part)
>>                                integer = integer*10 + *buf - '0';
>>                        else {
>> -                             micro += micro_mult*(*buf - '0');
>> -                             if (micro_mult == 1)
>> +                             fract += fract_mult*(*buf - '0');
>> +                             if (fract_mult == 1)
>>                                        break;
>> -                             micro_mult /= 10;
>> +                             fract_mult /= 10;
>>                        }
>>                } else if (*buf == '\n') {
>>                        if (*(buf + 1) == '\0')
>> @@ -448,11 +463,11 @@ static ssize_t iio_write_channel_info(struct device *dev,
>>                if (integer)
>>                        integer = -integer;
>>                else
>> -                     micro = -micro;
>> +                     fract = -fract;
>>        }
>>
>>        ret = indio_dev->info->write_raw(indio_dev, this_attr->c,
>> -                                      integer, micro, this_attr->address);
>> +                                      integer, fract, this_attr->address);
>>        if (ret)
>>                return ret;
>>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
