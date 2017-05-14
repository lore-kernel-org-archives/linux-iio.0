Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:52973 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759614AbdENT5u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 15:57:50 -0400
From: Peter Rosin <peda@lysator.liu.se>
To: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
Subject: [PATCH v15 01/13] devres: trivial whitespace fix
Date: Sun, 14 May 2017 21:51:04 +0200
Message-Id: <1494791476-14599-2-git-send-email-peda@lysator.liu.se>
In-Reply-To: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

Everything else is indented with two spaces, so fix the odd one out.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/driver-model/devres.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index e72587fe477d..af08b4cd7968 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -335,7 +335,7 @@ MEM
   devm_kzalloc()
 
 MFD
- devm_mfd_add_devices()
+  devm_mfd_add_devices()
 
 PER-CPU MEM
   devm_alloc_percpu()
-- 
2.1.4

