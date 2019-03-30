Return-Path: <SRS0=wc2U=SB=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACF5C43381
	for <linux-iio@archiver.kernel.org>; Sat, 30 Mar 2019 16:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF142082C
	for <linux-iio@archiver.kernel.org>; Sat, 30 Mar 2019 16:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbfC3QEF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:04:05 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:42394 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730537AbfC3QEF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Mar 2019 12:04:05 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1A7969E6A81;
        Sat, 30 Mar 2019 16:04:02 +0000 (GMT)
Date:   Sat, 30 Mar 2019 16:04:00 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH V2] iio: frequency: ad9523: Fix typo in
 ad9523_platform_data
Message-ID: <20190330160400.5c70ec5e@archlinux>
In-Reply-To: <20190326134003.18371-1-alexandru.ardelean@analog.com>
References: <20190326134003.18371-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Mar 2019 15:40:03 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Replace diff_{m1,m2} with div_{m1,m2} since they are dividers and not a
> differential settings.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing
for no particular reason.

Note that it would be helpful if, when you post a new version of a
patch despite (I think) no replies to the previous, that you also
reply to that thread to say there is a v2.  Sometimes I run forwards
through my emails and would have applied that before seeing this.

Thanks,

Jonathan

> ---
> 
> Changelog v1->v2:
> * added `frequency:` to prefix for consistency
> 
>  drivers/iio/frequency/ad9523.c       | 16 ++++++++--------
>  include/linux/iio/frequency/ad9523.h |  8 ++++----
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index 3f9be69499ec..9b9eee27176c 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -872,22 +872,22 @@ static int ad9523_setup(struct iio_dev *indio_dev)
>  		return ret;
>  
>  	ret = ad9523_write(indio_dev, AD9523_PLL2_VCO_DIVIDER,
> -		AD9523_PLL2_VCO_DIV_M1(pdata->pll2_vco_diff_m1) |
> -		AD9523_PLL2_VCO_DIV_M2(pdata->pll2_vco_diff_m2) |
> -		AD_IFE(pll2_vco_diff_m1, 0,
> +		AD9523_PLL2_VCO_DIV_M1(pdata->pll2_vco_div_m1) |
> +		AD9523_PLL2_VCO_DIV_M2(pdata->pll2_vco_div_m2) |
> +		AD_IFE(pll2_vco_div_m1, 0,
>  		       AD9523_PLL2_VCO_DIV_M1_PWR_DOWN_EN) |
> -		AD_IFE(pll2_vco_diff_m2, 0,
> +		AD_IFE(pll2_vco_div_m2, 0,
>  		       AD9523_PLL2_VCO_DIV_M2_PWR_DOWN_EN));
>  	if (ret < 0)
>  		return ret;
>  
> -	if (pdata->pll2_vco_diff_m1)
> +	if (pdata->pll2_vco_div_m1)
>  		st->vco_out_freq[AD9523_VCO1] =
> -			st->vco_freq / pdata->pll2_vco_diff_m1;
> +			st->vco_freq / pdata->pll2_vco_div_m1;
>  
> -	if (pdata->pll2_vco_diff_m2)
> +	if (pdata->pll2_vco_div_m2)
>  		st->vco_out_freq[AD9523_VCO2] =
> -			st->vco_freq / pdata->pll2_vco_diff_m2;
> +			st->vco_freq / pdata->pll2_vco_div_m2;
>  
>  	st->vco_out_freq[AD9523_VCXO] = pdata->vcxo_freq;
>  
> diff --git a/include/linux/iio/frequency/ad9523.h b/include/linux/iio/frequency/ad9523.h
> index 12ce3ee427fd..621b93c0bcf9 100644
> --- a/include/linux/iio/frequency/ad9523.h
> +++ b/include/linux/iio/frequency/ad9523.h
> @@ -129,8 +129,8 @@ enum cpole1_capacitor {
>   * @pll2_ndiv_b_cnt: PLL2 Feedback N-divider, B Counter, range 0..63.
>   * @pll2_freq_doubler_en: PLL2 frequency doubler enable.
>   * @pll2_r2_div: PLL2 R2 divider, range 0..31.
> - * @pll2_vco_diff_m1: VCO1 divider, range 3..5.
> - * @pll2_vco_diff_m2: VCO2 divider, range 3..5.
> + * @pll2_vco_div_m1: VCO1 divider, range 3..5.
> + * @pll2_vco_div_m2: VCO2 divider, range 3..5.
>   * @rpole2: PLL2 loop filter Rpole resistor value.
>   * @rzero: PLL2 loop filter Rzero resistor value.
>   * @cpole1: PLL2 loop filter Cpole capacitor value.
> @@ -176,8 +176,8 @@ struct ad9523_platform_data {
>  	unsigned char			pll2_ndiv_b_cnt;
>  	bool				pll2_freq_doubler_en;
>  	unsigned char			pll2_r2_div;
> -	unsigned char			pll2_vco_diff_m1; /* 3..5 */
> -	unsigned char			pll2_vco_diff_m2; /* 3..5 */
> +	unsigned char			pll2_vco_div_m1; /* 3..5 */
> +	unsigned char			pll2_vco_div_m2; /* 3..5 */
>  
>  	/* Loop Filter PLL2 */
>  	enum rpole2_resistor		rpole2;

