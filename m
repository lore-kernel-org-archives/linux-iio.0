Return-Path: <SRS0=Ahh5=33=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
To: Philipp Zabel <p.zabel@pengutronix.de>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-4-git-send-email-peda@axentia.se>
 <1492592817.2970.14.camel@pengutronix.de>
 <da90526b-7274-c52c-07e8-9f0d75cf1cbf@axentia.se>
 <1492609756.2970.131.camel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen
	<lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan
 Corbet <corbet@lwn.net>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Colin
 Ian King <colin.king@canonical.com>, Paul Gortmaker
	<paul.gortmaker@windriver.com>, <kernel@pengutronix.de>
From: Peter Rosin <peda@axentia.se>
Message-ID: <5945890d-2eea-f287-96ca-c095e8fa7be5@axentia.se>
Date: Wed, 19 Apr 2017 23:04:30 +0200
MIME-Version: 1.0
In-Reply-To: <1492609756.2970.131.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 2017-04-19 15:49, Philipp Zabel wrote:
> On Wed, 2017-04-19 at 14:00 +0200, Peter Rosin wrote:
> [...]
>>>> +int mux_control_select(struct mux_control *mux, int state)
>>>
>>> If we let two of these race, ...
>>
>> The window for this "race" is positively huge. If there are several
>> mux consumers of a single mux controller, it is self-evident that
>> if one of them grabs the mux for a long time, the others will suffer.
>>
>> The design is that the rwsem is reader-locked for the full duration
>> of a select/deselect operation by the mux consumer.
> 
> I was not clear. I meant: I think this can also happen if we let them
> race with the same state target.

Right, but there is another glaring problem with the v13 implementation
of select/deselect. If there are three consumers and the first one
holds the mux while the other two tries to select it to some other
position, then even if the two "new" consumers agree on the mux state,
then both of them will end up in the "it's just contended" case and
then be serialized. So, yes, the select/deselect implementation is not
perfect. To quote the cover letter:

	I'm using an rwsem to lock a mux, but that isn't really a
	perfect fit. Is there a better locking primitive that I don't
	know about that fits better? I had a mutex at one point, but
	that didn't allow any concurrent accesses at all. At least
	the rwsem allows concurrent access as long as all users
	agree on the mux state, but I suspect that the rwsem will
	degrade to the mutex situation pretty quickly if there is
	any contention.

But with your discovery that there's a race when two consumers go
for the same state in a free mux, in addition to the above contention
problem, I'm about ready to go with Greg's suggestion and just use a
mutex. I.e. ignore the desire to allow concurrent use. Because it's
not like the sketchy thing I threw out in the other part of the thread
solves any of these problems. I can live without the concurrency, and
I guess I can also live with passing the buck to the poor sod that
eventually needs it.

>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	if (down_read_trylock(&mux->lock)) {
>>>> +		if (mux->cached_state == state)
>>>> +			return 0;
> 
> This check makes it clear that a second select call is not intended to
> block if the intended state is already selected. But if the instance we
> will lose the race against has not yet updated cached_state, ...
> 
>>>> +		/* Sigh, the mux needs updating... */
>>>> +		up_read(&mux->lock);
>>>> +	}
>>>> +
>>>> +	/* ...or it's just contended. */
>>>> +	down_write(&mux->lock);
> 
> ... we are blocking here until the other instance calls up_read. Even
> though in this case (same state target) we would only have to block
> until the other instance calls downgrade_write after the mux control is
> set to the correct state.
> 
> Basically there is a small window before down_write with no lock at all,
> where multiple instances can already have decided they must change the
> mux (to the same state). If this happens, they go on to block each other
> unnecessarily.
> 
>>> ... then the last to get to down_write will just wait here forever (or
>>> until the first consumer calls mux_control_deselect, which may never
>>> happen)?
>>
>> It is vital that the mux consumer call _deselect when it is done with
>> the mux. Not doing so will surely starve out any other mux consumers.
>> The whole thing is designed around the fact that mux consumers should
>> deselect the mux as soon as it's no longer needed.
> 
> I'd like to use this for video bus multiplexers. Those would not be
> selected for the duration of an i2c transfer, but for the duration of a
> running video capture stream, or for the duration of an enabled display
> path. While I currently have no use case for multiple consumers
> controlling the same mux, this scenario is what shapes my perspective.
> For such long running selections the consumer should have the option to
> return -EBUSY instead of blocking when the lock can't be taken.

I'll see if I can implement a try variant for the mutex based select I
will probably end up with in v14...

Cheers,
peda
