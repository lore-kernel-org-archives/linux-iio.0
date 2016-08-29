Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42266 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755066AbcH2RtC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 13:49:02 -0400
Subject: Re: [PATCH 2/2] iio: gyro: Add driver for the MPU-3050 gyroscope
To: Linus Walleij <linus.walleij@linaro.org>
References: <1471286287-25074-1-git-send-email-linus.walleij@linaro.org>
 <53008712-7c50-79db-07ab-3544902887e1@kernel.org>
 <CACRpkdY=Y56Uz90Z2SW+=eYJaH1zd8FM6Th2tgjkXVmz6fSScA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Nick Vaccaro <nvaccaro@google.com>,
        Ge Gao <ggao@invensense.com>, Anna Si <asi@invensense.com>,
        Nathan Royer <nroyer@invensense.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Peter Rosin <peda@axentia.se>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <abe57b5d-a3f0-a81b-d08a-ecf4c431ac27@kernel.org>
Date: Mon, 29 Aug 2016 18:48:57 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdY=Y56Uz90Z2SW+=eYJaH1zd8FM6Th2tgjkXVmz6fSScA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/08/16 13:37, Linus Walleij wrote:
> On Sun, Aug 21, 2016 at 8:32 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 15/08/16 19:38, Linus Walleij wrote:
> 
>>> Since the MPU-3050 has an outgoing I2C port it needs to act as
>>> an I2C mux. This means that the device is switching I2C traffic
>>> to devices beyond it. On my system this is the only way to reach
>>> the accelerometer. The "sensor fusion" ability of the MPU-3050
>>> to directly talk to the device on the outgoing I2C port is
>>> currently not used by the driver, but it has code to allow I2C
>>> traffic to pass through so that the Linux kernel can reach the
>>> device on the other side with a kernel driver.
>>
>> Cc'd Peter Rosin as he's maintaining the i2c mux code now.
> 
> OK I'll follow up on that discussion thread too.
> 
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> A lot of the complexity in the data handling in here is down to
>> supporting triggers not supplied by this part.  Do we actually need
>> to do so?
> 
> If this sensor is used stand-alone no.
> 
> But the sensor is mounted on a board together with a bunch of
> other sensors (KXSD9 accelerometer, AK8975 magnetometer.)
> One of my usecases is sensor fusion. This means that you
> want to sample all sensors at the same timepoint and with the
> same frequency. Then it is preferable to just use an HRTimer
> and read from all three sensors at once and fuse the
> data AFAICT. Trying to use native triggers and then extrapolate
> and compensate for their different characteristics (KXSD9
> require you to use HRTimer due to lack of external trigger)
> would not be good.
Fair enough I guess.  It will still be 'interesting' in that
the actual timing will be inaccurate if the devices are self clocking.
To do high precision fusion that will matter so you'd actually fuse
with different frequencies and timing.  For less accurate stuff
you might 'get away' with doing this.
> 
>> The 6050 driver does similar 'interesting' stuff to make this
>> work. Is it actually a good idea?  Given we can do direct 'last measurement'
>> reads, perhaps we either operating in a fifo mode without trigger, or
>> if a trigger is supplied we operate using direct reads as if the fifo
>> wasn't there at all.
>>
>> It mostly just feels more complex than it needs to be so I'd like to
>> just through out these generic questions to see what people think.
>>
>> I'd also like to get some input from those particularly familiar with
>> the 6050 which is obviously pretty similar - be it with slighly
>> fewer odd corners...
> 
> The pattern (support both native hardware trigger and
> say HRTimer) emerge in other sensors too, including the whole
> suite of ST MEMS sensors. Not being able to also use HRTimer
> was reported as a bug when I was working on it so it definately
> is a widespread problem.
> 
> I think what I would like to do to alleviate the situation is to
> make the IIO core aware of whether the device is using its
> own trigger or some other trigger. So in the trigger callback
> we can do something like
> 
> if (iio_using_own_trigger(indio_dev))
>   ...
> else
>  ...
> 
> I can try to take a stab at it and prepend this patch with that.
> Would that be interesting?
Would be interesting to see what it gains us. I suspect you
are right in thinking this would be very useful.

