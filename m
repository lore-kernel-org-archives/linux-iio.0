Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53670 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdGYTBN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jul 2017 15:01:13 -0400
Date: Tue, 25 Jul 2017 20:01:12 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH v2 08/10] iio: humidity: hts221: support open drain mode
Message-ID: <20170725200112.06fa7187@jic23.retrosnub.co.uk>
In-Reply-To: <20170722212524.6fc06db7@kernel.org>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
        <20170717173905.8209-9-lorenzo.bianconi@st.com>
        <20170722212524.6fc06db7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 22 Jul 2017 21:25:24 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 17 Jul 2017 19:39:03 +0200
> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
> 
> > Add open drain support in order to share requested IRQ line between
> > hts221 device and other peripherals
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>  
> I'm going to hold off on the rest of this series to give Rob
> time to take another look at the bindings documentation and
> confirm he is happy with the changes.
> 
> Give me a poke if I seem to have forgotten them!
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> 
> Jonathan
> > ---
> >  drivers/iio/humidity/hts221_buffer.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> > index ad5222295b2c..f29f01a22375 100644
> > --- a/drivers/iio/humidity/hts221_buffer.c
> > +++ b/drivers/iio/humidity/hts221_buffer.c
> > @@ -20,10 +20,14 @@
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/iio/buffer.h>
> >  
> > +#include <linux/platform_data/st_sensors_pdata.h>
> > +
> >  #include "hts221.h"
> >  
> >  #define HTS221_REG_DRDY_HL_ADDR		0x22
> >  #define HTS221_REG_DRDY_HL_MASK		BIT(7)
> > +#define HTS221_REG_DRDY_PP_OD_ADDR	0x22
> > +#define HTS221_REG_DRDY_PP_OD_MASK	BIT(6)
> >  #define HTS221_REG_STATUS_ADDR		0x27
> >  #define HTS221_RH_DRDY_MASK		BIT(1)
> >  #define HTS221_TEMP_DRDY_MASK		BIT(0)
> > @@ -69,7 +73,9 @@ static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
> >  int hts221_allocate_trigger(struct hts221_hw *hw)
> >  {
> >  	struct iio_dev *iio_dev = iio_priv_to_dev(hw);
> > -	bool irq_active_low = false;
> > +	bool irq_active_low = false, open_drain = false;
> > +	struct device_node *np = hw->dev->of_node;
> > +	struct st_sensors_platform_data *pdata;
> >  	unsigned long irq_type;
> >  	int err;
> >  
> > @@ -95,6 +101,20 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
> >  				     HTS221_REG_DRDY_HL_MASK, irq_active_low);
> >  	if (err < 0)
> >  		return err;
> > +
> > +	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
> > +	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
> > +	    (pdata && pdata->open_drain)) {
> > +		irq_type |= IRQF_SHARED;
> > +		open_drain = true;
> > +	}
> > +
> > +	err = hts221_write_with_mask(hw, HTS221_REG_DRDY_PP_OD_ADDR,
> > +				     HTS221_REG_DRDY_PP_OD_MASK,
> > +				     open_drain);
> > +	if (err < 0)
> > +		return err;
> > +
> >  	err = devm_request_threaded_irq(hw->dev, hw->irq, NULL,
> >  					hts221_trigger_handler_thread,
> >  					irq_type | IRQF_ONESHOT,  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

