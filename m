Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44937 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932948AbcBIWRE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 17:17:04 -0500
Subject: Re: [PATCH 4/5] iio: hmc5843: Fix comment style warnings
To: Cristina Moraru <cristina.moraru09@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, marek@goldelico.com,
	sdliyong@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, tolga.ceylan@gmail.com,
	k.kozlowski@samsung.com, javier@osg.samsung.com, arnd@arndb.de,
	geert@linux-m68k.org, irina.tirdea@intel.com,
	daniel.baluta@intel.com, octavia.purdila@intel.com
References: <1454883711-15489-1-git-send-email-cristina.moraru09@gmail.com>
 <1454883711-15489-5-git-send-email-cristina.moraru09@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56BA655D.4000407@kernel.org>
Date: Tue, 9 Feb 2016 22:17:01 +0000
MIME-Version: 1.0
In-Reply-To: <1454883711-15489-5-git-send-email-cristina.moraru09@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/16 22:21, Cristina Moraru wrote:
> Fix comment style warnings in order to comply with Coding Style
> standard provided by Documentation/CodingStyle.
> 
> This patch solves following issue found with checkpatch:
> WARNING: Block comments use a trailing */ on a separate line
> 
> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
I've applied this, but with a few additions... see inline.
> ---
>  drivers/staging/iio/magnetometer/hmc5843.h     | 4 ++--
>  drivers/staging/iio/magnetometer/hmc5843_i2c.c | 2 +-
>  drivers/staging/iio/magnetometer/hmc5843_spi.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.h b/drivers/staging/iio/magnetometer/hmc5843.h
> index 06f35d3..cb284cf 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.h
> +++ b/drivers/staging/iio/magnetometer/hmc5843.h
> @@ -8,7 +8,7 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   *
Dropped the unwanted empty comment line as it doesn't add anything and we
might as well clean it up whilst here.
> - * */
> + */
>  
>  #ifndef HMC5843_CORE_H
>  #define HMC5843_CORE_H
> @@ -38,7 +38,7 @@ enum hmc5843_ids {
>   * @regmap:		hardware access register maps
>   * @variant:		describe chip variants
>   * @buffer:		3x 16-bit channels + padding + 64-bit timestamp
> - **/
> + */
>  struct hmc5843_data {
>  	struct device *dev;
>  	struct mutex lock;
> diff --git a/drivers/staging/iio/magnetometer/hmc5843_i2c.c b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
> index 3e06ceb..6f7b8fb 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843_i2c.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
> @@ -8,7 +8,7 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   *
snap
> - * */
> + */
>  
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> diff --git a/drivers/staging/iio/magnetometer/hmc5843_spi.c b/drivers/staging/iio/magnetometer/hmc5843_spi.c
> index 1549192..85adcdd 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843_spi.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843_spi.c
> @@ -7,7 +7,7 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   *
snap.
> - * */
> + */
>  
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
> 

