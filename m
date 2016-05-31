Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45804 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574AbcEaVFi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 31 May 2016 17:05:38 -0400
In-Reply-To: <CAKzfze9GaZDt8_ZPpXBhYwMHt4h2vQqNoT7hduhGp+znZg11Gw@mail.gmail.com>
References: <1464576722-6902-1-git-send-email-mranostay@gmail.com> <CAKzfze9usfXfL=MpbFJOCcfgGXYbkN6bvykC1jXs3ebEsaioqA@mail.gmail.com> <20160531174521.GA2841@d830.WORKGROUP> <CAKzfze9GaZDt8_ZPpXBhYwMHt4h2vQqNoT7hduhGp+znZg11Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: hudmidity: hdc100x: fix incorrect shifting and scaling
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 31 May 2016 22:05:32 +0100
To: Matt Ranostay <mranostay@gmail.com>,
	Alison Schofield <amsfield22@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <32FA8DE3-B686-42E9-90C9-39A888C34C51@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 31 May 2016 19:57:26 BST, Matt Ranostay <mranostay@gmail.com> wrote:
>On Tue, May 31, 2016 at 10:45 AM, Alison Schofield
><amsfield22@gmail.com> wrote:
>> On Sun, May 29, 2016 at 07:53:08PM -0700, Matt Ranostay wrote:
>>> Alison,
>>>
>>> Can you give a Tested-by:  since I don't own this sensor anymore.
>>>
>>> Thanks,
>>>
>>> Matt
>>
>> Tested it.  Verified temp & humidty calcs.  Looks great!
>>
>> And, (seeing a pattern here ;)) this comes with another question,
>> probably directed a Jonathan...
>>
>> with regards to temperature calculations:
>>
>> Datasheets give numbers for this method:
>>         temp = ((raw * scale) + offset)
>> IIO drivers report numbers for this method:
>>         temp = ((raw + offset) * scale)
>>
>We do it this way in iio.. hence why the offset needs the scaling
>value applied to it.
>
>> I've figured out the math for translating between them and creating
>> the offset for the driver to report in sysfs, but don't know why we
>> are doing that. 'Our' way seems kind of ugly. For example, for
>HDC1008
>> the offset is -40. It's the minimum expected temp value. But, we
>munge
>> it to be -15887.515151 so we can apply it before scaling.
>>
>> Why do we do it this way in IIO?
It is very device dependant or more correctly very data sheet dependant. By coincidence a
 lot of early IIO drivers were for parts that had it the other way around so we ended
 up with that. A classic example is a differential ADC that does an offset
 rather than 2's complement. Those are much neater offset first.

So six of one and half a dozen of the other...

Jonathan 




>>
>> alisons
>>
>>>
>>> On Sun, May 29, 2016 at 7:52 PM, Matt Ranostay <mranostay@gmail.com>
>wrote:
>>> > Shifting sensor data to the right 2 bits was incorrect and caused
>the
>>> > scaling values + offsets to be invalid.
>>> >
>>> > Reported-by: Alison Schofield <amsfield22@gmail.com>
>>> > Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>>> > ---
>>> >  drivers/iio/humidity/hdc100x.c | 16 ++++++++--------
>>> >  1 file changed, 8 insertions(+), 8 deletions(-)
>>> >
>>> > diff --git a/drivers/iio/humidity/hdc100x.c
>b/drivers/iio/humidity/hdc100x.c
>>> > index 3070983..a03832a 100644
>>> > --- a/drivers/iio/humidity/hdc100x.c
>>> > +++ b/drivers/iio/humidity/hdc100x.c
>>> > @@ -164,14 +164,14 @@ static int hdc100x_get_measurement(struct
>hdc100x_data *data,
>>> >                 dev_err(&client->dev, "cannot read high byte
>measurement");
>>> >                 return ret;
>>> >         }
>>> > -       val = ret << 6;
>>> > +       val = ret << 8;
>>> >
>>> >         ret = i2c_smbus_read_byte(client);
>>> >         if (ret < 0) {
>>> >                 dev_err(&client->dev, "cannot read low byte
>measurement");
>>> >                 return ret;
>>> >         }
>>> > -       val |= ret >> 2;
>>> > +       val |= ret;
>>> >
>>> >         return val;
>>> >  }
>>> > @@ -212,17 +212,17 @@ static int hdc100x_read_raw(struct iio_dev
>*indio_dev,
>>> >         case IIO_CHAN_INFO_SCALE:
>>> >                 if (chan->type == IIO_TEMP) {
>>> >                         *val = 165000;
>>> > -                       *val2 = 65536 >> 2;
>>> > +                       *val2 = 65536;
>>> >                         return IIO_VAL_FRACTIONAL;
>>> >                 } else {
>>> > -                       *val = 0;
>>> > -                       *val2 = 10000;
>>> > -                       return IIO_VAL_INT_PLUS_MICRO;
>>> > +                       *val = 100;
>>> > +                       *val2 = 65536;
>>> > +                       return IIO_VAL_FRACTIONAL;
>>> >                 }
>>> >                 break;
>>> >         case IIO_CHAN_INFO_OFFSET:
>>> > -               *val = -3971;
>>> > -               *val2 = 879096;
>>> > +               *val = -15887;
>>> > +               *val2 = 515151;
>>> >                 return IIO_VAL_INT_PLUS_MICRO;
>>> >         default:
>>> >                 return -EINVAL;
>>> > --
>>> > 2.7.4
>>> >

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
