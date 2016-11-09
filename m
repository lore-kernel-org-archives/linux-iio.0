Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:23191 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbcKIKPK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Nov 2016 05:15:10 -0500
Date: Wed, 9 Nov 2016 13:14:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: mranostay@gmail.com
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [bug report] iio: adc: ti-adc161s626: add regulator support
Message-ID: <20161109101432.GA28226@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Matt Ranostay,

The patch 92f0afb5b2be: "iio: adc: ti-adc161s626: add regulator
support" from Sep 18, 2016, leads to the following static checker
warning:

	drivers/iio/adc/ti-adc161s626.c:237 ti_adc_probe()
	error: 'data->ref' dereferencing possible ERR_PTR()

drivers/iio/adc/ti-adc161s626.c
   214  
   215          data->ref = devm_regulator_get(&spi->dev, "vdda");
   216          if (!IS_ERR(data->ref)) {
   217                  ret = regulator_enable(data->ref);
   218                  if (ret < 0)
   219                          return ret;
   220          }

This code assumes that devm_regulator_get() can fail and we continue
with what we have, but none of the rest of the driver assumes that.

   221  
   222          ret = iio_triggered_buffer_setup(indio_dev, NULL,
   223                                           ti_adc_trigger_handler, NULL);
   224          if (ret)
   225                  goto error_regulator_disable;
   226  
   227          ret = iio_device_register(indio_dev);
   228          if (ret)
   229                  goto error_unreg_buffer;
   230  
   231          return 0;
   232  
   233  error_unreg_buffer:
   234          iio_triggered_buffer_cleanup(indio_dev);
   235  
   236  error_regulator_disable:
   237          regulator_disable(data->ref);

Every reference to "data->ref" needs to be updated to wrapped in
"if (!IS_ERR(data->ref)) " otherwise it will oops.

   238  
   239          return ret;
   240  }

regards,
dan carpenter
