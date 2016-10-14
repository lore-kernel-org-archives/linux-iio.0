Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42523 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753042AbcJNOiM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2016 10:38:12 -0400
Date: Fri, 14 Oct 2016 17:37:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: gregor.boirie@parrot.com
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio:pressure: initial zpa2326 barometer support
Message-ID: <20161014143726.GA32542@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Gregor Boirie,

The patch 03b262f2bbf4: "iio:pressure: initial zpa2326 barometer
support" from Sep 13, 2016, leads to the following static checker
warning:

	drivers/iio/pressure/zpa2326.c:1050 zpa2326_fetch_raw_sample()
	warn: passing casted pointer 'value' to '__le16_to_cpup()' 32 vs 16.

drivers/iio/pressure/zpa2326.c
  1013  static int zpa2326_fetch_raw_sample(const struct iio_dev *indio_dev,
  1014                                      enum iio_chan_type    type,
  1015                                      int                  *value)
  1016  {
  1017          struct regmap *regs = ((struct zpa2326_private *)
  1018                                 iio_priv(indio_dev))->regmap;
  1019          int            err;
  1020  
  1021          switch (type) {
  1022          case IIO_PRESSURE:
  1023                  zpa2326_dbg(indio_dev, "fetching raw pressure sample");
  1024  
  1025                  err = regmap_bulk_read(regs, ZPA2326_PRESS_OUT_XL_REG, value,
  1026                                         3);
  1027                  if (err) {
  1028                          zpa2326_warn(indio_dev, "failed to fetch pressure (%d)",
  1029                                       err);
  1030                          return err;
  1031                  }
  1032  
  1033                  /* Pressure is a 24 bits wide little-endian unsigned int. */
  1034                  *value = (((u8 *)value)[2] << 16) | (((u8 *)value)[1] << 8) |
  1035                           ((u8 *)value)[0];
  1036  
  1037                  return IIO_VAL_INT;
  1038  
  1039          case IIO_TEMP:
  1040                  zpa2326_dbg(indio_dev, "fetching raw temperature sample");
  1041  
  1042                  err = regmap_bulk_read(regs, ZPA2326_TEMP_OUT_L_REG, value, 2);
  1043                  if (err) {
  1044                          zpa2326_warn(indio_dev,
  1045                                       "failed to fetch temperature (%d)", err);
  1046                          return err;
  1047                  }
  1048  
  1049                  /* Temperature is a 16 bits wide little-endian signed int. */
  1050                  *value = (int)le16_to_cpup((__le16 *)value);

This works...  but so ugly.  Next time consider a temporary variable.

  1051  
  1052                  return IIO_VAL_INT;
  1053  
  1054          default:
  1055                  return -EINVAL;
  1056          }


regards,
dan carpenter
