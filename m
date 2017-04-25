Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0118.outbound.protection.outlook.com ([104.47.2.118]:18434
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1948523AbdDYO4G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Apr 2017 10:56:06 -0400
Subject: Re: [PATCH v14 00/11] mux controller abstraction and iio/i2c muxes
To: Philipp Zabel <p.zabel@pengutronix.de>
References: <1493022995-16917-1-git-send-email-peda@axentia.se>
 <1493031179.2446.9.camel@pengutronix.de>
 <2d978956-d247-917d-4150-a6723917a733@axentia.se>
 <1493043046.2446.37.camel@pengutronix.de>
 <6fb34ea5-edc8-c7aa-1d49-f6ce1d33a2d4@axentia.se>
 <1493045969.2446.47.camel@pengutronix.de>
 <f74d5619-8614-d003-3c70-710aee0b550b@axentia.se>
CC: Jonathan Cameron <jic23@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <kernel@pengutronix.de>
From: Peter Rosin <peda@axentia.se>
Message-ID: <e53bbf82-793f-b22f-2e9b-4bd377446351@axentia.se>
Date: Tue, 25 Apr 2017 16:55:48 +0200
MIME-Version: 1.0
In-Reply-To: <f74d5619-8614-d003-3c70-710aee0b550b@axentia.se>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-25 16:16, Peter Rosin wrote:
> On 2017-04-24 16:59, Philipp Zabel wrote:
>> On Mon, 2017-04-24 at 16:36 +0200, Peter Rosin wrote:
>> [...]
>>>> How about an atomic use_count on the mux_control, a bool shared that is
>>>> only set by the first consumer, and controls whether selecting locks?
>>>
>>> That has the drawback that it is hard to restore the mux-control in a safe
>>> way so that exclusive consumers are allowed after the last shared consumer
>>> puts the mux away.
>>
>> True.
>>
>>> Agreed, it's a corner case, but I had this very similar
>>> patch going through the compiler when I got this mail. Does it work as well
>>> as what you suggested?
>>
>> Yes, this patch works just as well.
> 
> Right, as expected :-) However, I don't like it much. It divides the mux
> consumers into two camps in a way that makes it difficult to select which
> camp a consumer should be in.
> 
> E.g. consider the iio-mux. The current implementation only supports quick
> accesses that fit the mux_control_get_shared case. But if that mux in the
> future needs to grow continuous buffered accesses, I think there will be
> pressure to switch it over to the exclusive mode. Because that is a lot
> closer to what you are doing with the video-mux. And then what? It will be
> impossible to predict if the end user is going to use buffered accesses or
> not...
> 
> So, I think the best approach is to skip the distinction between shared
> and exclusive consumers and instead implement the locking with an ordinary
> semaphore (instead of the old rwsem or the current mutex). Semaphores don't
> have the property that the same task should down/up them (mutexes require
> that for lock/unlock, and is also the reason for the lockdep complaint) and
> thus fits better for long-time use such as yours or the above iio-mux with
> buffered accesses. It should also hopefully be cheaper that an rwsem, and
> not have any downgrade_write calls thus possibly keeping Greg sufficiently
> happy...
> 
> Sure, consumers can still dig themselves into a hole by not calling deselect
> as they should, but at least I think it can be made to work w/o dividing the
> consumers...

Like this (only compile-tested). Philipp, it should work the same as with
the rwsem in v13 and earlier. At least for your case...

Cheers,
peda

diff --git a/drivers/mux/mux-core.c b/drivers/mux/mux-core.c
index c02fa4dd2d09..f99b70d4e319 100644
--- a/drivers/mux/mux-core.c
+++ b/drivers/mux/mux-core.c
@@ -116,7 +116,7 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
                struct mux_control *mux = &mux_chip->mux[i];

                mux->chip = mux_chip;
-               mutex_init(&mux->lock);
+               sema_init(&mux->lock, 1);
                mux->cached_state = MUX_CACHE_UNKNOWN;
                mux->idle_state = MUX_IDLE_AS_IS;
        }
@@ -372,12 +372,14 @@ int mux_control_select(struct mux_control *mux, unsigned int state)
 {
        int ret;

-       mutex_lock(&mux->lock);
+       ret = down_killable(&mux->lock);
+       if (ret < 0)
+               return ret;

        ret = __mux_control_select(mux, state);

        if (ret < 0)
-               mutex_unlock(&mux->lock);
+               up(&mux->lock);

        return ret;
 }
@@ -399,13 +401,13 @@ int mux_control_try_select(struct mux_control *mux, unsigned int state)
 {
        int ret;

-       if (!mutex_trylock(&mux->lock))
+       if (down_trylock(&mux->lock))
                return -EBUSY;

        ret = __mux_control_select(mux, state);

        if (ret < 0)
-               mutex_unlock(&mux->lock);
+               up(&mux->lock);

        return ret;
 }
@@ -427,7 +429,7 @@ int mux_control_deselect(struct mux_control *mux)
            mux->idle_state != mux->cached_state)
                ret = mux_control_set(mux, mux->idle_state);

-       mutex_unlock(&mux->lock);
+       up(&mux->lock);

        return ret;
 }
diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index 95269f40670a..43f65f80c275 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -15,7 +15,6 @@

 #include <dt-bindings/mux/mux.h>
 #include <linux/device.h>
-#include <linux/mutex.h>
 #include <linux/semaphore.h>

 struct mux_chip;
@@ -44,7 +43,7 @@ struct mux_control_ops {
  * mux drivers.
  */
 struct mux_control {
-       struct mutex lock; /* protects the state of the mux */
+       struct semaphore lock; /* protects the state of the mux */

        struct mux_chip *chip;
        int cached_state;


