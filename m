Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34694 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbcALPuT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jan 2016 10:50:19 -0500
Received: by mail-wm0-f53.google.com with SMTP id u188so261455690wmu.1
        for <linux-iio@vger.kernel.org>; Tue, 12 Jan 2016 07:50:18 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 12 Jan 2016 23:50:17 +0800
Message-ID: <CAAn_ec90RULN=X=uoV4CrztyiQ0dsBOjYcSqgmbxqOheQR56ZA@mail.gmail.com>
Subject: How to address a latency issue in a data acquisition system (IIO based)?
From: Julio Cruz <jcsistemas2001@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'm running an acquisition system @1KHz sampling frequency (27
bytes/sample) with libiio as interface between the application and the
IIO driver (SPI based). The network and local context are working as
expected.

However, the system have some data loss at SPI level (confirmed by
scope) even if the data is not pushed to the buffer
(iio_push_to_buffers). The scope show that every 1.4 sec (aprox), the
handler is not called. It seem other process is taking priority over
this.

I'm trying to find the process that is taking over the SPI/IRQ handlers.

- My system is running in ext4 (on SD) and maybe this could be the
problem (journal)?
- Implement a RT and review interrupt context as suggested by Xander
(http://marc.info/?l=linux-iio&m=143933412720586&w=2)?
- I would like to implement a DMA buffer as suggested by Lars (two
month ago) but I'm not sure this will help in this case
(http://marc.info/?l=linux-iio&m=144475305426138&w=2), for now.

In any case, any advice to address this problem is welcome.

Thanks
