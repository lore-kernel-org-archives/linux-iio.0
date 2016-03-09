Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35102 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933890AbcCITZt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2016 14:25:49 -0500
From: Alison Schofield <amsfield22@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Subject: [RFC PATCH v2 0/2] iio: introduce iio_device_{claim|release}_direct_mode()
Date: Wed,  9 Mar 2016 11:25:23 -0800
Message-Id: <cover.1457549841.git.amsfield22@gmail.com>
In-Reply-To: <cover.1456794364.git.amsfield22@gmail.com>
References: <cover.1456794364.git.amsfield22@gmail.com>
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

Changes in v2:
o use iio_device prefix for new functions
o replace EINVAL with EBUSY on failure to claim direct mode
o update commit msg & changelog to reflect new prefix

Alison Schofield (2):
  iio: core: implement iio_device_{claim|release}_direct_mode()
  staging: iio: ad7192: use iio_device_{claim|release}_direct_mode()

 drivers/iio/industrialio-core.c  | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/ad7192.c | 24 +++++++++---------------
 include/linux/iio/iio.h          |  2 ++
 3 files changed, 50 insertions(+), 15 deletions(-)

-- 
2.1.4

