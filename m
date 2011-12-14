Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:53357 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab1LNKBc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2011 05:01:32 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v13] AT91: Add a driver for the ADC
Date: Wed, 14 Dec 2011 11:01:14 +0100
Message-Id: <1323856877-18255-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Working on supporting the hardware triggers for these drivers, I made some
patches that Jonathan suggested I merge with this patchset.

So, basically, what changed from v12:
  * Indentation fixes, added some comments
  * Rework of the platform data. Now the SoC-specific data are directly in the
driver, as it was kind of odd to declare all the triggers for the driver in the
SoC files. So the driver handles all of this now. It has nice side effects, as
it will also ease the transition to DT.

As it introduce heavy changes, I dropped the Acked-by and Signed-off-by from
the two last patches.

Maxime

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

