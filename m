Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33136 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeEUMV6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2018 08:21:58 -0400
From: Silvan Murer <silvan.murer@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/2] iio: dac: update ltc2632 device driver
Date: Mon, 21 May 2018 14:21:26 +0200
Message-Id: <1526905288-28668-1-git-send-email-silvan.murer@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes in v4:
	- fix patch format issues
Change in v3:
	- remove extra spaces and tab
Changes in v2:
	- Add 'optional properties' documentation
	- Return an error when a regulator is specified
	- Use internal reference when no regulator is specified
	- Use iio_device_register instead of devm_iio_device_register

