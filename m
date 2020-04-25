Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A498CC54FCB
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 17:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804BD20700
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 17:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587834333;
	bh=HEBM5f6Bxm4gddWoR8a8ZhgIdq8jzhjca00IaNpMkEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LujKEDv4oyWPf1gvU+QiV/OUdanVfmBv7mSGeZ52mT/98hQzu8hxBkIGIjIkDi7IT
	 w+ax0EnCUuIdZ7DPSe9isOqcWr5WKX3a6kPXkAM13rSi7zdzb/IwT7LgJCFEapVl6K
	 p8ODw6mou54ySwtkNJDIV4QXKCZuvOHggaKmN8u0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgDYRFd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgDYRFc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 13:05:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9550D206B6;
        Sat, 25 Apr 2020 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587834332;
        bh=HEBM5f6Bxm4gddWoR8a8ZhgIdq8jzhjca00IaNpMkEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r5PdOCLs4oOBJB5BoFuu7orSQTI9LbsyWZ20B+zHGTDchF4QFAA+076bT4DShzu98
         iQb2wJVsFttnWqY5S9vYzALoLhK6Zf3Eso8aMjkOhUSVUdtbUK9wjJiDwHSl6Wgba8
         FcBndTVVrav9RW/V2+GmeWurbgK5dIaRiE4gRW7U=
Date:   Sat, 25 Apr 2020 18:05:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: enable 833Hz sample frequency for
 tagged sensors
Message-ID: <20200425180528.75c420bb@archlinux>
In-Reply-To: <81e5660e7b7755346efefdd90f721a4b0cd63726.1587724988.git.lorenzo@kernel.org>
References: <81e5660e7b7755346efefdd90f721a4b0cd63726.1587724988.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Apr 2020 12:44:38 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Enable 833Hz ODR for sensors that supports tagged hw FIFO:
> - LSM6DSO/LSM6DSOX
> - LSM6DSR/LSM6DSRX
> - ASM330LHH
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Would ideally have liked a little more info on the 'why'.  Was this previously
capped by practicality - i.e. not possible to read faster or is there
something else going on here?

Don't really need to know for the applied patch though so
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 21 +++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 84d219ae6aee..e6339bbb4469 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -27,7 +27,8 @@
>   *   - FIFO size: 4KB
>   *
>   * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX:
> - *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
> + *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416,
> + *     833
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
>   *   - FIFO size: 3KB
> @@ -791,7 +792,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104000, 0x04 },
>  				.odr_avl[4] = { 208000, 0x05 },
>  				.odr_avl[5] = { 416000, 0x06 },
> -				.odr_len = 6,
> +				.odr_avl[6] = { 833000, 0x07 },
> +				.odr_len = 7,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.reg = {
> @@ -804,7 +806,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104000, 0x04 },
>  				.odr_avl[4] = { 208000, 0x05 },
>  				.odr_avl[5] = { 416000, 0x06 },
> -				.odr_len = 6,
> +				.odr_avl[6] = { 833000, 0x07 },
> +				.odr_len = 7,
>  			},
>  		},
>  		.fs_table = {
> @@ -994,7 +997,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104000, 0x04 },
>  				.odr_avl[4] = { 208000, 0x05 },
>  				.odr_avl[5] = { 416000, 0x06 },
> -				.odr_len = 6,
> +				.odr_avl[6] = { 833000, 0x07 },
> +				.odr_len = 7,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.reg = {
> @@ -1007,7 +1011,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104000, 0x04 },
>  				.odr_avl[4] = { 208000, 0x05 },
>  				.odr_avl[5] = { 416000, 0x06 },
> -				.odr_len = 6,
> +				.odr_avl[6] = { 833000, 0x07 },
> +				.odr_len = 7,
>  			},
>  		},
>  		.fs_table = {
> @@ -1171,7 +1176,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104000, 0x04 },
>  				.odr_avl[4] = { 208000, 0x05 },
>  				.odr_avl[5] = { 416000, 0x06 },
> -				.odr_len = 6,
> +				.odr_avl[6] = { 833000, 0x07 },
> +				.odr_len = 7,
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.reg = {
> @@ -1184,7 +1190,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.odr_avl[3] = { 104000, 0x04 },
>  				.odr_avl[4] = { 208000, 0x05 },
>  				.odr_avl[5] = { 416000, 0x06 },
> -				.odr_len = 6,
> +				.odr_avl[6] = { 833000, 0x07 },
> +				.odr_len = 7,
>  			},
>  		},
>  		.fs_table = {

