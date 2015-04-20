Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:24574 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbbDTVJk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2015 17:09:40 -0400
Message-ID: <55356A64.70909@imgtec.com>
Date: Mon, 20 Apr 2015 18:06:44 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Module get needed for iio_channel_get and friends
References: <552EC350.2000506@imgtec.com> <55351604.4000808@metafoo.de>
In-Reply-To: <55351604.4000808@metafoo.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 04/20/2015 12:06 PM, Lars-Peter Clausen wrote:
> On 04/15/2015 10:00 PM, Ezequiel Garcia wrote:
>> Jonathan, Lars:
>>
>> I've noticed that iio_channel_{get, get_all} don't call try_module_get
>> on the module associated to the indio_dev.
>>
>> This means that an IIO driver can be removed while having a consumer for
>> any of its channels.
> 

> The device can still be unbound from the driver, even if you pin the
> module. E.g. device hot-unplug.
> 

Hmm.. right.

>>
>> If each channel can have a completely different indio_dev, this means we
>> need to increase the refcount of the module on each indio_dev, right?
>>
> 
> I think we already handle this correctly. The device ref-count is
> incremented when a channel is requested. This means even when the device
> is unbound from the driver it will stay around until the channel is
> freed and the final reference is dropped. At the same time we set the
> info field of the IIO device to NULL when the driver is unbound from the
> driver and in iio_write_channel_raw() return -ENODEV when the info field
> is NULL.
> 

Oh, I see.

So this means there's no way to prevent an IIO driver/device from being
removed/unbinded if an IIO channel has been requested.

Somehow I thought the kernel was supposed to prevent such things, but
guess I was wrong.

Thanks,
-- 
Ezequiel
