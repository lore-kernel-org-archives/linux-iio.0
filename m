Return-Path: <SRS0=Z3Ke=LB=gmail.com=himanshujha199640@kernel.org>
Date: Sat, 18 Aug 2018 17:07:35 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jiecheng Wu <jasonwood2031@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, atx@atx.name,
	shubhrajyoti@ti.com, pmeerw@pmeerw.net
Subject: Re: [PATCH] hmc5843_i2c.c: fix missing return value check of
 devm_regmap_init_i2c()
Message-ID: <20180818113735.GI24920@himanshu-Vostro-3559>
References: <20180818020833.14376-1-jasonwood2031@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180818020833.14376-1-jasonwood2031@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

[ + CC'ing relevant people ]

Hi Jiecheng,

On Sat, Aug 18, 2018 at 10:08:33AM +0800, Jiecheng Wu wrote:
> Function hmc5843_i2c_probe() defined in drivers/iio/magnetometer/hmc5843_i2c.c calls devm_regmap_init_i2c() to initialise managed register map. As the return value of devm_regmap_init_i2c() will be an ERR_PTR() on error, the return value must be checked against NULL.

* Wrap up the commit log to 75 characters.
* Add your Signed-off-by: tag

All these warnings is stated by the checkpatch.
So, just run:

$ ./scripts/checkpatch.pl <your_patch>

Anothing question, did you actually hit this bug ? Or did you find doing
static analysis of code ?

Because I found your report on Bugzilla few days ago:
https://bugzilla.kernel.org/show_bug.cgi?id=200555#c0

Another exactly similar report before you reported.

These question shall determine whether the patch should be
backported to stable ?

I think yes, but I'll leave that upto maintainers.

Now, send the next version of patch to the relevant maintainers
using:

$ ./scripts/get_maintainer.pl <your_patch>

Adding Bugzilla-id to the commit log is also the tradition to
be followed.

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

Is this required ?

Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
