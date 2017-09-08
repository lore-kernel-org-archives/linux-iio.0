Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39948 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754539AbdIHG3O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Sep 2017 02:29:14 -0400
Date: Fri, 08 Sep 2017 07:29:06 +0100
In-Reply-To: <20170908044752.GA6199@himanshi-Inspiron-5558>
References: <20170908044752.GA6199@himanshi-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] Staging: iio: adc: Added Space around binary op.
To: Himanshi Jain <himshijain.hj@gmail.com>,
        outreachy-kernel@googlegroups.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <DEB4AC67-43D5-40F9-9495-DB4966A07661@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 8 September 2017 05:47:52 BST, Himanshi Jain <himshijain.hj@gmail.com> wrote:
>Added space around(one on each side of) binary
>operator(-) as preferred according to kernel
>coding style.
>
>Signed-off-by: Himanshi Jain <himshijain.hj@gmail.com>

Take a closer look at that macro. It isn't doing what you think...  To give a hint, changing this breaks userspace.

Jonathan


>---
> drivers/staging/iio/adc/ad7192.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/staging/iio/adc/ad7192.c
>b/drivers/staging/iio/adc/ad7192.c
>index d11c6de..1aee662 100644
>--- a/drivers/staging/iio/adc/ad7192.c
>+++ b/drivers/staging/iio/adc/ad7192.c
>@@ -341,7 +341,7 @@ static int ad7192_setup(struct ad7192_state *st,
> }
> 
> static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
>-			     in_voltage-voltage_scale_available,
>+			     in_voltage - voltage_scale_available,
> 			     0444, ad7192_show_scale_available, NULL, 0);
> 
> static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
