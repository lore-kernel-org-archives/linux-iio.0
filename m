Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33757 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdEHVdE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2017 17:33:04 -0400
Received: by mail-qt0-f170.google.com with SMTP id t26so45879985qtg.0
        for <linux-iio@vger.kernel.org>; Mon, 08 May 2017 14:33:04 -0700 (PDT)
MIME-Version: 1.0
From: Pavel Roskin <plroskin@gmail.com>
Date: Mon, 8 May 2017 14:33:03 -0700
Message-ID: <CAN_72e2ewyuiWR5eJGHbzxGRpugG3cc4kNLNyVBJrz5mySL=Hw@mail.gmail.com>
Subject: Primary and secondary IRQ handlers swapped in bcm_iproc_adc.c
To: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Raveendra,

I was checking examples of IRQ handlers in IIO drivers when I noticed
that bcm_iproc_adc.c appears to use devm_request_threaded_irq()
incorrectly.

The third argument of devm_request_threaded_irq() is the primary
handler. It is called in hardirq context and checks whether the
interrupt is relevant to the device. If the primary handler returns
IRQ_WAKE_THREAD, the secondary handler (a.k.a. handler thread) is
scheduled to run in process context. It is typical for the secondary
(but not the primary) handler to have the work "thread" in its name.

It looks like bcm_iproc_adc.c uses the secondary handler as the
primary one and the other way around.

iproc_adc_interrupt_thread() is passed to devm_request_threaded_irq()
as the primary handler, but it doesn't ever return IRQ_WAKE_THREAD.
The use of "thread" in the name is another indicator that the function
is not used properly.

iproc_adc_interrupt_handler() is passed to devm_request_threaded_irq()
as the secondary handler. But it actually does what the primary
handler should do. It checks that the interrupt belongs to the device
and returns IRQ_WAKE_THREAD.

The fix should be to swap the third and the fourth arguments to
devm_request_threaded_irq(). But I don't have the hardware to test it.

-- 
Regards,
Pavel Roskin
