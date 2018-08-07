Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:49318 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbeHGO1q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Aug 2018 10:27:46 -0400
Date: Tue, 7 Aug 2018 15:13:17 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: lars@metafoo.de
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: adxl345: Add support for the ADXL375
Message-ID: <20180807121317.3ed5lbi4ornxuuig@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Lars-Peter Clausen,

This is a semi-automatic email about new static checker warnings.

The patch ef89f4b96a2a: "iio: adxl345: Add support for the ADXL375" 
from Jul 13, 2018, leads to the following Smatch complaint:

    ./drivers/iio/accel/adxl345_i2c.c:38 adxl345_i2c_probe()
     warn: variable dereferenced before check 'id' (see line 37)

./drivers/iio/accel/adxl345_i2c.c
    36	
    37		return adxl345_core_probe(&client->dev, regmap, id->driver_data,
                                                                ^^^^^^^^^^^^^^^
Unchecked dereference

    38					  id ? id->name : NULL);
                                          ^^^^^^^^^^^^^^^^^^^^
Check not needed?

    39	}
    40	

regards,
dan carpenter
