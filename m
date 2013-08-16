Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39459 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab3HPNZv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Aug 2013 09:25:51 -0400
Date: Fri, 16 Aug 2013 15:25:49 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: jic23@cam.ac.uk, dmitry.torokhov@gmail.com,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	Russ.Dill@ti.com
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Message-ID: <20130816132549.GD1263@linutronix.de>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Zubair Lutfullah | 2013-08-13 21:05:03 [+0100]:

>diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>index 3ceac3e..0d7e313 100644
>--- a/drivers/iio/adc/ti_am335x_adc.c
>+++ b/drivers/iio/adc/ti_am335x_adc.c
>@@ -141,58 +350,51 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
> {
…
>+	if (iio_buffer_enabled(indio_dev))
>+		return -EBUSY;
>+	else {

You can drop else so you lose one ident level.

>+		unsigned long timeout = jiffies + usecs_to_jiffies
>+					(IDLE_TIMEOUT * adc_dev->channels);

What computing this once? ->channels is assigned at probe time.

>+		step_en = get_adc_step_mask(adc_dev);
>+		am335x_tsc_se_set(adc_dev->mfd_tscadc, step_en);
>+
>+		/* Wait for ADC sequencer to complete sampling */
>+		while (tiadc_readl(adc_dev, REG_ADCFSM) & SEQ_STATUS) {
>+			if (time_after(jiffies, timeout))
>+				return -EAGAIN;

You should check the condition after the timeout occured once again. It
is possible that the task performing the read has been pushed away by a
higher prio task (or preempted incase this sounds like a bully) and
after it got back on the cpu the timeout occured but the condition is
valid and no reason for -EAGAIN.

>+			}
and the bracket needs to left by one tab.

Sebastian
