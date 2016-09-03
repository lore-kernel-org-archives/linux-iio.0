Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45348 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752851AbcICQsI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 12:48:08 -0400
Subject: Re: [PATCH v1 3/3] iio:pressure: initial zpa2326 barometer support
To: Gregor Boirie <gregor.boirie@parrot.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <cover.1472050374.git.gregor.boirie@parrot.com>
 <a16becf5ac0ac811a993a26de32a0d41f3eb4ffa.1472050374.git.gregor.boirie@parrot.com>
 <alpine.DEB.2.02.1608242115340.4077@pmeerw.net> <57BF0488.4000902@parrot.com>
 <8a47f701-1cff-7c5c-639b-ec2258c62025@kernel.org>
 <57C5B1C4.8090509@parrot.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <23014ac9-04e2-7cc1-eb07-195aacfec0ac@kernel.org>
Date: Sat, 3 Sep 2016 17:46:39 +0100
MIME-Version: 1.0
In-Reply-To: <57C5B1C4.8090509@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/08/16 17:18, Gregor Boirie wrote:
> 
> 
> On 08/29/2016 09:01 PM, Jonathan Cameron wrote:
>> On 25/08/16 15:45, Gregor Boirie wrote:
>>> Answers inline
>>>
>>> On 08/25/2016 08:34 AM, Peter Meerwald-Stadler wrote:
>>>
>>>>> +
>>>>> +    zpa_init_runtime(slave);
>>>>> +
>>>>> +    err = devm_iio_device_register(slave, indio_dev);
>>>> can't use devm_ register if there is a non-empty remove()
>>> Removal hooks are registered onto bus specific devices not onto
>>> IIO ones. Enabling devm debug outputs a removal flow trace that
>>> seems correct. Is this really wrong ?
>> Yes.  The unwind of devm_iio_device_register will occur after the
>> whatever is in the remove function.  As devm_iio_device_unregister
>> is responsible for removal of the userspace and other interfaces
>> until that happens they are still present.
>>
>> Hence whilst a remove is going on the device can be powered
>> down but the interfaces still exposed.  A read at that point
>> is going to cause some an error to occur.
>>
>> Hence, using the devm form is fine if everything else is
>> handled automatically, i.e. there is nothing in remove.
>> Otherwise, you almost always have a race condition.
>>
>> It's a minor one given how often people remove modules, but
>> worth cleaning up anyway!
> Got it.
> 
> But something still makes me feel uncomfortable. Shouldn't we ensure the
> bus specific driver (i.e., zpa2326_i2c or zpa2326_spi in this case) be refcounted
> upon entry into the IIO layer ? Using try_module_get()/module_put() would :
> * prevent any attempt to remove module while being used
> * prevent any attempt to use module while it is going away.
> 
> I'm not quite sure here because of possible race conditions however (feels like
> mixing devm_ and module layers).
> 
> Anyway, it seems quite strange module removal succeeds despite being under use
> by userspace. This leads to inconsistent system state where userspace process
> gets stuck in poll syscall, waiting for data that will never come since modprobing
> module again will in the end allocate an new IIO device, etc...
In theory it should all unwind fine.  Lars spent a while some time
ago hammering this stuff with some test scripts and getting all
the fall overs to happen. It should wake up the poll in the
device_unregister and subsequent read should give an error to
say the device has gone away.

Do you have a particular case where it gets stuck?

It's effectively impossible to prevent a device going away when
userspace is using it.  The module_get, module_put makes it
slightly less likely, but unfortunately some sensors can simply
be pulled from a usb port or similar or a remove forced from
userspace.

Jonathan
> 
> confused,
> Grégor.
> 
>>
>> Jonathan
>>> Many thanks for the review. Regards,
>>> Greg.
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

