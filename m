Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:55228 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753009AbdCFL7f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2017 06:59:35 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Linux ELC & OpenIoT Report
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Alison Schofield <amsfield22@gmail.com>,
        linux-iio@vger.kernel.org
References: <20170305235202.GA6202@d830.WORKGROUP>
 <A78098D4-45DA-4D3B-B7EF-06B72FC9DD19@jic23.retrosnub.co.uk>
Message-ID: <86c71ea2-55dd-fa43-2825-3482d46e8f6d@metafoo.de>
Date: Mon, 6 Mar 2017 12:58:44 +0100
MIME-Version: 1.0
In-Reply-To: <A78098D4-45DA-4D3B-B7EF-06B72FC9DD19@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/06/2017 09:04 AM, Jonathan Cameron wrote:
> 
> 
> On 5 March 2017 23:52:04 GMT+00:00, Alison Schofield <amsfield22@gmail.com> wrote:
>> Hi IIO Community,
>>
>> I attended the Linux Foundation's Embedded Linux and OpenIoT Summit in
>> Portland, Oregon recently.
>>
>> I've appended a few excerpts from my blog write-up below and the full
>> text of my report is available here:
>> https://outreachyiio.blogspot.com/2017/03/embedded-linux-conference-openiot.html
>>
>> alisons
>>
>>
>> 2 Things that made me go hmmm:
>>
>> 1) There are developers who believe that user space drivers are more
>> efficient than kernel drivers. They don't mean more efficient as in
>> they
>> don't want to bother upstreaming the driver. They actually mean more
>> efficient in that they think the user space driver performs better.  I
>> didn't meet one of those developers...they were only whispered about ;)
> 
> There are circumstances in which they are right.
> Often it is because they don't have to play nice
>  with other elements of the system and can burn CPU cycles.
> 
> It's the same stuff that the networking lot have had arguements about for years.  Userspace
>  drivers often have the flexibility to do nasty stuff to lower latency.  What we need to do is an
>  exercise in pinning down the size of the various causes of latency and what we can do to
>  reduce them. If anyone wants to do an analysis of a typical userspace driver for these apps
> that might be very useful.

I like to argue that we've reached the post-framework era. Hardware is
getting quite complex, on one extreme they are too versatile and on the
other extreme too specialized for it to be practical to create a generic driver.

To be able to accommodate this tje current trend is that all frameworks are
drifting to is to having a property system. A device has properties and each
property has a value that can be read or written. But the the semantics are
otherwise completely up to the driver (except for a set of baseline properties).

A framework always introduces additional overhead by having indirection, so
to offset this overhead the framework needs to offer something in return.
For hardware abstraction layers this promise has often been that you can
write generic applications, that if they use the framework's API, can work
with any hardware for which a framework driver exists. Now with the property
approach this promise is gone. Each driver has custom semantics all that is
generic is the marshaling and unmarshaling of the data structures that are
used to communicate between the driver and the application.

This means and application needs to be aware of the specifics of the
hardware anyway. So why go through the hassle of using the framework and
introducing additional overhead if there are no gains.

So what we are seeing instead are application specific drivers. A piece of
software (driver, library, application whatever you want to call it) that is
aware of the intrinsics of the hardware and configures the hardware for a
specific usecase. It can typically do this much more efficient than a
generic driver since it can completely ignore all other usecase, while a
generic driver needs to somehow try to balance between all possible usecases.

With these application specific drivers you are not limited to one driver
per device, but there are many drivers for the same device, they are just
not active at the same time or even on the same system since different
systems use the same hardware for different usecases.


