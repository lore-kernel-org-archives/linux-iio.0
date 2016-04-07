Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36332 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbcDGDwP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2016 23:52:15 -0400
Received: by mail-io0-f172.google.com with SMTP id q128so79942652iof.3
        for <linux-iio@vger.kernel.org>; Wed, 06 Apr 2016 20:52:15 -0700 (PDT)
MIME-Version: 1.0
From: Yong Li <sdliyong@gmail.com>
Date: Thu, 7 Apr 2016 11:51:55 +0800
Message-ID: <CADO9-pckFN67QpCHs3Z-vLqH9-6zrdUazgth3Xd=Q++=V8Zkyg@mail.gmail.com>
Subject: How to use GPIO pin as the trigger for IIO devices?
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 am testing an IIO gyro sensor using kernel 4.4, currently I can use
the sysfs trigger as a trigger, I can read the data from
/dev/iio:deviceX after "echo 1 > trigger_now".


I want to use a gpio pin for the data trigger. For example, when the
GPIO pin 62 is low, the data will be ready.


How to connect/setup the gpio with the IIO triggers, how can I use the
iio_trig_interrupt.ko? I found there is new triggers in the
/sys/bus/iio/devices after I loaded the iio_trig_interrupt.ko.

Thanks,
Yong
