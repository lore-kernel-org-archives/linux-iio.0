Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34812 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431AbbEWUKv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 May 2015 16:10:51 -0400
Received: by pdbki1 with SMTP id ki1so1572433pdb.1
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2015 13:10:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Back porting bmg160 driver to 3.10.9 kernel
From: Oliver King-Smith <oliverks@elementalsemi.com>
In-Reply-To: <55603F40.2030709@metafoo.de>
Date: Sat, 23 May 2015 13:10:47 -0700
Cc: Rich.Surprenant@nuvation.com
Message-Id: <3866038E-173B-4183-821F-C03986D24A7A@elementalsemi.com>
References: <435F7C92-8E78-4BF9-8477-2032CE54AD04@elementalsemi.com> <55603F40.2030709@metafoo.de>
To: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> On May 23, 2015, at 1:50 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> On 05/22/2015 08:31 PM, Oliver King-Smith wrote:
>> I am trying to back port the bmg160 driver to the 3.10.9 kernel to work on an Android 4.4.x device.
>> 
>> The API for in ii_info has changed quite a bit between the 3.18 and the 3.10 kernel.  So this function won’t compile
>> 
>> static int bmg160_read_event(struct iio_dev *indio_dev,
>>                              const struct iio_chan_spec *chan,
>>                              enum iio_event_type type,
>>                              enum iio_event_direction dir,
>>                              enum iio_event_info info,
>>                              int *val, int *val2)
>> {
>>         struct bmg160_data *data = iio_priv(indio_dev);
>> 
>>         *val2 = 0;
>>         switch (info) {
>>         case IIO_EV_INFO_VALUE:
>>                 *val = data->slope_thres & BMG160_SLOPE_THRES_MASK;
>>                 break;
>>         default:
>>                 return -EINVAL;
>>         }
>> 
>>         return IIO_VAL_INT;
>> }
>> 
>> The 3.10 prototype for this function is
>>         int (*read_event_value)(struct iio_dev *indio_dev,
>>                                 u64 event_code,
>>                                 int *val);
>> 
>> My question is what does IIO_EV_INFO_VALUE map to in the old event_code in the 3.10.9 kernel
> 
> Nothing. With the old API events could only have values and no other attributes.
I may be miss interpreting this, but my read is I should just ignore the event_code and set val to
                *val = data->slope_thres & BMG160_SLOPE_THRES_MASK;

Does that seem reasonable?
> 
> - Lars
> 

