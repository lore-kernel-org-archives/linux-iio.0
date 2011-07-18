Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E243980.6040307@analog.com>
Date: Mon, 18 Jul 2011 15:47:44 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Subject: Re: [PATCH 2/2] iio: adc: New driver for AD7280A Lithium Ion Battery
 Monitoring System
References: <1310734743-2623-1-git-send-email-michael.hennerich@analog.com> <1310734743-2623-2-git-send-email-michael.hennerich@analog.com> <4E241C45.5090902@cam.ac.uk> <4E242BA8.8020006@analog.com> <4E242D8C.8080300@cam.ac.uk> <4E2436E0.9060501@analog.com> <4E243822.6020204@cam.ac.uk>
In-Reply-To: <4E243822.6020204@cam.ac.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/18/2011 03:41 PM, Jonathan Cameron wrote:
>>>>>> +
>>>>>> +static int ad7280_read_raw(struct iio_dev *dev_info,
>>>>>> +                        struct iio_chan_spec const *chan,
>>>>>> +                        int *val,
>>>>>> +                        int *val2,
>>>>>> +                        long m)
>>>>>> +{
>>>>>> +     struct ad7280_state *st = iio_priv(dev_info);
>>>>>> +     unsigned int scale_uv;
>>>>>> +     int ret;
>>>>>> +
>>>>>> +     switch (m) {
>>>>>> +     case 0:
>>>>>> +             mutex_lock(&dev_info->mlock);
>>>>>> +             switch (chan->type) {
>>>>>> +             case IIO_IN:
>>>>>> +                     ret = ad7280_read_channel(st, chan->address>>    8,
>>>>>> +                                               chan->address&    0xFF);
>>>>>> +                     break;
>>>>>> +             case IIO_IN_DIFF:
>>>>>> +                     ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
>>>>> Err... Really need some explanation for what this channel is!
>>>> Voltage across all cells.
>>> Fair enough. So are the other voltages not differential as well? (across a given
>>> cell rather than referred to a base voltage)
>>> ...
>> Yes technically seen they are all differential.
>>
> Any cost in setting them up as such then?
>
> in1-in0
> in2-in1 etc
> +
> inX-in0 for your summed one?
Yes this is already on my to-do list...
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
