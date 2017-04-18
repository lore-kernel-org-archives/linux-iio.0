Return-Path: <SRS0=C7XM=32=linuxfoundation.org=gregkh@kernel.org>
Date: Tue, 18 Apr 2017 13:44:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Colin Ian King <colin.king@canonical.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
Message-ID: <20170418114430.GA1496@kroah.com>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-4-git-send-email-peda@axentia.se>
 <20170418085156.GA4773@kroah.com>
 <bdeecccf-02d6-226b-8516-1d41e3602a7a@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bdeecccf-02d6-226b-8516-1d41e3602a7a@axentia.se>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Apr 18, 2017 at 12:59:50PM +0200, Peter Rosin wrote:
> On 2017-04-18 10:51, Greg Kroah-Hartman wrote:
> > On Thu, Apr 13, 2017 at 06:43:07PM +0200, Peter Rosin wrote:
> >> +config MUX_GPIO
> >> +	tristate "GPIO-controlled Multiplexer"
> >> +	depends on OF && GPIOLIB
> > 
> > Why have the gpio and mux core in the same patch?
> 
> One is not usable w/o the other. I can split them if you want to?

Then why are they two different config options?  Add the core code in
one patch, and then add the gpio controled mutiplexer in a separate
patch.

> >> +static struct class mux_class = {
> >> +	.name = "mux",
> >> +	.owner = THIS_MODULE,
> >> +};
> > 
> > No Documentation/ABI/ update for your sysfs files?  Please do so.
> 
> Ok I'll look into it. Wasn't even aware that I added any. But there's the
> new class of course...

Hint, you have files, the devices that belong to the class :)

> >> +static int __init mux_init(void)
> >> +{
> >> +	return class_register(&mux_class);
> >> +}
> >> +
> >> +static DEFINE_IDA(mux_ida);
> > 
> > When your module is unloaded, you forgot to clean this structure up with
> > what was done with it.
> 
> I was under the impression that not providing an exit function for modules
> made the module infrastructure prevent unloading (by bumping some reference
> counter). Maybe that is a misconception?

Ah, messy, don't do that.  Make it so you can unload your module please,
why wouldn't you want that to happen?

> >> +	mux_chip = kzalloc(sizeof(*mux_chip) +
> >> +			   controllers * sizeof(*mux_chip->mux) +
> >> +			   sizeof_priv, GFP_KERNEL);
> >> +	if (!mux_chip)
> >> +		return NULL;
> > 
> > You don't return PTR_ERR(-ENOMEM)?  Ok, why not?  (I'm not arguing for
> > it, just curious...)
> 
> There's no particular reason. Do you think I should change it?

What does the caller do with an error?  Pass it up to where?  Who gets
it?  Don't you want the caller to know you are out of memory?

> >> +
> >> +	device_initialize(&mux_chip->dev);
> > 
> > Why are you not registering the device here as well?  Why have this be a
> > two step process?
> 
> Because of idle state handling. The drivers are expected to fill in
> the desired idle state(s) after allocating the mux controller(s).
> Then, when registering, the desired idle state is activated (if the
> idle state is not idle-as-is, of course) and as a last step the mux
> is "advertised".

Ok, is that documented in the functions somewhere?

> >> +	ret = device_add(&mux_chip->dev);
> >> +	if (ret < 0)
> >> +		dev_err(&mux_chip->dev,
> >> +			"device_add failed in mux_chip_register: %d\n", ret);
> > 
> > Did you run checkpatch.pl in strict mode on this new file?  Please do so :)
> 
> I did, and did it again just to be sure, and I do not get any complaints.
> So, what's wrong?

You list the function name in the printk string, it should complain
that __func__ should be used.  Oh well, it's just a perl script, it
doesn't always catch everything.
isn't always correct :)

> >> +EXPORT_SYMBOL_GPL(devm_mux_chip_alloc);
> > 
> > 
> > Having devm functions that create/destroy other struct devices worries
> > me, do we have other examples of this happening today?  Are you sure you
> > got the reference counting all correct?
> 
> drivers/iio/industrialio_core.c:devm_iio_device_alloc
> 
> Or is the iio case different in some subtle way that I'm missing?

I don't know, hopefully you got it all correct, I haven't audited that
code path in a long time :)

