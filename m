Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:51310 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab3EVUZo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 16:25:44 -0400
Date: Wed, 22 May 2013 23:25:31 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: michael.hennerich@analog.com
Cc: linux-iio@vger.kernel.org
Subject: re: iio: frequency: New driver for Analog Devices ADF4350/ADF4351
 Wideband Synthesizers
Message-ID: <20130522202531.GA1438@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Michael Hennerich,

The patch e31166f0fd48: "iio: frequency: New driver for Analog
Devices ADF4350/ADF4351 Wideband Synthesizers" from May 29, 2012,
leads to the following warning:
"drivers/iio/frequency/adf4350.c:212 adf4350_set_freq()
	 warn: 0x13c001fc0 is larger than 32 bits"

I have been messing with Smatch recently and this is not the right
warning...  :/

drivers/iio/frequency/adf4350.c
   207          st->regs[ADF4350_REG2] =
   208                  ADF4350_REG2_10BIT_R_CNT(r_cnt) |
   209                  ADF4350_REG2_DOUBLE_BUFF_EN |
   210                  (pdata->ref_doubler_en ? ADF4350_REG2_RMULT2_EN : 0) |
   211                  (pdata->ref_div2_en ? ADF4350_REG2_RDIV2_EN : 0) |
   212                  (pdata->r2_user_settings & (ADF4350_REG2_PD_POLARITY_POS |
   213                  ADF4350_REG2_LDP_6ns | ADF4350_REG2_LDF_INT_N |
   214                  ADF4350_REG2_CHARGE_PUMP_CURR_uA(5000) |
   215                  ADF4350_REG2_MUXOUT(0x7) | ADF4350_REG2_NOISE_MODE(0x9)));
                        ^^^^^^^^^^^^^^^^^^^^^^^^   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
0x7 and 0x9 are signed int so when we do "<< 29" it wraps or has a sign
extention.  Also we are doing a bitwise AND with 32 bit unsigned values
so they get truncated that way too.

It's not clear what was intended here.

regards,
dan carpenter

