Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:50038 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbaF0Rx5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jun 2014 13:53:57 -0400
Received: by mail-we0-f173.google.com with SMTP id t60so5542060wes.32
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2014 10:53:56 -0700 (PDT)
From: Johannes Pointner <johannes.pointner@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org
Subject: [PATCH 1/2] Adds the vendor prefix "epcos" to vendor-prefixes.txt
Date: Fri, 27 Jun 2014 19:53:53 +0200
Message-ID: <2420621.lSeA9X6AqK@lenovobook>
In-Reply-To: <53AD7F8F.7070501@roeck-us.net>
References: <CAJKbBDDFD294xnqkYq_auW=ppMyPJxigYUF-YAhXZVXw3NN5Xg@mail.gmail.com> <53AD7F8F.7070501@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the vendor prefix for "epcos" to the vendor-prefixes.

Signed-off-by: Johannes Pointner <johannes.pointner@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt 
b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 46a311e..97c9c06 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -42,6 +42,7 @@ dmo	Data Modul AG
 ebv	EBV Elektronik
 edt	Emerging Display Technologies
 emmicro	EM Microelectronic
+epcos	EPCOS AG
 epfl	Ecole Polytechnique Fédérale de Lausanne
 epson	Seiko Epson Corp.
 est	ESTeem Wireless Modems
-- 
2.0.0
