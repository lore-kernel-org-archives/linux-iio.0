Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752148AbdIXNJY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 09:09:24 -0400
Date: Sun, 24 Sep 2017 14:09:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <benjamin.gaignard@st.com>,
        <benjamin.gaignard@linaro.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: stm32: fix bad error check on max_channels
Message-ID: <20170924140919.669c9cca@archlinux>
In-Reply-To: <1505751855-15490-1-git-send-email-fabrice.gasnier@st.com>
References: <1505751855-15490-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 18 Sep 2017 18:24:15 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Fix a bad error check when counting 'st,adc-channels' array elements.
> This is seen when all channels are in use simultaneously.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Applied to fixes-togreg-post-rc1, fixes tag added and marked for
stable.

Jonathan

> ---
>  drivers/iio/adc/stm32-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index e3c15f8..4df32cf 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1666,7 +1666,7 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>  
>  	num_channels = of_property_count_u32_elems(node, "st,adc-channels");
>  	if (num_channels < 0 ||
> -	    num_channels >= adc_info->max_channels) {
> +	    num_channels > adc_info->max_channels) {
>  		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
>  		return num_channels < 0 ? num_channels : -EINVAL;
>  	}

