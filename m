Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34111 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754537AbcKBHis (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Nov 2016 03:38:48 -0400
From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
        linux-iio@vger.kernel.org, harald@ccbib.org,
        stefan.wahren@i2se.com, fabio.estevam@freescale.com,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v9 5/5] mfd: Move binding document
Date: Wed,  2 Nov 2016 08:38:26 +0100
Message-Id: <890396579f049f5c4a750892a87165e3171cb1ca.1478071676.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
References: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
References: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The bindings, which are now used in MFD, need also to be
documented in the MFD binding document.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
---
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

