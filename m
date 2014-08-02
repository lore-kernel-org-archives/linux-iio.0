Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46256 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405AbaHBL2N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Aug 2014 07:28:13 -0400
Message-ID: <53DCCB4A.3020304@kernel.org>
Date: Sat, 02 Aug 2014 12:28:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Aniroop Mathur <aniroop.mathur@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: IIO: Why cannot open two iio device node file descriptors simultaneously
 ?
References: <CADYu309fV8qNv0v03xr1T0eeLEV97YFPoAVkKdT8jZcom8uqGQ@mail.gmail.com>
In-Reply-To: <CADYu309fV8qNv0v03xr1T0eeLEV97YFPoAVkKdT8jZcom8uqGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/31/14 18:07, Aniroop Mathur wrote:
> Dear IIO Community,
> Greetings !!
> 
> I am Aniroop Mathur working in Sensors kernel and HAL field.
> I have one question about IIO, for which i need your support.
> 
> I would like to open two file descriptors for IIO device node - /dev/iio:device0
> int fd1 = open("/dev/iio:device0",O_RDONLY);
> int fd2 = open("/dev/iio:device0",O_RDONLY);
> 
> But, only first open call succeeds.
> The second open calls fails with error "Device or Resource busy".
> 
> In normal input device, we can open as many event node file
> descriptors as we like.
> int fd1 = open("/dev/input/event1");
> int fd2 = open("/dev/input/event1");
> 
> Both calls succeeds for input subsystem case.
> 
> So, why restriction is present in IIO subsystem ?
Basically a different design descision for the userspace interfaces.  Input moves
a lot of handling and processing into the kernel.  For IIO, which at least sometimes
is dealing with much faster devices, this adds overhead.  Note that we remove
all overhead of description of data from the main data stream to reduce overhead
so that must be described elsewhere (sysfs).

If you really want to do that then we do have a prototype input client driver for IIO
(though it's not seen much work recently).

In theory it is possible to have more userspace exposed buffer associated with
a given IIO device, though right now this isn't actually done.  The intent of that
infrastructure is to provide splitting of data to multiple users within the kernel
(one might be IIO, another input and a third battery monitoring).

Ultimately if you want multiple userspace devices to share a datastream, then it
makes sense to avoid multiple switches in and out of the kernel and do it in userspace
instead.

Jonathan

> Why two iio device nodes cannot be open together ?
Not quite what I think you mean.  You mean, why can you not open the same device node
twice?
> 
> Thanks in advance !
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
