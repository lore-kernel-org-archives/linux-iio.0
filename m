Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27364 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933069AbbELSJt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2015 14:09:49 -0400
Date: Tue, 12 May 2015 21:09:41 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-iio@vger.kernel.org
Subject: re: iio: ltr501: Add interrupt support
Message-ID: <20150512180941.GD5672@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Kuppuswamy Sathyanarayanan,

The patch 7ac702b3144b: "iio: ltr501: Add interrupt support" from Apr
19, 2015, leads to the following static checker warning:

	drivers/iio/light/ltr501.c:869 ltr501_write_thresh()
	info: ignoring unreachable code.

drivers/iio/light/ltr501.c
   867          case IIO_PROXIMITY:
   868                  switch (dir) {
   869                  if (val > LTR501_PS_THRESH_MASK)
   870                          return -EINVAL;

Probably this code should be outside of this switch (dir) statement?

   871                  case IIO_EV_DIR_RISING:
   872                          mutex_lock(&data->lock_ps);
   873                          ret = regmap_bulk_write(data->regmap,
   874                                                  LTR501_PS_THRESH_UP,
   875                                                  &val, 2);
   876                          mutex_unlock(&data->lock_ps);
   877                          return ret;
   878                  case IIO_EV_DIR_FALLING:
   879                          mutex_lock(&data->lock_ps);
   880                          ret = regmap_bulk_write(data->regmap,
   881                                                  LTR501_PS_THRESH_LOW,
   882                                                  &val, 2);
   883                          mutex_unlock(&data->lock_ps);
   884                          return ret;
   885                  default:
   886                          return -EINVAL;
   887                  }
   888          default:
   889                  return -EINVAL;
   890          }
   891  
   892          return -EINVAL;
   893  }

regards,
dan carpenter
