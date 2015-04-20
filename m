Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vn0-f47.google.com ([209.85.216.47]:36300 "EHLO
	mail-vn0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbbDTNFs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2015 09:05:48 -0400
Received: by vnbf62 with SMTP id f62so30462994vnb.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2015 06:05:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEnQRZC4D2Kc_udhmDs9kg14R9MSvocRkPEOa8zTxE+MV=d62w@mail.gmail.com>
References: <CAD56B7fZW3Y07ghhrz-ymz+xE-=4oNyZr3FEvX+NhLHn1KWdOw@mail.gmail.com>
	<CAEnQRZC4D2Kc_udhmDs9kg14R9MSvocRkPEOa8zTxE+MV=d62w@mail.gmail.com>
Date: Mon, 20 Apr 2015 09:05:47 -0400
Message-ID: <CAD56B7d9jstrFeXRsg8g__YHFBy6CRuQSm97G4Onh0yFgssYnA@mail.gmail.com>
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
You mean after I've loaded an iio_interrupt_trigger and can see
irqtrigX in /sys/bus/iio/devices right? (I tried it just now without
that, and current_trigger is just blank after 'echo irqtrigX') Which
means I need a proper struct platform_device setup? Looking through
Documentation/driver-model/platform.txt I see a platform_device is
normally loaded with platform_device_register.

thanks,
Paul
