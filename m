Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43628 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942191AbcJZNBw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Oct 2016 09:01:52 -0400
From: Rama Krishna Phani A <rphani@codeaurora.org>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: linux-arm-msm@vger.kernel.org, smohanad@codeaurora.org,
        mgautam@codeaurora.org, sivaa@codeaurora.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, Julia.Lawall@lip6.fr,
        Rama Krishna Phani A <rphani@codeaurora.org>
Subject: [PATCH V2 0/2] iio: adc: spmi-vadc: Changes to support different scaling
Date: Wed, 26 Oct 2016 18:30:49 +0530
Message-Id: <1477486851-24700-1-git-send-email-rphani@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

VADC is a 15 bit ADC that measures signals through the Main analog
multiplexer (AMUX). The driver arbitrates the request to issue ADC
read requests. These patches adds different scaling functionality
to convert adc code to physical units.

[V1]
https://lkml.org/lkml/2016/10/25/26

Rama Krishna Phani A (2):
  iio: adc: spmi-vadc: Update changes to support reporting of Raw adc
    code.
  iio: adc: spmi-vadc: Changes to support different scaling

 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  14 +
 drivers/iio/adc/qcom-spmi-vadc.c                   | 311 ++++++++++++++++-----
 2 files changed, 261 insertions(+), 64 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

