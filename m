Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:32917 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbbDRTOu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 15:14:50 -0400
Received: by wgin8 with SMTP id n8so142059824wgi.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2015 12:14:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAD56B7fZW3Y07ghhrz-ymz+xE-=4oNyZr3FEvX+NhLHn1KWdOw@mail.gmail.com>
References: <CAD56B7fZW3Y07ghhrz-ymz+xE-=4oNyZr3FEvX+NhLHn1KWdOw@mail.gmail.com>
Date: Sat, 18 Apr 2015 22:14:49 +0300
Message-ID: <CAEnQRZC4D2Kc_udhmDs9kg14R9MSvocRkPEOa8zTxE+MV=d62w@mail.gmail.com>
Subject: Re: trigger question
From: Daniel Baluta <daniel.baluta@intel.com>
To: Paul Thomas <pthomas8589@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Apr 17, 2015 at 11:57 PM, Paul Thomas <pthomas8589@gmail.com> wrote:
> Hello, I would like to setup an iio_interrupt_trigger. I see the the
> actual request_irq happens in iio_interrupt_trigger_probe. What is a
> good example of a driver using this?
>

Good question. AFAIK there is no driver directly using iio_interrupt_trigger.

> I take it that, if I have a GPIO pin setup as an interrupt from
> userspace, there is no way to add the trigger from userspace in a way
> similar to 'iio_sysfs_trigger/add_trigger'?

You could use this trigger from user space by writing:

echo irqtrigX > /sys/bus/iio/iio:device0/trigger/current_trigger

The problem is GPIO irq setup. iio-trig-interrupt uses platform data to receive
the IRQ number to associate with the irqtrigger.

Could you tell use more about what exactly to you want to achieve? :).

If you don't really need a hardware interrupt to be the event source
for your trigger
you can use the IIO hrtimer patches. The work is still on going here:

https://lkml.org/lkml/2015/4/6/113

thanks,
Daniel.
