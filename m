Return-Path: <SRS0=wvAN=YF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BD8C4360C
	for <linux-iio@archiver.kernel.org>; Sat, 12 Oct 2019 12:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2DA21850
	for <linux-iio@archiver.kernel.org>; Sat, 12 Oct 2019 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570883433;
	bh=0ReNxhftJOF60VkFLiQmAsnmky8PfTo6E4U2X+8k41g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eEr3e91ohmiBdrEu4HSHY0/4fw7iyH/gaej6D6zv9xDFcW1DmCsczmyyIQAvGz0GL
	 d0iGK5OxuGfKeOnzXslKNGlAOYkjTV/XpfG4KC0+3jDzC97MMDGDDGFTaF4fkuHxP4
	 Dc5ybUNoInsQ/NTTJXFo4RQP56YubBi9IXRQdr48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfJLMad (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 12 Oct 2019 08:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfJLM2d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 08:28:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 208E32089F;
        Sat, 12 Oct 2019 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570883312;
        bh=0ReNxhftJOF60VkFLiQmAsnmky8PfTo6E4U2X+8k41g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D8gEPKvSgKo1KNiB39htE13HMYIjaMS7y5jzFkx87nkognyWPBEeglSyglWvPMiUe
         d6l/RlFCvcgyP2GkYAJ4NyhC0SwMDSlSRU6NzDUt4hOq9vi/p5B1lY2RSnyfV9DdMb
         TJx3uxsCjmswOqS1fo+kZLSMAz5plAHXgxGraUmY=
Date:   Sat, 12 Oct 2019 13:28:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 13/13] iio: imu: st_lsm6dsx: enable wake-up event for
 LSM6DSO
Message-ID: <20191012132827.0a8a7335@archlinux>
In-Reply-To: <a67031c30724002724209dc1e0bba3c53c53a2a5.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
        <a67031c30724002724209dc1e0bba3c53c53a2a5.1570367532.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  6 Oct 2019 15:22:07 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add missing wake-up register info for LSM6DSO/LSM6DSOX sensor
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 25 +++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index a2a0ac81e3d3..876f59cedc8b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -780,6 +780,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x56,
>  				.mask = BIT(6),
>  			},
> +			.irq1_func = {
> +				.addr = 0x5e,
> +				.mask = BIT(5),
> +			},
> +			.irq2_func = {
> +				.addr = 0x5f,
> +				.mask = BIT(5),
> +			},
>  			.hla = {
>  				.addr = 0x12,
>  				.mask = BIT(5),
> @@ -847,7 +855,22 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.slv0_addr = 0x15,
>  			.dw_slv0_addr = 0x21,
>  			.batch_en = BIT(3),
> -		}
> +		},
> +		.event_settings = {
> +			.enable_reg = {
> +				.addr = 0x58,
> +				.mask = BIT(7),
> +			},
> +			.wakeup_reg = {
> +				.addr = 0x5b,
> +				.mask = GENMASK(5, 0),
> +			},
> +			.wakeup_src_reg = 0x1b,
> +			.wakeup_src_status_mask = BIT(3),
> +			.wakeup_src_z_mask = BIT(0),
> +			.wakeup_src_y_mask = BIT(1),
> +			.wakeup_src_x_mask = BIT(2),
> +		},
>  	},
>  	{
>  		.wai = 0x6b,

