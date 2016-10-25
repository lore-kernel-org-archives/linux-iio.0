Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:24506 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbcJYTOb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 15:14:31 -0400
Date: Tue, 25 Oct 2016 22:06:16 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: mranostay@gmail.com
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: adc: ti-adc161s626: add regulator support
Message-ID: <20161025190616.GA30520@elgon.mountain>
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

I don't understand what's going on here.

   217                  ret = regulator_enable(data->ref);
   218                  if (ret < 0)
   219                          return ret;
   220          }
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

Static checker is correct.

   238  
   239          return ret;
   240  }

regards,
dan carpenter
