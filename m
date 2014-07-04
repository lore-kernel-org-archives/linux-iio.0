Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59557 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbaGDVJL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jul 2014 17:09:11 -0400
In-Reply-To: <53B6F9A4.2080302@linux.intel.com>
References: <53B6F9A4.2080302@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: panic in iio_trigger_notify_done
From: Jonathan Cameron <jic23@kernel.org>
Date: Fri, 04 Jul 2014 22:09:02 +0100
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org
Message-ID: <3bdcc377-bc21-40ca-894c-162cee7c0cf0@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On July 4, 2014 7:59:48 PM GMT+01:00, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>Hi Jonathan,
>
>I got reports of some rare to reproduce random crash in inv_mpu6050
>driver.
>Always crash points to iio_trigger_notify_done.
>Usually, when user space disconnects the trigger by writing a dummy
>name,
>(following example generic_buffer.c)
>this indio_dev->trig can be set to NULL. But there can be race between
>kernel and user space, so still the iio_trigger_notify_done can be
>called, which will try to dereference on NULL pointer.
>
>Recently you commented on my patch that setting
>"indio_dev->trig
>This is dangerous.  Doing it like this will, IIRC leave the wrong
>reference counts for the trigger.  If you really, really want to do
>this then call iio_get_trigger on the trigger as well to increment
>the use count.  Preferred option is to leave the binding to userspace
>after the driver is probed.
>"
>
>I have seen several drivers in upstream kernel is doing this
>assignment,
>I have patches to correct all of them assuming  they will used on
>x86 platform.
>
>Is it OK to submit patches for all even, if we don't have evidence of 
>problem?
Absolutely. I had a feeling I haven't kept a close eye on this one and I is definitely a real
 issue as you can tract the reference counts easily enough and see it is zero when it
 should not be! 


>
>Thanks,
>Srinivas
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
