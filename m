Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.236]:59125 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbeKLBrt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Nov 2018 20:47:49 -0500
From: Slawomir Stepien <sst@poczta.fm>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v6 0/2] staging: iio: adc: ad7280a: use devm API when applicable
Date: Sun, 11 Nov 2018 16:59:09 +0100
Message-Id: <20181111155911.3604-1-sst@poczta.fm>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This small series of patches will enable devm API in the driver when applicable.

The patch contains two parts: 1st part enables powering down the device in
probe function, 2nd part changes the API to devm when applicable.

The first commit has been added for better visualization of what will happen
when the devm API is used - the whole remove function is not needed, but we
still need to power down the device from somewhere.

History:

Since v5:
* split the patch into two commits: (1) power down the device in probe, (2) use
  devm API when applicable
* devm_add_action -> devm_add_action_or_reset

Since v4:
* on devm_add_action fail, call the action on error handling
* move the devm_add_action just after spi_setup - this will call the action on
  more error paths in probe (fail in: ad7280_chain_setup, ad7280_channel_init,
  ad7280_attr_init)

Since v3:
* use devm_add_action with software power down
* the whole remove call back is not needed anymore

Since v2:
* iio_device_register -> devm_iio_device_register

Since v1:
* request_threaded_irq -> devm_request_threaded_irq

Slawomir Stepien (2):
  staging: iio: adc: ad7280a: power down the device on error in probe
  staging: iio: adc: ad7280a: use devm_* APIs

 drivers/staging/iio/adc/ad7280a.c | 95 +++++++++++++------------------
 1 file changed, 39 insertions(+), 56 deletions(-)

-- 
2.19.1
