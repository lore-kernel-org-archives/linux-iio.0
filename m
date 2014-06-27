Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:52008 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbaF0QUS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jun 2014 12:20:18 -0400
Received: by mail-we0-f169.google.com with SMTP id t60so5527168wes.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2014 09:20:17 -0700 (PDT)
From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de,
	yannick.bedhomme@mobile-devices.fr,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Subject: [PATCH v3 0/2] iio: add watermark logic to iio read and poll
Date: Fri, 27 Jun 2014 18:19:59 +0200
Message-Id: <1403886001-23354-1-git-send-email-josselin.costanzi@mobile-devices.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Continuing discussion in thread "iio: make blocking read wait for data", 
here is another version of the patchset.
Waking the pollqueue only when needed is more difficult than we though because
you have to take into account both the watermark and the amount of data 
currently requested by read().


Changelog:
v3: 
- Make timeout an inactivity timeout
- Add Documentation
- Issue wake_up on buffer disable
v2: thanks to Lars-Peter Clausen and Jonathan Cameron
- Avoid breaking default ABI
- Add watermark and timeout properties to buffers


Josselin Costanzi (2):
  iio: staging: sca3000: hide stufftoread logic
  iio: add watermark logic to iio read and poll

 Documentation/ABI/testing/sysfs-bus-iio  |  21 ++++
 drivers/iio/industrialio-buffer.c        | 193 +++++++++++++++++++++++++++----
 drivers/iio/kfifo_buf.c                  |  15 +--
 drivers/staging/iio/accel/sca3000_ring.c |   6 +
 include/linux/iio/buffer.h               |  48 +++++++-
 5 files changed, 249 insertions(+), 34 deletions(-)

-- 
1.9.1

