Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vn0-f49.google.com ([209.85.216.49]:41247 "EHLO
	mail-vn0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069AbbDQU5P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2015 16:57:15 -0400
Received: by vnbg190 with SMTP id g190so26991710vnb.8
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2015 13:57:14 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 17 Apr 2015 16:57:14 -0400
Message-ID: <CAD56B7fZW3Y07ghhrz-ymz+xE-=4oNyZr3FEvX+NhLHn1KWdOw@mail.gmail.com>
Subject: trigger question
From: Paul Thomas <pthomas8589@gmail.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello, I would like to setup an iio_interrupt_trigger. I see the the
actual request_irq happens in iio_interrupt_trigger_probe. What is a
good example of a driver using this?

I take it that, if I have a GPIO pin setup as an interrupt from
userspace, there is no way to add the trigger from userspace in a way
similar to 'iio_sysfs_trigger/add_trigger'?

Thanks in advance.

-Paul
