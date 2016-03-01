Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35785 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbcCAS6j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2016 13:58:39 -0500
From: Alison Schofield <amsfield22@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Subject: [RFC PATCH 0/2] iio: introduce iio_{claim|release}_direct_mode()
Date: Tue,  1 Mar 2016 10:58:19 -0800
Message-Id: <cover.1456794364.git.amsfield22@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset introduces two helper functions to simplify driver code
requiring the device to be locked in direct mode during execution of a
code path. The staging driver ad7192 is updated to demonstrate usage.

This could be applied to approximately 18 known cases where the driver
is holding the lock in direct mode.  Unknown cases might be those that
should, but don't, hold the lock.

Alternate implementation: Generalize to support a claim on any mode.
Do iio_claim_mode(device,mode) where if the device is in *mode*, it
is guaranteed to stay that way until release is called. I considered
and rejected this option because a) not sure other modes would ever
need to be locked, and b) the semantic improvement is less when it
is generalized.
 
This patchset was inspired by a discussion on linux-iio:
http://www.spinics.net/lists/linux-iio/msg18540.html

Alison Schofield (2):
  iio: core: implement iio_{claim|release}_direct_mode()
  staging: iio: adc7192: use iio_{claim|release}_direct_mode()

 drivers/iio/industrialio-core.c  | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/ad7192.c | 24 +++++++++---------------
 include/linux/iio/iio.h          |  2 ++
 3 files changed, 50 insertions(+), 15 deletions(-)

-- 
2.1.4

