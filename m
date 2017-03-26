Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34653 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdCZHCH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2017 03:02:07 -0400
Received: by mail-vk0-f43.google.com with SMTP id z204so24322216vkd.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Mar 2017 00:02:06 -0700 (PDT)
MIME-Version: 1.0
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Sun, 26 Mar 2017 12:32:05 +0530
Message-ID: <CALrZqyPPCGE0zZwrEcwBbOX75d7ZnA8E1in=6nJfN9xCf4rTvA@mail.gmail.com>
Subject: Problem in loading module of Software trigger
To: kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I read this documentation "Documentation/iio/iio_configfs.txt" for
creating software trigger.

So, by following this I created the module with name iio-trig-sample.c
in drivers/iio/trigger/.

iio-trigger-sample.c also compiled successfully.

Now, when I tried to insert module:

$ sudo insmod iio-trig-sample.ko
insmod: ERROR: could not insert module iio-trig-sample.ko: Unknown
symbol in module

Ans in /var/log/kern.log:
I am getting following reason:-
iio_trig_sample: Unknown symbol iio_unregister_sw_trigger_type (err 0)
iio_trig_sample: Unknown symbol iio_register_sw_trigger_type (err 0)
