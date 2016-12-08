Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35431 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753854AbcLHW1a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2016 17:27:30 -0500
From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
        linux-iio@vger.kernel.org, harald@ccbib.org,
        stefan.wahren@i2se.com, fabio.estevam@freescale.com,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v11 5/5] mfd: Move binding document
Date: Thu,  8 Dec 2016 23:27:11 +0100
Message-Id: <bdf92a9bfc74fc9f9741caf508b1d6e2f45826b0.1481234322.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1481234322.git.ksenija.stanojevic@gmail.com>
References: <cover.1481234322.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1481234322.git.ksenija.stanojevic@gmail.com>
References: <cover.1481234322.git.ksenija.stanojevic@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The bindings, which are now used in MFD, need also to be
documented in the MFD binding document.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
---
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

