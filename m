Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:19629 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab2FGMMR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jun 2012 08:12:17 -0400
Date: Thu, 7 Jun 2012 15:12:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: michael.hennerich@analog.com
Cc: linux-iio@vger.kernel.org
Subject: re: iio: frequency: New driver for AD9523 SPI Low Jitter Clock
 Generator
Message-ID: <20120607121207.GA4784@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Michael Hennerich,

The patch cd1678f96329: "iio: frequency: New driver for AD9523 SPI
Low Jitter Clock Generator" from May 29, 2012, leads to the following
warning:

drivers/iio/frequency/ad9523.c:378 ad9523_vco_out_map()
	 warn: value 2 can't fit into 1 'out'


   363  static int ad9523_vco_out_map(struct iio_dev *indio_dev,
   364                                unsigned ch, bool out)
                                                   ^^^^^^^^
Bool.

   365  {
   366          struct ad9523_state *st = iio_priv(indio_dev);
   367          int ret;
   368          unsigned mask;
   369  
   370          switch (ch) {
   371          case 0 ... 3:
   372                  ret = ad9523_read(indio_dev, AD9523_PLL1_OUTPUT_CHANNEL_CTRL);
   373                  if (ret < 0)
   374                          break;
   375                  mask = AD9523_PLL1_OUTP_CH_CTRL_VCXO_SRC_SEL_CH0 << ch;
   376                  if (out) {
   377                          ret |= mask;
   378                          out = 2;
                                ^^^^^^^
Should be either true or false.  Two implies FileNotFound.
http://thedailywtf.com/Articles/What_Is_Truth_0x3f_.aspx

   379                  } else {
   380                          ret &= ~mask;
   381                  }

regards,
dan carpenter

