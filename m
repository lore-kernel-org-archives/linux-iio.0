Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ve1eur01on0101.outbound.protection.outlook.com ([104.47.1.101]:50352
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751977AbdDRVxX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Apr 2017 17:53:23 -0400
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-4-git-send-email-peda@axentia.se>
 <20170418085156.GA4773@kroah.com>
 <bdeecccf-02d6-226b-8516-1d41e3602a7a@axentia.se>
 <20170418114430.GA1496@kroah.com>
CC: <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
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
        Philipp Zabel <p.zabel@pengutronix.de>, <kernel@pengutronix.de>
From: Peter Rosin <peda@axentia.se>
Message-ID: <aacdc359-e46d-7d1a-d959-63d4ecb99fde@axentia.se>
Date: Tue, 18 Apr 2017 23:53:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170418114430.GA1496@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-18 13:44, Greg Kroah-Hartman wrote:
> On Tue, Apr 18, 2017 at 12:59:50PM +0200, Peter Rosin wrote:
>> On 2017-04-18 10:51, Greg Kroah-Hartman wrote:
>>> On Thu, Apr 13, 2017 at 06:43:07PM +0200, Peter Rosin wrote:
>>>> +config MUX_GPIO
>>>> +	tristate "GPIO-controlled Multiplexer"
>>>> +	depends on OF && GPIOLIB
>>>
>>> Why have the gpio and mux core in the same patch?
>>
>> One is not usable w/o the other. I can split them if you want to?
> 
> Then why are they two different config options?  Add the core code in
> one patch, and then add the gpio controled mutiplexer in a separate
> patch.

Ah, I meant when there are not yet any other mux drivers. I'll just
split the patch.

>>>> +static struct class mux_class = {
>>>> +	.name = "mux",
>>>> +	.owner = THIS_MODULE,
>>>> +};
>>>
>>> No Documentation/ABI/ update for your sysfs files?  Please do so.
>>
>> Ok I'll look into it. Wasn't even aware that I added any. But there's the
>> new class of course...
> 
> Hint, you have files, the devices that belong to the class :)

Right.

>>>> +static int __init mux_init(void)
>>>> +{
>>>> +	return class_register(&mux_class);
>>>> +}
>>>> +
>>>> +static DEFINE_IDA(mux_ida);
>>>
>>> When your module is unloaded, you forgot to clean this structure up with
>>> what was done with it.
>>
>> I was under the impression that not providing an exit function for modules
>> made the module infrastructure prevent unloading (by bumping some reference
>> counter). Maybe that is a misconception?
> 
> Ah, messy, don't do that.  Make it so you can unload your module please,
> why wouldn't you want that to happen?

What made me do it was the worry that mux drivers might be left dangling
w/o the core. But that can probably only happen if someone is very
deliberately trying to break stuff by forcing unloads??

>>>> +	mux_chip = kzalloc(sizeof(*mux_chip) +
>>>> +			   controllers * sizeof(*mux_chip->mux) +
>>>> +			   sizeof_priv, GFP_KERNEL);
>>>> +	if (!mux_chip)
>>>> +		return NULL;
>>>
>>> You don't return PTR_ERR(-ENOMEM)?  Ok, why not?  (I'm not arguing for
>>> it, just curious...)
>>
>> There's no particular reason. Do you think I should change it?
> 
> What does the caller do with an error?  Pass it up to where?  Who gets
> it?  Don't you want the caller to know you are out of memory?

The current callers return -ENOMEM when NULL is returned here. Looks
like I'm going to be doing some fairly major changes anyway so I'll
just change this too while at it...

>>>> +
>>>> +	device_initialize(&mux_chip->dev);
>>>
>>> Why are you not registering the device here as well?  Why have this be a
>>> two step process?
>>
>> Because of idle state handling. The drivers are expected to fill in
>> the desired idle state(s) after allocating the mux controller(s).
>> Then, when registering, the desired idle state is activated (if the
>> idle state is not idle-as-is, of course) and as a last step the mux
>> is "advertised".
> 
> Ok, is that documented in the functions somewhere?

I'll make sure to add it if it's missing.

>>>> +	ret = device_add(&mux_chip->dev);
>>>> +	if (ret < 0)
>>>> +		dev_err(&mux_chip->dev,
>>>> +			"device_add failed in mux_chip_register: %d\n", ret);
>>>
>>> Did you run checkpatch.pl in strict mode on this new file?  Please do so :)
>>
>> I did, and did it again just to be sure, and I do not get any complaints.
>> So, what's wrong?
> 
> You list the function name in the printk string, it should complain
> that __func__ should be used.  Oh well, it's just a perl script, it
> doesn't always catch everything.
> isn't always correct :)

Ah, ok.

