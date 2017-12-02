Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751568AbdLBL6o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Dec 2017 06:58:44 -0500
Date: Sat, 2 Dec 2017 11:58:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linux-iio@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] iio: accel: kxsd9: add MODULE_LICENSE
Message-ID: <20171202115840.7593e943@archlinux>
In-Reply-To: <20171201022131.26456-1-dja@axtens.net>
References: <20171201022131.26456-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  1 Dec 2017 13:21:31 +1100
Daniel Axtens <dja@axtens.net> wrote:

> This fixes the following warning in an allmodconfig build:
> WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/accel/kxsd9-i2c.o
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
I clearly need to be a bit sharper with sending pull requests upstream.

This is patch 3 for the same issue.

Jonathan
> ---
>  drivers/iio/accel/kxsd9-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> index 98fbb628d5bd..5e14262248b8 100644
> --- a/drivers/iio/accel/kxsd9-i2c.c
> +++ b/drivers/iio/accel/kxsd9-i2c.c
> @@ -63,3 +63,5 @@ static struct i2c_driver kxsd9_i2c_driver = {
>  	.id_table	= kxsd9_i2c_id,
>  };
>  module_i2c_driver(kxsd9_i2c_driver);
> +
> +MODULE_LICENSE("GPL v2");

