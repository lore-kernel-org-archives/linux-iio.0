Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:23503 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbJAWQW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Oct 2015 18:16:22 -0400
Date: Fri, 2 Oct 2015 01:16:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: cmo@melexis.com
Cc: linux-iio@vger.kernel.org
Subject: re: iio: mlx90614: Implement filter configuration
Message-ID: <20151001221609.GA3694@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Crt Mori,

The patch 764589b688a1: "iio: mlx90614: Implement filter
configuration" from Aug 17, 2015, leads to the following static
checker warning:

	drivers/iio/temperature/mlx90614.c:167 mlx90614_iir_search()
	warn: this cast is a no-op

drivers/iio/temperature/mlx90614.c
   158          ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
   159          if (ret > 0)
   160                  return ret;
   161  
   162          /* Write changed values */
   163          ret = mlx90614_write_word(client, MLX90614_CONFIG,
   164                          (i << MLX90614_CONFIG_IIR_SHIFT) |
   165                          (((u16) ((0x7 << MLX90614_CONFIG_FIR_SHIFT) |
   166                          ((u16) ret & (~((u16) MLX90614_CONFIG_FIR_MASK))))) &
   167                          (~(u16) MLX90614_CONFIG_IIR_MASK)));

Quite a few of these casts make no sense.  It's not clear what was
intended.

	(~(u16) MLX90614_CONFIG_IIR_MASK)

So we take int 0x7 and cast it to u16, then because of type promotion
we convert it to int and do a bitwise negate.  The static checker
warning is because often that means (u16)~MLX90614_CONFIG_IIR_MASK is
intended instead.  In this case it looks like we could just remove the
cast with no harm done.

But why are we ANDing it with "ret" which is a negative error code???
I think there is some other typo here beyond the extra casts.

   168          return ret;

regards,
dan carpenter
