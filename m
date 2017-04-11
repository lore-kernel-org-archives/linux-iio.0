Return-Path: <SRS0=opTc=3T=gmail.com=plroskin@kernel.org>
MIME-Version: 1.0
In-Reply-To: <4311cd69-c853-8fee-c0d2-0476b24580e4@kernel.org>
References: <CAN_72e1apsS2nKh7SYiETz+=bJW7mEBS6GV8DmzZEPzroaeACg@mail.gmail.com>
 <23293209-00F9-4D1E-8822-00B3B267EF79@sense.com> <CAN_72e0u+fgOB9TmvP55pDLOC1Z9vGYnNj5Zpogc1b-K7xW7WA@mail.gmail.com>
 <AD6B3C1C-0A2A-4941-86E6-D2AFB6446E18@sense.com> <CAN_72e3-Zzr7b9sLfKk1EGeAYwb03=UrJsGpLOGbR4C-QjOtLw@mail.gmail.com>
 <4311cd69-c853-8fee-c0d2-0476b24580e4@kernel.org>
From: Pavel Roskin <plroskin@gmail.com>
Date: Tue, 11 Apr 2017 14:01:35 -0700
Message-ID: <CAN_72e1voayyNrg2+6V7hhGG4uJi0FSotwrT9FeQ4QgTPoawUw@mail.gmail.com>
Subject: Re: Raw data block input: is IIO a good choice?
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonah Petri <jonah@sense.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

I appreciate your response.

On Sat, Apr 8, 2017 at 7:36 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 08/04/17 07:13, Pavel Roskin wrote:
>> Jonah, I appreciate your advice.
>>
>> I'm still considering using IIO, as I would need some ways to
>> configure the hardware (set interrupt watermark, set some other
>> configuration registers). But it's good to understand why the
>> resulting driver would be unlike all others.
> The primary reason for the existence of a subsystem is to
> provide a consistent userspace interface. In some ways it doesn't
> matter what goes on within the kernel at all.
>
> Now it may be possible to do this for your device, but that would
> only make sense if we were to describe the data in your ring buffer.
> It could be implemented as a hardware ring buffer with no software
> buffer.

I can describe the data.

My concern is that I don't see way to read unparsed blocks of data.
realbits and storagebits are described by u8, which limits them to 255
bits or 63 bytes.

The main userspace consumer of the data will need whole blocks of data
captures at the same time.

> Whilst we fairly recently move the sca3000 driver away from this,
> as in that case an intermediate software buffer made more sense,
> that driver used to do this.
> Jumping back an arbitrary distance:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/staging/iio/accel/sca3000_ring.c?h=iio-for-4.7a&id=486294f184c05cff116160bb731cbb679f047621
> I believe there are drivers in analog devices out of mainline tree
> that do it as well. One example there is the spi offload engine
> support which uses the hardware buffer stuff, but that is somewhat
> cryptic so the sca3000 driver above is probably a better starting
> point.

Thank you for the example! The driver is quite large, it will take me
a while to process.

Do you have any documentation about buffers? It's good to have
iio_simple_dummy_buffer.c, but it doesn't have a hardware buffer mode.

> Then we come to the question of how to describe the data. If you
> don't do this of course you can use IIO out of mainline, but there
> will be little interest in merging it.
>
> If you describe the data using normal IIO channels it is up to you
> whether you then use your own userspace stack or something more
> general.  What we are interested in from a subsystem point of view
> is ensuring you 'could' use standard userspace code.
>
> So what is actually in this magic data dump?  Sensor data by the
> sound of it, so it could be described?  Without that description
> I'm not going to be keen to have it mainline IIO.

Yes, it can be described. It's sensor data, nothing unusual.

> p.s. When replying to a thread, please keep all relevant previous
> emails in there! Makes it a lot easier for those of us running
> a bit behind to catch up.

My bad, I just realized gmail can do the right thing. Jonathan, please
ignore the personal reply, my email setup is new to me.

Pavel
