Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:42506 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933540AbeCELTZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Mar 2018 06:19:25 -0500
Received: by mail-qt0-f177.google.com with SMTP id t6so19856603qtn.9
        for <linux-iio@vger.kernel.org>; Mon, 05 Mar 2018 03:19:25 -0800 (PST)
MIME-Version: 1.0
From: Srishti Sharma <srishtishar@gmail.com>
Date: Mon, 5 Mar 2018 16:49:24 +0530
Message-ID: <CAB3L5ozYkWv0qO5LrKUHyfXXdRf2RCgAOorHp-DNiKCMzDof6Q@mail.gmail.com>
Subject: Unknown symbols in module
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,
I was trying to work with the iio dummy driver, and when I try to load
the iio_dummy_evgen.ko module I am getting unknown symbols found in
module error on running modprobe.

These variables are unknown
iio_bus_type
irq_sim_init
irq_sim_fini
irq_sim_fire
irq_sim_fini

All of these variables are present in the Module.symvers file in the
/lib/modules/<kernel version>/build directory. The kernel and the
modules versions match. I ran make clean, make, and make
modules_install before trying to load them. I am unable to figure out
the problem. Where I might be going wrong any ideas ?

Thanks,
Srishti
