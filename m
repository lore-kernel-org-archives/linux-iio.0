Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbdL2RZw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 12:25:52 -0500
Date: Fri, 29 Dec 2017 17:25:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: humidity: hts221: add regmap API support
Message-ID: <20171229172548.37a9d7da@archlinux>
In-Reply-To: <CAA2SeNLyLgj4ra7K6g-0rEjQF3k-jiTjnF518dkte4+Fc3Lj+A@mail.gmail.com>
References: <cover.1514042380.git.lorenzo.bianconi@redhat.com>
        <ff8438f5dfb20be4499456d9e56ea7deac712352.1514042380.git.lorenzo.bianconi@redhat.com>
        <20171229132415.28b2913c@archlinux>
        <CAA2SeNLyLgj4ra7K6g-0rEjQF3k-jiTjnF518dkte4+Fc3Lj+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 29 Dec 2017 14:33:39 +0100
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> > On Sat, 23 Dec 2017 18:16:21 +0100
> > Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
> >  
> >> Introduce regmap API support to access to i2c/spi bus instead of
> >> using a custom support.
> >> Remove lock mutex since concurrency is already managed by regmap API
> >>
> >> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>  
> >
> > Looks good. A few minor comments and a question inline.  
> 
> Hi Jonathan,
> 
> Thanks for the review.
> 
> >
> > Thanks,
> >
> > Jonathan
> >  
> >> ---
> >>  drivers/iio/humidity/Kconfig         |  2 +
> >>  drivers/iio/humidity/hts221.h        | 27 ++++--------
> >>  drivers/iio/humidity/hts221_buffer.c | 20 ++++-----
> >>  drivers/iio/humidity/hts221_core.c   | 84 ++++++++++--------------------------
> >>  drivers/iio/humidity/hts221_i2c.c    | 64 ++++++++-------------------
> >>  drivers/iio/humidity/hts221_spi.c    | 79 ++++++++-------------------------
> >>  6 files changed, 76 insertions(+), 200 deletions(-)
> >>
> >> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> >> index 2c0fc9a400b8..1a0d458e4f4e 100644
> >> --- a/drivers/iio/humidity/Kconfig
> >> +++ b/drivers/iio/humidity/Kconfig
> >> @@ -68,10 +68,12 @@ config HTS221
> >>  config HTS221_I2C
> >>       tristate
> >>       depends on HTS221
> >> +     select REGMAP_I2C
> >>
> >>  config HTS221_SPI
> >>       tristate
> >>       depends on HTS221
> >> +     select REGMAP_SPI
> >>
> >>  config HTU21
> >>       tristate "Measurement Specialties HTU21 humidity & temperature sensor"
> >> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> >> index c581af8c0f5d..00596879010e 100644
> >> --- a/drivers/iio/humidity/hts221.h
> >> +++ b/drivers/iio/humidity/hts221.h
> >> @@ -15,21 +15,8 @@
> >>
> >>  #include <linux/iio/iio.h>
> >>
> >> -#define HTS221_RX_MAX_LENGTH 8
> >> -#define HTS221_TX_MAX_LENGTH 8
> >> -
> >>  #define HTS221_DATA_SIZE     2
> >>
> >> -struct hts221_transfer_buffer {
> >> -     u8 rx_buf[HTS221_RX_MAX_LENGTH];
> >> -     u8 tx_buf[HTS221_TX_MAX_LENGTH] ____cacheline_aligned;
> >> -};
> >> -
> >> -struct hts221_transfer_function {
> >> -     int (*read)(struct device *dev, u8 addr, int len, u8 *data);
> >> -     int (*write)(struct device *dev, u8 addr, int len, u8 *data);
> >> -};
> >> -
> >>  enum hts221_sensor_type {
> >>       HTS221_SENSOR_H,
> >>       HTS221_SENSOR_T,
> >> @@ -44,8 +31,8 @@ struct hts221_sensor {
> >>  struct hts221_hw {
> >>       const char *name;
> >>       struct device *dev;
> >> +     struct regmap *regmap;
> >>
> >> -     struct mutex lock;
> >>       struct iio_trigger *trig;
> >>       int irq;
> >>
> >> @@ -53,16 +40,18 @@ struct hts221_hw {
> >>
> >>       bool enabled;
> >>       u8 odr;
> >> -
> >> -     const struct hts221_transfer_function *tf;
> >> -     struct hts221_transfer_buffer tb;
> >>  };
> >>
> >>  extern const struct dev_pm_ops hts221_pm_ops;
> >>
> >> -int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask, u8 val);
> >> +static inline int hts221_write_with_mask(struct hts221_hw *hw, u8 addr,
> >> +                                      u8 mask, u8 val)
> >> +{
> >> +     return regmap_update_bits(hw->regmap, addr, mask, val << __ffs(mask));
> >> +}
> >> +
> >>  int hts221_probe(struct device *dev, int irq, const char *name,
> >> -              const struct hts221_transfer_function *tf_ops);
> >> +              struct regmap *regmap);
> >>  int hts221_set_enable(struct hts221_hw *hw, bool enable);
> >>  int hts221_allocate_buffers(struct hts221_hw *hw);
> >>  int hts221_allocate_trigger(struct hts221_hw *hw);
> >> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> >> index e971ea425268..b1141acfd100 100644
> >> --- a/drivers/iio/humidity/hts221_buffer.c
> >> +++ b/drivers/iio/humidity/hts221_buffer.c
> >> @@ -12,6 +12,7 @@
> >>  #include <linux/device.h>
> >>  #include <linux/interrupt.h>
> >>  #include <linux/irqreturn.h>
> >> +#include <linux/regmap.h>
> >>
> >>  #include <linux/iio/iio.h>
> >>  #include <linux/iio/trigger.h>
> >> @@ -38,12 +39,9 @@ static int hts221_trig_set_state(struct iio_trigger *trig, bool state)
> >>  {
> >>       struct iio_dev *iio_dev = iio_trigger_get_drvdata(trig);
> >>       struct hts221_hw *hw = iio_priv(iio_dev);
> >> -     int err;
> >>
> >> -     err = hts221_write_with_mask(hw, HTS221_REG_DRDY_EN_ADDR,
> >> +     return hts221_write_with_mask(hw, HTS221_REG_DRDY_EN_ADDR,
> >>                                    HTS221_REG_DRDY_EN_MASK, state);  
> >
> > You could use the regmap call directly inconjunction with FIELD_PREP
> >
> > return regmap_update_bits(hw->regmap, HTS221_REG_DRDY_EN_ADDR,
> >                           HTS221_REG_DRDY_EN_MASK,
> >                           FIELD_PREP(HTS221_REG_DRDY_EN_MASK, val));
> >  
> 
> Do you prefer to always drop hts221_write_with_mask() and use just
> regmap_update_bits() with FIELD_PREP()?

Hmm. On balance yes.  It slightly wins I think.
<snip>
