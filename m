Return-Path: <SRS0=StV2=KQ=codeaurora.org=smohanad@kernel.org>
From: Siddartha Mohanadoss <smohanad@codeaurora.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v4 3/3] iio: adc: Update QCOM ADC license to SPDX format
Date: Wed,  1 Aug 2018 16:39:18 -0700
Message-Id: <1533166758-23909-1-git-send-email-smohanad@codeaurora.org>
List-ID: <linux-iio@vger.kernel.org>

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
