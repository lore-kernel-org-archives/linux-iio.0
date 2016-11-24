Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50410 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbcKXFbW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2016 00:31:22 -0500
From: Rama Krishna Phani A <rphani@codeaurora.org>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: linux-arm-msm@vger.kernel.org, cdevired@codeaurora.org,
        smohanad@codeaurora.org, mgautam@codeaurora.org,
        sivaa@codeaurora.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Julia.Lawall@lip6.fr,
        Rama Krishna Phani A <rphani@codeaurora.org>
Subject: [PATCH V5 0/2] Changes to support different VADC scaling
Date: Thu, 24 Nov 2016 11:01:03 +0530
Message-Id: <1479965465-30182-1-git-send-email-rphani@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

VADC is a 15 bit ADC that measures signals through the Main analog
multiplexer (AMUX). The driver arbitrates the request to issue ADC
read requests. These patches adds different scaling functionality
to convert adc code to physical units.

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
 1 file changed, 350 insertions(+), 129 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

