Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60979 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab1HZBR6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2011 21:17:58 -0400
Received: by wyg24 with SMTP id 24so2097107wyg.19
        for <linux-iio@vger.kernel.org>; Thu, 25 Aug 2011 18:17:57 -0700 (PDT)
Date: Fri, 26 Aug 2011 04:15:42 +0300
From: Dan Carpenter <error27@gmail.com>
To: Grant Grundler <grundler@google.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: re: STAGING:iio:light: fix ISL29018 init to handle brownout
Message-ID: <20110826011542.GK5975@shale.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Grant,

There is a memory corruption bug in 176f9f29cec9 "STAGING:iio:light:
fix ISL29018 init to handle brownout".

In isl29018_chip_init() we call:
        status = isl29018_write_data(client, ISL29018_REG_TEST, 0,               
                                ISL29018_TEST_MASK, ISL29018_TEST_SHIFT);        

where ISL29018_REG_TEST is 8.

In isl29018_write_data() it uses reg (ISL29018_REG_TEST) as the
offset into the ->reg_cache[] array:
	chip->reg_cache[reg] = regval;

But ->reg_cache[] only has 3 elements, so we're past the end of the
array.

I don't know the code well enough to fix this.

regards,
dan carpenter
