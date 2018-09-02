Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbeIBWJM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 18:09:12 -0400
Date: Sun, 2 Sep 2018 18:52:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5: Verify channel numbers from
 DT
Message-ID: <20180902185228.2eadbce6@archlinux>
In-Reply-To: <20180827211453.213061-1-mka@chromium.org>
References: <20180827211453.213061-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 27 Aug 2018 14:14:53 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> The driver only defines a subset of all possible ADC channels. Channel
> numbers read from the device tree are accepted as long as they don't
> exceed a max value, even when no channel definition exists. Add a
> check to abort initialization in this case.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks for tidying this up.

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 9c8e6f9e8248..ab5bec917c0a 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -519,7 +519,8 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  		return ret;
>  	}
>  
> -	if (chan > ADC5_PARALLEL_ISENSE_VBAT_IDATA) {
> +	if (chan > ADC5_PARALLEL_ISENSE_VBAT_IDATA ||
> +	    !data->adc_chans[chan].datasheet_name) {
>  		dev_err(dev, "%s invalid channel number %d\n", name, chan);
>  		return -EINVAL;
>  	}
