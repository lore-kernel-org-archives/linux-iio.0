Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:14759 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932515Ab2DKRir (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 13:38:47 -0400
From: Laxman Dewangan <ldewangan@nvidia.com>
To: jic23@cam.ac.uk, gregkh@linuxfoundation.org,
	grant.likely@secretlab.ca, rob.herring@calxeda.com,
	jbrenner@taosinc.com, rklein@nvidia.com, max@stro.at
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V1 0/2] istaging: iio: add isl29028 driver
Date: Wed, 11 Apr 2012 22:57:07 +0530
Message-Id: <1334165229-11285-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ISL29028 is concurrent Ambient light and proximity sensor from intersil.
Adding driver for supporting this device.

Also adding details of interface roximity_sampling_period in documentation.

Laxman Dewangan (2):
  staging: iio: add driver for isl29028
  staging: Documentation: add proximity_sampling_period as sysfs
    details

 .../staging/iio/Documentation/sysfs-bus-iio-light  |    7 +
 drivers/staging/iio/light/Kconfig                  |   10 +
 drivers/staging/iio/light/Makefile                 |    1 +
 drivers/staging/iio/light/isl29028.c               |  538 ++++++++++++++++++++
 4 files changed, 556 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/light/isl29028.c

