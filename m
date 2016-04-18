Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60670 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbcDRT0A (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 15:26:00 -0400
Subject: Re: [PATCH v2 4/5] iio: health: afe4404: use regmap to retrieve
 struct device
To: "Andrew F. Davis" <afd@ti.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <cover.1460314070.git.amsfield22@gmail.com>
 <2dd23e55fa7c2d16c577146eefd4a84046d2b838.1460314070.git.amsfield22@gmail.com>
 <57129101.7000503@kernel.org> <5713D0F8.20303@ti.com>
 <20160418045621.GA2835@d830.WORKGROUP> <571502E6.2090405@ti.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	kgene@kernel.org, k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571534C5.5020903@kernel.org>
Date: Mon, 18 Apr 2016 20:25:57 +0100
MIME-Version: 1.0
In-Reply-To: <571502E6.2090405@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/04/16 16:53, Andrew F. Davis wrote:
> On 04/17/2016 11:56 PM, Alison Schofield wrote:
>> On Sun, Apr 17, 2016 at 01:07:52PM -0500, Andrew F. Davis wrote:
>>> On 04/16/2016 02:22 PM, Jonathan Cameron wrote:
>>>> On 10/04/16 20:07, Alison Schofield wrote:
>>>>> Driver includes struct regmap and struct device in its global data.
>>>>> Remove the struct device and use regmap API to retrieve device info.
>>>>>
>>>
>>> Why? This adds nothing but more code to get dev through some
>>> container_of trickery when we could just keep a dev pointer in the data
>>> structure.
>>>
>>> Andrew
>>
>> Thanks for the review and response.  The why would be for
>> simplification and uniformity across IIO.
>>
> 
> I'm all for simplification and uniformity but I think this will take us
> in the wrong direction, a lot drivers do not use regmap for instance and
> so will need another method to lookup the device struct.
> 
>> I think I see your point in general, but not sure I get your
>> specific concerns with these afe4403/04 drivers.
>>
>> The drivers only use the device struct in probe and then
>> again at device remove time.  At probe, the change no
>> longer stores it in the global data. At remove the
>> regmap_get_device() func is a simple dereference to retrieve
>> the device struct. That's the simplification: we don't carry
>> that ptr in global data waiting for the opportunity to use it
>> at device remove.  We just find it when we need it at device
>> remove.
> 
> A lot of what drivers store in their per-instance data structure is only
> held for use in remove. Using afe4404 as an example trig and irq are
> also only stored for removal. A good driver framework will pass in
> relevant information to the driver callbacks, and so instance data
> structures have gotten very small, for afe4404 only regmap and regulator
> are actually used during runtime currently.
The difference here is that we are handing over the device access to
entirely be via regmap - so to my mind we should probably also hand
over the dev pointer itself (which in fact we are doing anyway) as such
it makes sense to retrieve it from regmap when needed.  Anyhow, whilst
I originally suggested this (in a driver review a while back) it's not
an important issue and can be left to the tastes of individual authors.

Alison, you win some you loose some with this sort of cleanup patch!
In this particular case the fact that it was used as a convenient
place to get hold of it in the probe function made the patch a lot
more 'noisy' than it would otherwise have been.
> 
> The direction that would really be of best simplification would be to
> remove the need for the remove function from these drivers, if
> iio_trigger_register and iio_triggered_buffer_setup had devm_ versions
> (like most other setup functions) everything would automatically be
> cleaned up properly without needing a remove function. Then I would have
> no problem removing the unused device structure pointer, but for now
> their will never be a simpler trick to getting the device pointer than
> simply storing it in the instance data.
Whilst that might be nice.... Actually most devices need to do something
very much device specific in their shutdown - such as turning themselves off
so devm still only takes us so far.  Still I don't mind patches proposing
moving more stuff over to devm - they do help for some devices
(though the devm_iio_device_register still causes me a enough issues in
incorrect usage that I'm doubtful that accepting that one was ever a good
idea!)
> 
>> (Perhaps these devices are getting removed frequently?)
>>
> 
> Quite the opposite, same for many drivers, the remove path is
> dangerously untested in the real world, even more reason it's nice to
> not need remove and let devm_ cleanup for us :)

> 
> Thanks,
> Andrew
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

