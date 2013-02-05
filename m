Return-Path: <lars@metafoo.de>
Message-ID: <511161DA.1020607@metafoo.de>
Date: Tue, 05 Feb 2013 20:47:38 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] [V9] Invensense MPU6050 Device Driver.
References: <52d13e205f916eefa0b7fda2c8d0f20a@mail.gmail.com> <2b0b8fba-fc2c-44fb-9512-d86e87b698c1@email.android.com> <51101648.7000205@metafoo.de> <4781ec0fc6f6eb18cc8470fabce3e2a6@mail.gmail.com> <5110D84D.9030308@metafoo.de> <5f06a44b95d69cb71424a59ce4f461f2@mail.gmail.com>
In-Reply-To: <5f06a44b95d69cb71424a59ce4f461f2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 02/05/2013 07:36 PM, Ge Gao wrote:
> Dear Lars-Peter,
> 	I am using iio_get_time_ns() to get the timestamp. The variation
> is big. For example, the frequency is 10Hz, which translates into 100ms
> per interrupt. However, I get something like 100, 100, 40, 160, 100,
> 100...... When a smaller timestamp happens, a big one follows to
> compensates it. So on average, it is hard to tell.

Hm, this looks a bit odd indeed. Do you have other drivers active which could
be running code with interrupts disabled (e.g. their interrupt handlers) and be
delaying your interrupt handler?

> Only on per interrupt
> basis, you can tell it. While on an oscilloscope, I can see interrupts
> come at a very regular and precise pace. The hardware I am using Panda
> board.  However, I don't think it is the hardware problem. The time
> function is updated via a timer interrupt. On a dual core system, it might
> be possible that one core cache get updated while the other is not. When
> interrupt happens, if the "wrong" CPU takes the interrupt, it might cause
> the problem. The iio_get_time_ns() is calling ktime_get_real_ts(), which
> calls getnstimeofday(). This function basically uses a static variable to
> get time. If the static variable is not updated, which could happen on an
> interrupt environment, and CPU is just using its cached version, it is
> quite possible that the data is wrong.
> 	Thanks.

If you take a look at getnstimeofday() carefully you'll see that it will also
call timekeeping_get_ns() which again queries the hardware directly and adds
the difference between the hardware timestamp and the timestamp when the static
variable was updated to the result, so it should be pretty precise. Or maybe
your hardware source is so imprecise, but I doubt it.

- Lars

> 
> Best Regards,
> 
> GE GAO
> 
> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Tuesday, February 05, 2013 2:01 AM
> To: Ge Gao
> Cc: Jonathan Cameron; linux-iio@vger.kernel.org
> Subject: Re: [PATCH] [V9] Invensense MPU6050 Device Driver.
> 
> On 02/05/2013 02:28 AM, Ge Gao wrote:
>> Dear Lars and Jonanthan,
>> 	I have one question regarding the timestamp inside IRQ. I found
> that
>> the timestamp taken during IRQ is not accurate and it varies a lot. I
>> can see the hardware interrupt came in a regular pace while the
>> timestamp taken varies violently(up to 50% or more). It seems that it
>> is because the data cache that stores the timestamp(xtime) is not
>> updated when there is interrupt. So it actually takes the wrong
>> timestamp. I searched online and didn't find any useful ideas. I think
>> taking timestamp during IRQ is a common practice. Is there any
>> existing solution for this or did I do anything wrong? The code in the
>> current patch is inv_mpu6050_irq_handler() of inv_mpu_ring.c. Thanks.
> 
> What kind of time variation are we talking about? nanosecons,
> microseconds, milliseconds? iio_get_time_ns should query the systems
> clockchip and so the result should be pretty precise.
> 
> - Lars
