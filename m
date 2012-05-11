Return-Path: <ggao@invensense.com>
From: Ge Gao <ggao@invensense.com>
References: <dca0c620c60e1144778bfea74da1336b@mail.gmail.com> <4FACC265.4000408@cam.ac.uk>
In-Reply-To: <4FACC265.4000408@cam.ac.uk>
MIME-Version: 1.0
Date: Fri, 11 May 2012 10:45:28 -0700
Message-ID: <26bba6e6470eba82ab34f37d5a7a69da@mail.gmail.com>
Subject: RE: trigger removal problem.
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

I found that if I write "NULL" to the "current_trigger", it will not be
able to be removed. However, if I write a valid trigger name, such as the
one in my driver code, it can be removed. Looks strange. But solve the
problem anyway.
I actually want to submit my driver code to you. However, it is pretty
big(it supports all invensense sensors, which are similar but some
differences still). Is that possible I package the code and send it
directly?
Thanks for your help.

Ge


-----Original Message-----
From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
Sent: Friday, May 11, 2012 12:40 AM
To: Ge Gao
Cc: linux-iio@vger.kernel.org
Subject: Re: trigger removal problem.

On 5/11/2012 12:53 AM, Ge Gao wrote:
> Dear all,
>
>                  I am building my IIO driver as a module and will
> constantly need to use "insmod" and "rmmod" to install it and remove
> it due to development. However, I found that if I write anything to
> the "trigger/current_trigger", it will not be able to remove it. The
> error code is (11). Even I write "null" to it, it will not be able to
> be removed.
> However, If I don't write anything to it, just insmod and rmmod, it
> will be remove successfully. Any idea what could cause this problem? I
> followed what is in the IIO subsystem driver to write my driver. I can
> post it if anyone want to take a look.
Hi Ge,

I'm afraid I won't be able to do any testing until at least tomorrow.
There are a few things that could give more information though in the
meantime:

* Could you try the above, but note down the reference counts that lsmod
will give you for the various drivers at each step of the process. (before
connecting the trigger, whilst it is connected and upon disconnecting).

* Is there anything left when you read 'current_trigger' after writing an
invalid name to it?

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
> To unsubscribe from this list: send the line "unsubscribe linux-iio"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
