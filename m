Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27543 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbcCBSSK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2016 13:18:10 -0500
Date: Wed, 2 Mar 2016 21:18:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: matt.ranostay@intel.com
Cc: linux-iio@vger.kernel.org
Subject: re: iio: imu: mpu6050: add mpu6500 register settings
Message-ID: <20160302181801.GA12744@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Matt Ranostay,

This is a semi-automatic email about new static checker warnings.

The patch 33da559f861b: "iio: imu: mpu6050: add mpu6500 register 
settings" from Feb 22, 2016, leads to the following Smatch complaint:

drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c:58 inv_mpu_probe()
	 error: we previously assumed 'id' could be null (see line 48)

drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
    47		const struct spi_device_id *id = spi_get_device_id(spi);
    48		const char *name = id ? id->name : NULL;
                                   ^^
Existing code assumed id could be NULL.

    49	
    50		regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
    51		if (IS_ERR(regmap)) {
    52			dev_err(&spi->dev, "Failed to register spi regmap %d\n",
    53				(int)PTR_ERR(regmap));
    54			return PTR_ERR(regmap);
    55		}
    56	
    57		return inv_mpu_core_probe(regmap, spi->irq, name,
    58					  inv_mpu_i2c_disable, id->driver_data);
                                                               ^^^^^^^^^^^^^^^
The patch adds an unchecked dereference.

    59	}
    60	

regards,
dan carpenter
