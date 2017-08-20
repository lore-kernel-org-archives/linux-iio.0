Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752696AbdHTJRq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 05:17:46 -0400
Date: Sun, 20 Aug 2017 10:17:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: light: tsl2583: constify i2c_device_id
Message-ID: <20170820101738.676604de@archlinux>
In-Reply-To: <1503168458-17676-4-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503168458-17676-1-git-send-email-arvind.yadav.cs@gmail.com>
        <1503168458-17676-4-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 20 Aug 2017 00:17:38 +0530
Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> i2c_device_id are not supposed to change at runtime. All functions
> working with i2c_device_id provided by <linux/i2c.h> work with
> const i2c_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/light/tsl2583.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index 1679181..fb711ed 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -924,7 +924,7 @@ static const struct dev_pm_ops tsl2583_pm_ops = {
>  	SET_RUNTIME_PM_OPS(tsl2583_suspend, tsl2583_resume, NULL)
>  };
>  
> -static struct i2c_device_id tsl2583_idtable[] = {
> +static const struct i2c_device_id tsl2583_idtable[] = {
>  	{ "tsl2580", 0 },
>  	{ "tsl2581", 1 },
>  	{ "tsl2583", 2 },

