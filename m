Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35247 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbbCHMCz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 08:02:55 -0400
Message-ID: <54FC3A6E.1050609@kernel.org>
Date: Sun, 08 Mar 2015 12:02:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Tolga Ceylan <tolga.ceylan@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Staging: iio: meter: ade7854-i2c: code style improvements
References: <1423974765-1782-1-git-send-email-tolga.ceylan@gmail.com> <1423974765-1782-3-git-send-email-tolga.ceylan@gmail.com>
In-Reply-To: <1423974765-1782-3-git-send-email-tolga.ceylan@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/02/15 04:32, Tolga Ceylan wrote:
> Code reformatting based on checkpatch.pl with --strict:
> Comparison to NULL rewritten as !indio_dev
> 
> Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
Whilst I find it hard to care on this particular fix.. what the heck.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 5e6fbe4..4e7a382 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -210,7 +210,7 @@ static int ade7854_i2c_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
> -	if (indio_dev == NULL)
> +	if (!indio_dev)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
> 

