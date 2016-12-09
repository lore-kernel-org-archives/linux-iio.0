Return-Path: <SRS0=D+Aj=XY=codeaurora.org=rphani@kernel.org>
From: Rama Krishna Phani A <rphani@codeaurora.org>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	cdevired@codeaurora.org,
	smohanad@codeaurora.org,
	mgautam@codeaurora.org,
	sivaa@codeaurora.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Julia.Lawall@lip6.fr,
	Rama Krishna Phani A <rphani@codeaurora.org>
Subject: [PATCH V6 0/2] Changes to support different VADC scaling 
Date: Fri,  9 Dec 2016 20:31:48 +0530
Message-Id: <1481295710-22931-1-git-send-email-rphani@codeaurora.org>
List-ID: <linux-iio@vger.kernel.org>

VADC is a 15 bit ADC that measures signals through the Main analog
multiplexer (AMUX). The driver arbitrates the request to issue ADC
read requests. These patches adds different scaling functionality
to convert adc code to physical units.

[V6]
	1. Remove processed sysfs attributes for SCALE_NONE.

[V5]
	1. Retain new line as suggested.

[V4] 
	1. Remove DT bindings and implement scaling logic with in driver.
	
[V3]
	1. Update the commit text to give more information on the
	   functionality implemented in the patches.
   	2. Added Dt maintainers.

[V2]
	1. Replaced the do_div with normal division.
	2. Split the functionality implemented in v1 patch.
	3. Abstracted out common logic and updated change to report
	   Raw adc code properly.
   	4. Change to support different scaling functionality.
	5. Added support for introducing new bindings in driver.

[V1]
	https://lkml.org/lkml/2016/10/25/26

Rama Krishna Phani A (2):
  iio: adc: spmi-vadc: Update function for generic voltage conversion
  iio: adc: spmi-vadc: Changes to support different scaling

 drivers/iio/adc/qcom-spmi-vadc.c | 479 ++++++++++++++++++++++++++++-----------
 1 file changed, 351 insertions(+), 128 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