> 
>>> I suspect some of the stuff I've done here should be carried
>>> over to the MPU-6050 driver in drivers/iio/imu/inv_mpu6050/*
>>
>> Which bits in particular?
> 
> - Fetch and handle regulators for vdd and vddio (currently
>   totally missing).
> 
> - Runtime PM, including getting rid of the horrible homebrewn
>   reference count in inv_mpu6050_set_power_itg()
> 
> - Oh mpu6050 doesn't even seem to power the device down
>   on .remove() I think it's a bug actually
> 
Thanks ;) Didn't want to have to read both drivers to figure
it out.
>>> +obj-$(CONFIG_MPU3050) += mpu3050.o
>>> +obj-$(CONFIG_MPU3050_I2C) += mpu3050-i2c.o
>>
>> I'd have built it as a single module until we have spi support. Guessing
>> that might be a while ;)
> 
> Yeah. The other driver in drivers/input/misc/mpu3050.c
> only supports I2C as well.
> 
> I augmented the Makefile and the filenames so we create a single
> module for I2C only for now, preserving the nice core/transport
> split so it's still easy to bolt on SPI if desired.
Good.
> 
>>> +static int mpu3050_write_raw(struct iio_dev *indio_dev,
>>> +                          const struct iio_chan_spec *chan,
>>> +                          int val, int val2, long mask)
>>> +{
>>> +     struct mpu3050 *mpu3050 = iio_priv(indio_dev);
>>> +     /*
>>> +      * Couldn't figure out a way to precalculate these at compile time.
>>
>> Do it on paper in advance? Or use a calculator and just document the
>> calculation.
> 
> I did that for the strings, but I don't like hardcoding literals, and
> this:
> 
>>> +      */
>>> +     unsigned int fs250 =
>>> +             DIV_ROUND_CLOSEST(mpu3050_fs_precision[0] * 1000000,
>>> +                               S16_MAX + 1);
>>> +     unsigned int fs500 =
>>> +             DIV_ROUND_CLOSEST(mpu3050_fs_precision[1] * 1000000,
>>> +                               S16_MAX + 1);
>>> +     unsigned int fs1000 =
>>> +             DIV_ROUND_CLOSEST(mpu3050_fs_precision[2] * 1000000,
>>> +                               S16_MAX + 1);
>>> +     unsigned int fs2000 =
>>> +             DIV_ROUND_CLOSEST(mpu3050_fs_precision[3] * 1000000,
>>> +                               S16_MAX + 1);
> 
> is IMO actually easier to maintain because we see what is going on.
> It's not in any performance-critical part anyway.
Fair enough
> 
>>> +static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
> 
>> These combined fifo / non fifo handlers always give
>> me a headache. Do we actually need to support other triggers?
>> We can if we have too poll the fifo counter in a thread to
>> avoid the case of no interrupt wired. That would mean we can
>> drop the triggers existence completely and have a nice simple
>> bit of code?  I guess there are usecases for buffered capture
>> at less than the full rate (when the rate is rather high as
>> here) so we have to do this complexity.
>>
>> I'm not sure there is a better way of doing it though so I
>> guess we'll end up sticking with this.
> 
> As outlined above I think the IIO core needs to be more aware
> of this usecase. (So already answered this I think.)
> 
>>> +                     /*
>>> +                      * At this point, the timestamp that triggered the
>>> +                      * hardware interrupt is no longer valid for what
>>> +                      * we are reading (the interrupt likely fired for
>>> +                      * the value on the top of the FIFO), so re-stamp
>>> +                      * the time.
>>> +                      */
>>> +                     timestamp = iio_get_time_ns(indio_dev);
>>
>> Hmm.  Normal trick when we have a hardware fifo is to not use
>> triggers at all, but push directly to the buffer.
>>
>> If we really want to do triggered handling then the next option is to use
>> a timestamp set to 0 to indicate we don't actually know when the sample
>> was generated (this is what the 6050 driver is doing - though in that
>> case there is a local timestamp fifo to muddy the waters). Making one up
>> here seems like a bad idea...
> 
> We're not talking big deviations here. What happens here is that
> the sensor gets "choked" because we are generating new data
> quicker than the interrupt handler can serve it. That is the case
> when there is > 1 value in the FIFO. So the timestamp will be
> reasonable, just a bit monotonically further than for the first
> sample in the series.
> 
> But I can set it to zero if that is preferred for this situation.
I personally prefer that. Leave the decision to fake it to userspace
if it wants to do it.

