Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49889 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833AbbITKfD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2015 06:35:03 -0400
Subject: Re: [PATCH 2/2] iio: dac: max5821: Fix module autoload for OF
 platform driver
To: Luis de Bethencourt <luis@debethencourt.com>,
	linux-kernel@vger.kernel.org
References: <20150917170232.GA27487@goodgumbo.baconseed.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55FE8BD4.6020400@kernel.org>
Date: Sun, 20 Sep 2015 11:35:00 +0100
MIME-Version: 1.0
In-Reply-To: <20150917170232.GA27487@goodgumbo.baconseed.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/09/15 18:02, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
Thanks

Applied to the togreg branch of iio.git.

As stated before I am treating these as additions of missing functionality
rather than explicit fixes of something broken.  As such they can wait
for the next merge window.

Thanks,

Jonathan
> ---
>  drivers/iio/dac/max5821.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> index 28b8748..86e9e11 100644
> --- a/drivers/iio/dac/max5821.c
> +++ b/drivers/iio/dac/max5821.c
> @@ -387,6 +387,7 @@ static const struct of_device_id max5821_of_match[] = {
>  	{ .compatible = "maxim,max5821" },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, max5821_of_match);
>  
>  static struct i2c_driver max5821_driver = {
>  	.driver = {
> 

