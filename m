Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53140 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeCPMur (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Mar 2018 08:50:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id t3so2826529wmc.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Mar 2018 05:50:46 -0700 (PDT)
To: linux-iio@vger.kernel.org
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
Subject: Removal of blackfin architecture
Cc: Tom Lebreux <tomlebreux@cock.li>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Message-ID: <5871ecb8-d726-0f6c-3e7a-da58896a97e2@gmail.com>
Date: Fri, 16 Mar 2018 13:50:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear IIO Community,

Currently, there are 3 people working on moving resolver driver out of
staging.
Rodrigo Siqueira is working on ad2s1210, Tom Lebreux is working on ad2s90,
and I'm working on ad2s1200.

There is only a single blackfin board ([1]) that sets the proper spi
driver mod
alias and platform data for the ad2s1200 and the ad2s1210, and the proper
mod alias for ads90.

However, it seems that general support for blackfin architecture is
slated to be
removed, see [2] and [3]. The relevant spi master driver is also being
removed.

What is the best course of action? Continue working on the drivers, or
remove
the drivers altogether?

[1] See arch/blackfin/mach-bf537/boards/stamp.c
[2] https://marc.info/?l=linux-kernel&m=152112517630790&w=2
[3] https://marc.info/?w=4&r=1&s=%5BBlackfin+removal%5D&q=t

Best regards,
David Veenstra
