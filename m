Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:33096 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbGOThL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2015 15:37:11 -0400
Date: Wed, 15 Jul 2015 22:36:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: aybuke.147@gmail.com
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: re: staging: iio: accel: Use __be16 instead of u16
Message-ID: <20150715193650.GA28245@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Aybuke Ozdemir,

The patch 03c6eaa37ad7: "staging: iio: accel: Use __be16 instead of
u16" from Sep 28, 2014, leads to the following static checker warning:

	drivers/staging/iio/accel/sca3000_ring.c:120 sca3000_read_first_n_hw_rb()
	warn: potential pointer math issue ('rx' is a 16 bit pointer)

drivers/staging/iio/accel/sca3000_ring.c
   107           */
   108          if (count > num_available * bytes_per_sample)
   109                  num_read = num_available*bytes_per_sample;
   110          else
   111                  num_read = count;
   112  
   113          ret = sca3000_read_data(st,
   114                                  SCA3000_REG_ADDR_RING_OUT,
   115                                  &rx, num_read);
   116          if (ret)
   117                  goto error_ret;
   118  
   119          for (i = 0; i < num_read; i++)
   120                  *(((u16 *)rx) + i) = be16_to_cpup((__be16 *)rx + i);
                          ^^^^^^^^^^^^^^^

We're writing beyond the end of the array here because of the pointer
math issue.  The fix is probably to say:

		for (i = 0; i < num_read / sizeof(u16); i++)
			*(((u16 *)rx) + i) = be16_to_cpup((__be16 *)rx + i);

   121  
   122          if (copy_to_user(buf, rx, num_read))
   123                  ret = -EFAULT;


regards,
dan carpenter
