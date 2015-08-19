Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61325 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbbHSJH6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 19 Aug 2015 05:07:58 -0400
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net, daniel.baluta@intel.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH v4 0/2] Add support and documentation for UPISEMI us5182d als and proximity sensor
Date: Wed, 19 Aug 2015 12:07:51 +0300
Message-Id: <1439975273-16387-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series adds basic support for this als and proximity sensor
and devicetree docs.


Adriana Reus (2):
  iio: light: Add support for UPISEMI uS5182d als and proximity sensor
  devicetree: Add documentation for UPISEMI us5182d ALS and Proximity
    sensor

 .../devicetree/bindings/iio/light/us5182d.txt      |  23 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/us5182d.c                        | 502 +++++++++++++++++++++
 5 files changed, 537 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/us5182d.txt
 create mode 100644 drivers/iio/light/us5182d.c

-- 
1.9.1

