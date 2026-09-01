Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FFD30AD1A;
	Tue,  1 Sep 2026 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788227559; cv=none; b=l4BtsTqxE9qK1gjD6M4tSJaPHc9ZlOKwls0ycEjyAKHtAg9otiviRyDU1yULYeeCOuItMoXmbfhmZY0caqHYiZPU2OVwZZR6HZyZQMDYY2ZwDTB2zrSHfzUVy48fld/Wq24F7fYB05rGpiYh1IO3odROA2q4ISOzvypQ0EopAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788227559; c=relaxed/simple;
	bh=3UmUw4nrHT0b5+MbAUoqh1gXuodJ9SwsPV2gcSiDF8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiGl/DbWbRgbWnmx+SLrV1Mpe1iiBfzwLlaRlEA7k709hIZRuvxmAhc2tZ+KXqoaFc53AKN1/VcIlMfGFgpmQ3BGXwXR0JCnQBZAlL647mNgevb7i2zA1q0AJmue4mFNtHMNTWspGw7s5DAswN/7fSaE3NvCkq+kYF5qRwruxx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfSjujZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfSjujZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613401F000E9;
	Tue,  1 Sep 2026 01:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788227513;
	bh=Lwc3lYlmp2C91be++pQikaqh89mSmcIEr02veu+yVs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QfSjujZ43jw6tCx9bZOQPZhv65v8QSSlWkdwig6y8nRxLO9wFDD3d2pRylMCMAeu7
	 GT9CCadeKa3ddsJpnvcuJsFaB2+T8v6RVUToKwWI3tNK/OoAxoVv0vpsWtFeeoMIYW
	 AYRBHHILGE96ryOG71sahMcd5ExJjkWnQWPmZH7dhRk5I3z3JzJ11lqleb2cuikw96
	 YHtnKUmxmT193gs89/ddR+keviT1wPiTyB22hYD2Mzlb4MF0OdFJJGrblt796no43V
	 eh1qDZENIZWjvOy6KMsMGrRtidpnzVJSaMXPMwwP4N54SXV3udVlg5v0KzZsDZX8pP
	 sESYom469snsA==
Date: Tue, 1 Sep 2026 02:51:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: ti-ads112c14: add continuous mode
 support
Message-ID: <20260901025147.583b3f61@jic23-huawei>
In-Reply-To: <9576dc33-f622-4578-9dff-526046ff0689@baylibre.com>
References: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-0-1e51a6e20a69@baylibre.com>
	<20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com>
	<178812363490.2788519.7648614173312615575.b4-review@b4>
	<9576dc33-f622-4578-9dff-526046ff0689@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 16:31:13 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/30/26 4:00 PM, Jonathan Cameron wrote:
