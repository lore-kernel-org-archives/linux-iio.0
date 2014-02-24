Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:44143 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbaBXWER (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2014 17:04:17 -0500
Date: Tue, 25 Feb 2014 01:04:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org
Subject: re: iio:magnetometer:mag3110: Scale factor missing for temperature
Message-ID: <20140224220419.GC29170@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Peter Meerwald,

The patch f9279d3a8cc8: "iio:magnetometer:mag3110: Scale factor
missing for temperature" from Oct 1, 2014, leads to the following
                              ^^^^^^^^^^^
[ just the other day people were searching the internet for time
  travellers from the future ].

static checker warning:

	drivers/iio/magnetometer/mag3110.c:197 mag3110_read_raw()
	info: ignoring unreachable code.

drivers/iio/magnetometer/mag3110.c
   185          case IIO_CHAN_INFO_SCALE:
   186                  switch (chan->type) {
   187                  case IIO_MAGN:
   188                          *val = 0;
   189                          *val2 = 1000;
   190                          return IIO_VAL_INT_PLUS_MICRO;
   191                  case IIO_TEMP:
   192                          *val = 1000;
   193                          return IIO_VAL_INT;
   194                  default:
   195                          return -EINVAL;
   196                  }
   197                  return IIO_VAL_INT_PLUS_MICRO;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Was -EINVAL intended here?

regards,
dan carpenter
