Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35256 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdAMONy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jan 2017 09:13:54 -0500
Received: by mail-yw0-f180.google.com with SMTP id l19so31770562ywc.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Jan 2017 06:13:54 -0800 (PST)
MIME-Version: 1.0
From: Matthias Klumpp <matthias@tenstral.net>
Date: Fri, 13 Jan 2017 15:13:53 +0100
Message-ID: <CAKNHny9CYKzSoyq_-T3q35rq=1y1ekQPXr2Rg1ByhabadMWv9A@mail.gmail.com>
Subject: Using IIO for high-speed DAQ
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello!
I would like to use IIO for high-speed data acquisition. In order to
do that I implemented a new IIO driver for the ADC chip I am using
(MAX1133, maximum sampling frequency 200ksps).

The initial approach with triggered buffers was way too slow,
achieving only a maximum sampling frequency of 4ksps.
I now changed the driver to use DMA, using the recent code landed in
IIO. The DMA dummy driver was very helpful as a template for writing
the new code and seeing how all parts fit together (why isn't this
included in the kernel?).

I am now achieving sampling frequencies of 6.6ksps, which is far
better but still way below what the chip can do. As a bonus, I got rid
of the need to trigger scans explicitly, which is quite nice for my
application.

In any case, 6.6ksps is still pretty slow, and I would ideally like to
sample with at least 10ksps, and sampling 200ksps would of course be
the ideal goal.

The question is, can IIO do that, and if so, how? Using iio_readdev
from libiio on my device prints a warning about high-speed mode not
being enabled, but I couldn't find much information on how to enable
that properly.
Maybe Lars-Peter Clausen could comment on that.

In general, if I can't use IIO, I would be stuck with rolling my own
driver without the benefit of using the IIO subsystem, or tap into
COMEDI which is a complete overkill for this usecase.

In any case, it would be awesome if someone could give me some
pointers on what to do here (I know Analog Devices uses IIO for an
oscilloscope application, so I guess high sampling rates are possible,
the question is how one can achieve that and if it makes sense at
all).

Kind regards,
    Matthias
