Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yh0-f74.google.com ([209.85.213.74]:43843 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbaKEWK4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 17:10:56 -0500
Received: by mail-yh0-f74.google.com with SMTP id a41so132349yho.5
        for <linux-iio@vger.kernel.org>; Wed, 05 Nov 2014 14:10:55 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
	knaack.h@gmx.de
Cc: linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/3] Support all AKM compass in a single driver
Date: Wed,  5 Nov 2014 14:10:49 -0800
Message-Id: <1415225452-21957-1-git-send-email-gwendal@chromium.org>
In-Reply-To: <CAMHSBOWmmCdd=5HXJN-vz9saaPrq3n0p-LjCNvnX3Q3ZieZdRQ@mail.gmail.com>
References: <CAMHSBOWmmCdd=5HXJN-vz9saaPrq3n0p-LjCNvnX3Q3ZieZdRQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently, 2 drivers are used for supporting AKM compasses:
- ak8975 and ak8963 in ak875.c: these compasses support DRDY line and interrupt.
- ak09911 in ak0911.c: this compass has a new register map and does not support DRDY line.

A newer compass, ak09912 has the same register map as ak09911 but the same functionality as
ak8975. By adding support to ak09912 into ak8975, we can remove the driver specific to ak09911.

Gwendal Grignou (3):
  iio: ak8975: minor fixes
  iio: ak8975: add definition structure per compass type
  iio: ak8975: add ak09911 and ak09912 support

 drivers/iio/magnetometer/Kconfig   |  17 +-
 drivers/iio/magnetometer/Makefile  |   1 -
 drivers/iio/magnetometer/ak09911.c | 326 ------------------------
 drivers/iio/magnetometer/ak8975.c  | 501 +++++++++++++++++++++++++++----------
 4 files changed, 377 insertions(+), 468 deletions(-)
 delete mode 100644 drivers/iio/magnetometer/ak09911.c

-- 
2.1.0.rc2.206.gedb03e5

