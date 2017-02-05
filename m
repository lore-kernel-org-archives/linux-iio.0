Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34891 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbdBEPDw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2017 10:03:52 -0500
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCH 3/4] of: add vendor prefixes for Samyoung and Shinyei
Date: Sun,  5 Feb 2017 16:02:52 +0100
Message-Id: <20170205150252.10884-1-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds prefixes for Samyoung and Shinyei companies.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index cf1c36616507..1a090a330674 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -252,6 +252,7 @@ rikomagic	Rikomagic Tech Corp. Ltd
 rockchip	Fuzhou Rockchip Electronics Co., Ltd
 samsung	Samsung Semiconductor
 samtec	Samtec/Softing company
+samyoung Samyoung S&C Co., Ltd
 sandisk	Sandisk Corporation
 sbs	Smart Battery System
 schindler	Schindler
@@ -259,6 +260,7 @@ seagate	Seagate Technology PLC
 semtech	Semtech Corporation
 sgx	SGX Sensortech
 sharp	Sharp Corporation
+shinyei Shinyei Technology Co., Ltd
 si-en	Si-En Technology Ltd.
 sigma	Sigma Designs, Inc.
 sii	Seiko Instruments, Inc.
-- 
2.11.1

