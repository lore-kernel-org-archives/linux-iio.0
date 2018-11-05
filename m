Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34410 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbeKFEfl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Nov 2018 23:35:41 -0500
Date: Mon, 5 Nov 2018 17:14:28 -0200
From: Renato Lui Geh <renatogeh@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        giuliano.belinassi@usp.br
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v4 0/2] staging: iio: ad7780: correct driver read
Message-ID: <cover.1541444377.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The purpose of this series is to correct an issue in the driver's raw
read function and remove an unnecessary struct field.

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
*v4
	- removed voltage reading from probe
	- fixed voltage error handling

Renato Lui Geh (2):
  staging: iio: ad7780: update voltage on read
  staging: iio: ad7780: remove unnecessary stashed voltage value

 drivers/staging/iio/adc/ad7780.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

-- 
2.19.1
