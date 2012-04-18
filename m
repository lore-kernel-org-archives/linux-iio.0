Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44818 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab2DRNeR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:34:17 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2] Add ADC driver for G20 and G45 evaluation boards
Date: Wed, 18 Apr 2012 15:33:50 +0200
Message-Id: <1334756036-15944-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

Here is the improved version of what I've been posting some time ago.
Some things changed since last version:
  - Support for Hardware triggers for the G20 has been added
  - Support for the AT91SAM9M10G45 board has been added too, both for
    software and hardware triggers
  - The driver is now in drivers/staging/iio to include all these features.

The first three patches should not have changed much since last post, so it
should be pretty ok.

Changes since v1:
  - Added DT bindings
  - Removed the clock_name field and used adc_clk instead. Used CLKDEV_CON_ID
    for the G45.
  - Misc fixes:
    * Added clk_prepare
    * Replaced kcalloc by devm_kzalloc for the trigger allocation

Thanks,
Maxime