> >> +
> >> +static int devm_mux_chip_match(struct device *dev, void *res, void *data)
> >> +{
> >> +	struct mux_chip **r = res;
> >> +
> >> +	if (WARN_ON(!r || !*r))
> > 
> > How can this happen?
> 
> It shouldn't. I copied the pattern from the iio subsystem.

Then it should be removed there too...

> >> +void devm_mux_chip_free(struct device *dev, struct mux_chip *mux_chip)
> >> +{
> >> +	WARN_ON(devres_release(dev, devm_mux_chip_release,
> >> +			       devm_mux_chip_match, mux_chip));
> > 
> > What can someone do with these WARN_ON() splats in the kernel log?
> 
> Don't know. Again, I copied the pattern from the iio subsystem.

If you don't know what it should be used for, don't copy it!

Cargo-cult coding is horrible, please no.

> >> +	/* ...or it's just contended. */
> >> +	down_write(&mux->lock);
> > 
> > Why use a read/write lock at all?  Have you tested this to verify it
> > really is faster and needed?
> 
> For one of the HW configuration that drove the development, the same mux
> controller is used to mux both an I2C channel and a couple of ADC lines.
> 
> If there is no kind of reader/writer locking going on, there is no way to
> do ADC readings concurrently with an I2C transfer even when the consumers
> want the mux in the same position. With an ordinary mutex controlling the
> mux position, the consumers will unconditionally get serialized, which
> seems like a waste to me. Or maybe I'm missing something?

Why is serializing things a "waste"?  Again, a rw semaphore is slower,
takes more logic to get correct, and is very complex at times.  If you
are not SURE you need it, and that it matters, don't use it.  And if you
do use it, document the heck out of it how you need it and why.

> >> +
> >> +	if (mux->cached_state == state) {
> >> +		/*
> >> +		 * Hmmm, someone else changed the mux to my liking.
> >> +		 * That makes me wonder how long I waited for nothing?
> >> +		 */
> >> +		downgrade_write(&mux->lock);
> > 
> > Oh that always scares me...  Are you _sure_ this is correct?  And
> > needed?
> 
> It might not be needed, and it would probably work ok to just fall
> through and call mux_control_set unconditionally. What is it that
> always scares you exactly? Relying on cached state to be correct?
> Downgrading writer locks?

downgrading a writer lock scares me, especially for something as
"simple" as this type of interface.  Again, don't use it unless you
_have_ to.  Simple is good, start with that always.

> >> +	if (mux->idle_state != MUX_IDLE_AS_IS &&
> >> +	    mux->idle_state != mux->cached_state)
> >> +		ret = mux_control_set(mux, mux->idle_state);
> >> +
> >> +	up_read(&mux->lock);
> > 
> > You require a lock to be held for a "global" function?  Without
> > documentation?  Or even a sparse marking?  That's asking for trouble...
> 
> Documentation I can handle, but where should I look to understand how I
> should add sparse markings?

Run sparse on the code and see what it says :)

> The mux needs to be locked somehow. But as I stated in the cover letter
> the rwsem isn't a perfect fit.
> 
> 	I'm using an rwsem to lock a mux, but that isn't really a
> 	perfect fit. Is there a better locking primitive that I don't
> 	know about that fits better? I had a mutex at one point, but
> 	that didn't allow any concurrent accesses at all. At least
> 	the rwsem allows concurrent access as long as all users
> 	agree on the mux state, but I suspect that the rwsem will
> 	degrade to the mutex situation pretty quickly if there is
> 	any contention.
> 
> Also, the lock doesn't add anything if there is only one consumer of
> a mux controller. Maybe there should be some mechanism for shortcutting
> the locking for the (more common?) single-consumer case?
> 
> But again, I need the locking for my multi-consumer use case.

Go back to a mutex, and having a function that requires it to be held
is, icky.

> >> +/*
> >> + * Using subsys_initcall instead of module_init here to ensure - for the
> >> + * non-modular case - that the subsystem is initialized when mux consumers
> >> + * and mux controllers start to use it /without/ relying on link order.
> >> + * For the modular case, the ordering is ensured with module dependencies.
> >> + */
> >> +subsys_initcall(mux_init);
> > 
> > Even with subsys_initcall you are relying on link order, you do realize
> > that?  What about other subsystems that rely on this?  :)
> 
> Yes, that is true, but if others start relying on this, that's their problem,
> right? :-)

Yes, but no need to document something that isn't true.  You are relying
on link order here.

> >> +struct mux_control_ops {
> >> +	int (*set)(struct mux_control *mux, int state);
> >> +};
> >> +
> >> +/* These defines match the constants from the dt-bindings. On purpose. */
> > 
> > Why on purpose?
> 
> I sure wasn't an accident? :-)
> 
> Want me to remove it?

At least explain _why_ you are doing this, that would help, right?

thanks,

greg k-h
