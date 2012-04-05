Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:59048 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab2DEQBq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 5 Apr 2012 12:01:46 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] Add ADC driver for G20 and G45 evaluation boards
Date: Thu,  5 Apr 2012 18:01:19 +0200
Message-Id: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com>
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

Thanks,
Maxime

