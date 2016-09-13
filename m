Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <fba23293-2bbd-4337-62dc-2a7dc7c5f3e0@kernel.org>
References: <1472646781-5551-1-git-send-email-linus.walleij@linaro.org>
 <1472646781-5551-2-git-send-email-linus.walleij@linaro.org> <fba23293-2bbd-4337-62dc-2a7dc7c5f3e0@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Sep 2016 22:38:19 +0200
Message-ID: <CACRpkdbfFpzc9v_-7DSfHctzq2m7aH7BW0BWkq5e0L9UaFuPKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] iio: gyro: Add driver for the MPU-3050 gyroscope
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Nick Vaccaro <nvaccaro@google.com>,
	Ge Gao <ggao@invensense.com>, Anna Si <asi@invensense.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Crestez Dan Leonard <leonard.crestez@intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>, Gregor Boirie <gregor.boirie@parrot.com>,
	Peter Rosin <peda@axentia.se>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Sep 3, 2016 at 6:08 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 31/08/16 13:33, Linus Walleij wrote:

> I thought I'd hate this driver as invensense always seem
> to make things more complex than they need to be, but you've
> done a really nice job of keeping it clear and straight forward.
> Of course there's always the auxilliary sensor support if you
> get bored ;)

I don't see that ever being useful, but I might be surprised.

I'd rather use the obviously present firmware extraction and
alteration commands to assemble my own firmware and make
it do what is best for Linux/IIO...

>> +     /* Set up sampling frequency */
>> +     ret = regmap_write(mpu3050->map,
>> +                        MPU3050_SMPLRT_DIV,
>> +                        mpu3050->divisor);
>         ret = regmap_write(mpu3050->map, MPU3050_SMPLRT_DIV, mpu3050->divisor);
>
> Looks like it fits to me and doesn't hurt readability. I'm going to stop
> commenting on these - feel free to tidy up any others ;)

I'll try to squash all I see. If we're discussing syntax like this it
is a clear sign that
we are nearing completion so I'm happy to tidy it up.


> The next bit is both crazy and cool. I like it ;) (and I haven't
> even been drinking - yet...)

I can't honestly think of a better way of handling it.
The STMicro sensors have something similar, just hidden in the
hurdle of abstraction we have around them.

>> +     /*
>> +      * If we picked some datums from the FIFO that's enough, else
>> +      * fall through and just read from the current value registers.
>> +      * This happens in two cases:
>> +      *
>> +      * - We are using some other trigger (external, like an HRTimer)
>> +      *   than the sensor's own sample generator. In this case the
>> +      *   sensor is just set to the max sampling frequency and we give
>> +      *   the trigger a copy of the latest value every time we get here.
>> +      *
>> +      * - The hardware trigger is active but unused and we actually use
>> +      *   another trigger which calls here with a frequency higher
>> +      *   than what the device provides data. We will then just read
>> +      *   duplicate values directly from the hardware registers.
>
> Hmm. so you did take into account the hideous option of another driver
> using this trigger.  I'd just prevent that happening (as it's crazy ;)
> and simplify the logic a touch here perhaps.

If did and I tested the inverse: another driver (kxsd9) using the
MPU-3050 as trigger - and it worked like a charm.

>> +     iio_push_to_buffers_with_timestamp(indio_dev,
>> +                                        hw_values,
>> +                                        timestamp);
>
> Feels like you have gotten carried away with new lines in the above..
> I make it 76 characters if you put it on one line.

Sure I'm doing this everywhere I can.

>> +     /* Unless we have OUR trigger active, run at full speed */
>> +     if (!mpu3050->hw_irq_trigger)
>> +             return mpu3050_set_8khz_samplerate(mpu3050);
>
> Nice - we could control this separately via sampling_frequency but I can
> see your logic in running this fast.  Only question is does that have
> an effect on the noise?  No idea ;)

There is a filter you can set up, I save that for later...
I'll put a TODO in the code or something.

Apart from that we are pretty much feature complete.

>> +     iio_trigger_poll_chained(p);
>
> Nitpick - blank line here would make it ever so slightly nicer to read...
> (same in the function above)

Yeah I'll try to put some newlines where you like them (usually before
lone returns at end of complex to semi-complex functions)

>> +             pm_runtime_mark_last_busy(mpu3050->dev);
>> +             pm_runtime_put_autosuspend(mpu3050->dev);
>> +             mpu3050->hw_irq_trigger = false;
>> +             return 0;
>> +     }
>
> Slightly code flow presentational preference for the rest of this being
> in an else... Yeah I know it doesn't actually matter but it'd
> give me warm fuzzy feelings :)

OK

>> +     /* Else we're enabling the trigger from this point */
>> +     pm_runtime_get_sync(mpu3050->dev);
>> +     mpu3050->hw_irq_trigger = true;
>
> Hmm. What if another device was using this trigger and this one wasn't?
> I think you need to validate the device if it's using this trigger.
> (so provide the validate_device callback)

Ah I wondered what that was for :)

Will drill into this.

>> +int mpu3050_common_remove(struct device *dev)
>> +{
>> +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +     struct mpu3050 *mpu3050 = iio_priv(indio_dev);
>> +
>> +     iio_device_unregister(indio_dev);
>> +     iio_triggered_buffer_cleanup(indio_dev);
>> +     pm_runtime_get_sync(dev);
>> +     pm_runtime_put_noidle(dev);
>> +     pm_runtime_disable(dev);
>> +     mpu3050_power_down(mpu3050);
>
> The unwind in here is different from the ordering above.
> I 'think' you are fine as it is, but would prefer the obviously correct
> remove having the reverse order of probe.

OK

Yours,
Linus Walleij
