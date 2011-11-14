Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:41230 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab1KNKGp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2011 05:06:45 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv5] AT91: Add a driver for the ADC
Date: Mon, 14 Nov 2011 11:06:30 +0100
Message-Id: <1321265193-15817-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

This patchset adds the driver for the ADC in the AT91 SoC. It has been tested on
the at91sam9g20ek and should work on sam9g45 as well.

For now, it only reads values when asked for by sysfs, but eventually will
support hardware triggers and more boards.

This patchset is based on the "[PATCH 0/6 V2] IIO: Out of staging step 1: The
core" patchset from Jonathan Cameron, applied on top of 3.1

Improvements for v5:
  - Don't loop through the channels in the irq handler anymore but use the last
converted data register instead.

Improvements for v4:
  - Various fixes (Remove the clock at drivers's remove, change the registers
access functions prototypes,... )

Improvements for v3:
  - Move the driver out of staging
  - Slightly modify the definition of channels to use bitmaps
  - The driver no longer leaks the channels array
  - Various minor fixes and codestyle improvements

Improvements for v2:
  - Rebase on top of commit 85d8ff8
  - Initialise scan_types
  - Added scale informations in the driver
  - Allow to use only a subset of adc channels available on the SoC
  - Various fix according to reviews

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

