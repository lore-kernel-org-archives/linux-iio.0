Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C7D48D4.8070106@cam.ac.uk>
Date: Tue, 31 Aug 2010 19:24:20 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
 "Song, Barry" <Barry.Song@analog.com>
Subject: Re: Using uinput
References: <4C7BEF39.2030507@cam.ac.uk>
In-Reply-To: <4C7BEF39.2030507@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/30/10 18:49, Jonathan Cameron wrote:
> Hi All,
> 
> In a thread to do with the cma3000 accelerometer on lkml Dmitry (input maintainer)
> in passing mentioned that an iio to input bridge might exist in userspace
> using uinput.
> 
> Looks to me like this might kill two birds with one stone for us.
> 
> * Would finally provide a route for all those who want their sensor
>   drivers in input because they want to use them for games.
> * Would provide a fairly good test of the generality of the user space interfaces.
> 
> What do people think of this rather than an in kernel bridge?
> 
> Given it would trivially have access to all of the info on what the sensor is producing
> it actually looks much easier to do than the kernel bridge (which was going to need
> a userspace configuration element or a lot of changes to our internal structure).
> 
If anyone is curious, I just cc'd the list in on the mega lkml thread because
my post includes a quick and dirty hacked together bridge.  It works.

Annoying my test platform is currently rather unstable (stargate2).
Git bisect fun tomorrow.

Jonathan
