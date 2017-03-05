Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33325 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbdCEX7E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 18:59:04 -0500
Received: by mail-pg0-f47.google.com with SMTP id 25so59747973pgy.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Mar 2017 15:59:03 -0800 (PST)
Received: from d830 (or-67-232-66-135.dhcp.embarqhsd.net. [67.232.66.135])
        by smtp.gmail.com with ESMTPSA id 23sm11176262pfz.127.2017.03.05.15.52.06
        for <linux-iio@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Mar 2017 15:52:07 -0800 (PST)
Date: Sun, 5 Mar 2017 15:52:04 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: linux-iio@vger.kernel.org
Subject: Linux ELC & OpenIoT Report
Message-ID: <20170305235202.GA6202@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi IIO Community,

I attended the Linux Foundation's Embedded Linux and OpenIoT Summit in
Portland, Oregon recently.

I've appended a few excerpts from my blog write-up below and the full
text of my report is available here:
https://outreachyiio.blogspot.com/2017/03/embedded-linux-conference-openiot.html

alisons


2 Things that made me go hmmm:

1) There are developers who believe that user space drivers are more
efficient than kernel drivers. They don't mean more efficient as in they
don't want to bother upstreaming the driver. They actually mean more
efficient in that they think the user space driver performs better.  I
didn't meet one of those developers...they were only whispered about ;)

2) Android Things (Intel & Google product) will not use our lovely IIO
drivers. They will not include any non-essential drivers in the kernel
image and there will not be a way to rebuild it. They have set up a git
repository for the world to share user space drivers for sensors. 

IIO Community Sightings: Matt Ranostay 
Matt gave a great IIO Subsystem presentation!!! It contained a live demo
of one of his more recent driver additions: heart rate and pulse
oximeter. When Matt's hear rate only measured 42, he wrote it off to a
loose connection, but I'm not convinced. I may go look for a bug in that
driver ;)

IIO Community Hindsight: David Lechner 
When I met David displaying his ev3 devices at the technical showcase, I
didn't know of him from the IIO community. David has some drivers he
wants upstreamed to IIO.  Potential Outreachy projects?  I'm fuzzy on
this. Can we add support for sensors that basically have no datasheet,
but that David has reverse engineered?

IIO Community Hindsight: Jason Kridner 
Jason gave a presentation and also showed off some beaglebone devices at
the technical showcase. Jason noted in his presentation that he'd like
to see additional sensor support in IIO.
