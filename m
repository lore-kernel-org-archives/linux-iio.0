Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52349 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbbDUFw6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2015 01:52:58 -0400
In-Reply-To: <55356A64.70909@imgtec.com>
References: <552EC350.2000506@imgtec.com> <55351604.4000808@metafoo.de> <55356A64.70909@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Module get needed for iio_channel_get and friends
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 21 Apr 2015 06:52:50 +0100
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <1C6A9E97-255A-41E8-BB7D-AB76E2654644@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 20 April 2015 22:06:44 BST, Ezequiel Garcia <ezequiel.garcia@imgtec.com> wrote:
>
>
>On 04/20/2015 12:06 PM, Lars-Peter Clausen wrote:
>> On 04/15/2015 10:00 PM, Ezequiel Garcia wrote:
>>> Jonathan, Lars:
>>>
>>> I've noticed that iio_channel_{get, get_all} don't call
>try_module_get
>>> on the module associated to the indio_dev.
>>>
>>> This means that an IIO driver can be removed while having a consumer
>for
>>> any of its channels.
>> 
>
>> The device can still be unbound from the driver, even if you pin the
>> module. E.g. device hot-unplug.
>> 
>
>Hmm.. right.
>
>>>
>>> If each channel can have a completely different indio_dev, this
>means we
>>> need to increase the refcount of the module on each indio_dev,
>right?
>>>
>> 
>> I think we already handle this correctly. The device ref-count is
>> incremented when a channel is requested. This means even when the
>device
>> is unbound from the driver it will stay around until the channel is
>> freed and the final reference is dropped. At the same time we set the
>> info field of the IIO device to NULL when the driver is unbound from
>the
>> driver and in iio_write_channel_raw() return -ENODEV when the info
>field
>> is NULL.
>> 
>
>Oh, I see.
>
>So this means there's no way to prevent an IIO driver/device from being
>removed/unbinded if an IIO channel has been requested.
>
>Somehow I thought the kernel was supposed to prevent such things, but
>guess I was wrong.
>
>Thanks,
The easy way of understanding it can't do this is with USB devices. No way the kernel
can stop you unplugging them!

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
