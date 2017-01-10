Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35145 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756823AbdAJSvC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 13:51:02 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, gnurou@gmail.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 1/3] pc104: Introduce the PC104 Kconfig option
Date: Tue, 10 Jan 2017 13:50:54 -0500
Message-Id: <17b3b34d44b8914496aa8256eb6e9c43ee6925ca.1484073325.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1484073324.git.vilhelm.gray@gmail.com>
References: <cover.1484073324.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

PC/104 form factor devices serve a specific niche of embedded system
users; most Linux users will not have PC/104 form factor devices. This
patch introduces the PC104 Kconfig option, which should be used to
filter PC/104 specific device drivers and options, so that only those
users interested in PC/104 related options are exposed to them.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 init/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 223b734abccd..12841d75a04d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1716,6 +1716,13 @@ config PERF_USE_VMALLOC
 	help
 	  See tools/perf/design.txt for details
 
+config PC104
+	bool "PC/104 support"
+	help
+	  Expose PC/104 form factor device drivers and options available for
+	  selection and configuration. Enable this option if your target
+	  machine has a PC/104 bus.
+
 menu "Kernel Performance Events And Counters"
 
 config PERF_EVENTS
-- 
2.11.0

