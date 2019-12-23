Return-Path: <SRS0=L16q=2N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D987C2D0C0
	for <linux-iio@archiver.kernel.org>; Mon, 23 Dec 2019 16:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02275207FF
	for <linux-iio@archiver.kernel.org>; Mon, 23 Dec 2019 16:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577118964;
	bh=F6AEmDUrUi8IXaoBYTP7+POv/0lTK0dSTE/Ok0tvEcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hSEbKp9b5xs3xQf2OHyuuJ8N+6Poh7XkTeFBZFtiVzKMOP3hYIFHhfgApjGy+TI5V
	 lVA4XP2L1LnnDuuNoqOEmenWafmkW/DtbGg+EIfjpsnzATe99dwZ6L4UW+q6J1kyeX
	 qZDX1Pvk4nUAcONpTkoTWy7sQff4QpaNkzAgfLl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLWQgD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 23 Dec 2019 11:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfLWQgC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:36:02 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A95CA20663;
        Mon, 23 Dec 2019 16:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577118961;
        bh=F6AEmDUrUi8IXaoBYTP7+POv/0lTK0dSTE/Ok0tvEcY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZmeMtPFuyylj09XfkTPUdoya1zUlK71v0LiwOfhWEPyiJsACm9i0g8qOotir9t7m9
         o5Ck9JM+iCTnofcSTDDvy+3V66FfgotvncjjVJ6/mcWU4ltzbljK6ME4OeUwc+/b5P
         P7gQf/MIkv9LWhOtn/WX8y0UKtkTGkFd8cI4ocjo=
Date:   Mon, 23 Dec 2019 16:35:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID
Message-ID: <20191223163557.6955bc42@archlinux>
In-Reply-To: <20191216124120.8789-1-stephan@gerhold.net>
References: <20191216124120.8789-1-stephan@gerhold.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 13:41:20 +0100
Stephan Gerhold <stephan@gerhold.net> wrote:

> At the moment, attempting to probe a device with ST_LSM6DS3_ID
> (e.g. using the st,lsm6ds3 compatible) fails with:
> 
>     st_lsm6dsx_i2c 1-006b: unsupported whoami [69]
> 
> ... even though 0x69 is the whoami listed for ST_LSM6DS3_ID.
> 
> This happens because st_lsm6dsx_check_whoami() also attempts
> to match unspecified (zero-initialized) entries in the "id" array.
> ST_LSM6DS3_ID = 0 will therefore match any entry in
> st_lsm6dsx_sensor_settings (here: the first), because none of them
> actually have all 12 entries listed in the "id" array.
> 
> Avoid this by additionally checking if "name" is set,
> which is only set for valid entries in the "id" array.
> 
> Note: Although the problem was introduced earlier it did not surface until
> commit 52f4b1f19679 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
> because ST_LSM6DS3_ID was the first entry in st_lsm6dsx_sensor_settings.
> 
> Fixes: d068e4a0f921 ("iio: imu: st_lsm6dsx: add support to multiple devices with the same settings")
> Cc: <stable@vger.kernel.org> # 5.4
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
> v1: https://lore.kernel.org/linux-iio/20191209170541.198206-1-stephan@gerhold.net/
> 
> Changes in v2:
>   - Add Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
>   - Add Fixes tag
>   - Cc stable@vger.kernel.org
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index a7d40c02ce6b..b921dd9e108f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1301,7 +1301,8 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
>  
>  	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
>  		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
> -			if (id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> +			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
> +			    id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
>  				break;
>  		}
>  		if (j < ST_LSM6DSX_MAX_ID)

