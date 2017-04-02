Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47226 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbdDBIsJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 04:48:09 -0400
Subject: Re: [PATCH] iio: common: ms_sensors: Remove unnecessary cast on void
 pointer
To: simran singhal <singhalsimran0@gmail.com>
References: <20170401140921.GA24486@singhal-Inspiron-5558>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1db695c8-44ba-cd0a-bb19-e935725db1a5@kernel.org>
Date: Sun, 2 Apr 2017 09:48:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170401140921.GA24486@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/17 15:09, simran singhal wrote:
> The following Coccinelle script was used to detect this:
> @r@
> expression x;
> void* e;
> type T;
> identifier f;
> @@
> (
>   *((T *)e)
> |
>   ((T *)x)[...]
> |
>   ((T*)x)->f
> |
> - (T*)
>   e
> )
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied.
> ---
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> index ecf7721..125b5ff 100644
> --- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> @@ -74,7 +74,7 @@ EXPORT_SYMBOL(ms_sensors_reset);
>  int ms_sensors_read_prom_word(void *cli, int cmd, u16 *word)
>  {
>  	int ret;
> -	struct i2c_client *client = (struct i2c_client *)cli;
> +	struct i2c_client *client = cli;
>  
>  	ret = i2c_smbus_read_word_swapped(client, cmd);
>  	if (ret < 0) {
> @@ -107,7 +107,7 @@ int ms_sensors_convert_and_read(void *cli, u8 conv, u8 rd,
>  {
>  	int ret;
>  	__be32 buf = 0;
> -	struct i2c_client *client = (struct i2c_client *)cli;
> +	struct i2c_client *client = cli;
>  
>  	/* Trigger conversion */
>  	ret = i2c_smbus_write_byte(client, conv);
> 

