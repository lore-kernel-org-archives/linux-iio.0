Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:26598 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbcJLGH4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2016 02:07:56 -0400
Date: Wed, 12 Oct 2016 09:07:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: cmo@melexis.com
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [bug report] iio: fetch and enable regulators unconditionally
Message-ID: <20161012060719.GD12841@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Crt Mori,

The patch 67516074884b: "iio: fetch and enable regulators
unconditionally" from Sep 5, 2016, leads to the following static
checker warning:

	drivers/iio/pressure/ms5611_core.c:419 ms5611_init()
	error: 'st->vdd' dereferencing possible ERR_PTR()

drivers/iio/pressure/ms5611_core.c
   388  static int ms5611_init(struct iio_dev *indio_dev)
   389  {
   390          int ret;
   391          struct ms5611_state *st = iio_priv(indio_dev);
   392  
   393          /* Enable attached regulator if any. */
   394          st->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
   395          if (!IS_ERR(st->vdd)) {
   396                  ret = regulator_enable(st->vdd);
   397                  if (ret) {
   398                          dev_err(indio_dev->dev.parent,
   399                                  "failed to enable Vdd supply: %d\n", ret);
   400                          return ret;
   401                  }
   402          } else {
   403                  ret = PTR_ERR(st->vdd);
   404                  if (ret != -ENODEV)
   405                          return ret;

You probably want to update this chunk as well?  Otherwise static
checkers think we're dereferencing -ENODEV.

   406          }
   407  
   408          ret = ms5611_reset(indio_dev);
   409          if (ret < 0)
   410                  goto err_regulator_disable;
   411  
   412          ret = ms5611_read_prom(indio_dev);
   413          if (ret < 0)
   414                  goto err_regulator_disable;
   415  
   416          return 0;
   417  
   418  err_regulator_disable:
   419          regulator_disable(st->vdd);
   420          return ret;
   421  }

regards,
dan carpenter
