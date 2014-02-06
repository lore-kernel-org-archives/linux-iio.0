Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relaygw2-2.mclink.it ([213.21.178.137]:48710 "EHLO
	relaygw2-2.mclink.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbaBFVQk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2014 16:16:40 -0500
Received: from [195.110.128.82] (HELO smtpoutgw1.mclink.it)
  by relaygw2-2.mclink.it (CommuniGate Pro SMTP 6.0.4)
  with ESMTP id 11575438 for linux-iio@vger.kernel.org; Thu, 06 Feb 2014 22:16:38 +0100
Date: Thu, 6 Feb 2014 22:16:37 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: lars@metafoo.de
Cc: john3909@gmail.com, linux-iio@vger.kernel.org, broonie@kernel.org,
	flatmax@flatmax.org
Subject: Re: DMA sampling and IIO
Message-ID: <20140206211637.GA14525@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52F3F84F.5040001@metafoo.de>
References: <52F3F84F.5040001@metafoo.de>  <52F35C5B.7080409@metafoo.de>
  <CF17C5B7.1940A%john3909@gmail.com>
 <20140206205327.GA11958@mail.gnudd.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>> ZIO already supports dma. And mmaping the buffer from user space.  It
>> is in the design since inception, and in the code since Feb 2012 (git
>> log says).
> 
> I know. And I did study the ZIO DMA code (among other things),
> before I implemented the IIO DMA code. As you might remember from
> our last discussion, my preference is to add the features that are
> in ZIO but not in IIO to IIO and then ditch ZIO instead of having
> two frameworks for the class of devices.

I remember. And we both know that the class of devices that ZIO already
supports cannot be supported by IIO, unless many incompatible changes
are made (sub-nanosecond timestamps, symmetric input and output,
hot-swap of buffer and trigger type, ...).

I'm happy all accelerometers have the same interface to user space,
this is definitely useful. But that's clearly not the same class of
devices.

> and then ditch ZIO

How can you "ditch" something you don't use? Or is your employer
currently using zio while helping iio catch up?

Our users will not stop using it, despite your desire, because it
already serves them pretty well: 100MS ADC, with DMA and mmap, all
sysfs-based, completely run-time configurable, and v2.6.24..v3.12 (13
untested yet).

/alessandro
