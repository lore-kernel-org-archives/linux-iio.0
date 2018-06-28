Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:9613 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965557AbeF1Pha (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Jun 2018 11:37:30 -0400
Date: Thu, 28 Jun 2018 23:37:09 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: kbuild-all@01.org, jic23@kernel.org, Michael.Hennerich@analog.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org, lukas@wunner.de,
        Ismail.Kose@maximintegrated.com, vilhelm.gray@gmail.com,
        sean.nyekjaer@prevas.dk, pombredanne@nexb.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefan.popa@analog.com
Subject: [RFC PATCH] iio: dac: cmpfunc() can be static
Message-ID: <20180628153709.GA31782@lkp-ib03>
References: <1530188012-28253-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530188012-28253-1-git-send-email-stefan.popa@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Fixes: 2c1562568d29 ("iio: dac: Add AD5758 support")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 ad5758.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 2aaddf9..55c0a61 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -234,7 +234,7 @@ static int ad5758_spi_write_mask(struct ad5758_state *st,
 	return ad5758_spi_reg_write(st, addr, regval);
 }
 
-int cmpfunc(const void *a, const void *b)
+static int cmpfunc(const void *a, const void *b)
 {
 	return (*(int *)a - *(int *)b);
 }
