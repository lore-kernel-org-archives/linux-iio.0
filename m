Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21909 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbaGDS7w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 4 Jul 2014 14:59:52 -0400
Message-ID: <53B6F9A4.2080302@linux.intel.com>
Date: Fri, 04 Jul 2014 11:59:48 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: panic in iio_trigger_notify_done
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

I got reports of some rare to reproduce random crash in inv_mpu6050 driver.
Always crash points to iio_trigger_notify_done.
Usually, when user space disconnects the trigger by writing a dummy name,
(following example generic_buffer.c)
this indio_dev->trig can be set to NULL. But there can be race between
kernel and user space, so still the iio_trigger_notify_done can be
called, which will try to dereference on NULL pointer.

Recently you commented on my patch that setting
"indio_dev->trig
This is dangerous.  Doing it like this will, IIRC leave the wrong
reference counts for the trigger.  If you really, really want to do
this then call iio_get_trigger on the trigger as well to increment
the use count.  Preferred option is to leave the binding to userspace
after the driver is probed.
"

I have seen several drivers in upstream kernel is doing this assignment,
I have patches to correct all of them assuming  they will used on
x86 platform.

Is it OK to submit patches for all even, if we don't have evidence of 
problem?

Thanks,
Srinivas
