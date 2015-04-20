Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vn0-f52.google.com ([209.85.216.52]:33396 "EHLO
	mail-vn0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbbDTBBl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2015 21:01:41 -0400
Received: by vnbf1 with SMTP id f1so29594188vnb.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2015 18:01:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEnQRZC4D2Kc_udhmDs9kg14R9MSvocRkPEOa8zTxE+MV=d62w@mail.gmail.com>
References: <CAD56B7fZW3Y07ghhrz-ymz+xE-=4oNyZr3FEvX+NhLHn1KWdOw@mail.gmail.com>
	<CAEnQRZC4D2Kc_udhmDs9kg14R9MSvocRkPEOa8zTxE+MV=d62w@mail.gmail.com>
Date: Sun, 19 Apr 2015 21:01:40 -0400
Message-ID: <CAD56B7dE31xYq-iqx4Vf7_bmQqnZSxv+jK8Mm9iMJhwC-Q5PXw@mail.gmail.com>
Subject: Re: trigger question
From: Paul Thomas <pthomas8589@gmail.com>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Apr 18, 2015 at 3:14 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> On Fri, Apr 17, 2015 at 11:57 PM, Paul Thomas <pthomas8589@gmail.com> wrote:
>> Hello, I would like to setup an iio_interrupt_trigger. I see the the
>> actual request_irq happens in iio_interrupt_trigger_probe. What is a
>> good example of a driver using this?
>>
>
> Good question. AFAIK there is no driver directly using iio_interrupt_trigger.
>
>> I take it that, if I have a GPIO pin setup as an interrupt from
>> userspace, there is no way to add the trigger from userspace in a way
>> similar to 'iio_sysfs_trigger/add_trigger'?
>
> You could use this trigger from user space by writing:
>
> echo irqtrigX > /sys/bus/iio/iio:device0/trigger/current_trigger
Great thanks! I'll try this tomorrow.

>
> The problem is GPIO irq setup. iio-trig-interrupt uses platform data to receive
> the IRQ number to associate with the irqtrigger.
>
> Could you tell use more about what exactly to you want to achieve? :).
Really it's just a data ready interrupt. So with the irqtrigX that's
all I need to test, but for the actual driver I was thinking the GPIO
interrupt would be part of the device tree, but even though
configuring the GPIO pin from sysfs is OK, I'm not too clear how this
would look in the device tree.

>
> If you don't really need a hardware interrupt to be the event source
> for your trigger
> you can use the IIO hrtimer patches. The work is still on going here:
>
> https://lkml.org/lkml/2015/4/6/113
I saw that, it looks cool. It this case I think it would double the
interrupts, the hrtimer could start the conversion, but then you'd
still have to wait for the data to be ready.

thanks,
Paul
