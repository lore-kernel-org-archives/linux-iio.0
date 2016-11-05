Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:39722 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753009AbcKELid (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Nov 2016 07:38:33 -0400
Received: from localhost (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 5AC43D8D
        for <linux-iio@vger.kernel.org>; Sat,  5 Nov 2016 11:38:32 +0000 (UTC)
Date: Sat, 5 Nov 2016 07:38:31 -0400
From: Brian Masney <masneyb@onstation.org>
To: linux-iio@vger.kernel.org
Subject: regmap and i2c_smbus_write_byte question
Message-ID: <20161105113831.GA6053@basecamp.onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I am investigating converting the tsl2583 staging driver over to use
the regmap API. I ran into an issue converting the following call to
i2c_smbus_write_byte() over to the regmap API:

struct tsl2583_chip {
        struct i2c_client *client;
        ...
}

/*
 * clear status, really interrupt status (interrupts are off), but
 * we use the bit anyway - don't forget 0x80 - this is a command
 */      
ret = i2c_smbus_write_byte(chip->client,
                           (TSL258X_CMD_REG | TSL258X_CMD_SPL_FN |
                            TSL258X_CMD_ALS_INT_CLR));

I don't see a way to do this in the regmap API.  
drivers/input/touchscreen/tsc2004.c has this same issue and that code
directly calls i2c_smbus_write_byte() along with the regmap API. Am I
missing something? This doesn't feel right to me to bypass the regmap
API and directly access the i2c client.

The data sheet for the tsl2583 sensor is available here:
http://media.digikey.com/PDF/Data%20Sheets/Austriamicrosystems%20PDFs/TSL2581,83.pdf
Page 10 has the table that describes clearing the interrupt bit. The
sensor will not take additional readings until that bit is cleared
(even though interrupts are off).

Thanks,

Brian

