Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55254 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbaBYUAL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 25 Feb 2014 15:00:11 -0500
Date: Tue, 25 Feb 2014 21:00:10 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Dan Carpenter <dan.carpenter@oracle.com>
cc: linux-iio@vger.kernel.org
Subject: re: iio:magnetometer:mag3110: Scale factor missing for temperature
In-Reply-To: <20140224220419.GC29170@elgon.mountain>
Message-ID: <alpine.DEB.2.01.1402252053550.30927@pmeerw.net>
References: <20140224220419.GC29170@elgon.mountain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> The patch f9279d3a8cc8: "iio:magnetometer:mag3110: Scale factor
> missing for temperature" from Oct 1, 2014, leads to the following
>                               ^^^^^^^^^^^
> [ just the other day people were searching the internet for time
>   travellers from the future ].

this is indeed weird

> 	drivers/iio/magnetometer/mag3110.c:197 mag3110_read_raw()
> 	info: ignoring unreachable code.
> 
> drivers/iio/magnetometer/mag3110.c
>    185          case IIO_CHAN_INFO_SCALE:
>    186                  switch (chan->type) {
>    187                  case IIO_MAGN:
>    188                          *val = 0;
>    189                          *val2 = 1000;
>    190                          return IIO_VAL_INT_PLUS_MICRO;
>    191                  case IIO_TEMP:
>    192                          *val = 1000;
>    193                          return IIO_VAL_INT;
>    194                  default:
>    195                          return -EINVAL;
>    196                  }
>    197                  return IIO_VAL_INT_PLUS_MICRO;
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Was -EINVAL intended here?

no, this is dead code as the checker indicated

thanks for reporting, sent fix to linux-iio

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
