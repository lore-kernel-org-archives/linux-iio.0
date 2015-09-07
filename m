Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36697 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbbIGCjA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 6 Sep 2015 22:39:00 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v2 3/4] devicetree: add SGX Sensortech vendor id
Date: Sun,  6 Sep 2015 19:39:06 -0700
Message-Id: <1441593547-10896-4-git-send-email-mranostay@gmail.com>
In-Reply-To: <1441593547-10896-1-git-send-email-mranostay@gmail.com>
References: <1441593547-10896-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ac5f0c3..281e8f0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -191,6 +191,7 @@ sbs	Smart Battery System
 schindler	Schindler
 seagate	Seagate Technology PLC
 semtech	Semtech Corporation
+sgx	SGX Sensortech
 sharp	Sharp Corporation
 sil	Silicon Image
 silabs	Silicon Laboratories
-- 
1.9.1

