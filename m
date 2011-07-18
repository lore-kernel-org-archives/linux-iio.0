Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:50450 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab1GRPMD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2011 11:12:03 -0400
Message-ID: <4E244D45.7010306@cam.ac.uk>
Date: Mon, 18 Jul 2011 16:12:05 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH 2/2] iio: adc: New driver for AD7280A Lithium Ion Battery
 Monitoring System
References: <1310734743-2623-1-git-send-email-michael.hennerich@analog.com> <1310734743-2623-2-git-send-email-michael.hennerich@analog.com> <4E241C45.5090902@cam.ac.uk> <4E242BA8.8020006@analog.com> <4E242D8C.8080300@cam.ac.uk> <4E2436E0.9060501@analog.com> <4E244C00.5090701@analog.com>
In-Reply-To: <4E244C00.5090701@analog.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/18/11 16:06, Michael Hennerich wrote:
> On 07/18/2011 03:36 PM, Michael Hennerich wrote:
>> On 07/18/2011 02:56 PM, Jonathan Cameron wrote:
>>> On 07/18/11 13:48, Michael Hennerich wrote:
>>>> On 07/18/2011 01:43 PM, Jonathan Cameron wrote:
>>>>> On 07/15/11 13:59, michael.hennerich@analog.com wrote:
>>>>>
>>> ...
>>>>>> +static irqreturn_t ad7280_event_handler(int irq, void *private)
>>>>>> +{
>>>>>> +     struct iio_dev *dev_info = private;
>>>>>> +
>>>>>> +     iio_push_event(dev_info, 0,
>>>>>> +                    IIO_UNMOD_EVENT_CODE(IIO_IN,
>>>>>> +                                         0,
>>>>>> +                                         IIO_EV_TYPE_THRESH,
>>>>>> +                                         IIO_EV_DIR_EITHER),
>>>>>> +                    iio_get_time_ns());
>>>>> You have thresholds for temp and voltage below, but only voltage
>>>>> event. I wonder if the right thing here is to issue two events
>>>>> (subject to what is enabled).  If everything is turned on, there
>>>>> doesn't seem to be anyway to tell what happened.  If the event
>>>>> is consistent, I guess you could write a strobe function that would
>>>>> enable events up the chain and see when it kicked in. That would
>>>>> tell you where it came from.  No idea if one ever wants to know though.
>>>> Alternatively I could read all channels in the stack and compare
>>>> against the set thresholds. I think that would make the most sense here.
>>> Good point. That's much simpler.
>>>
> Actually - I remember why I didn't do that in the first place.
> The bits reserved in IIO_EVENT_CODE for the number are not enough.
Fair enough.  Then we need to fix that.  What is the maximum number you need?
