Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60880 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753950AbbKXLBF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 24 Nov 2015 06:01:05 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	robh+dt@kernel.org, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, pawel.moll@arm.com, pmeerw@pmeerw.net,
	lars@metafoo.de, Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH 0/5] iio: light: us5281d: Add power managmenet and interrupt support
Date: Tue, 24 Nov 2015 12:59:47 +0200
Message-Id: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The first patches add a dt property for choosing the power mode for raw reads.
The following adds helper functions preparing for pm support.
The last ones add power management and interrupt support.

Adriana Reus (5):
  iio: light: us5182d: Add property for choosing default power mode
  Documentation: devicetree: Add property for controlling power saving
    mode for the us5182 als sensor
  iio: light: us5182d: Add functions for selectively enabling als and
    proximity
  iio: light: us8152d: Add power management support
  iio: light: us5182d: Add interrupt support and events

 .../devicetree/bindings/iio/light/us5182d.txt      |  11 +
 drivers/iio/light/us5182d.c                        | 513 ++++++++++++++++++++-
 2 files changed, 504 insertions(+), 20 deletions(-)

-- 
1.9.1

