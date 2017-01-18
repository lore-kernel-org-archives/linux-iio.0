Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ve1eur01on0105.outbound.protection.outlook.com ([104.47.1.105]:51220
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752822AbdARQP3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Jan 2017 11:15:29 -0500
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 01/12] devres: trivial whitespace fix
Date: Wed, 18 Jan 2017 16:57:04 +0100
Message-ID: <1484755035-25927-2-git-send-email-peda@axentia.se>
In-Reply-To: <1484755035-25927-1-git-send-email-peda@axentia.se>
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Everything else is indented with two spaces, so fix the odd one out.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/driver-model/devres.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index ca9d1eb46bc0..dc51fb024190 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -330,7 +330,7 @@ MEM
   devm_kzalloc()
 
 MFD
- devm_mfd_add_devices()
+  devm_mfd_add_devices()
 
 PER-CPU MEM
   devm_alloc_percpu()
-- 
2.1.4

