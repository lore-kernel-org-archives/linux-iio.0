Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:6823 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab2DLMt5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Apr 2012 08:49:57 -0400
From: Laxman Dewangan <ldewangan@nvidia.com>
To: jic23@cam.ac.uk, gregkh@linuxfoundation.org,
	grant.likely@secretlab.ca, rob.herring@calxeda.com,
	jbrenner@taosinc.com, rklein@nvidia.com, max@stro.at
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V3 0/2] staging: iio: add isl29028 driver
Date: Thu, 12 Apr 2012 18:08:06 +0530
Message-Id: <1334234288-25037-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ISL29028 is concurrent Ambient light and proximity sensor
from intersil.
Adding driver for supporting this device.

Changes from V1:
- Taken care of cleanups comments.

Changes from V2:
- Implement the sampling frequency selection per channel wise.
- Remove documentation change as it is already there.
- Use the channel info for selecting proximity sampling rather than
  exposing new sysfs from driver.


Laxman Dewangan (2):
  staging: iio: add channel info for sampling frequency
  staging: iio: add driver for isl29028

 drivers/staging/iio/iio.h               |    5 +
 drivers/staging/iio/industrialio-core.c |    1 +
 drivers/staging/iio/light/Kconfig       |   10 +
 drivers/staging/iio/light/Makefile      |    1 +
 drivers/staging/iio/light/isl29028.c    |  574 +++++++++++++++++++++++++++++++
 5 files changed, 591 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/light/isl29028.c

