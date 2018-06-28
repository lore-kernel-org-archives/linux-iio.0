Return-Path: <SRS0=s+IP=JO=codeaurora.org=smohanad@kernel.org>
From: Siddartha Mohanadoss <smohanad@codeaurora.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/2] Add QCOM PMIC5 ADC driver
Date: Thu, 28 Jun 2018 11:29:10 -0700
Message-Id: <1530210550-16085-1-git-send-email-smohanad@codeaurora.org>
List-ID: <linux-iio@vger.kernel.org>

This patch series adds the PMIC5 ADC family of chipset
that supports clients to measure voltage and current on
inputs connected to the PMIC ADC AMUX. Clients include
reading voltage phone power and on board system thermistors
for thermal management.

The v2 patchset addresses most of the review comments from
prior patchset.

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

Siddartha Mohanadoss (2):
  dt-bindings: iio: adc: Add DT binding document for PMIC5 ADC
  iio: adc: Add QCOM SPMI PMIC5 ADC driver

 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  77 +-
 drivers/iio/adc/Kconfig                            |  20 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/qcom-spmi-adc5.c                   | 878 +++++++++++++++++++++
 drivers/iio/adc/qcom-vadc-common.c                 | 230 +++++-
 drivers/iio/adc/qcom-vadc-common.h                 |  56 ++
 include/dt-bindings/iio/qcom,spmi-vadc.h           | 115 ++-
 7 files changed, 1352 insertions(+), 25 deletions(-)
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
