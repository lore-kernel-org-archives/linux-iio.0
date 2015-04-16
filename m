Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36331 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbbDPTVN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2015 15:21:13 -0400
Received: by wgsk9 with SMTP id k9so91376572wgs.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2015 12:21:12 -0700 (PDT)
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, daniel.baluta@intel.com,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH v2 0/3] staging: iio: light: isl29018: Remove non-standard sysfs attributes
Date: Thu, 16 Apr 2015 22:20:56 +0300
Message-Id: <1429212059-13010-1-git-send-email-roberta.dobrescu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This set of patches removes non-standard sysfs attributes used
by isl29018 driver.

Integration time is used instead of adc resolution since these are
strongly connected. Also, full scale range is controlled by scale.
isl29018 driver code is refactored in order to use these standard attributes.

Additionally, it renames lux_scale to calibscale and lux_uscale to
ucalibscale since these parameters are used for hardware applied calibration.

The purpose of these patches is to change the isl29018 driver to use
standard IIO attributes in order to be moved out of staging.

Changes since v1:
	* Use integration time for controlling adc resolution
	* Use scale to control range instead of introducing IIO_CHAN_INFO_RANGE

Roberta Dobrescu (3):
  staging: iio: light: isl29018: Remove non-standard sysfs attributes
  staging: iio: light: isl29018: Rename lux_scale to calibscale
  staging: iio: light: isl29018: Use standard sysfs attributes for scale
    and integration time

 drivers/staging/iio/light/isl29018.c | 294 +++++++++++++++++++----------------
 1 file changed, 163 insertions(+), 131 deletions(-)

-- 
1.9.1

