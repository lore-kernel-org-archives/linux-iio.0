Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35695 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295AbcENR00 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2016 13:26:26 -0400
Subject: Re: IIO trigger names are not actually unique
To: Lars-Peter Clausen <lars@metafoo.de>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <55b99ca2-21c2-cfc6-b42d-904edb6b217d@intel.com>
 <573052BB.9050504@metafoo.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dc4d6719-ae05-22d8-7455-a1599ac33403@kernel.org>
Date: Sat, 14 May 2016 18:26:21 +0100
MIME-Version: 1.0
In-Reply-To: <573052BB.9050504@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/16 10:04, Lars-Peter Clausen wrote:
> On 05/05/2016 01:52 PM, Crestez Dan Leonard wrote:
>> Hello,
>>
>> I've been looking at trigger code and it seems to me that trigger->name
>> is not guaranteed to be unique. This is despite the fact that it's
>> documented as "@name: [DRIVER] unique name" on top of struct
>> iio_trigger. Just like indio_dev->name it seems to be a mostly cosmetic
>> label.
>>
>> You can easily create a software trigger with a duplicate name if you
>> enable CONFIG_IIO_HRTIMER_TRIGGER:
>>
>> mkdir /sys/kernel/config/iio/triggers/hrtimer/`cat
>> /sys/bus/iio/devices/trigger0/name`
>>
>> It seems that trigger names are set at allocation time, mostly through
>> some variant of:
>>
>>     iio_trigger_alloc("%s-dev%d", indio_dev->name, indio_dev->id);
>>
>> indio_dev->name is not guaranteed to be unique but indio_dev->id is. The
>> are some exceptions, including st_sensors which does:
>>
>>     iio_trigger_alloc("%s-trigger", indio_dev->name);
>>
>> Since indio_dev->name is just the model name it seems that attaching two
>> identical st_sensors devices will create two triggers with the same name.
>>
> 
> Yeah, this is certainly broken.
> 
>> The "current_trigger" for an iio_device is identified by name. If you
>> have two triggers with the same name then the "first one" will be picked
>> up, probably in registration order.
>>
>> One solution would be to refuse to register triggers with duplicate
>> names but that might cause probe errors in some cases.
>>
> 
> Well, it is broken anyway and wont work as expected, which means nobody
> probably ever ran such a configuration, so we might return an error to
> prevent unexpected behavior.
Agreed - I think that would be a safe ABI fix to make.
> 
>> Another option would be to just warn on duplicate names and provide a
>> separate current_trigger_id which identifies the current trigger by
>> numeric ID. In general it seems to me that it's better to identify
>> entities by numbers rather than strings.
> 
> We could support writing triggerX to current_name as an alternative to the
> name to get a unique identifier.
That would also work fine as far as I'm concerned.  Mostly a case of documenting
that case clearly in the ABI docs.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

