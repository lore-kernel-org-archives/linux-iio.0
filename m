Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57016 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934007AbdC3SQy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Mar 2017 14:16:54 -0400
Subject: Re: [PATCH] drivers: iio: replace comma with a semicolon
To: Arushi Singhal <arushisinghal19971997@gmail.com>
References: <20170330124121.GA29095@arushi-HP-Pavilion-Notebook>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8151b453-3ae7-7321-8294-c5c8e1cf7a29@kernel.org>
Date: Thu, 30 Mar 2017 19:16:51 +0100
MIME-Version: 1.0
In-Reply-To: <20170330124121.GA29095@arushi-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/03/17 13:41, Arushi Singhal wrote:
> Replace a comma between expression statements by a semicolon. This
> changes the semantics of the code, but given the current indentation
> appears to be what is intended.
> A simplified version of the Coccinelle semantic patch that performs this
> transformation is as follows:
> 
> // <smpl>
> @r@
> expression e1,e2;
> @@
> 
>  e1
> -,
> +;
>  e2;
> // </smpl>
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
As per the discussion about the other one.  This is perfectly
correct, but weird enough that I think we'll clear it out.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

I did add chemical to the title though to make it clearer what
this was covering.

Thanks,

Jonathan
> ---
>  drivers/iio/chemical/ams-iaq-core.c | 2 +-
>  drivers/iio/chemical/vz89x.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
> index 41a8e6f2e31d..c948ad2ee9ad 100644
> --- a/drivers/iio/chemical/ams-iaq-core.c
> +++ b/drivers/iio/chemical/ams-iaq-core.c
> @@ -163,7 +163,7 @@ static int ams_iaqcore_probe(struct i2c_client *client,
>  	mutex_init(&data->lock);
>  
>  	indio_dev->dev.parent = &client->dev;
> -	indio_dev->info = &ams_iaqcore_info,
> +	indio_dev->info = &ams_iaqcore_info;
>  	indio_dev->name = dev_name(&client->dev);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index 8e0e4415c161..f75eea6822f2 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -393,7 +393,7 @@ static int vz89x_probe(struct i2c_client *client,
>  	mutex_init(&data->lock);
>  
>  	indio_dev->dev.parent = &client->dev;
> -	indio_dev->info = &vz89x_info,
> +	indio_dev->info = &vz89x_info;
>  	indio_dev->name = dev_name(&client->dev);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> 

