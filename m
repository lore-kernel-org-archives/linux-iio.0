Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:45129 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751578AbaBFU7e (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2014 15:59:34 -0500
Message-ID: <52F3F84F.5040001@metafoo.de>
Date: Thu, 06 Feb 2014 22:02:07 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Alessandro Rubini <rubini@gnudd.com>
CC: john3909@gmail.com, linux-iio@vger.kernel.org, broonie@kernel.org,
	flatmax@flatmax.org
Subject: Re: DMA sampling and IIO
References: <52F35C5B.7080409@metafoo.de>  <CF17C5B7.1940A%john3909@gmail.com> <20140206205327.GA11958@mail.gnudd.com>
In-Reply-To: <20140206205327.GA11958@mail.gnudd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/2014 09:53 PM, Alessandro Rubini wrote:
>> We do have patches for better integration of DMA (especially for high speed
>> devices) into the IIO framework[1]. This is not yet upstream since it is
>> still a bit WIP, but I'm confident that it will find it's way into upstream
>> soon.
>
> ZIO already supports dma. And mmaping the buffer from user space.  It
> is in the design since inception, and in the code since Feb 2012 (git
> log says).

I know. And I did study the ZIO DMA code (among other things), before I 
implemented the IIO DMA code. As you might remember from our last discussion, 
my preference is to add the features that are in ZIO but not in IIO to IIO and 
then ditch ZIO instead of having two frameworks for the class of devices.

- Lars

