Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38151 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbbA1U1z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jan 2015 15:27:55 -0500
In-Reply-To: <CAE1zotLxq0E+aOpCHnT=MrpRxmcFyDRe816xjMG4ntOV+DL0ZQ@mail.gmail.com>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com> <1419122556-8100-9-git-send-email-octavian.purdila@intel.com> <54A96BF4.303@kernel.org> <CAE1zotLxq0E+aOpCHnT=MrpRxmcFyDRe816xjMG4ntOV+DL0ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v2 08/11] iio: bmc150: introduce bmc150_accel_interrupt
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 28 Jan 2015 13:20:22 +0000
To: Octavian Purdila <octavian.purdila@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <A0167C26-04DA-4F34-AA3E-788439809449@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 28 January 2015 11:09:46 GMT+00:00, Octavian Purdila <octavian.purdila@intel.com> wrote:
>On Sun, Jan 4, 2015 at 6:36 PM, Jonathan Cameron <jic23@kernel.org>
>wrote:
>> On 21/12/14 00:42, Octavian Purdila wrote:
>>> Since both triggers and events can share an interrupt, add a data
>>> structure that tracks the users of an interrupt so that it enables
>or
>>> disables it only for the first users and respectively last user.
>>>
>>> This will allows us to easily add more events or triggers.
>>>
>>> The patch also adds an interrupt enabled counter, so that we can
>>> easily know if we need to put the device in normal mode when the
>>> resume callback is issued.
>>>
>>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>> This is probably the cleanest way of doing this, but an alternative
>is
>> to register an interrupt chip and then you can have each interrupt
>source
>> (internal to the device) have it's own interrupt and register as if
>> it had direct access (rather than having to read what interrupt
>occured
>> first).  This is the preferred method these days for MFDs where this
>> tree structure of interrupts is common.
>>
>> I think that would result in slightly more code though, so perhaps
>this
>> local version of some of that infrastructure is fine.
>>
>
>Good to know about the interrupt chip approach. I also think in this
>case the local version is better.
>
>But if we see a common pattern across multiple drivers, perhaps we can
>add the interrupt chip to the IIO core for those drivers that want to
>make use of it. I'll take a look, but on the top of your head, do you
>know of any drivers for this would be useful?
I doubt it would generalise in a useful way.
The code needed is pretty compact and mostly very part specific.
Note the triggers in iio are already using this approach but there the purpose is a bit different. We always want to interrupt all children who are ready...
>
>>> ---
>>>  drivers/iio/accel/bmc150-accel.c | 87
>+++++++++++++++++++++-------------------
>>>  1 file changed, 45 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/bmc150-accel.c
>b/drivers/iio/accel/bmc150-accel.c
>>> index aaad2fb..7c905f6 100644
>>> --- a/drivers/iio/accel/bmc150-accel.c
>>> +++ b/drivers/iio/accel/bmc150-accel.c
>>> @@ -151,10 +151,19 @@ struct bmc150_accel_interrupt_info {
>>>       u8 en_bitmask;
>>>  };
>>>
>>> +struct bmc150_accel_interrupt {
>>> +     struct bmc150_accel_interrupt_info *info;
>>> +     atomic_t users;
>>> +};
>>> +
>>> +#define BMC150_ACCEL_INTERRUPTS              2
>>> +
>>>  struct bmc150_accel_data {
>>>       struct i2c_client *client;
>>> +     struct bmc150_accel_interrupt
>interrupts[BMC150_ACCEL_INTERRUPTS];
>>>       struct iio_trigger *dready_trig;
>>>       struct iio_trigger *motion_trig;
>>> +     atomic_t active_intr;
>>>       struct mutex mutex;
>>>       s16 buffer[8];
>>>       u8 bw_bits;
>>> @@ -436,7 +445,8 @@ static int bmc150_accel_set_power_state(struct
>bmc150_accel_data *data, bool on)
>>>  }
>>>  #endif
>>>
>>> -static struct bmc150_accel_interrupt_info bmc150_accel_interrupts[]
>= {
>>> +static struct bmc150_accel_interrupt_info
>> Just noticed. Should this not also be const?
>>> +bmc150_accel_interrupts[BMC150_ACCEL_INTERRUPTS] = {
>
>Yes indeed, fixed.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
