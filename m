Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752696AbdHTJRm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 05:17:42 -0400
Date: Sun, 20 Aug 2017 10:16:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: accel: bma180: constify i2c_device_id
Message-ID: <20170820101617.476bba9a@archlinux>
In-Reply-To: <1503168458-17676-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503168458-17676-1-git-send-email-arvind.yadav.cs@gmail.com>
        <1503168458-17676-2-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 20 Aug 2017 00:17:36 +0530
Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> i2c_device_id are not supposed to change at runtime. All functions
> working with i2c_device_id provided by <linux/i2c.h> work with
> const i2c_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/bma180.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index efc6773..3dec972 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -842,7 +842,7 @@ static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
>  #define BMA180_PM_OPS NULL
>  #endif
>  
> -static struct i2c_device_id bma180_ids[] = {
> +static const struct i2c_device_id bma180_ids[] = {
>  	{ "bma180", BMA180 },
>  	{ "bma250", BMA250 },
>  	{ }

