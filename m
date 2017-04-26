Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24048 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1946896AbdDZHNa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 03:13:30 -0400
From: Lorenzo BIANCONI <lorenzo.bianconi@st.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: export st_lsm6dsx_flush_fifo()
 and st_lsm6dsx_set_fifo_mode() routines
Date: Wed, 26 Apr 2017 07:13:23 +0000
Message-ID: <20170426071323.GA4960@ctocxl0005.oa.cto.st.com>
References: <20170421182213.21481-1-lorenzo.bianconi@st.com>
 <20170421182213.21481-2-lorenzo.bianconi@st.com>
 <13c8b737-a6a2-ca69-55b1-e38ad89d6d1c@kernel.org>
In-Reply-To: <13c8b737-a6a2-ca69-55b1-e38ad89d6d1c@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Apr 26, Jonathan Cameron wrote:
> On 21/04/17 19:22, Lorenzo Bianconi wrote:
> > Remove static qualifier from st_lsm6dsx_flush_fifo() and
> > st_lsm6dsx_set_fifo_mode() in order to use them in system sleep pm support
> Export kind of implies exporting the symbols when referring to kernel code.
> Here you are just making them available to other parts of the same driver.
> Perhaps reword the patch title.

Ack, will do in v2.
Thx,
Lorenzo

> 
> Jonathan
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 3 +++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 6 +++---
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > index 4839db7..7778520 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -144,5 +144,8 @@ int st_lsm6dsx_write_with_mask(struct st_lsm6dsx_hw *hw, u8 addr, u8 mask,
> >  			       u8 val);
> >  int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
> >  				u16 watermark);
> > +int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
> > +int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> > +			     enum st_lsm6dsx_fifo_mode fifo_mode);
> >  
> >  #endif /* ST_LSM6DSX_H */
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index c8e5cfd..b19a62d 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -130,8 +130,8 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
> >  	return 0;
> >  }
> >  
> > -static int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> > -				    enum st_lsm6dsx_fifo_mode fifo_mode)
> > +int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> > +			     enum st_lsm6dsx_fifo_mode fifo_mode)
> >  {
> >  	u8 data;
> >  	int err;
> > @@ -303,7 +303,7 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >  	return read_len;
> >  }
> >  
> > -static int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
> > +int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
> >  {
> >  	int err;
> >  
> > 
> 

-- 