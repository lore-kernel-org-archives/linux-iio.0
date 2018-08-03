Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732067AbeHCDiE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Aug 2018 23:38:04 -0400
From: Siddartha Mohanadoss <smohanad@codeaurora.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v5 3/3] iio: adc: Update QCOM ADC license to SPDX format
Date: Thu,  2 Aug 2018 18:44:06 -0700
Message-Id: <1533260646-12476-1-git-send-email-smohanad@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Update QCOM ADC header file to SPDX format.

Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/iio/qcom,spmi-vadc.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
index bf54b5a..61d556d 100644
--- a/include/dt-bindings/iio/qcom,spmi-vadc.h
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -1,14 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2012-2014,2018 The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_H
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

