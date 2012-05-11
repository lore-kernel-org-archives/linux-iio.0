Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:38905 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755569Ab2EKHkX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 03:40:23 -0400
Message-ID: <4FACC265.4000408@cam.ac.uk>
Date: Fri, 11 May 2012 08:40:21 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: linux-iio@vger.kernel.org
Subject: Re: trigger removal problem.
References: <dca0c620c60e1144778bfea74da1336b@mail.gmail.com>
In-Reply-To: <dca0c620c60e1144778bfea74da1336b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/11/2012 12:53 AM, Ge Gao wrote:
> Dear all,
>
>                  I am building my IIO driver as a module and will
> constantly need to use "insmod" and "rmmod" to install it and remove it
> due to development. However, I found that if I write anything to the
> "trigger/current_trigger", it will not be able to remove it. The error
> code is (11). Even I write "null" to it, it will not be able to be
> removed.
> However, If I don't write anything to it, just insmod and rmmod, it will
> be remove successfully. Any idea what could cause this problem? I followed
> what is in the IIO subsystem driver to write my driver. I can post it if
> anyone want to take a look.
Hi Ge,

I'm afraid I won't be able to do any testing until at least tomorrow.
There are a few things that could give more information though in the
meantime:

* Could you try the above, but note down the reference counts that
lsmod will give you for the various drivers at each step of the
process. (before connecting the trigger, whilst it is connected and upon
disconnecting).

* Is there anything left when you read 'current_trigger' after writing
an invalid name to it?

*  Are you using an existing trigger or is it also part of you driver?

Having the source code when I dig futher into this would also be helpful.

Anyone else seen anything similar?  I haven't run any removal hammering
tests for a month or so, so something might have slipped into the core...

Jonathan
>
>                  Thanks.
>
>
>
> Ge
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

