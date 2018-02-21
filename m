Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f201.google.com ([209.85.217.201]:46723 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeBUTpz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Feb 2018 14:45:55 -0500
Received: by mail-ua0-f201.google.com with SMTP id k4so1475510uad.13
        for <linux-iio@vger.kernel.org>; Wed, 21 Feb 2018 11:45:55 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 21 Feb 2018 20:45:26 +0100
In-Reply-To: <20180221194526.49183-1-delroth@google.com>
Message-Id: <20180221194526.49183-2-delroth@google.com>
References: <20180221125512.8265-1-delroth@google.com> <20180221194526.49183-1-delroth@google.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: light: Add bh1730fvc bindings
From: Pierre Bourdon <delroth@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Pierre Bourdon <delroth@google.com>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Pierre Bourdon <delroth@google.com>
---
 .../devicetree/bindings/iio/light/bh1730.txt      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/bh1730.txt

diff --git a/Documentation/devicetree/bindings/iio/light/bh1730.txt b/Documentation/devicetree/bindings/iio/light/bh1730.txt
new file mode 100644
index 000000000000..6b38c4010647
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/bh1730.txt
@@ -0,0 +1,15 @@
+* ROHM BH1730FVC ambient light sensor
+
+http://www.rohm.com/web/global/products/-/product/BH1730FVC
+
+Required properties:
+
+  - compatible : should be "rohm,bh1730fvc"
+  - reg : the I2C address of the sensor
+
+Example:
+
+bh1730fvc@29 {
+	compatible = "rohm,bh1730fvc";
+	reg = <0x29>;
+};
-- 
2.16.1.291.g4437f3f132-goog

