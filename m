Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41269 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbcHOOr2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 10:47:28 -0400
Subject: Re: [PATCH] iio: pressure: bmp280: fix runtime suspend/resume crash
To: Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1469651578-6085-1-git-send-email-linus.walleij@linaro.org>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5ebe6922-83d7-9599-73c6-735dad486827@kernel.org>
Date: Mon, 15 Aug 2016 15:47:25 +0100
MIME-Version: 1.0
In-Reply-To: <1469651578-6085-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/07/16 21:32, Linus Walleij wrote:
> In commit 3d838118c6aa ("iio: pressure: bmp280: add power management")
> 
> For some reason the code in the runtime suspend/resume hooks
> got wrong (I suspect in the ambition to cut down boilerplate)
> and it seems it was tested without CONFIG_PM and crashes like
> so for me:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> pgd = c0204000
> [0000000c] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 89 Comm: kworker/1:2 Not tainted
>   4.7.0-03348-g90dc3680458a-dirty #99
> Hardware name: Generic DT based system
> Workqueue: pm pm_runtime_work
> task: df3c6300 ti: dec8a000 task.ti: dec8a000
> PC is at regulator_disable+0x0/0x6c
> LR is at bmp280_runtime_suspend+0x3c/0xa4
> 
> Dereferencing the BMP280 state container properly fixes the problem,
> sorry for screwing up.
> 
> Fixes: 3d838118c6aa ("iio: pressure: bmp280: add power management")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied and marked for staging.  Thanks,

Jonathan
> ---
>  drivers/iio/pressure/bmp280-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 6943688e66df..724fefd4af00 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1079,7 +1079,8 @@ EXPORT_SYMBOL(bmp280_common_remove);
>  #ifdef CONFIG_PM
>  static int bmp280_runtime_suspend(struct device *dev)
>  {
> -	struct bmp280_data *data = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmp280_data *data = iio_priv(indio_dev);
>  	int ret;
>  
>  	ret = regulator_disable(data->vdda);
> @@ -1090,7 +1091,8 @@ static int bmp280_runtime_suspend(struct device *dev)
>  
>  static int bmp280_runtime_resume(struct device *dev)
>  {
> -	struct bmp280_data *data = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmp280_data *data = iio_priv(indio_dev);
>  	int ret;
>  
>  	ret = regulator_enable(data->vddd);
> 

