Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43041 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942077AbdAHJss (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:48:48 -0500
Subject: Re: [PATCH] staging:iio:addac Fixes Alignment should match open
 parenthesis
To: Scott Matheina <scott@matheina.com>, linux-kernel@vger.kernel.org
References: <1483494633-6239-1-git-send-email-scott@matheina.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0124f416-f015-2e77-1f2f-d117b71cb9c7@kernel.org>
Date: Sat, 7 Jan 2017 22:20:36 +0000
MIME-Version: 1.0
In-Reply-To: <1483494633-6239-1-git-send-email-scott@matheina.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/17 01:50, Scott Matheina wrote:
> Fixes style issue where Alignment doesn't match open parenthesis
> 
> Signed-off-by: Scott Matheina <scott@matheina.com>
Please include the part number in the patch title. It's more important
than the directory it happens to be in.

Here you have space to include the whole lot
staging:iio:addac:adt7316

Applied with that minor change to the togreg branch of iio.git which
will get pushed out as testing sometime soon.

Jonathan
> ---
>  drivers/staging/iio/addac/adt7316-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
> index 0ccf192..f66dd3e 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -93,7 +93,7 @@ static int adt7316_i2c_multi_write(void *client, u8 reg, u8 count, u8 *data)
>   */
>  
>  static int adt7316_i2c_probe(struct i2c_client *client,
> -		const struct i2c_device_id *id)
> +			     const struct i2c_device_id *id)
>  {
>  	struct adt7316_bus bus = {
>  		.client = client,
> 

