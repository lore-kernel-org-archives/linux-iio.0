Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:36687 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbdCFDkX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 22:40:23 -0500
Received: by mail-ua0-f176.google.com with SMTP id 72so155102735uaf.3
        for <linux-iio@vger.kernel.org>; Sun, 05 Mar 2017 19:40:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170305235202.GA6202@d830.WORKGROUP>
References: <20170305235202.GA6202@d830.WORKGROUP>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Sun, 5 Mar 2017 19:31:50 -0800
Message-ID: <CAJCx=gmAEXhZCMpDdvNQ+9Cw+E_gqS3H6rSkYo=vM_5QaBmYxA@mail.gmail.com>
Subject: Re: Linux ELC & OpenIoT Report
To: Alison Schofield <amsfield22@gmail.com>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 5, 2017 at 3:52 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> Hi IIO Community,
>
> I attended the Linux Foundation's Embedded Linux and OpenIoT Summit in
> Portland, Oregon recently.
>
> I've appended a few excerpts from my blog write-up below and the full
> text of my report is available here:
> https://outreachyiio.blogspot.com/2017/03/embedded-linux-conference-openiot.html
>
> alisons
>
>
> 2 Things that made me go hmmm:
>
> 1) There are developers who believe that user space drivers are more
> efficient than kernel drivers. They don't mean more efficient as in they
> don't want to bother upstreaming the driver. They actually mean more
> efficient in that they think the user space driver performs better.  I
> didn't meet one of those developers...they were only whispered about ;)
>
> 2) Android Things (Intel & Google product) will not use our lovely IIO
> drivers. They will not include any non-essential drivers in the kernel
> image and there will not be a way to rebuild it. They have set up a git
> repository for the world to share user space drivers for sensors.
>
> IIO Community Sightings: Matt Ranostay
> Matt gave a great IIO Subsystem presentation!!! It contained a live demo
> of one of his more recent driver additions: heart rate and pulse
> oximeter. When Matt's hear rate only measured 42, he wrote it off to a
> loose connection, but I'm not convinced. I may go look for a bug in that
> driver ;)

Actually it was because I was talking it was at 42.. it did go back to
~90 in the demo which is more sane
when I stop talking for a few seconds. There is a reason the doctors
tell you to breathe normally and not
talk when taking your blood pressure. Not exactly what you are doing
in a talk though :).

Not doubt there are bugs... but more likely in the oximeter processing
script since there is a lot of peak detection
magic I'm not sure is 100% accurate :).

>
> IIO Community Hindsight: David Lechner
> When I met David displaying his ev3 devices at the technical showcase, I
> didn't know of him from the IIO community. David has some drivers he
> wants upstreamed to IIO.  Potential Outreachy projects?  I'm fuzzy on
> this. Can we add support for sensors that basically have no datasheet,
> but that David has reverse engineered?
>
> IIO Community Hindsight: Jason Kridner
> Jason gave a presentation and also showed off some beaglebone devices at
> the technical showcase. Jason noted in his presentation that he'd like
> to see additional sensor support in IIO.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
