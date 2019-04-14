Return-Path: <SRS0=A0tK=SQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1B3C10F13
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 12:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93E6218D3
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 12:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555245619;
	bh=tCV3b4ZByZO/xhPF62beKrEJU83J2Ez5Ldnyf8BQSdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZAT7ea4nQl8jjRaZHkd7sltFNAPzA1HQywQdWupnSDoxlCdnUCsTIDMfsB6Vt1C9P
	 2ajhfT/DV5H8wOJPo370K9pmv9hla+jqmB3GBZQ3lYT25DMNjhNTsydG5U2F+ggIm9
	 gu1D5kv2pE5jJBueEJLBJYKqRzhlGXc2APWh6Vrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfDNMkT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Apr 2019 08:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfDNMkT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Apr 2019 08:40:19 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C967C20896;
        Sun, 14 Apr 2019 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555245618;
        bh=tCV3b4ZByZO/xhPF62beKrEJU83J2Ez5Ldnyf8BQSdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jV+LEupoOQR4msAIf+qe2qdK6VaRKyUsR37eF25zx0s6El8Q/JEee3y9hbl1kLUIh
         ysiArRwRkgCvXHetwH+m/Wc/RrLXsK5Ff5/1PwXiYSa+UO/q5Avk3hqhetKdTTNR3T
         wSGfHQNN3i5XMMPw0nxqTwFRC9AW5dt9663cnk5U=
Date:   Sun, 14 Apr 2019 13:40:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] iio: imu: st_lsm6dsx: remove set but not used
 variables 'acc_sensor' and 'gyro_sensor'
Message-ID: <20190414134013.257d58ac@archlinux>
In-Reply-To: <20190409082448.GA26320@localhost.localdomain>
References: <20190409021217.155327-1-yuehaibing@huawei.com>
        <20190409082448.GA26320@localhost.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Apr 2019 10:24:49 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > Fixes gcc '-Wunused-but-set-variable' warning:
> > 
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c: In function 'st_lsm6dsx_read_tagged_fifo':
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:520:41: warning:
> >  variable 'gyro_sensor' set but not used [-Wunused-but-set-variable]
> > 
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:520:28: warning:
> >  variable 'acc_sensor' set but not used [-Wunused-but-set-variable]
> > 
> > They are not used since commit 14c7c6e1a860 ("iio: imu: st_lsm6dsx: add
> > st_lsm6dsx_push_tagged_data routine")
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>  
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

thanks,

Jonathan

> 
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 2da8c5ff699a..bd08711d5b75 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -517,7 +517,6 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
> >  {
> >  	u16 pattern_len = hw->sip * ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
> >  	u16 fifo_len, fifo_diff_mask;
> > -	struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor;
> >  	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE], tag;
> >  	bool reset_ts = false;
> >  	int i, err, read_len;
> > @@ -539,9 +538,6 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
> >  	if (!fifo_len)
> >  		return 0;
> >  
> > -	acc_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> > -	gyro_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
> > -
> >  	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
> >  		err = st_lsm6dsx_read_block(hw,
> >  					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
> > 
> > 
> >   

