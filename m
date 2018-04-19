Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bert.emutex.com ([91.103.1.109]:53634 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752085AbeDSNph (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Apr 2018 09:45:37 -0400
From: Javier Arteaga <javier@emutex.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dan O'Donovan <dan@emutex.com>,
        Javier Arteaga <javier@emutex.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ACPI match adc128s052 to ADC on UP Squared
Date: Thu, 19 Apr 2018 14:20:34 +0100
Message-Id: <20180419132036.27493-1-javier@emutex.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

On AAEON's UP Squared board, there is an ADC124S101 enumerated via ACPI.
This patchset enables ACPI matching by compatible string and by AAEON's
allocated HID.

Dan O'Donovan (1):
  iio: adc128s052: allow driver to be matched using ACPI

Nicola Lunghi (1):
  iio: adc128s052: add ACPI _HID AANT1280

 drivers/iio/adc/ti-adc128s052.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

-- 
2.17.0

