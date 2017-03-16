Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36406 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbdCPM1r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Mar 2017 08:27:47 -0400
From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
        linux-iio@vger.kernel.org, harald@ccbib.org,
        stefan.wahren@i2se.com, fabio.estevam@freescale.com,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v15 5/5] mfd: Move binding document
Date: Thu, 16 Mar 2017 13:27:13 +0100
Message-Id: <edd8c5266b9d2cdac81ee1ec8e511fef1ed160af.1489666428.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
References: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
References: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The bindings, which are now used in MFD, need also to be
documented in the MFD binding document.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v15:
 - none

Changes in v14:
 - none

Changes in v13:
 - none

Changes in v12:
 - none

Changes in v11:
 - none

Changes in v10:
 - none

Changes in v9:
 - format patch using -M option

Changes in v8:
 - rebase onto 4.9-rc1

Changes in v7:
 - add to the patchset

 Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)

diff --git a/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/mfd/mxs-lradc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
rename to Documentation/devicetree/bindings/mfd/mxs-lradc.txt
-- 
1.9.1

