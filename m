Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:51975 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793Ab3BESgF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Feb 2013 13:36:05 -0500
Received: by mail-vc0-f178.google.com with SMTP id m8so274891vcd.9
        for <linux-iio@vger.kernel.org>; Tue, 05 Feb 2013 10:36:04 -0800 (PST)
From: Ge Gao <ggao@invensense.com>
References: <52d13e205f916eefa0b7fda2c8d0f20a@mail.gmail.com>
 <2b0b8fba-fc2c-44fb-9512-d86e87b698c1@email.android.com> <51101648.7000205@metafoo.de>
 <4781ec0fc6f6eb18cc8470fabce3e2a6@mail.gmail.com> <5110D84D.9030308@metafoo.de>
In-Reply-To: <5110D84D.9030308@metafoo.de>
MIME-Version: 1.0
Date: Tue, 5 Feb 2013 10:36:03 -0800
Message-ID: <5f06a44b95d69cb71424a59ce4f461f2@mail.gmail.com>
Subject: RE: [PATCH] [V9] Invensense MPU6050 Device Driver.
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Lars-Peter,
	I am using iio_get_time_ns() to get the timestamp. The variation
is big. For example, the frequency is 10Hz, which translates into 100ms
per interrupt. However, I get something like 100, 100, 40, 160, 100,
100...... When a smaller timestamp happens, a big one follows to
compensates it. So on average, it is hard to tell.. Only on per interrupt
basis, you can tell it. While on an oscilloscope, I can see interrupts
come at a very regular and precise pace. The hardware I am using Panda
board.  However, I don't think it is the hardware problem. The time
function is updated via a timer interrupt. On a dual core system, it might
be possible that one core cache get updated while the other is not. When
interrupt happens, if the "wrong" CPU takes the interrupt, it might cause
the problem. The iio_get_time_ns() is calling ktime_get_real_ts(), which
calls getnstimeofday(). This function basically uses a static variable to
get time. If the static variable is not updated, which could happen on an
interrupt environment, and CPU is just using its cached version, it is
quite possible that the data is wrong.
	Thanks.

Best Regards,

GE GAO

-----Original Message-----
From: Lars-Peter Clausen [mailto:lars@metafoo.de]
Sent: Tuesday, February 05, 2013 2:01 AM
To: Ge Gao
Cc: Jonathan Cameron; linux-iio@vger.kernel.org
Subject: Re: [PATCH] [V9] Invensense MPU6050 Device Driver.

On 02/05/2013 02:28 AM, Ge Gao wrote:
> Dear Lars and Jonanthan,
> 	I have one question regarding the timestamp inside IRQ. I found
that
> the timestamp taken during IRQ is not accurate and it varies a lot. I
> can see the hardware interrupt came in a regular pace while the
> timestamp taken varies violently(up to 50% or more). It seems that it
> is because the data cache that stores the timestamp(xtime) is not
> updated when there is interrupt. So it actually takes the wrong
> timestamp. I searched online and didn't find any useful ideas. I think
> taking timestamp during IRQ is a common practice. Is there any
> existing solution for this or did I do anything wrong? The code in the
> current patch is inv_mpu6050_irq_handler() of inv_mpu_ring.c. Thanks.

What kind of time variation are we talking about? nanosecons,
microseconds, milliseconds? iio_get_time_ns should query the systems
clockchip and so the result should be pretty precise.

- Lars
