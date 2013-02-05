Return-Path: <lars@metafoo.de>
Message-ID: <5110D84D.9030308@metafoo.de>
Date: Tue, 05 Feb 2013 11:00:45 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] [V9] Invensense MPU6050 Device Driver.
References: <52d13e205f916eefa0b7fda2c8d0f20a@mail.gmail.com> <2b0b8fba-fc2c-44fb-9512-d86e87b698c1@email.android.com> <51101648.7000205@metafoo.de> <4781ec0fc6f6eb18cc8470fabce3e2a6@mail.gmail.com>
In-Reply-To: <4781ec0fc6f6eb18cc8470fabce3e2a6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 02/05/2013 02:28 AM, Ge Gao wrote:
> Dear Lars and Jonanthan,
> 	I have one question regarding the timestamp inside IRQ. I found that the
> timestamp taken during IRQ is not accurate and it varies a lot. I can see
> the hardware interrupt came in a regular pace while the timestamp taken
> varies violently(up to 50% or more). It seems that it is because the data
> cache that stores the timestamp(xtime) is not updated when there is
> interrupt. So it actually takes the wrong timestamp. I searched online and
> didn't find any useful ideas. I think taking timestamp during IRQ is a
> common practice. Is there any existing solution for this or did I do
> anything wrong? The code in the current patch is inv_mpu6050_irq_handler()
> of inv_mpu_ring.c. Thanks.

What kind of time variation are we talking about? nanosecons, microseconds,
milliseconds? iio_get_time_ns should query the systems clockchip and so the
result should be pretty precise.

- Lars
