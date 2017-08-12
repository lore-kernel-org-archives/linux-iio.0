Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbdHLLNl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Aug 2017 07:13:41 -0400
Date: Sat, 12 Aug 2017 12:07:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 03/10] iio: humidity: hts221: do not overwrite
 reserved data during power-down
Message-ID: <20170812120724.0f4b783e@archlinux>
In-Reply-To: <CAA2SeN+PwAomyi6+xpFVqa1MtcDnd=PWvSjZiKvi5_3K2NdZCQ@mail.gmail.com>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
        <20170717173905.8209-4-lorenzo.bianconi@st.com>
        <20170722190215.5922dafb@kernel.org>
        <CAA2SeN+PwAomyi6+xpFVqa1MtcDnd=PWvSjZiKvi5_3K2NdZCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 11 Aug 2017 21:54:07 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> > On Mon, 17 Jul 2017 19:38:58 +0200
> > Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
> >  
> >> GENMASK(6, 3) in CTRL_REG1 and GENMASK(6, 2) in CTRL_REG2 are marked
> >> reserved. Do not changed the original value (not declared in the
> >> datasheet) during power-down/suspend routines.
> >>
> >> Fixes: e4a70e3e7d84 (iio: humidity: add support to hts221 rh/temp device)
> >> Fixes: b7079eeac5da (iio: humidity: hts221: add power management support)
> >> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>  
> > Applied to the togreg branch of iio.git and pushed out as testing.
> >
> > If we want to do a backport of this it would be fine, but it needs
> > to require absolute minimal changes to the driver.
> >  
> 
> I think we need to push write_with_mask patch as well in order to fix
> that issue. What do you think?
> 
> Regards,
> Lorenzo
Hmm.  Is it possible to do a much more minimal local implementation
in just these two locations.  That patch is rather larger than
it feels like we should need.  Obviously the end result is clean,
but the process to get there is non trivial.

Jonathan
> 
> > Jonathan  
> >> ---
> >>  drivers/iio/humidity/hts221_core.c | 10 ++++------
> >>  1 file changed, 4 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> >> index 47a29b2da1ce..6e5847386a45 100644
> >> --- a/drivers/iio/humidity/hts221_core.c
> >> +++ b/drivers/iio/humidity/hts221_core.c
> >> @@ -305,11 +305,10 @@ int hts221_power_on(struct hts221_hw *hw)
> >>
> >>  int hts221_power_off(struct hts221_hw *hw)
> >>  {
> >> -     __le16 data = 0;
> >>       int err;
> >>
> >> -     err = hw->tf->write(hw->dev, HTS221_REG_CNTRL1_ADDR, sizeof(data),
> >> -                         (u8 *)&data);
> >> +     err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> >> +                                  HTS221_ENABLE_MASK, false);
> >>       if (err < 0)
> >>               return err;
> >>
> >> @@ -692,11 +691,10 @@ static int __maybe_unused hts221_suspend(struct device *dev)
> >>  {
> >>       struct iio_dev *iio_dev = dev_get_drvdata(dev);
> >>       struct hts221_hw *hw = iio_priv(iio_dev);
> >> -     __le16 data = 0;
> >>       int err;
> >>
> >> -     err = hw->tf->write(hw->dev, HTS221_REG_CNTRL1_ADDR, sizeof(data),
> >> -                         (u8 *)&data);
> >> +     err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> >> +                                  HTS221_ENABLE_MASK, false);
> >>
> >>       return err < 0 ? err : 0;
> >>  }  
> >  
> 
> 
> 

