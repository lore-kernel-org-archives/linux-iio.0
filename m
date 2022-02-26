Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A724C433F5
	for <linux-iio@archiver.kernel.org>; Sat, 26 Feb 2022 18:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiBZSNS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Feb 2022 13:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiBZSNR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Feb 2022 13:13:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627AC51E74
        for <linux-iio@vger.kernel.org>; Sat, 26 Feb 2022 10:12:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFBB5B80A2B
        for <linux-iio@vger.kernel.org>; Sat, 26 Feb 2022 18:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A56C340E9;
        Sat, 26 Feb 2022 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645899156;
        bh=+upCCjQCaIHiMmlbOF6c49Y97wT1UxaY5SzkZ8PJMH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IYuSJAEexySDMztPxIjYRlAeCFARkFonyxuTPUaahtyD3MKJx6cCz49F4tpC/oSvi
         YqkD1oQ14R9nJVp7AkxgqoTQKOOB901aGduEab9RWPbfZ4oK5iTlEtxcQfuI4Gf8RG
         9Dt7Wxl/NET4Oo8iceoobbWE+FUj+dKepfTjEC5+o6HSbi/+qC1GuDXDDcECpJXXlJ
         +uLB3N+G+MEHCqJJstqQV+wbgDDCDzXwSdU9ypPIKyu1VGAWy4HgXGMvHdztJakHb+
         OqxOgeEuaLPt0Kf4QJhKCF9lqfiA4l+1bj9mChIhLa9QctVZbru1uA6k+QYtK/14jI
         ImbfQqIv3axaQ==
Date:   Sat, 26 Feb 2022 18:19:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     haibo.chen@nxp.com
Cc:     lorenzo.bianconi83@gmail.com, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: use dev_to_iio_dev() to get
 iio_dev struct
Message-ID: <20220226181937.4f2eeca6@jic23-huawei>
In-Reply-To: <1645702191-9400-1-git-send-email-haibo.chen@nxp.com>
References: <1645702191-9400-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Feb 2022 19:29:51 +0800
haibo.chen@nxp.com wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
> 
> After commit 8b7651f25962 ("iio: iio_device_alloc(): Remove
> unnecessary self drvdata"), current driver will meet kernel dump,
> kernel handle NULL pointer dereference.
Formal Fixes tag needed, but I can turn this into one whilst applying
and modify this description to talk about what no longer works rather
than the patch.
> 
> Use dev_to_iio_dev() to get iio_dev struct.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Looks correct to me, so I'll queue it up in the iio/fixes-togreg branch.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 93f0c6bce502..b1d8d5a66f01 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1633,7 +1633,7 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf)
>  {
> -	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_to_iio_dev(dev));
>  	const struct st_lsm6dsx_odr_table_entry *odr_table;
>  	int i, len = 0;
>  
> @@ -1651,7 +1651,7 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
>  					    struct device_attribute *attr,
>  					    char *buf)
>  {
> -	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_to_iio_dev(dev));
>  	const struct st_lsm6dsx_fs_table_entry *fs_table;
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
>  	int i, len = 0;

