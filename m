Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353D38F65C;
	Thu, 17 Sep 2026 02:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613185; cv=none; b=Uq/B7bRF2iRyUp6JGyCplIeCSr3GgeBo1RiWcCHzmBK6ef54jEKMUhWHXE6oQBfrtSMHl1Y1SdMeSJIHRu9Q0wSLiZRrjnkpbUQF5nk7mUKHbytB3EGidnKT/TH/q85Z5FwpcUJg8mn1N/qRo/OXTChKymtL2eCB3YDEdUfAsOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613185; c=relaxed/simple;
	bh=Z4F4UlJd7/nPmUh0RCHmV43t2CGkZbgLC7yVMcbuN70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hq/0wzoGwAr9PD9GXUv5tbw8HDOtkKfPUEO9e8wHL4B5zFH2bWR4Wghy+gBNC+gR0w6ZaEZ8Qjz6IeA2TgOfjjUyxjqoaBduyvsWTYSHBgxgbKpPdfVFYjomP014ZSZDkj/pNpIwuzSgioP/GwD+Rdu8LXdVzvw+ubbWhc1wD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5dPvW7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5dPvW7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C8F1F000FF;
	Thu, 17 Sep 2026 02:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613174;
	bh=UN5Huh0snw2hAqQl+cycuS2Mfq3pAGMsrgQd6J2731E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P5dPvW7QRJIKLFjc1ZdtupFsBUxzp6xNVgq0O7qemg2PR9SXo3gemALz2h42fx+x4
	 BOF9rA+fq64kt1ZRIvqnwkfotGFdNtdU9qScNOBWf51Ulbbba9T12tpAJIVIuEXYMe
	 g0DKzk0dmY4YDwCH8vmGyly4eTHmPWvXnhZSgaDIt5OvV1puEJYkAkxoZZOl2WPo5P
	 0cDfchwsLqyNlX5cEcZ6EQj8uVkrbqIYXWbaD6Yh2qxiHuW3NZC/QtDPL5Vp2uG7Rf
	 Ob3riojHf1LNr/0o5Ctgx39WkZXbpba5OnLYxDBi4shoBPTzQJGEbYJ5lthzY4nnHf
	 deby/u8cWbZfw==
Date: Thu, 17 Sep 2026 03:46:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>, "Martin Kepplinger"
 <martink@posteo.de>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Sean Nyekjaer" <sean@geanix.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Martin Kepplinger"
 <martin.kepplinger@theobroma-systems.com>, "Christoph Muellner"
 <christoph.muellner@theobroma-systems.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 9/9] iio: accel: mma8452: Support interrupt sharing
Message-ID: <20260917034607.2674781e@jic23-hlaptop>
In-Reply-To: <87y0d4pal0.fsf@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-9-c17407e22118@geanix.com>
	<_9NG2PCqwv-AxkrhQVOkPVIgvYD4-t2CFH5W5HVBmr35w9xmX9v9FIraB1OPE8Ssbd_pjQqM-bq3DEAtRl78Sg==@protonmail.internalid>
	<20260914002203.5ca07dd0@jic23-hlaptop>
	<87y0d4pal0.fsf@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 09:15:55 +0200
Esben Haabendal <esben@geanix.com> wrote:

