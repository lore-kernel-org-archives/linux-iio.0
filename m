Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:2451 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751184AbdGOUct (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jul 2017 16:32:49 -0400
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 00/11] Drop unnecessary static
Date: Sat, 15 Jul 2017 22:07:35 +0200
Message-Id: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These patches fix cases where there is a static on a local variable, but
the variable is initialized before any possible use.  Thus, the static has
no benefit.

---

 drivers/ata/sata_gemini.c                     |    2 +-
 drivers/clk/clk-moxart.c                      |    4 ++--
 drivers/clk/mmp/clk.c                         |    2 +-
 drivers/iio/orientation/hid-sensor-rotation.c |    2 +-
 drivers/irqchip/irq-digicolor.c               |    2 +-
 drivers/irqchip/irq-gic-realview.c            |    2 +-
 drivers/irqchip/irq-mips-cpu.c                |    2 +-
 drivers/mfd/max8925-i2c.c                     |    2 +-
 drivers/mfd/twl4030-irq.c                     |    2 +-
 drivers/mtd/maps/physmap_of_versatile.c       |    2 +-
 drivers/video/fbdev/da8xx-fb.c                |    2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)
