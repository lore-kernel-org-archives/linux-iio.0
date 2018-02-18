Return-Path: <SRS0=qxVu=FM=gmail.com=himanshujha199640@kernel.org>
Date: Sun, 18 Feb 2018 17:01:38 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, daniel.baluta@nxp.com
Subject: Re: [PATCH 1/3] Staging: iio: adis16209: Use SPDX identifier
Message-ID: <20180218113138.GA4039@himanshu-Vostro-3559>
References: <cover.1518883035.git.shreeya.patel23498@gmail.com>
 <6771b95bbfb8301724086dba4d92df6a6b11d6f7.1518883035.git.shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6771b95bbfb8301724086dba4d92df6a6b11d6f7.1518883035.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Shreeya,

On Sat, Feb 17, 2018 at 09:34:56PM +0530, Shreeya Patel wrote:
> Use SPDX identifier format instead of GPLv2. Also rearrange the
> headers in alphabetical order.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16209.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 7fcef9a..e3d9f80 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -1,19 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
>   *
>   * Copyright 2010 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2 or later.

I see that you too are doing similar cleanup which I did a while ago
https://lkml.org/lkml/2018/2/12/255
where I got some update suggestions for the patch series. It would be
great if you could update this patch series consistent with the
reviewers.

For eg: in this patch you changed 

+// SPDX-License-Identifier: GPL-2.0+

and therefore

MODULE_LICENSE("GPL v2");

should also be changed to 

MODULE_LICENSE("GPL"); 

as explained by	Philippe Ombredanne to me in my patch series.

I am not sure if you're subscribed to the IIO mailing list but you can find
all the update suggestions from the above link. :)

-- 
Thanks
Himanshu Jha