> "Jonathan Cameron" <jic23@kernel.org> writes:
> 
> > On Mon, 07 Sep 2026 16:51:04 +0200
> > Esben Haabendal <esben@geanix.com> wrote:
> >  
> >> Adding support for sharing interrupt line with other device requires the
> >> interrupt handler to handle runtime PM suspension properly, ignoring the
> >> irq if the device is suspended (maybe even off). And while at it, we use
> >> the PM reference to ensure we do not get suspended while processing an irq.
> >>
> >> In order to prevent the chip from raising irq while suspended (that is when
> >> using fixed regulator, where suspend just means setting the device in
> >> STANDBY mode), we disable all interrupt sources by clearing CTRL_REG4, and
> >> then restores the value again when resuming.
> >>
> >> With that in place, it is safe to add the IRQF_SHARED flag.
> >>
> >> Keep in mind that the device by default is using push-pull for the irq pin,
> >> which might require additional hardware design to allow interrupt sharing.
> >>
> >> Signed-off-by: Esben Haabendal <esben@geanix.com>
> >> ---
> >>  drivers/iio/accel/mma8452.c | 67 +++++++++++++++++++++++++++++++++++++++------
> >>  1 file changed, 58 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> >> index fda29df5d109..e521dca37f76 100644
> >> --- a/drivers/iio/accel/mma8452.c
> >> +++ b/drivers/iio/accel/mma8452.c
> >> @@ -120,6 +120,7 @@
> >>   * @sleep_val:			time in ms to sleep while waiting for drdy
> >>   * @ctrl_reg1:			CTRL_REG1 register shadow value
> >>   * @data_cfg:			DATA_CFG register shadow value
> >> + * @ctrl_reg4:			CTRL_REG4 register value to restore on resume
> >>   * @open_drain:			true for irq pin in open-drain mode
> >>   */
> >>  struct mma8452_data {
> >> @@ -138,6 +139,7 @@ struct mma8452_data {
> >>  	int sleep_val;
> >>  	u8 ctrl_reg1;
> >>  	u8 data_cfg;
> >> +	u8 ctrl_reg4;
> >>  	bool open_drain;
> >>  };
> >>
> >> @@ -1083,15 +1085,21 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
> >>  {
> >>  	struct iio_dev *indio_dev = p;
> >>  	struct mma8452_data *data = iio_priv(indio_dev);
> >> +	struct device *dev = &data->client->dev;
> >>  	irqreturn_t ret = IRQ_NONE;
> >> +	int pm_status;
> >>  	int src;
> >>
> >> +	pm_status = pm_runtime_get_if_active(dev);  
> >
> > Sashiko raises the question of what happens if you actually get an error
> > return from this. You may be deliberately ignoring those, but if
> > so add a comment.  
> 
> Yes, sounds like a good idea.
> 
> > The fun race around tear down is worth considering in particular (see
> > sashiko comment).  
> 
> I will look into that. Although very unlikely, it does sound like a real
> issue that *could* occur.
> 
> Adding a boolean flag (remove_in_progress = true) to the mma8452_data
> struct, and set that in mma8452_remove() before disabling runtime pm
> seems like a KISS solution. Should we be returning IRQ_HANDLED or
> IRQ_NONE in that case?  There is no IRQ_MAYBE return value :D

This has been much debated. Personally I think IRQ_HANDLED because
we don't know it is a spurious interrupt which is more or less
all IRQ_NONE is useful for.  Arguably doesn't matter as we don't
expect many hits on this path and the spurious handling needs a lot
before it does anything!

> 
> >> +	if (pm_status == 0)
> >> +		return IRQ_NONE; /* device is powered down */  
> >  
> >> @@ -1784,29 +1796,62 @@ static void mma8452_remove(struct i2c_client *client)
> >>  #ifdef CONFIG_PM
> >>  static int mma8452_runtime_suspend(struct device *dev)
> >>  {
> >> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> >> +	struct i2c_client *client = to_i2c_client(dev);
> >> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> >>  	struct mma8452_data *data = iio_priv(indio_dev);
> >>  	int ret;
> >>
> >> -	scoped_guard(mutex, &data->lock)
> >> -		ret = mma8452_standby(data);
> >> +	guard(mutex)(&data->lock);  
> > Mixing guards...  
> 
> Yes, I know. Resolving that turned out to be a bit more painful than I
> thought. I do have that resolved in the next series I keep on talking
> about. But distilling that as a separate patch for adding to this series
> turned out to be impossible, as it relies on some of the other work,
> like refactoring of the ACTIVE/STANDBY state handling (synchronization),
> and most importantly, the switch to using regmap caching to properly
> handle restoring of register values on resume.
> 
> I am therefore hoping that we can find some way to agree on things here,
> and then properly resolve it in the next series...

Ok. It is fine for now.  Perhaps add a comment along the lines of
/* Must be first action in scope that needs to be undone on error */

And hopefully it won't be around long enough for anyone to copy it
into more code!
> 
> For what it is worth, in this very specific case, the only guard used is
> first in the LIFO order, and will therefore be executed in exactly the
> right order on exit, as it will run after all the goto cleanup, just as
> the LIFO cleanup order requires.
> 
> Obviously a fragile and undesirable way of doing error handling, but it
> will go away again in the next series where I will eliminate the goto
> error handling in mma8452_runtime_suspend().
> 

