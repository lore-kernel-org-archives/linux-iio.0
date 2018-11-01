Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34877 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbeKAXph (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Nov 2018 19:45:37 -0400
Date: Thu, 1 Nov 2018 11:42:16 -0300
From: Renato Lui Geh <renatogeh@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        giuliano.belinassi@usp.br
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 0/3] staging: iio: ad7780: correct driver read
Message-ID: <cover.1541082656.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The purpose of this series is to correct two issues in the driver's raw
read function and remove unnecessary struct fields.

Changelog:
*v2
	- separated original patch into two patches
	  (https://marc.info/?l=linux-iio&m=154047435605492)
*v3
	- reordered patches so that fixes go first
	- removed unnecessary initialization
	- removed unnecessary voltage field variable
	- dropped reading voltage on probe
	- returns -EINVAL error on null voltage

Renato Lui Geh (3):
  staging: iio: ad7780: fix offset read value
  staging: iio: ad7780: update voltage on read
  staging: iio: ad7780: remove unnecessary stashed voltage value

 drivers/staging/iio/adc/ad7780.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.19.1
