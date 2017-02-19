Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35304 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdBSPBU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 10:01:20 -0500
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Subject: [PATCH 2/3] of: add vendor prefix for Sensirion company
Date: Sun, 19 Feb 2017 15:59:49 +0100
Message-Id: <20170219145949.22750-1-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds prefix for Sensirion company.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 44ddc980b085..992ec480be53 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -203,6 +203,7 @@ sbs	Smart Battery System
 schindler	Schindler
 seagate	Seagate Technology PLC
 semtech	Semtech Corporation
+sensirion Sensirion AG
 sgx	SGX Sensortech
 sharp	Sharp Corporation
 sigma	Sigma Designs, Inc.
--
2.11.1