Hmm. Add something to the Doc Book for IIO to hammer this point home?
> 
>>> +     /*
>>> +      * If we picked some datums from the FIFO that's enough, else
>>> +      * fall through and just read from the current value registers.
>>> +      */
>>> +     if (datums_from_fifo) {
>>> +             dev_dbg(mpu3050->dev,
>>> +                     "read %d datums from the FIFO\n",
>>> +                     datums_from_fifo);
>>> +             goto out_trigger_unlock;
>>> +     }
>>> +
>>> +     ret = regmap_bulk_read(mpu3050->map,
>>> +                            MPU3050_TEMP_H,
>>> +                            &hw_values,
>>> +                            sizeof(hw_values));
>>
>> So this is for the case where the (non device provided)
>> trigger is running faster than the sampling frequency?
>> Will result in duplicated data?  Perhaps a note to explain that.
> 
> That is one of the cases when we end up here.
> 
> But the normal case is actually just using any external trigger
> at any frequency. The hardware FIFO is turned off unless
> we use the local hardware trigger, in that case we just
> sample as quickly as we can (8kHz) and give the buffer
> the most recent value from the hardware whenever the trigger
> handler is called.
Ah, I'd missed you had the fifo turned off for that case.
Definitely makes more sense if that's the case.
> 
> I'll put in some comments.
> 
>>> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
>>> +                           mpu3050_read_frequency,
>>> +                           mpu3050_write_frequency);
>>
>> Why not through the read_raw callback?  Need a very good reason to
>> not use that for standard info_mask elements.  This prevents
>> consumer drivers being able to read or set the sampling frequency.
> 
> Copy/paste error I guess, bad inspiration. Fixed it.
> 
>>> +     /* All others sets the sample frequenct to 1 kHz */
>> frequency
> 
> Fixed.
> 
>>> +enum mpu3050_axis {
>>> +     AXIS_X = 0,
>>> +     AXIS_Y,
>>> +     AXIS_Z,
>>> +     AXIS_MAX,
>>> +};
>>
>> A lot of this stuff is not relevant to the _i2c.c file, so I'd
>> flatten it into the main c file.
> 
> However I need to share the state container:
> 
>>> + * struct mpu3050 - instance state container for the device
> 
> Across the files (so the I2C driver can manage the power state
> of the device), and since that contains:
> 
>>> +struct mpu3050 {
>>> +     enum mpu3050_fullscale fullscale;
>>> +     enum mpu3050_lpf lpf;
> 
> The following happens if I leave it out:
>   CC      drivers/iio/gyro/mpu3050-core.o
>   CC      drivers/iio/gyro/mpu3050-i2c.o
> In file included from ../drivers/iio/gyro/mpu3050-core.c:28:0:
> ../drivers/iio/gyro/mpu3050.h:41:25: error: field 'fullscale' has
> incomplete type
>   enum mpu3050_fullscale fullscale;
>                          ^
> ../drivers/iio/gyro/mpu3050.h:42:19: error: field 'lpf' has incomplete type
>   enum mpu3050_lpf lpf;
>                    ^
> 
> Of course I can put a void * into the state, maintain these things
> there but it creates another allocation and ... this is the lesser
> of two evils IMO.
Fair point.
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

