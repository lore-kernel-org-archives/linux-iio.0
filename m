Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55997 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422986AbcBQTgW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2016 14:36:22 -0500
Subject: Re: [PATCH] iio: health/afe4404: mark suspend/resume functions
 __maybe_unused
To: Arnd Bergmann <arnd@arndb.de>
References: <1455527958-2647084-1-git-send-email-arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	"Andrew F . Davis" <afd@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56C4CBB4.3050708@kernel.org>
Date: Wed, 17 Feb 2016 19:36:20 +0000
MIME-Version: 1.0
In-Reply-To: <1455527958-2647084-1-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/02/16 09:19, Arnd Bergmann wrote:
> The newly added afe4404 driver implements suspend/resume using the
> SIMPLE_DEV_PM_OPS() macro, which leaves out references to the actual
> functions when CONFIG_PM is disabled, causing a harmless warning:
> 
> health/afe4404.c:509:12: error: 'afe4404_suspend' defined but not used
> health/afe4404.c:530:12: error: 'afe4404_resume' defined but not used
> 
> This marks the functions as __maybe_unused so we don't get those
> warnings.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 87aec56e27ef ("iio: health: Add driver for the TI AFE4404 heart monitor")
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/health/afe4404.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> index 0759268f37e0..5096a4643784 100644
> --- a/drivers/iio/health/afe4404.c
> +++ b/drivers/iio/health/afe4404.c
> @@ -477,7 +477,7 @@ static const struct of_device_id afe4404_of_match[] = {
>  MODULE_DEVICE_TABLE(of, afe4404_of_match);
>  #endif
>  
> -static int afe4404_suspend(struct device *dev)
> +static int __maybe_unused afe4404_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct afe4404_data *afe = iio_priv(indio_dev);
> @@ -498,7 +498,7 @@ static int afe4404_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int afe4404_resume(struct device *dev)
> +static int __maybe_unused afe4404_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct afe4404_data *afe = iio_priv(indio_dev);
> 

