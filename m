Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47847 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdDBKMO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 06:12:14 -0400
To: Wolfram Sang <wsa@the-dreams.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Subject: DMA safe buffers for I2C.
Message-ID: <5e4f022e-9434-2892-4fac-94cadd1f8f43@kernel.org>
Date: Sun, 2 Apr 2017 11:12:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Wolfram,

Just looking to get up to date info on whether we need to be careful
with cachelines on buffers passed to i2c function calls or not.
i.e. do they need to DMA safe buffers.

I have it in the back of my head somewhere that i2c insisted that
if necessary this was sorted by the i2c master drivers, but I
suspect I am completely wrong.

There are 'lots' of drivers out there that aren't taking care of
this.  We have traditionally been much better with SPI where there
were explicit warnings about this.

Anyhow, could you clarify the situation?  Even if we audited existing
master drivers to check we were fine, if it's not coming from you
the chances are another one would sneak in sometime in the future
which does need dma safe buffers.

Certainly a superficial glance suggests that the at91 i2c master
is mapping these directly as DMA buffers.

Anyhow, what I'm really looking for is a quick email that I can
point people at in future ;)  or a reference to one somewhere else.

Thanks,

Jonathan
