Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 6 Aug 2012 10:39:34 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: jic23@cam.ac.uk
cc: linux-iio@vger.kernel.org
Subject: lis3l02dq_core fails to compile
Message-ID: <alpine.DEB.2.01.1208061029320.1363@pmeerw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

staging/iio/accel/lis3l02dq_core.c fails to compile when irq_to_gpio() is 
not available

the solution is to pass both, irq and gpio via platform data (e.g. as 
done by staging/iio/magnetometer/ak8975.c)?

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
