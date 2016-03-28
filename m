Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34992 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbcC1JUv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 05:20:51 -0400
Received: by mail-ob0-f174.google.com with SMTP id fp4so95139097obb.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Mar 2016 02:20:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56F8E550.6040305@kernel.org>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
	<1458825486-17188-2-git-send-email-linus.walleij@linaro.org>
	<56F8E550.6040305@kernel.org>
Date: Mon, 28 Mar 2016 11:20:50 +0200
Message-ID: <CACRpkdZx2L8JZ76iypApN7WCz7vgSVvamBamkzhQfyG+NdUcbw@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: st_sensors: read each channel individually
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 28, 2016 at 10:03 AM, Jonathan Cameron <jic23@kernel.org> wrote:

> No problem with the patch itself, but I'd like to get a better
> understanding of the issue.  Are we talking a weird hardware 'bug' that
> occurs only in these particular circumstances?  Can we pin down which of
> the above conditions are necessary to make it not work?

I have. I have the following patch in my tree
(Giuseppe, tell me if I should send this as patch if you
want to try it on your designs.):

>From 24fe4792c3bc92f587f44a5c54435be5745e424c Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 Mar 2016 09:21:01 +0100
Subject: [PATCH] iio: st_sensors: detect residue in channels

Hack.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c
b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index c55898543a47..71c079b50548 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -83,6 +83,26 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
     iio_push_to_buffers_with_timestamp(indio_dev, sdata->buffer_data,
         pf->timestamp);

+    if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
+        u8 status;
+
+        len = sdata->tf->read_byte(&sdata->tb, sdata->dev,
+               sdata->sensor_settings->drdy_irq.addr_stat_drdy,
+               &status);
+        if (len < 0)
+            dev_err(sdata->dev, "could not read channel status\n");
+
+        /*
+         * If this was not caused by any channels on this sensor,
+         * return IRQ_NONE
+         */
+        if (status & (u8)indio_dev->active_scan_mask[0])
+            dev_err(sdata->dev,
+                "ERROR residue data status = %02x, scan_mask = %02x\n",
+                status,
+                (u8)indio_dev->active_scan_mask[0]);
+    }
+
 st_sensors_get_buffer_element_error:
     iio_trigger_notify_done(indio_dev->trig);

-- 
2.4.3

This triggers when I use active-low IRQs and open drain setting.
The register contains 0x07 or 0xee indicating that the X axis status
bit was cleared but not Y, Z.

> I'd just like to know if this is a fix that needs to go upstream faster
> than the open drain support or not.

I cannot test active-high IRQs on the LIS331DL since it is wired
up as it is (requireing active-low+open drain). I don't think it's an
issue with that sensor in general but rather with the active-low+OD
mode in general but admittedly it is a rough guess.

It *might* be that LIS331DL needs this to even work properly :/

Yours,
Linus Walleij
