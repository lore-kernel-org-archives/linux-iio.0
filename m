Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56183 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbaHCPnZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Aug 2014 11:43:25 -0400
Message-ID: <53DE5898.1040806@kernel.org>
Date: Sun, 03 Aug 2014 16:43:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: gmane@reliableembeddedsystems.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: linux-iio@vger.kernel.org
Subject: Re: iio A/D converter input to input event subsystem
References: <b12ce7f23b622a613c07e9de19ece607@reliableembeddedsystems.com> <20140803095610.GQ3214@piout.net> <33f1c38a7367710e30956080fa02da8a@reliableembeddedsystems.com>
In-Reply-To: <33f1c38a7367710e30956080fa02da8a@reliableembeddedsystems.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/08/14 16:08, gmane@reliableembeddedsystems.com wrote:
> Hi,
> 
> On 2014-08-03 04:56, Alexandre Belloni wrote:
>> Hi Robert,
> 
>>
>> Did you have a look at uinput? This would allow you to inject input
>> events after processing the ADC values in userspace.
>>
>> Simple example: http://thiemonge.org/getting-started-with-uinput
> 
> Thanks this looks interesting. I had in the meantime a look at iio_hwmon [1] which does something similar to what I want
> for the hwmon subsystem instead of the input event subsystem.

There is a rather aged iio_input driver, that uses the buffered interface (not polled)
and could probably be adapted to your usecase reasonably easily.  The case is different enough
that I'd probably suggest a new driver for it though rather than trying to blugeon it into
the existing driver.

http://www.spinics.net/lists/linux-iio/msg06881.html (latest version I think).
The infrastructure for this went in back then, but the input driver never quite got the
attention it needed.

One big issue outstanding around this stuff is that no one likes the device
tree bindings.  Probably doesn't matter for your project in the short term however!

Jonathan
> 
> Regards,
> 
> Robert
> 
> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/iio_hwmon.c?id=refs/tags/v3.16-rc7
=
