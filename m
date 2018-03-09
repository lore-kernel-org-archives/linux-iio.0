Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:45473 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeCIAwE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Mar 2018 19:52:04 -0500
Received: by mail-ua0-f180.google.com with SMTP id n24so1175830ual.12
        for <linux-iio@vger.kernel.org>; Thu, 08 Mar 2018 16:52:04 -0800 (PST)
Date: Thu, 8 Mar 2018 21:52:00 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: linux-iio@vger.kernel.org, daniel.baluta@nxp.com,
        graff.yang@gmail.com, davidjulianveenstra@gmail.com
Subject: Work plan to move AD2S1210 out of staging
Message-ID: <20180309005200.pj6ez2xgrxjwhvxe@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Today I looked at the AD2S1210 code and datasheet. As a result, I present here
the following work plan for discussion:

0) Checkpach free

There are just two 'CHECKs' in this module. Fix it is easy.

1) Update the channels definition

After a first read of the datasheet, I believe the AD2S1210 need an update to
the iio_chan_spec already defined and also requires another channel for
velocity. I am not 100% sure, but I also think that other channels have to be
defined because of this chip has many features (absolute position and velocity,
system fault detect, programmable sinusoidal, etc.); however, I prefer to keep
things simple now.

2) Events for handling error detections

The AD2S1210 provide many fault detection thresholds. The chip triggers some
faults, and I believe the AD2S1210 module can handle it with events interface.
If I am right, I to start by adding LOS  handler.

3) Use IIO ABI

>From what I understood from the documentation, I believe the write using sysfs
interface is not right. The AD2S1210 module should use iio_info for this tasks
(even for read). If I am right, I want to fix it.

Is my work plan to move AD2S1210 out of staging make sense?

Finally, I want to work on AD2S1210, but David Veenstra has priority on
this task because he already expressed his interest in working on
AD2S1210 and AD2S1200.  I proposed to him that we divided this task in
two: I work in the  AD2S1210 and him in the AD2S1200.

Best regards,
Siqueira
