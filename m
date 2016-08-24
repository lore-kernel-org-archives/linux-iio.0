Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0093.outbound.protection.outlook.com ([104.47.2.93]:50395
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752389AbcHXLWT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Aug 2016 07:22:19 -0400
Subject: Re: [PATCH 2/2] iio: gyro: Add driver for the MPU-3050 gyroscope
To: <jic23@jic23.retrosnub.co.uk>
References: <1471286287-25074-1-git-send-email-linus.walleij@linaro.org>
 <53008712-7c50-79db-07ab-3544902887e1@kernel.org>
 <285e7c3f-eedb-28ed-f651-926260d17a8a@axentia.se>
 <c45a4c34d8c980d20e790741f33961f7@jic23.retrosnub.co.uk>
CC: Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-iio@vger.kernel.org>, Nick Vaccaro <nvaccaro@google.com>,
        Ge Gao <ggao@invensense.com>, Anna Si <asi@invensense.com>,
        Nathan Royer <nroyer@invensense.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <ed7493a1-37e4-2291-c66e-11cb97b6e5e3@axentia.se>
Date: Wed, 24 Aug 2016 10:49:54 +0200
MIME-Version: 1.0
In-Reply-To: <c45a4c34d8c980d20e790741f33961f7@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

[CC'd linux-i2c@ and Wolfram Sang as the branch might end up with him]

On 2016-08-23 16:38, jic23@jic23.retrosnub.co.uk wrote:
> On 23.08.2016 09:37, Peter Rosin wrote:
>> On 2016-08-21 20:32, Jonathan Cameron wrote:
>>> On 15/08/16 19:38, Linus Walleij wrote:
>>>> Since the MPU-3050 has an outgoing I2C port it needs to act as
>>>> an I2C mux. This means that the device is switching I2C traffic
>>>> to devices beyond it. On my system this is the only way to reach
>>>> the accelerometer. The "sensor fusion" ability of the MPU-3050
>>>> to directly talk to the device on the outgoing I2C port is
>>>> currently not used by the driver, but it has code to allow I2C
>>>> traffic to pass through so that the Linux kernel can reach the
>>>> device on the other side with a kernel driver.
>>> Cc'd Peter Rosin as he's maintaining the i2c mux code now.
>>
>> The i2c-mux handling looks sane, with the current code, but I had
>> an update in mind for the next merge window that affects this:
>>
>> [PATCH v2 0/8] devicetree cleanup for i2c muxes/arbs/gates
>> https://lkml.org/lkml/2016/8/15/569
>>
>> Specifically patch 3/8 is relevant
>>
>> [PATCH v2 3/8] dt-bindings: i2c: add support for 'i2c-gate' subnode
>> https://lkml.org/lkml/2016/8/15/270
>>
>> (implemented in 5/7)
>>
>> The above is not in next (yet). I don't know how this situation is
>> best handled?
>>
>> Cheers,
>> Peter
> Hmm. Depends a bit on timing.  The merge window close for IIO is in
> perhaps 3 weeks time.  If this driver isn't ready reasonably quickly
> I'll probably hold it for next window anyway.
> 
> If we do want to do the mux stuff and this in the same window then
> the standard trick is a branch with just the relevant patches that
> are the dependency in it and we both merge that into our trees.
> Key thing is that we then don't touch this branch at all.
> 
> Git then sorts the mess out just fine when that works it's way to
> Linus.  The two trees will have the same commit id's for the patches
> so he'll get them via which ever tree he merges first.

Ok, but if the driver is ready in time, then this i2c-mux-dt-branch
needs to have soaked in next for at least a week before we start
relying on it. No?

Therefore, I better prepare the i2c-mux-dt-branch right away so that
there is also time to make use of it. My plan is that I make the branch
in the i2c-mux repo, then get it added to next somehow for soaking. I
do not currently have a branch registered to be included in next, and I
know it's just a matter of asking, but it seems rather pointless to add
one just for this one-off occurrence? And since my series is closer to
i2c than it is to iio, it feels righter to have it soak in next via the
i2c tree.

Wolfram, is that ok with you? Or should I just bite the bullet and ask
Stephen to include a brand new for-next branch from the i2c-mux repo
instead?

And a final question before I start with the i2c-mux-dt-branch; Is any
base better than any other for it? I know i2c/for-next is based on
v4.8-rc3 (at least currently, but I don't think Wolfram rebases
willy-nillilly). So, would v4.8-rc3 be ok as a base for everyone?

Cheers,
Peter

