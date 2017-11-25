Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbdKYPP3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 10:15:29 -0500
Date: Sat, 25 Nov 2017 15:13:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jesse Chan <jc@linux.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] iio: accel: kxsd9-i2c: add missing
 MODULE_AUTHOR/DESCRIPTION/LICENSE
Message-ID: <20171125151333.0f279ce4@archlinux>
In-Reply-To: <20171120205520.84809-1-jc@linux.com>
References: <20171120205520.84809-1-jc@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 20 Nov 2017 12:55:18 -0800
Jesse Chan <jc@linux.com> wrote:

> This change resolves a new compile-time warning
> when built as a loadable module:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/accel/kxsd9-i2c.o
> see include/linux/module.h for more information
> 
> This adds the license as "GPL v2", which matches the header of the file.
> 
> MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Linus sent patches fixing the license and description the other day.
Also wise to actually cc Linus!

Right now they are only publicly visible in the testing
branch of iio.git on kernel.org as I'll be rebasing once rc1 is out...

Thanks,

Jonathan
> 
> Signed-off-by: Jesse Chan <jc@linux.com>
> ---
>  drivers/iio/accel/kxsd9-i2c.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> index 98fbb628d5bd..40f82ada6a52 100644
> --- a/drivers/iio/accel/kxsd9-i2c.c
> +++ b/drivers/iio/accel/kxsd9-i2c.c
> @@ -63,3 +63,7 @@ static struct i2c_driver kxsd9_i2c_driver = {
>  	.id_table	= kxsd9_i2c_id,
>  };
>  module_i2c_driver(kxsd9_i2c_driver);
> +
> +MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
> +MODULE_DESCRIPTION("Kionix KXSD9 I2C driver");
> +MODULE_LICENSE("GPL v2");

