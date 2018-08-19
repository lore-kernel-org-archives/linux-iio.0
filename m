Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33192 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeHSMCe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Aug 2018 08:02:34 -0400
Received: by mail-pl0-f68.google.com with SMTP id b90-v6so5650624plb.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Aug 2018 01:51:48 -0700 (PDT)
Date: Sun, 19 Aug 2018 14:21:42 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jiecheng Wu <jasonwood2031@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] hmc5843_i2c.c: fix missing return value check of
 devm_regmap_init_i2c()
Message-ID: <20180819085142.GA2133@himanshu-Vostro-3559>
References: <20180819021641.3068-1-jasonwood2031@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180819021641.3068-1-jasonwood2031@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Aug 19, 2018 at 10:16:41AM +0800, Jiecheng Wu wrote:
> Function hmc5843_i2c_probe() defined in
>  drivers/iio/magnetometer/hmc5843_i2c.c calls devm_regmap_init_i2c()
>  to initialise managed register map. As the return value of
>  devm_regmap_init_i2c() will be an ERR_PTR() on error, the return
>  value must be checked against NULL.

Please take a careful look again at what points I suggested
in a previous patch you sent.

Take a look at a sample patch:
https://lore.kernel.org/lkml/20180531112107.13778-1-hdegoede@redhat.com/

* Signed-off-by:
* Bugzilla link:
* Send to relevant maintainers:
himanshu@himanshu-Vostro-3559:~/linux-next$ ./scripts/get_maintainer.pl ~/Downloads/hmc5843_i2c.c-fix-missing-return-value-check-of-devm_regmap_init_i2c.patch

	Jonathan Cameron <jic23@kernel.org> (maintainer:IIO SUBSYSTEM AND DRIVERS)
	Hartmut Knaack <knaack.h@gmx.de> (reviewer:IIO SUBSYSTEM AND DRIVERS)
	Lars-Peter Clausen <lars@metafoo.de> (reviewer:IIO SUBSYSTEM AND DRIVERS)
	Peter Meerwald-Stadler <pmeerw@pmeerw.net> (reviewer:IIO SUBSYSTEM AND DRIVERS)
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
	linux-kernel@vger.kernel.org (open list)
* cc stable
* Fixes tag: -- would be helpful
* correct version numbering with changelog below the '---' (v1->v2->3 ...)

All these are documented here:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> ---
>  drivers/iio/magnetometer/hmc5843_i2c.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
> index 3de7f44..4911cf8 100644
> --- a/drivers/iio/magnetometer/hmc5843_i2c.c
> +++ b/drivers/iio/magnetometer/hmc5843_i2c.c
> @@ -14,6 +14,7 @@
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/device.h>

This include is not required since #include <linux/iio/iio.h>
already includes it.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
