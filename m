Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:43145 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbcBPH5m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Feb 2016 02:57:42 -0500
Date: Tue, 16 Feb 2016 10:56:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: ksenija.stanojevic@gmail.com
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: re: iio: adc: Move mxs-lradc out of staging
Message-ID: <20160216075658.GA4553@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Ksenija Stanojevic,

The patch f836c4592244: "iio: adc: Move mxs-lradc out of staging"
from Feb 6, 2016, leads to the following static checker warning:

	drivers/iio/adc/mxs-lradc.c:1503 mxs_lradc_hw_init()
	warn: inconsistent indenting

drivers/iio/adc/mxs-lradc.c
  1496          mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(3));
  1497  
  1498          /* Configure the touchscreen type */
  1499          if (lradc->soc == IMX28_LRADC) {
  1500                  mxs_lradc_reg_clear(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
  1501                                      LRADC_CTRL0);
  1502  
  1503          if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
  1504                  mxs_lradc_reg_set(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
  1505                                    LRADC_CTRL0);

Should these lines be indented more or are the curly braces misplaced?

  1506          }
  1507  
  1508          /* Start internal temperature sensing. */
  1509          mxs_lradc_reg_wrt(lradc, 0, LRADC_CTRL2);
  1510  
  1511          return 0;


regards,
dan carpenter
