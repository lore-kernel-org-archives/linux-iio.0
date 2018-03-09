Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:48734 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbeCIJA5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Mar 2018 04:00:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.stresser.de (Postfix) with ESMTP id 260654380065
        for <linux-iio@vger.kernel.org>; Fri,  9 Mar 2018 10:00:56 +0100 (CET)
Received: from _ (frachter.heine.tech [46.4.84.91])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stresser.de (Postfix) with ESMTPSA id 17BA04380064
        for <linux-iio@vger.kernel.org>; Fri,  9 Mar 2018 10:00:55 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 09 Mar 2018 10:00:54 +0100
From: Michael Nosthoff <committed@heine.so>
To: linux-iio@vger.kernel.org
Subject: [PATCH 0/2] iio: st_pressure: st_accel: Fix initialization of
 platform_data
Message-ID: <d67b56d1a2aea044ce27175e486fa4cb@heine.so>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit 7383d44b added a pointer pdata which gets initialized with
the default platform_data when non was defined. But it did not
pass this pointer to the st_sensors_init_sensor call but still
used the maybe uninitialized platform_data from dev.

This breaks initialization when no platform_data is given and
the optional st,drdy-int-pin devicetree option is not set.

As pdata was not used at all after this a subsequent commit
removed the setting of pdata. As it is needed to fix this the
first patch reverts that commit.

Michael Nosthoff (2):
   iio: accel: Revert "iio: accel: st_accel: remove redundant pointer 
pdata"
   iio: st_pressure: st_accel: pass correct platform data to init

  drivers/iio/accel/st_accel_core.c       | 7 ++++++-
  drivers/iio/pressure/st_pressure_core.c | 2 +-
  2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.7.4
