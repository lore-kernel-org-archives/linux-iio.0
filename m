Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbeHTVma (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Aug 2018 17:42:30 -0400
Date: Mon, 20 Aug 2018 19:25:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: potentiometer: mcp4018: use the correct
 MODULE_LICENSE
Message-ID: <20180820192544.44b2657f@archlinux>
In-Reply-To: <20180820100114.22966-2-peda@axentia.se>
References: <20180820100114.22966-1-peda@axentia.se>
        <20180820100114.22966-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 20 Aug 2018 12:01:10 +0200
Peter Rosin <peda@axentia.se> wrote:

> The file is GPL v2 only.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

thanks,

Jonathan
> ---
>  drivers/iio/potentiometer/mcp4018.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
> index 320a7c929777..5ab74a839982 100644
> --- a/drivers/iio/potentiometer/mcp4018.c
> +++ b/drivers/iio/potentiometer/mcp4018.c
> @@ -190,4 +190,4 @@ module_i2c_driver(mcp4018_driver);
>  
>  MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
>  MODULE_DESCRIPTION("MCP4018 digital potentiometer");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
