Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36146 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbdCFIEj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2017 03:04:39 -0500
Date: Mon, 06 Mar 2017 08:04:21 +0000
In-Reply-To: <20170305235202.GA6202@d830.WORKGROUP>
References: <20170305235202.GA6202@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: Linux ELC & OpenIoT Report
To: Alison Schofield <amsfield22@gmail.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <A78098D4-45DA-4D3B-B7EF-06B72FC9DD19@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 5 March 2017 23:52:04 GMT+00:00, Alison Schofield <amsfield22@gmail.com> wrote:
>Hi IIO Community,
>
>I attended the Linux Foundation's Embedded Linux and OpenIoT Summit in
>Portland, Oregon recently.
>
>I've appended a few excerpts from my blog write-up below and the full
>text of my report is available here:
>https://outreachyiio.blogspot.com/2017/03/embedded-linux-conference-openiot.html
>
>alisons
>
>
>2 Things that made me go hmmm:
>
>1) There are developers who believe that user space drivers are more
>efficient than kernel drivers. They don't mean more efficient as in
>they
>don't want to bother upstreaming the driver. They actually mean more
>efficient in that they think the user space driver performs better.  I
>didn't meet one of those developers...they were only whispered about ;)

There are circumstances in which they are right.
Often it is because they don't have to play nice
 with other elements of the system and can burn CPU cycles.

It's the same stuff that the networking lot have had arguements about for years.  Userspace
 drivers often have the flexibility to do nasty stuff to lower latency.  What we need to do is an
 exercise in pinning down the size of the various causes of latency and what we can do to
 reduce them. If anyone wants to do an analysis of a typical userspace driver for these apps
that might be very useful.

Jason's thoughts on control loops in the kernel using bpf might be the ultimate answer, who
 knows! I haven't dug through all that would be involved with that yet... Idea seems interesting
 though.
>
>2) Android Things (Intel & Google product) will not use our lovely IIO
>drivers. They will not include any non-essential drivers in the kernel
>image and there will not be a way to rebuild it. They have set up a git
>repository for the world to share user space drivers for sensors. 
Ah well.... 
>
>IIO Community Sightings: Matt Ranostay 
>Matt gave a great IIO Subsystem presentation!!! It contained a live
>demo
>of one of his more recent driver additions: heart rate and pulse
>oximeter. When Matt's hear rate only measured 42, he wrote it off to a
>loose connection, but I'm not convinced. I may go look for a bug in
>that
>driver ;)
>
>IIO Community Hindsight: David Lechner 
>When I met David displaying his ev3 devices at the technical showcase,
>I
>didn't know of him from the IIO community. David has some drivers he
>wants upstreamed to IIO.  Potential Outreachy projects?  I'm fuzzy on
>this. Can we add support for sensors that basically have no datasheet,
>but that David has reverse engineered?

Sure we can. Lots of drivers in the wider kernel are reverse engineered. A few in IIO may well have been.

Hmm would take a slightly brave outreach y candidate perhaps.

>
>IIO Community Hindsight: Jason Kridner 
>Jason gave a presentation and also showed off some beaglebone devices
>at
>the technical showcase. Jason noted in his presentation that he'd like
>to see additional sensor support in IIO.
Thanks for the update.

Jonathan
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
