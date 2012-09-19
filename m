Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51073 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756622Ab2ISQOf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Sep 2012 12:14:35 -0400
References: <CAEE_umptNVPOYeTANC4mtAo8AxizmFkrFoa0eLGoLFtTRgWzng@mail.gmail.com> <CAEE_umoJ-QmmFMkiXE0AvC3cE4PoD2DrsivFa-49jS2L=nG0ZA@mail.gmail.com>
In-Reply-To: <CAEE_umoJ-QmmFMkiXE0AvC3cE4PoD2DrsivFa-49jS2L=nG0ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Fwd: iio_trigger doesn't work
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 19 Sep 2012 17:14:22 +0100
To: Denis Ciocca <denis.ciocca@gmail.com>, linux-iio@vger.kernel.org
Message-ID: <ac6def29-515a-4d2e-8d97-ed5b6378a320@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Denis Ciocca <denis.ciocca@gmail.com> wrote:

>Hi everybody,
>
>I write in this mailing list because I have some problems to
>understand the trigger event catch and I ask for your help.
>
>I write a little driver for accelerometer and the core driver works,
>but now I want to write trigger code. What I understand is that:
>
>1. register iio_trigger;
>2. associate iio_trigger to iio_dev;
>3. associate pollfunc with iio_alloc_pollfunc to iio_info;

Buffer set up and enabled?
>
>when trigger occuring (in my example at hrtimers), I call
>iio_trigger_poll() function and I expect which handler function
>declared inside iio_alloc_pollfunc(...) is called.
>This does not happen!

Superficially looks correct.  Verify the trigger association worked by checking current_trigger under sysfs entry for the iio device.  Otherwise either post code or insert some printk statements to see where things are going.
>
>What I'm doing wrong?
>There is some documentation about this?

Kind of in code... generic_buffer.c for userspace side and dummy driver for kernel side.  Text docs rotted so until someone has time to update heavily commented examples were more useful.
>
>Thanks,
>
>Denis
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
