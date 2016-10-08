Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbcJHMfI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Oct 2016 08:35:08 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
Subject: [PATCH 0/4] iio: accel: Add 3 new drivers
Date: Sat,  8 Oct 2016 14:34:22 +0200
Message-Id: <20161008123426.8991-1-hdegoede@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan, et al.,

Here is 1. a patch to add some missing compatibles to
i2c/trivial-devices.txt, 2. Version 3 of 2 new accelerometer drivers
which I've submitted before, addressing all the review comments and;
3. a new driver for MiraMEMS DA280 / DA226 accelerometers (*).

I'm sending this as a patch-set since there is a potential for conflicts
if these are not applied in the right order.

Regards,

Hans

*) I've bought 2 second hand Allwinner A33 tablets and both ended up having
a DA280 and I borrowed another A33 tablet from a friend which turned out to
have a DA226, this driver has been tested on all 3 devices.
