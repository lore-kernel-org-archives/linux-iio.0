Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37442 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbdDHOgL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 10:36:11 -0400
Subject: Re: Raw data block input: is IIO a good choice?
To: Pavel Roskin <plroskin@gmail.com>, Jonah Petri <jonah@sense.com>,
        linux-iio@vger.kernel.org
References: <CAN_72e1apsS2nKh7SYiETz+=bJW7mEBS6GV8DmzZEPzroaeACg@mail.gmail.com>
 <23293209-00F9-4D1E-8822-00B3B267EF79@sense.com>
 <CAN_72e0u+fgOB9TmvP55pDLOC1Z9vGYnNj5Zpogc1b-K7xW7WA@mail.gmail.com>
 <AD6B3C1C-0A2A-4941-86E6-D2AFB6446E18@sense.com>
 <CAN_72e3-Zzr7b9sLfKk1EGeAYwb03=UrJsGpLOGbR4C-QjOtLw@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4311cd69-c853-8fee-c0d2-0476b24580e4@kernel.org>
Date: Sat, 8 Apr 2017 15:36:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAN_72e3-Zzr7b9sLfKk1EGeAYwb03=UrJsGpLOGbR4C-QjOtLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/17 07:13, Pavel Roskin wrote:
> Jonah, I appreciate your advice.
> 
> I'm still considering using IIO, as I would need some ways to
> configure the hardware (set interrupt watermark, set some other
> configuration registers). But it's good to understand why the
> resulting driver would be unlike all others.
The primary reason for the existence of a subsystem is to
provide a consistent userspace interface. In some ways it doesn't
matter what goes on within the kernel at all.

Now it may be possible to do this for your device, but that would
only make sense if we were to describe the data in your ring buffer.
It could be implemented as a hardware ring buffer with no software
buffer.

Whilst we fairly recently move the sca3000 driver away from this,
as in that case an intermediate software buffer made more sense,
that driver used to do this.
Jumping back an arbitrary distance:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/staging/iio/accel/sca3000_ring.c?h=iio-for-4.7a&id=486294f184c05cff116160bb731cbb679f047621
I believe there are drivers in analog devices out of mainline tree
that do it as well. One example there is the spi offload engine
support which uses the hardware buffer stuff, but that is somewhat
cryptic so the sca3000 driver above is probably a better starting
point.

Then we come to the question of how to describe the data. If you
don't do this of course you can use IIO out of mainline, but there
will be little interest in merging it.

If you describe the data using normal IIO channels it is up to you
whether you then use your own userspace stack or something more
general.  What we are interested in from a subsystem point of view
is ensuring you 'could' use standard userspace code.

So what is actually in this magic data dump?  Sensor data by the
sound of it, so it could be described?  Without that description
I'm not going to be keen to have it mainline IIO.

Jonathan

p.s. When replying to a thread, please keep all relevant previous
emails in there! Makes it a lot easier for those of us running
a bit behind to catch up.

> 
> Pavel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

