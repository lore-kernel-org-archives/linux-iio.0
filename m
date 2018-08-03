Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbeHCDga (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Aug 2018 23:36:30 -0400
From: Siddartha Mohanadoss <smohanad@codeaurora.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v5 0/3] Add QCOM PMIC5 ADC driver
Date: Thu,  2 Aug 2018 18:42:26 -0700
Message-Id: <1533260546-11916-1-git-send-email-smohanad@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series adds the PMIC5 ADC family of chipset
that supports clients to measure voltage and current on
inputs connected to the PMIC ADC AMUX. Clients include
reading voltage phone power and on board system thermistors
for thermal management.

The v5 patchset addresses most of the review comments from
prior patchset.

Changes since patchset v4
* Remove support to query channels raw ADC code readings.
* Few minor changes.

Changes since patchset v3
* Few minor changes.

Changes since patchset v2
* Removed support for current channel as part of this series.
* Fix pointer arithmetic for iio_chan.
* Few minor changes.
* Update license to SPDX format for ADC header file.

Changes since patchset v1
* Merged DT bindings with prior PMIC family instead of a
  seperate DT file for PMIC5 family.
* Updated documentation for 'label' and 'value' property.
* Updated using unique prefix adc5 for functions and defines
  specific for this family of chipset.
* Refactored scaling functions to use function pointer for
  scaling lookup.
* Added documentation comments as requested in the
  scaling functions as applicable.
* Added utility functions in the scaling API to avoid some of
  the code repetitions.
* Use consistent hex format for adc_data and use specific length
  while assigning data.
* Added support to determine controller version and check against
  supported hardware settling delay values.
* Various minor changes.

Siddartha Mohanadoss (3):
  dt-bindings: iio: adc: Add DT binding document for PMIC5 ADC
  iio: adc: Add QCOM SPMI PMIC5 ADC driver
  iio: adc: Update QCOM ADC license to SPDX format

 ,                                                  |   0
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  77 +-
 drivers/iio/adc/Kconfig                            |  20 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/qcom-spmi-adc5.c                   | 788 +++++++++++++++++++++
 drivers/iio/adc/qcom-vadc-common.c                 | 189 ++++-
 drivers/iio/adc/qcom-vadc-common.h                 |  54 ++
 include/dt-bindings/iio/qcom,spmi-vadc.h           | 125 +++-
 8 files changed, 1220 insertions(+), 34 deletions(-)
 create mode 100644 ,
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

