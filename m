Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34849 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966172AbcKLNN6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 08:13:58 -0500
Subject: Re: [PATCH 1/2] iio: bmi160: Support hardware fifo
To: Marcin Niestroj <m.niestroj@grinn-global.com>
References: <20161103112527.29623-1-m.niestroj@grinn-global.com>
 <b7dd5694-b757-c0d1-3400-46e92b8deb58@kernel.org>
 <1d50ebf1-2f14-2e3f-9b8e-b34a7ebca4c5@grinn-global.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0c4ef1f6-dcac-3025-3f54-dc1aae425ad6@kernel.org>
Date: Sat, 12 Nov 2016 13:13:52 +0000
MIME-Version: 1.0
In-Reply-To: <1d50ebf1-2f14-2e3f-9b8e-b34a7ebca4c5@grinn-global.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/16 14:52, Marcin Niestroj wrote:
> Hi,
> Thanks for review. I agree with all of the comments and will fix these in next patch version. Below is just a comment on hwfifo_* sysfs access.
> 
> On 06.11.2016 13:35, Jonathan Cameron wrote:
>> On 03/11/16 11:25, Marcin Niestroj wrote:
>>> This patch was developed primarily based on bmc150_accel hardware fifo
>>> implementation.
>>>
>>> IRQ handler was added, which for now is responsible only for handling
>>> watermark interrupts. The BMI160 chip has two interrupt outputs. By
>>> default INT is considered to be connected. If INT2 is used instead, the
>>> interrupt-names device-tree property can be used to specify that.
>>>
>>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
>> I agree with Peter that there should have been a few precursor patches
>> to this one doing various cleanups and reworking bits that you have
>> in here.  Would have made it easier to review (always a good thing :)
>>
>> In general the resulting code looks good to me.  A few little
>> additional comments inline from me.  Mostly about small code ordering things
>> and function rename suggestions that would make the code more 'obviously'
>> correct.
>>
>> Thanks,
>>
>> Jonathan
>>> ---
>>>  drivers/iio/imu/bmi160/bmi160.h      |   3 +-
>>>  drivers/iio/imu/bmi160/bmi160_core.c | 633 +++++++++++++++++++++++++++++++++--
>>>  drivers/iio/imu/bmi160/bmi160_i2c.c  |   7 +-
>>>  drivers/iio/imu/bmi160/bmi160_spi.c  |   3 +-
>>>  4 files changed, 618 insertions(+), 28 deletions(-)
> 
> <snip>
> 
>>> +
>>> +static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
>>> +static IIO_CONST_ATTR(hwfifo_watermark_max,
>>> +              __stringify(BMI160_FIFO_LENGTH));
>>> +static IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO,
>>> +               bmi160_get_fifo_state, NULL, 0);
>>> +static IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO,
>>> +               bmi160_get_fifo_watermark, NULL, 0);
>>> +
>>> +static const struct attribute *bmi160_fifo_attributes[] = {
>>> +    &iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
>>> +    &iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
>>> +    &iio_dev_attr_hwfifo_watermark.dev_attr.attr,
>>> +    &iio_dev_attr_hwfifo_enabled.dev_attr.attr,
>> There are enough of these drivers now that sometimes soon we should
>> revisit the question of pulling these into the core.  Can certainly
>> concieve of downstream consumer devices (in particular the iio_input
>> bridge when that finally resurfaces - my fault) wanting to be able to
>> manipulate or at least have visibilty of these.
> 
> One more thing to consider is setting hwfifo_watermark to other value
> than "userspace" watermark. It would be nice to set hwfifo_watermark
> to a *safe* value to be able to get all data from hardware to kfifo.
> By safe I mean that the chance of hardware fifo overflow will be
> small. On the other hand there might be no reason to have such small
> watermark for userspace application, so we can save scheduler
> cycles.
> 
This may be worth doing, but I worry we'll end up with too many knobs
around this feature.  Ultimately there is no point in setting the hardware
fifo as smaller than the userspace one if the userspace one is small enough.

What counts as a safe level is going to be very hardware / load dependant.
We 'could' try and put this in the devicetree so that a particular setup
could set it at a level that is 'reasonable'.  It's kind of a hardware
feature, but will also depend on software constraints (like whether the
bus controller driver can support dma for example).

Non obvious unfortunately. 

Jonathan
> <snip>
> 