>>>> +EXPORT_SYMBOL_GPL(devm_mux_chip_alloc);
>>>
>>>
>>> Having devm functions that create/destroy other struct devices worries
>>> me, do we have other examples of this happening today?  Are you sure you
>>> got the reference counting all correct?
>>
>> drivers/iio/industrialio_core.c:devm_iio_device_alloc
>>
>> Or is the iio case different in some subtle way that I'm missing?
> 
> I don't know, hopefully you got it all correct, I haven't audited that
> code path in a long time :)

Looks as ok to me as it did before. Moving on... :-)

>>>> +
>>>> +static int devm_mux_chip_match(struct device *dev, void *res, void *data)
>>>> +{
>>>> +	struct mux_chip **r = res;
>>>> +
>>>> +	if (WARN_ON(!r || !*r))
>>>
>>> How can this happen?
>>
>> It shouldn't. I copied the pattern from the iio subsystem.
> 
> Then it should be removed there too...

Ok, I'll see if I can find time to suggest some patch(es) to Jonathan.

>>>> +void devm_mux_chip_free(struct device *dev, struct mux_chip *mux_chip)
>>>> +{
>>>> +	WARN_ON(devres_release(dev, devm_mux_chip_release,
>>>> +			       devm_mux_chip_match, mux_chip));
>>>
>>> What can someone do with these WARN_ON() splats in the kernel log?
>>
>> Don't know. Again, I copied the pattern from the iio subsystem.
> 
> If you don't know what it should be used for, don't copy it!
> 
> Cargo-cult coding is horrible, please no.

Ok, I'll just drop those WARNs...

>>>> +	/* ...or it's just contended. */
>>>> +	down_write(&mux->lock);
>>>
>>> Why use a read/write lock at all?  Have you tested this to verify it
>>> really is faster and needed?
>>
>> For one of the HW configuration that drove the development, the same mux
>> controller is used to mux both an I2C channel and a couple of ADC lines.
>>
>> If there is no kind of reader/writer locking going on, there is no way to
>> do ADC readings concurrently with an I2C transfer even when the consumers
>> want the mux in the same position. With an ordinary mutex controlling the
>> mux position, the consumers will unconditionally get serialized, which
>> seems like a waste to me. Or maybe I'm missing something?
> 
> Why is serializing things a "waste"?  Again, a rw semaphore is slower,
> takes more logic to get correct, and is very complex at times.  If you
> are not SURE you need it, and that it matters, don't use it.  And if you
> do use it, document the heck out of it how you need it and why.

It's a waste of time because two independent mux consumers of the same
mux controller can't do things concurrently even if they want the same
thing from the mux. Let's say that one mux consumer is an iio-mux and
one is an i2c-mux. Also, let's say that you for some reason need to get
a lot of samples at a determined rate through the iio-mux. With a mutex,
that can't happen if there is an access through the i2c-mux taking
"forever" in the eyes of the ADC/iio-mux, even if they both want the
shared mux controller to be in the same position. The ADC/iio-mux and
the i2c-mux would be waiting for each other for no purpose at all.

>>>> +
>>>> +	if (mux->cached_state == state) {
>>>> +		/*
>>>> +		 * Hmmm, someone else changed the mux to my liking.
>>>> +		 * That makes me wonder how long I waited for nothing?
>>>> +		 */
>>>> +		downgrade_write(&mux->lock);
>>>
>>> Oh that always scares me...  Are you _sure_ this is correct?  And
>>> needed?
>>
>> It might not be needed, and it would probably work ok to just fall
>> through and call mux_control_set unconditionally. What is it that
>> always scares you exactly? Relying on cached state to be correct?
>> Downgrading writer locks?
> 
> downgrading a writer lock scares me, especially for something as
> "simple" as this type of interface.  Again, don't use it unless you
> _have_ to.  Simple is good, start with that always.

Some kind of lock needs to be grabbed in mux_control_select and
released in mux_control_deselect that fixes the mux state while the
mux consumer goes about its business. For the reasons stated above I
went with a reader/writer lock instead of the mutex I had originally.

Agreed, the code in mux_control_select is a few more lines than I
like, but I suspected the big issue to be holding *any* lock over
a pair of "global" functions. Changing from holding a rw-lock as
reader to instead holding a mutex changes very little in my eyes.
mux_control_select is simply not *that* complicated...

>>>> +	if (mux->idle_state != MUX_IDLE_AS_IS &&
>>>> +	    mux->idle_state != mux->cached_state)
>>>> +		ret = mux_control_set(mux, mux->idle_state);
>>>> +
>>>> +	up_read(&mux->lock);
>>>
>>> You require a lock to be held for a "global" function?  Without
>>> documentation?  Or even a sparse marking?  That's asking for trouble...
>>
>> Documentation I can handle, but where should I look to understand how I
>> should add sparse markings?
> 
> Run sparse on the code and see what it says :)

Will do.

>> The mux needs to be locked somehow. But as I stated in the cover letter
>> the rwsem isn't a perfect fit.
>>
>> 	I'm using an rwsem to lock a mux, but that isn't really a
>> 	perfect fit. Is there a better locking primitive that I don't
>> 	know about that fits better? I had a mutex at one point, but
>> 	that didn't allow any concurrent accesses at all. At least
>> 	the rwsem allows concurrent access as long as all users
>> 	agree on the mux state, but I suspect that the rwsem will
>> 	degrade to the mutex situation pretty quickly if there is
>> 	any contention.
>>
>> Also, the lock doesn't add anything if there is only one consumer of
>> a mux controller. Maybe there should be some mechanism for shortcutting
>> the locking for the (more common?) single-consumer case?
>>
>> But again, I need the locking for my multi-consumer use case.
> 
> Go back to a mutex, and having a function that requires it to be held
> is, icky.

But how do you propose that the ickyness is avoided? It's a requirement
that any waiters are released when the mux is available...

*thinking/coding for a bit*

I'm going to experiment with the below (untested) code which AFAICT
has the issues that starvation is possible, that it isn't first-come
first-serve, and that once there is contention the waiters may wait
for a longer time than needed...

On the positive side there are no actual locks held from select over
to deselect and there's no rwsem. But a missing (or an extra) deselect
still messes things up pretty fatally, since the below is really just
some kind of open coded locking thingy that I thought was one of the
things I should stay away from. But maybe you like it better?

(In the below, mux->wait_sem is assumed to be initialized to zero.)

int mux_control_select(struct mux_control *mux, int state)
{
	int ret = 0;

again:
	mutex_lock(&mux->lock);

	if (mux->cached_state == state) {
		/* The mux is already correct, just bump the user count. */
		++mux->users;
		goto done;
	}
	if (mux->users) {
		/* The mux needs updating but is in use, wait... */
		++mux->waiters;
		mutex_unlock(&mux->lock);
		down(&mux->wait_sem);
		goto again;
	}

	/* The mux needs updating and is unused. */
	ret = mux_control_set(mux, state);
	if (ret >= 0) {
		++mux->users;
		goto done;
	}

	/* The mux update failed, try to revert if appropriate... */
	if (mux->idle_state != MUX_IDLE_AS_IS)
		mux_control_set(mux, mux->idle_state);

	/* ...and release a waiter if there is one. */
	if (mux->waiters) {
		--mux->waiters;
		up(&mux->wait_sem);
	}

done:
	mutex_unlock(&mux->lock);

	return ret;
}

int mux_control_deselect(struct mux_control *mux)
{
	int ret = 0;

	mutex_lock(&mux->lock);
	if (--mux->users)
		goto done;

	/* This was the last user, idle the mux if appropriate... */
	if (mux->idle_state != MUX_IDLE_AS_IS &&
	    mux->idle_state != mux->cached_state)
		ret = mux_control_set(mux, mux->idle_state);

	/* ...and release a waiter if there is one. */
	if (mux->waiters) {
		--mux->waiters;
		up(&mux->wait_sem);
	}

done:
	mutex_unlock(&mux->lock);

	return ret;
}

>>>> +/*
>>>> + * Using subsys_initcall instead of module_init here to ensure - for the
>>>> + * non-modular case - that the subsystem is initialized when mux consumers
>>>> + * and mux controllers start to use it /without/ relying on link order.
>>>> + * For the modular case, the ordering is ensured with module dependencies.
>>>> + */
>>>> +subsys_initcall(mux_init);
>>>
>>> Even with subsys_initcall you are relying on link order, you do realize
>>> that?  What about other subsystems that rely on this?  :)
>>
>> Yes, that is true, but if others start relying on this, that's their problem,
>> right? :-)
> 
> Yes, but no need to document something that isn't true.  You are relying
> on link order here.

Well, am I? If I change it to module_init I do get runtime errors for a
non-modular build (when mux consumers get initialized before the mux core).
With subsys_init the mux core get initialized before all (current)
consumers. I don't really see how the link order *currently* matters?

So, just making sure that we are on the same page, the thing that relies on
link order are any mux consumers/drivers that in the future may be added as
part of some other subsys_init call (or earlier). Right?

Hmmm, or are you perhaps referring to the fact that the mux core depends on
other subsystems being initialized first?

>>>> +struct mux_control_ops {
>>>> +	int (*set)(struct mux_control *mux, int state);
>>>> +};
>>>> +
>>>> +/* These defines match the constants from the dt-bindings. On purpose. */
>>>
>>> Why on purpose?
>>
>> I sure wasn't an accident? :-)
>>
>> Want me to remove it?
> 
> At least explain _why_ you are doing this, that would help, right?

Should I perhaps just #include <linux/dt-bindings/mux/mux.h> instead?
Is that an OK thing to do? I didn't because I feared it might come back
to haunt me at some point if the bindings header needed stuff in the
future that made it incompatible...

It's also not terribly common to include bindings from an include...

Cheers,
peda