> >> Add support for continuous mode in the TI ADS112C14 ADC driver. In this
> >> mode the ADC itself is starting each conversion, so we add a trigger
> >> based on the DRDY interrupt to read each sample. This mode is also
> >> limited in that only one channel can be enabled at a time since the
> >> chip does not have a sequencer or simultaneous sampling capability.
> >> Continuous mode will only be used when this new trigger is the current
> >> trigger.
> >>
> >> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>  
> > Sashiko caught some interesting things in this one.
> > 
> > See inline.
> >   
> >>
> >> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> >> index 23f15be303fb..878764deffc5 100644
> >> --- a/drivers/iio/adc/ti-ads112c14.c
> >> +++ b/drivers/iio/adc/ti-ads112c14.c
> >> @@ -9,6 +9,7 @@
> >>   */
> >>  
> >>  #include <linux/bitfield.h>
> >> +#include <linux/bitmap.h>
> >>  #include <linux/cleanup.h>
> >>  #include <linux/completion.h>
> >>  #include <linux/crc8.h>
> >> @@ -18,6 +19,7 @@
> >>  #include <linux/i2c.h>
> >>  #include <linux/iio/buffer.h>
> >>  #include <linux/iio/iio.h>
> >> +#include <linux/iio/trigger.h>
> >>  #include <linux/iio/trigger_consumer.h>
> >>  #include <linux/iio/triggered_buffer.h>
> >>  #include <linux/interrupt.h>
> >> @@ -257,6 +259,7 @@ struct ads112c14_measurement {
> >>  struct ads112c14_data {
> >>  	const struct ads112c14_chip_info *chip_info;
> >>  	struct regmap *regmap;
> >> +	struct iio_trigger *drdy_trig;
> >>  	/* Synchronizes access to register value fields. */
> >>  	struct mutex lock;
> >>  	int drdy_irq;
> >> @@ -280,11 +283,18 @@ static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
> >>  	struct iio_dev *indio_dev = private;
> >>  	struct ads112c14_data *data = iio_priv(indio_dev);
> >>  
> >> -	complete(&data->drdy_completion);
> >> +	if (indio_dev->trig && iio_trigger_using_own(indio_dev))  
> > 
> > 
> > This indeed needs more guarding given we hit these interrupts for
> > a normal read (to get to the completion)
> > 
> > 
> > Likewise seems valid.  
> 
> I figured it didn't need guarding since we are claiming direct mode. The
> trigger can't be assigned until buffer mode is claimed. and we can't
> switch to buffer mode if direct mode is claimed.
> 

Hmm. Is indio_dev->trig guarded enough? Some of the set paths
are fine because they are things the driver calls directly. The one
that I think is a problem is current_trigger_store().  

That has some protections to stop the indio_dev->trig being changed
whilst we are in buffered mode (those looks suspiciously like the
have a time of check time of use bug though maybe a harmless one).
Anyhow, that's not relevant here as we care about the not in buffered
mode.  For that there is no guarding.  Maybe we can just claim
direct mode in there (which closes the toctou issue as well)?

It seems unlikely anyone will do a claim_direct in the validation
or set_trigger_state callbacks.  Would have to check that carefully
though.

> 
> >   
> >> +		iio_trigger_poll(data->drdy_trig);
> >> +	else
> >> +		complete(&data->drdy_completion);
> >>  
> >>  	return IRQ_HANDLED;
> >>  }  
> > 
> > ...
> >   
> >>  static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
> >>  {
> >>  	struct iio_poll_func *pf = private;
> >> @@ -961,6 +984,26 @@ static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
> >>  	u32 i;
> >>  	int ret;
> >>  
> >> +	if (iio_trigger_using_own(indio_dev)) {  
> > 
> >  | sashiko.dev <sashiko@sashiko.dev>:
> >  |
> >  | [Severity: High]
> >  | Will this check incorrectly enable continuous mode processing for any
> >  | external trigger that belongs to its own device?
> >  |
> >  | If a user assigns an external trigger that sets its attached_own_device
> >  | property to true, iio_trigger_using_own() will evaluate to true. Could this
> >  | misroute the interrupt handler into assuming continuous mode when it should
> >  | not?
> >  |
> >  | via: https://sashiko.dev/#/message/20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com
> > 
> > I think this is triggered by the more complex handling you have
> > to detect use of the dataready trigger below.  There is only one trigger
> > currently so they end up the same, but perhaps we should make the handling
> > more similar?  
> 
> I'll just create our own local flag instead of relying on IIO internals.

That would be safer.

> 
> >   
> >> +		const struct iio_chan_spec *chan;
> >> +
> >> +		chan = ads112c14_first_active_channel(indio_dev);
> >> +		if (!chan)
> >> +			goto out;
> >> +
> >> +		ret = ads112c14_scan_read(data, (u8 *)&data->scan[0]);  
> > 
> >  | sashiko.dev <sashiko@sashiko.dev>:
> >  |
> >  | [Severity: High]
> >  | This is a pre-existing issue, but is there a missing length check in the
> >  | underlying I2C block read that leaves stack memory partially uninitialized?
> >  |
> >  | If i2c_smbus_read_i2c_block_data() (called by ads112c14_scan_read()) returns
> >  | a positive value smaller than the requested length, the condition if (ret < 0)
> >  | fails to catch the short read. Does this leak uninitialized stack memory to
> >  | userspace when data->scan is later pushed to the IIO buffers?
> >  |
> >  | via: https://sashiko.dev/#/message/20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com
> > 
> > I haven't chased this one through - but in a similar example in a review
> > I did yesterday I suggested just initializing the memory anyway
> > so we don't have to care one way or the other.  
> 
> This uses i2c_smbus_xfer() in the end which returns 0 or negative error.
> No partial reads. So I don't see how we could be leaking.
Ok. Probably fine.  I still need to get back to that related i2c set that
makes the handling more expected.
> 
> >   
> >> +		if (ret) {
> >> +			dev_err_once(indio_dev->dev.parent,
> >> +				     "failed to read channel %d: %pe; additional errors will be suppressed\n",
> >> +				     chan->channel, ERR_PTR(ret));
> >> +			goto out;
> >> +		}
> >> +
> >> +		iio_push_to_buffers_with_ts(indio_dev, data->scan,
> >> +					    sizeof(data->scan), pf->timestamp);
> >> +		goto out;
> >> +	}
> >> +
> >>  	iio_for_each_active_channel(indio_dev, i) {
> >>  		const struct iio_chan_spec *chan = &indio_dev->channels[i];
> >>    

