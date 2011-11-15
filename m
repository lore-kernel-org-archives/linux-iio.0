Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:54022 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab1KOKyQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2011 05:54:16 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v7] AT91: Add a driver for the ADC
Date: Tue, 15 Nov 2011 11:54:02 +0100
Message-Id: <1321354445-4023-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

This patchset adds the driver for the ADC in the AT91 SoC. It has been tested on
the at91sam9g20ek and should work on sam9g45 as well.

For now, it only reads values when asked for by sysfs, but eventually will
support hardware triggers and more boards.

This patchset is based on the "[PATCH 0/6 V2] IIO: Out of staging step 1: The
core" patchset from Jonathan Cameron, applied on top of 3.1

Improvements from v6:
  - Fix the unit in the scale read
  - Minor type fix

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

