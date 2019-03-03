Return-Path: <SRS0=rKOe=RG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8131C43381
	for <linux-iio@archiver.kernel.org>; Sun,  3 Mar 2019 15:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BD1204FD
	for <linux-iio@archiver.kernel.org>; Sun,  3 Mar 2019 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551626636;
	bh=HZk6Oa3tXNOKqeRdwu3g6gOZHol+4Bm6ZP1lRnszZ1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=au8XmImMjsS2D58go3gGn/VUKFWtZ5pouGaCI9unJiORlpfNrrWgw/1WvBNj3AEpo
	 3GUzpP1wRwkdtWh8c8+qFgpbi4KoOE0xVMPCyoiEvGm1kusNc+2zX7B2hfYboMtmKK
	 K+Kg1KbWjha0yH08EVo0LR2+twurGUr3vbakYw78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfCCPX4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:23:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfCCPX4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Mar 2019 10:23:56 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 354FA20836;
        Sun,  3 Mar 2019 15:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551626635;
        bh=HZk6Oa3tXNOKqeRdwu3g6gOZHol+4Bm6ZP1lRnszZ1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LFrH959CSM1Wq8eUAg8OYIbEpdHeTfa5wBERvIInojSZ6SVr2j4PF1UOJemwKAXT6
         Tc5LtPbNxQ0QMgBxXoAL4jolVEnaRHWg25yoboSTGBMUBg/SpQe64LV+q6CzJQICNs
         F82MD/4EVb2IWEcyFnzZWrZKNA+gznXkptXSkv9U=
Date:   Sun, 3 Mar 2019 15:23:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] iio: magnetometer: bmc150: add mount matrix
 support
Message-ID: <20190303152347.1183694a@archlinux>
In-Reply-To: <92f9b04e6540612b8bb8450803df1fcda21e364b.1550768574.git.hns@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
        <92f9b04e6540612b8bb8450803df1fcda21e364b.1550768574.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Feb 2019 18:02:52 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> This patch allows to read a mount-matrix device tree
> property and report to user-space or in-kernel iio
> clients.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index d91cb845e3d6..b0d8b036d9bb 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -143,6 +143,7 @@ struct bmc150_magn_data {
>  	 */
>  	struct mutex mutex;
>  	struct regmap *regmap;
> +	struct iio_mount_matrix orientation;
>  	/* 4 x 32 bits for x, y z, 4 bytes align, 64 bits timestamp */
>  	s32 buffer[6];
>  	struct iio_trigger *dready_trig;
> @@ -612,6 +613,20 @@ static ssize_t bmc150_magn_show_samp_freq_avail(struct device *dev,
>  	return len;
>  }
>  
> +static const struct iio_mount_matrix *
> +bmc150_magn_get_mount_matrix(const struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan)
> +{
> +	struct bmc150_magn_data *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
> +}
> +
> +static const struct iio_chan_spec_ext_info bmc150_magn_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmc150_magn_get_mount_matrix),
> +	{ }
> +};
> +
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(bmc150_magn_show_samp_freq_avail);
>  
>  static struct attribute *bmc150_magn_attributes[] = {
> @@ -638,6 +653,7 @@ static const struct attribute_group bmc150_magn_attrs_group = {
>  		.storagebits = 32,					\
>  		.endianness = IIO_LE					\
>  	},								\
> +	.ext_info = bmc150_magn_ext_info,				\
>  }
>  
>  static const struct iio_chan_spec bmc150_magn_channels[] = {
> @@ -861,6 +877,11 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
>  	data->irq = irq;
>  	data->dev = dev;
>  
> +	ret = iio_read_mount_matrix(dev, "mount-matrix",
> +				&data->orientation);
> +	if (ret)
> +		return ret;
> +
>  	if (!name && ACPI_HANDLE(dev))
>  		name = bmc150_magn_match_acpi_device(dev);
>  

