Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ve1eur01on0090.outbound.protection.outlook.com ([104.47.1.90]:48584
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1762553AbdDSMBE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Apr 2017 08:01:04 -0400
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
To: Philipp Zabel <p.zabel@pengutronix.de>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-4-git-send-email-peda@axentia.se>
 <1492592817.2970.14.camel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
Message-ID: <da90526b-7274-c52c-07e8-9f0d75cf1cbf@axentia.se>
Date: Wed, 19 Apr 2017 14:00:54 +0200
MIME-Version: 1.0
In-Reply-To: <1492592817.2970.14.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-19 11:06, Philipp Zabel wrote:
> On Thu, 2017-04-13 at 18:43 +0200, Peter Rosin wrote:
>> Add a new minimalistic subsystem that handles multiplexer controllers.
>> When multiplexers are used in various places in the kernel, and the
>> same multiplexer controller can be used for several independent things,
>> there should be one place to implement support for said multiplexer
>> controller.
>>
>> A single multiplexer controller can also be used to control several
>> parallel multiplexers, that are in turn used by different subsystems
>> in the kernel, leading to a need to coordinate multiplexer accesses.
>> The multiplexer subsystem handles this coordination.
>>
>> This new mux controller subsystem initially comes with a single backend
>> driver that controls gpio based multiplexers. Even though not needed by
>> this initial driver, the mux controller subsystem is prepared to handle
>> chips with multiple (independent) mux controllers.
>>
>> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---

*snip*

>> +int mux_control_select(struct mux_control *mux, int state)
> 
> If we let two of these race, ...

The window for this "race" is positively huge. If there are several
mux consumers of a single mux controller, it is self-evident that
if one of them grabs the mux for a long time, the others will suffer.

The design is that the rwsem is reader-locked for the full duration
of a select/deselect operation by the mux consumer.

>> +{
>> +	int ret;
>> +
>> +	if (down_read_trylock(&mux->lock)) {
>> +		if (mux->cached_state == state)
>> +			return 0;
>> +		/* Sigh, the mux needs updating... */
>> +		up_read(&mux->lock);
> 
> ... and both decide the mux needs updating ...
> 
>> +	}
>> +
>> +	/* ...or it's just contended. */
>> +	down_write(&mux->lock);
> 
> ... then the last to get to down_write will just wait here forever (or
> until the first consumer calls mux_control_deselect, which may never
> happen)?

It is vital that the mux consumer call _deselect when it is done with
the mux. Not doing so will surely starve out any other mux consumers.
The whole thing is designed around the fact that mux consumers should
deselect the mux as soon as it's no longer needed.

It's simply not possible to share something as fundamental as a mux
without some cooperation. It's not like suffering mux consumers can
go off and use some other mux, and it's also not possible for a
"competing" mux consumer to just clobber the mux state.

>> +
>> +	if (mux->cached_state == state) {
>> +		/*
>> +		 * Hmmm, someone else changed the mux to my liking.
>> +		 * That makes me wonder how long I waited for nothing?
>> +		 */
>> +		downgrade_write(&mux->lock);
>> +		return 0;
>> +	}
>> +
>> +	ret = mux_control_set(mux, state);
>> +	if (ret < 0) {
>> +		if (mux->idle_state != MUX_IDLE_AS_IS)
>> +			mux_control_set(mux, mux->idle_state);
>> +
>> +		up_write(&mux->lock);
>> +		return ret;
>> +	}
>> +
>> +	downgrade_write(&mux->lock);
>> +
>> +	return 1;
>> +}
>> +EXPORT_SYMBOL_GPL(mux_control_select);
> 
> I wonder if these should be called mux_control_lock/unlock instead,
> which would allow for try_lock and lock_timeout variants.

Maybe, I'm not totally against it. Do others care to opine?

But mux_control_try_select and mux_control_select_timeout does not
look all that bad either. But maybe foo_lock is making it clearer
that a foo_unlock is needed, if you compared it to foo_select and
foo_unselect? I'm probably not the best person to make the call,
as I know all to well what to expect from the functions...

Cheers,
peda

