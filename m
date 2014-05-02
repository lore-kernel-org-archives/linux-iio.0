Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:39101 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbaEBSp4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 May 2014 14:45:56 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so4986651wes.15
        for <linux-iio@vger.kernel.org>; Fri, 02 May 2014 11:45:55 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 2 May 2014 20:45:55 +0200
Message-ID: <CAFKr4p-3k7DfXoLGkKkqptm+0FCZgJcSXR3zFGmP5xUpPU3s8Q@mail.gmail.com>
Subject: How to sample continuously in IIO, but without a trigger per scan set?
From: Leon Woestenberg <sidebranch.linux@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello all,

my first endeavours with IIO began with the requirement to sample a
4-channel SPI ADC at 10 kHz rate with accurate periodicy, lowest
jitter and lowest CPU usage.

I first adapted the SPI master to use the hardware DMA capability for
cyclic transfers from the SPI controller. This fulfills the above
requirements, any other approach would introduce too much jitter,
pause in sample trains, or too much CPU overhead.

Then I started working on the IIO driver to use the above. Then I got stuck.

After a trigger, I would like to capture for a large period of time,
with a fixed sampling frequency, not via a software scheduled trigger
per scan. I.e. any trigger (if at all) should start a continuous
capture.

How can I do this in IIO?

I only see calls of a single scan (4 channels, 16-bits per channel) to
my trigger handler; this induces too much overhead.


Regards,

Leon.
