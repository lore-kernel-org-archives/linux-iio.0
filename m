Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <5d31460f-8377-50b9-3960-d2204d4a4347@gmail.com>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
	<1458825486-17188-3-git-send-email-linus.walleij@linaro.org>
	<5728E6C2.1050901@gmail.com>
	<CACRpkdaLc8frud64VZEuQ=dXGpgk+kBj94otoCCC=-Pvoe09tw@mail.gmail.com>
	<4e983a0c-88f9-b5bf-3439-15f006736a7d@kernel.org>
	<CACRpkdas0XhPJWXd-HnYEOM4KALk23v_XnkZhkcsdzBjvHewsw@mail.gmail.com>
	<5d31460f-8377-50b9-3960-d2204d4a4347@gmail.com>
Date: Fri, 6 May 2016 11:14:28 +0200
Message-ID: <CACRpkdYr+pEd58tTfS5J9jC+vr_-S3tYJeKnG8CTt-AaZuShHw@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: st_sensors: verify interrupt event to status
From: Linus Walleij <linus.walleij@linaro.org>
To: Crestez Dan Leonard <cdleonard@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 4, 2016 at 8:14 PM, Crestez Dan Leonard <cdleonard@gmail.com> wrote:
> On 05/04/2016 05:34 PM, Linus Walleij wrote:
>> On Wed, May 4, 2016 at 9:35 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 03/05/16 21:10, Linus Walleij wrote:
>>
>>>>> Even with hardware triggers: are you sure this is correct? Shouldn't
>>>>> iio_trigger_notify_done still get called even when there is nothing to do?
>>>>
>>>> No then the (hardware) IRQ can have come in from some other
>>>> device sharing the line with the peripheral and we need to return
>>>> IRQ_NONE. It's not our interrupt.
>>>
>>> Gah, I fouled up reviewing this.  We really need to know if it is our
>>> trigger 'before' we fire off the trigger logic - any number of other
>>> devices can in theory be hanging off a given trigger - none of them will
>>> be able to know if it was a real trigger or not.
>>
>> Ooops sorry, but the good thing is: we get to properly fix it.

I have sent out a fix (first v1 then v2... because I missed the timestamps)
for this: turns out it was simpler than I thought as there was already a
properly threaded accelerometer driver in the kernel, I just didn't see
it before.

> I've been testing with some st_sensors devices I have around and it
> seems to me that triggered buffers with hardware interrupts don't
> actually work properly at high sampling frequencies. It is possible for
> another sample to come in before the buffer handler completes and
> further interrupts will be lost.

Yes the threaded interrupt handler (if specifying IRQF_ONESHOT)
will mask the DRDY interrupt line while the sensor is being polled for
values.

As these interrupts are usually edge triggered, the transient interrupt
will be lost :(

> This happens on at least LIS3DH.
>
> It's not obvious how to handle this. Presumably the fix would be to
> check STATUS_REG after reading one sample and if new values are
> available schedule a new read?

I actually have a patch similar to that sitting around: I was using it
to detect residues in the sensor when I was debugging LIS331DL.
Let me look it over and see if I can post something on top of the
just sent threading patch.

Still I would consider it something of a hack: if the overall sample
speed goes above the latencies that the hardware and software can
really handle, the the system as a whole is underdimensioned,
and polling from a HRTimer may be more reliable as they at least
don't loose interrupts.

I might be able to get rid of the lock-ups, but that doesn't mean
the timestamps on the readings won't be tilted: they will.

> This is easy to reproduce for me because I use an usb-to-i2c adapter
> with high latencies. It helps if you increase the sampling_frequency but
> it might still be very hard to reproduce on a direct i2c bus.

Yeah you see where the latencies come from.

And I actually could reproduce this with just I2C on the ux500
by setting the sampling frequency on the LIS331DL to 400Hz.

An I2C bus is usually 100kHz or 400kHz if you're lucky. So 1/100k s
per bit transferred. This still would be way quicker than the ST sensors
I've seen (though I hear that things like the Oculus Rift need complete
sensor data at speeds close to the I2C bus bitrate!)

Yours,
Linus Walleij
