Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24E3C43460
	for <linux-iio@archiver.kernel.org>; Sat,  8 May 2021 16:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7B1610CD
	for <linux-iio@archiver.kernel.org>; Sat,  8 May 2021 16:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhEHQGl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 8 May 2021 12:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEHQGk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 12:06:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EEE960FE9;
        Sat,  8 May 2021 16:05:38 +0000 (UTC)
Date:   Sat, 8 May 2021 17:06:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     lorenzo.bianconi83@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: correct ODR in header
Message-ID: <20210508170637.19ba89f1@jic23-huawei>
In-Reply-To: <20210507103149.2193932-1-sean@geanix.com>
References: <20210507103149.2193932-1-sean@geanix.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  7 May 2021 12:31:49 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Fix wrongly stated 13 Hz ODR for accelerometers, the correct ODR is 12.5 Hz
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
For some reason git didn't want to apply this automatically so I did it by hand.
Hopefully ended up with the same result.

Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to do nothing much with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 2ab1ac5a2412..a3ab16615729 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -15,19 +15,19 @@
>   *
>   * Supported sensors:
>   * - LSM6DS3:
> - *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
> + *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
>   *   - FIFO size: 8KB
>   *
>   * - LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC/LSM6DS3TR-C:
> - *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
> + *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
>   *   - FIFO size: 4KB
>   *
>   * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX:
> - *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416,
> + *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
>   *     833
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000

