Return-Path: <SRS0=DicA=EH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F2EC388F2
	for <linux-iio@archiver.kernel.org>; Sun,  1 Nov 2020 15:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB9722246
	for <linux-iio@archiver.kernel.org>; Sun,  1 Nov 2020 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604245396;
	bh=g/MdvF1782+4tAyNQICgZpreoOVBRgo0HyFav97maws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EGYwFCEG+nFkyLjm87Tl6RsY531noCebhFsFiHOp3sTZqIJf+eJGpaOtww+Yh1bZ2
	 AfNYLUNaCabhooGUypkiAiuVl+QGNy3OxoO11GL8hlrH+aZDKxrHBkeTjlzIcuttUp
	 EpPg5tXNBfrvuwqLtnIcfrhcCx9Y6wwzvYdf+qYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgKAPnO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 1 Nov 2020 10:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgKAPnO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 10:43:14 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C13D22246;
        Sun,  1 Nov 2020 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604245394;
        bh=g/MdvF1782+4tAyNQICgZpreoOVBRgo0HyFav97maws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V1sV1/nJ8GFtPv3TZXpwtn4+1MR8noyN26KtmtgIf35vnMbU4P78+oiPhupm7ge0K
         /mjHXbSGIjiHDjBFZPSIvW3qIBwcq0i86C6XJqTpVqmGjPZrzw/LnRWyFlUxxRCSMz
         D4FVrX4ue7GJfpj2zzecLbsN9PvtM/j6SmPqVgdI=
Date:   Sun, 1 Nov 2020 15:43:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: set 10ms as min shub slave
 timeout
Message-ID: <20201101154310.6f2aa827@archlinux>
In-Reply-To: <b0cd79d1b72246652df9ccef19bd951bb17b5c55.1603317102.git.lorenzo@kernel.org>
References: <b0cd79d1b72246652df9ccef19bd951bb17b5c55.1603317102.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Oct 2020 23:53:54 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Set 10ms as minimum i2c slave configuration timeout since at high ODRs
> (e.g. 833Hz) the slave sensor may need more cycles than ~3ms
> (2s/833Hz + 1) for the configuration
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

This sounds like a fix to me.  Could you give a bit more detail on what
setup it fails for and a fixes tag so we can get this into appropriate
stable trees?

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 8c8d8870ca07..99562ba85ee4 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -156,11 +156,13 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
>  static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
>  {
>  	struct st_lsm6dsx_sensor *sensor;
> -	u32 odr;
> +	u32 odr, timeout;
>  
>  	sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
>  	odr = (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 12500;
> -	msleep((2000000U / odr) + 1);
> +	/* set 10ms as minimum timeout for i2c slave configuration */
> +	timeout = max_t(u32, 2000000U / odr + 1, 10);
> +	msleep(timeout);
>  }
>  
>  /*

