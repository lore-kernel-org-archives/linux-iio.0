Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:11624 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbeICNIS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 Sep 2018 09:08:18 -0400
Date: Mon, 3 Sep 2018 09:48:53 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: take into account ts samples in
 wm configuration
Message-ID: <20180903094853.00004152@huawei.com>
In-Reply-To: <20180902211942.4922c0ec@archlinux>
References: <cover.1535705166.git.lorenzo.bianconi@redhat.com>
        <20180830203859.6527-1-lorenzo.bianconi@redhat.com>
        <20180902211942.4922c0ec@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2 Sep 2018 21:19:42 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 30 Aug 2018 22:38:59 +0200
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
> 
> > Take into account hw timer samples in pattern length computation used
> > in st_lsm6dsx_update_watermark routine for watermark configuration
> > 
> > Fixes: 213451076bd3 ("iio: imu: st_lsm6dsx: add hw timestamp support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>  
> Applied to the fixes-togreg branch of iio.git and marked for stable.
> 
Oops. I actually applied V2 and replied to the wrong email.

> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 7589f2ad1dae..2b49d928f4c0 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -187,9 +187,10 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
> >  
> >  int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
> >  {
> > -	u16 fifo_watermark = ~0, cur_watermark, sip = 0, fifo_th_mask;
> > +	u16 fifo_watermark = ~0, cur_watermark, fifo_th_mask;
> >  	struct st_lsm6dsx_hw *hw = sensor->hw;
> >  	struct st_lsm6dsx_sensor *cur_sensor;
> > +	u16 sip = hw->ts_sip;
> >  	int i, err, data;
> >  	__le16 wdata;
> >    
> 
