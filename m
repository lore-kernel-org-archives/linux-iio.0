Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:22152 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967AbbIPIPB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Sep 2015 04:15:01 -0400
From: Adriana Reus <adriana.reus@intel.com>
To: robherring2@gmail.com, jic23@kernel.org
Cc: pmeerw@pmeerw.net, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, Adriana Reus <adriana.reus@intel.com>
Subject: [v7 PATCH 0/2] Add support and documentation for UPISEMI us5182d als and proximity sensor
Date: Wed, 16 Sep 2015 11:14:10 +0300
Message-Id: <1442391252-7368-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series adds basic support for this als and proximity sensor
and devicetree docs.

Adriana Reus (2):
  iio: light: Add support for UPISEMI uS5182d als and proximity sensor
  devicetree: Add documentation for UPISEMI us5182d ALS and Proximity
    sensor

 .../devicetree/bindings/iio/light/us5182d.txt      |  34 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/us5182d.c                        | 507 +++++++++++++++++++++
 5 files changed, 553 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/us5182d.txt
 create mode 100644 drivers/iio/light/us5182d.c

-- 
1.9.1

