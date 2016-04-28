Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:31704 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbcD1Jkz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2016 05:40:55 -0400
Date: Thu, 28 Apr 2016 12:40:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: linus.walleij@linaro.org
Cc: linux-iio@vger.kernel.org
Subject: re: iio: light: new driver for the ROHM BH1780
Message-ID: <20160428094034.GA7255@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Linus Walleij,

This is a semi-automatic email about new static checker warnings.

The patch 1f0477f18306: "iio: light: new driver for the ROHM BH1780" 
from Apr 11, 2016, leads to the following Smatch complaint:

drivers/iio/light/bh1780.c:93 bh1780_debugfs_reg_access()
	 error: we previously assumed 'readval' could be null (see line 86)

drivers/iio/light/bh1780.c
    85	
    86		if (!readval)
                    ^^^^^^^^
    87			bh1780_write(bh1780, (u8)reg, (u8)writeval);

Should this be:
			return bh1780_write(bh1780, (u8)reg, (u8)writeval);

    88	
    89		ret = bh1780_read(bh1780, (u8)reg);
    90		if (ret < 0)
    91			return ret;
    92	
    93		*readval = ret;
                ^^^^^^^^
    94	
    95		return 0;

regards,
dan carpenter
