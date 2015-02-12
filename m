Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:39208 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbBLVA3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Feb 2015 16:00:29 -0500
Received: by mail-we0-f178.google.com with SMTP id w62so12654341wes.9
        for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2015 13:00:27 -0800 (PST)
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: daniel.baluta@intel.com, octavian.purdila@intel.com,
	jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 0/2] iio: light: Select REGMAP_I2C
Date: Thu, 12 Feb 2015 23:00:13 +0200
Message-Id: <1423774815-26816-1-git-send-email-roberta.dobrescu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds missing select statements for gp2ap020a00f and jsa1212
drivers. Without regmap_i2c, loadind these drivers fails with the following
error message:
Unknown symbol devm_regmap_init_i2c.

Roberta Dobrescu (2):
  iio: light: jsa1212: Select REGMAP_I2C
  iio: light: gp2ap020a00f: Select REGMAP_I2C

 drivers/iio/light/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
1.9.1

