Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FD2AEE4;
	Sun, 12 Jul 2026 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783816589; cv=none; b=Y7xODZ6u06UmUXJ0bo6VOCNJNX5NVQjj0t3q8c2Kvw9poX+AionH6xEPO1No7xEixck3YMEhB7vm16b9pNoNyFisujVEdN0KK3q7N/ISe+YuVCKn+iRZW03Phtqm4w7QuoFjdUdWYbs7lYu+iZyMPjYjZPypGPHcF6tzGUGcqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783816589; c=relaxed/simple;
	bh=b8e4yPiHgqHl59uK9q616uKBokTBSMYDLnbBY+gHaEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z90n/lnvQ60Qbyzq6IrcPykDJdglWQ3htxDBuHizJfzL4TiVZ+emZ2P1HxaBsNANCSLtB2+D/jVa5pqj6+mEUXuyXmOPjoxvHPAmcx+x7MEk8UN0f8COyMJhvsuvWnRv0/MEH096vhhMql3wtwMwvJpoc2iBVknNDxlKl+tk5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGB0JFRQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGB0JFRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836481F000E9;
	Sun, 12 Jul 2026 00:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783816587;
	bh=x1j8DX2IHYQZ0gKyHZAxUzd8u/c4TZWcimdtxRdj6u0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FGB0JFRQdMk+p/bHp4xgGPlUsbJ/VP+MGnv/OvYXf/IMGmwASt7qHijAIDD+7mCod
	 4E4xlo5oObK0CCHvDP5C7KUAjg/Owc82Z6+FJt00y0armH+fKDEe1Ktb7zFuNqedZm
	 r0eMCRgTYurFS4S17ogHamP/uJq8Up3mwluXkHbRID7iuNmZWlrzeSAikuLJTmZ9Sn
	 NZ2Ak4uk2DSZj7AVtnTqQ0kY+0GBfPjNC3GcRob+cvL2WQdcN0c522q8CWSq280HCo
	 nksPQ1mkANnJSxtZo4haZkqLs3qHx4LHMzhzDm8yO79PqIgxLpY59nxEbUwgusRWrO
	 3E9hbeI1T1qOQ==
Date: Sun, 12 Jul 2026 01:36:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@intel.com,
 u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v9 2/2] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <20260712013620.7136b5de@jic23-huawei>
In-Reply-To: <20260707140545.0000029a@gmail.com>
References: <20260707112714.2261727-3-shofiqtest@gmail.com>
	<20260707140545.0000029a@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jul 2026 14:05:45 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue,  7 Jul 2026 14:27:14 +0300
> Md Shofiqul Islam <shofiqtest@gmail.com> wrote:
> 
> > Add a new IIO driver for the Analog Devices MAX86150 integrated
> > biosensor, which combines two PPG optical channels (Red/IR LED) and
> > one ECG biopotential channel in a single I2C device.
> > 
> > The device has a 32-entry hardware FIFO with a configurable almost-full
> > interrupt.  Because all samples arrive via the FIFO, the driver uses a
> > kfifo buffer (like the sibling MAX30100 and MAX30102 drivers) rather
> > than the triggered-buffer framework.  The interrupt handler drains the
> > FIFO on each A_FULL event and timestamps samples back-calculated from
> > the interrupt arrival time by one sample_period_ns per step.
> > 
> > Key implementation details:
> > - FIFO draining via iio_buffer_setup_ops postenable/predisable
> > - DMA-safe FIFO read buffer aligned to IIO_DMA_MINALIGN
> > - IIO_DECLARE_BUFFER_WITH_TS for the push buffer
> > - 24-bit FIFO words decoded via get_unaligned_be24()
> > - regmap_set_bits() / regmap_clear_bits() for single-direction writes
> > - Overflow drops all samples; timestamps are unreliable after overflow
> > - Device remains in shutdown between captures to suppress LED current
> > - vdd and vled regulators required per datasheet; vref is not a supply
> > - synchronize_irq() in predisable ensures threaded handler completes
> >   before the IIO core clears active_scan_mask
> > - INT_STATUS1 cleared before polling PPG_RDY to avoid stale flag
> > - A_FULL status bit used to detect FIFO exactly full (wr_ptr == rd_ptr
> >   with OVF_COUNTER == 0) so valid samples are not silently dropped
> > 
> > Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>  

I note that ADI had this as 'last time buy'.  I don't mind supporting a
device if it is in use but I thought I'd just call that out.

> 
> Hi, I took a quick look at this driver - surely I've missed something
> and there are a few Analog folk in IIO which will probably know more.

You caught a lot :)

> 
> Additionally, Sashiko had some remarks, please check them out.
> 
> https://sashiko.dev/#/patchset/20260707104234.1957104-1-shofiqtest%40gmail.com
> 
> Several comments inline.

I added a few things on top. Reduces duplication seeing as Joshua had enough
comments scattered through that they didn't crop out anything.
> 
> > ---
> >  MAINTAINERS                   |   1 +
> >  drivers/iio/health/Kconfig    |  17 ++
> >  drivers/iio/health/Makefile   |   1 +
> >  drivers/iio/health/max86150.c | 560 ++++++++++++++++++++++++++++++++++
> >  4 files changed, 579 insertions(+)
> >  create mode 100644 drivers/iio/health/max86150.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e9b9fd619bd86..361a7c8b99ead 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15868,6 +15868,7 @@ M:	Md Shofiqul Islam <shofiqtest@gmail.com>
> >  L:	linux-iio@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
> > +F:	drivers/iio/health/max86150.c
> >  
> >  MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
> >  M:	Krzysztof Kozlowski <krzk@kernel.org>
> > diff --git a/drivers/iio/health/Kconfig b/drivers/iio/health/Kconfig
> > index a89f3abf11f4a..c18d41d5044fa 100644
> > --- a/drivers/iio/health/Kconfig
> > +++ b/drivers/iio/health/Kconfig
> > @@ -62,4 +62,21 @@ config MAX30102
> >  
> >  endmenu
> >  
> > +config MAX86150
> > +	tristate "MAX86150 ECG and PPG biosensor"
> > +	depends on I2C
> > +	select IIO_BUFFER
> > +	select IIO_KFIFO_BUF
> > +	select REGMAP_I2C
> > +	help
> > +	  Say Y here to enable support for the Maxim MAX86150 combined
> > +	  ECG and photoplethysmography (PPG) biosensor.
> > +
> > +	  The driver exposes three IIO channels: two PPG optical channels
> > +	  (Red and IR LED) for heart rate and SpO2 monitoring, and one
> > +	  ECG channel for biopotential recording.  
> 
> Delete the above paragraph. You don't describe the code in the Kconfig.
> 
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called max86150.
> > +
> >  endmenu
> > diff --git a/drivers/iio/health/Makefile b/drivers/iio/health/Makefile
> > index 9108171122588..04fc73c584449 100644
> > --- a/drivers/iio/health/Makefile
> > +++ b/drivers/iio/health/Makefile
> > @@ -9,3 +9,4 @@ obj-$(CONFIG_AFE4403)		+= afe4403.o
> >  obj-$(CONFIG_AFE4404)		+= afe4404.o
> >  obj-$(CONFIG_MAX30100)		+= max30100.o
> >  obj-$(CONFIG_MAX30102)		+= max30102.o
> > +obj-$(CONFIG_MAX86150)		+= max86150.o
> > diff --git a/drivers/iio/health/max86150.c b/drivers/iio/health/max86150.c
> > new file mode 100644
> > index 0000000000000..e8394031f3acb
> > --- /dev/null
> > +++ b/drivers/iio/health/max86150.c
> > @@ -0,0 +1,560 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * MAX86150 combined ECG and PPG biosensor driver
> > + *
> > + * Copyright (C) 2026 Md Shofiqul Islam <shofiqtest@gmail.com>
> > + *
> > + * The MAX86150 integrates two PPG optical channels (Red/IR LED) and one
> > + * ECG biopotential channel in a single I2C device.  Data is captured
> > + * through a 32-entry hardware FIFO with a configurable almost-full
> > + * interrupt, making it well-suited for continuous monitoring with a
> > + * low-power host.
> > + *
> > + * Datasheet:
> > + *   https://www.analog.com/media/en/technical-documentation/data-sheets/MAX86150.pdf
> > + */
> > +  
> 
> You're missing array_size.h, err.h, types.h
> 
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/timekeeping.h>
> > +#include <linux/unaligned.h>  
> 
> Blank line here.
> 
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/kfifo_buf.h>
> > +
> > +/* Register addresses */
> > +#define MAX86150_REG_INT_STATUS1	0x00
> > +#define MAX86150_REG_INT_STATUS2	0x01
> > +#define MAX86150_REG_INT_ENABLE1	0x02
> > +#define MAX86150_REG_INT_ENABLE2	0x03
> > +#define MAX86150_REG_FIFO_WR_PTR	0x04
> > +#define MAX86150_REG_OVF_COUNTER	0x05
> > +#define MAX86150_REG_FIFO_RD_PTR	0x06
> > +#define MAX86150_REG_FIFO_DATA		0x07
> > +#define MAX86150_REG_FIFO_CONFIG	0x08
> > +#define MAX86150_REG_FIFO_DCTRL1	0x09
> > +#define MAX86150_REG_FIFO_DCTRL2	0x0A
> > +#define MAX86150_REG_SYS_CTRL		0x0D
> > +#define MAX86150_REG_PPG_CONFIG1	0x10
> > +#define MAX86150_REG_PPG_CONFIG2	0x11
> > +#define MAX86150_REG_LED1_PA		0x14
> > +#define MAX86150_REG_LED2_PA		0x15
> > +#define MAX86150_REG_ECG_CONFIG1	0x3C
> > +#define MAX86150_REG_ECG_CONFIG3	0x3E
> > +#define MAX86150_REG_PART_ID		0xFF
> > +
> > +#define MAX86150_PART_ID_VAL		0x1E
> > +
> > +/* INT_STATUS1 / INT_ENABLE1 */
> > +#define MAX86150_INT_A_FULL		BIT(7)
> > +#define MAX86150_INT_PPG_RDY		BIT(6)
> > +
> > +/* SYS_CTRL */
> > +#define MAX86150_SYS_CTRL_SHDN		BIT(1)
> > +#define MAX86150_SYS_CTRL_RESET		BIT(0)
> > +
> > +/* FIFO_CONFIG */
> > +#define MAX86150_FIFO_CONFIG_SMP_AVE_MASK	GENMASK(7, 5)
> > +#define MAX86150_FIFO_CONFIG_ROLLOVER_EN	BIT(4)
> > +#define MAX86150_FIFO_CONFIG_A_FULL_MASK	GENMASK(3, 0)
> > +
> > +/* FIFO slot data-type codes */
> > +#define MAX86150_FD_NONE		0x0
> > +#define MAX86150_FD_LED1		0x1
> > +#define MAX86150_FD_LED2		0x2
> > +#define MAX86150_FD_ECG			0x9
> > +
> > +/* FIFO_DCTRL1 / FIFO_DCTRL2 */
> > +#define MAX86150_FIFO_DCTRL_FD_LO_MASK	GENMASK(3, 0)
> > +#define MAX86150_FIFO_DCTRL_FD_HI_MASK	GENMASK(7, 4)
> > +
> > +/* PPG_CONFIG1 */

Given well named defines (which they are) the comment doesn't add
value. So drop it. Just keep ones that add something less obvious.

> > +#define MAX86150_PPG_CONFIG1_ADC_RGE_MASK	GENMASK(7, 6)
> > +#define MAX86150_PPG_CONFIG1_SR_MASK		GENMASK(5, 1)
> > +
> > +#define MAX86150_FIFO_DEPTH		32
> > +#define MAX86150_BYTES_PER_SLOT		3
> > +#define MAX86150_NUM_SLOTS		3
> > +#define MAX86150_SAMPLE_BYTES		(MAX86150_NUM_SLOTS * MAX86150_BYTES_PER_SLOT)
> > +
> > +/* Fire A_FULL when 17 slots are available (32 - 15 = 17) */
> > +#define MAX86150_FIFO_A_FULL_VAL	15

Put that value inline.  It isn't a hardware provided choice but rather the one
you've decided to use, so I'd rather see the value + comment at the the place
where the field is written.

> > +
> > +#define MAX86150_LED_PA_50MA		0x3F
As below.
> > +#define MAX86150_PPG_SR_100HZ		4

Even though only this value is used, I'd be tempted to list all of them.  That would
also make the naming include that this is the single pulse per second version of
100 Hz. There is also a double pulse value.  Similar applies to other field values.
Having just one defined makes them look very random whereas, with the full set we 
can see that a value out the middle has been chosen.

> > +#define MAX86150_PPG_ADC_RGE_16384	2
> > +
Similar for this one.

> > +
> > +struct max86150_data {
> > +	struct regmap *regmap;
> > +	int irq;
> > +	u32 sample_period_ns;
> > +	u8 fifo_raw[ALIGN(MAX86150_SAMPLE_BYTES, IIO_DMA_MINALIGN)]
> > +		__aligned(IIO_DMA_MINALIGN);

I2C device, why do you need an aligned buffer?  Note that Sashiko
regularly gives wrong advice on this. For I2C we have to opt in
if we don't want to bounce buffer. Given I2C is slow we rarely bother.

> > +	IIO_DECLARE_BUFFER_WITH_TS(s32, buf, 3);
> > +};  
> 
> Have you checked this struct layout with pahole?


> 
> > +static int max86150_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int *val, int *val2, long mask)
> > +{
> > +	struct max86150_data *data = iio_priv(indio_dev);
> > +	unsigned int ppg_rdy_status;
> > +	u32 ppg_red, ppg_ir;
> > +	s32 ecg;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (!iio_device_claim_direct(indio_dev))
> > +			return -EBUSY;
Can use 
	case IIO_CHAN_INFO_RAW: {
		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
		if (IIO_DEV_ACQUIRE_DIRECT_MODE(claim))
			return -EBUSY;

		ret = regmap_clear_bits(data->regmap, MAX86150_REG_SYS_CTRL,
					MAX86150_SYS_CTRL_SHDN);
		if (ret)
			return ret;

		ret = do_max86150_read_raw(data); // see below for a similar helper suggestion
		if (ret) {
			regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL,
					MAX86150_SYS_CTRL_SHDN);
			return ret;
		}

		ret = regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL,
				      MAX86150_SYS_CTRL_SHDN);
		if (ret)
			return ret;

		switch (chan->scan_index) {
		case MAX86150_IDX_PPG_RED:
			*val = ppg_red;
			break;
		case MAX86150_IDX_PPG_IR:
			*val = ppg_ir;
			break;
		case MAX86150_IDX_ECG:
			*val = ecg;
			break;
		default:
			return -EINVAL;
		}
		return IIO_VAL_INT;
	} //claim on direct mode will be released here, but not a problem to hold it over setting val.

> > +		ret = regmap_clear_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> > +					MAX86150_SYS_CTRL_SHDN);
> > +		if (ret)
> > +			goto out_shutdown;

Why?  you failed to turn it on.

> > +
> > +		ret = regmap_write(data->regmap, MAX86150_REG_FIFO_WR_PTR, 0);
> > +		if (ret)
> > +			goto out_shutdown;  
> 
> Blank line.
> 
> > +		ret = regmap_write(data->regmap, MAX86150_REG_OVF_COUNTER, 0);
> > +		if (ret)
> > +			goto out_shutdown;  
> 
> Blank line.
> 
> > +		ret = regmap_write(data->regmap, MAX86150_REG_FIFO_RD_PTR, 0);
> > +		if (ret)
> > +			goto out_shutdown;
> > +
> > +		/*
> > +		 * Clear stale PPG_RDY from a previous session; reading
> > +		 * INT_STATUS1 de-asserts any pending flags so the poll
> > +		 * below waits for a genuinely new sample.
> > +		 */
> > +		regmap_read(data->regmap, MAX86150_REG_INT_STATUS1,
> > +			    &ppg_rdy_status);  
> 
> You're not checking the return value of regmap_read.
> 
> > +
> > +		/*
> > +		 * Poll PPG_RDY rather than sleeping a fixed interval -- the
> > +		 * internal oscillator may start slower than nominal, leaving
> > +		 * the FIFO empty if we read too early.
> > +		 */
> > +		ret = regmap_read_poll_timeout(data->regmap,
> > +					       MAX86150_REG_INT_STATUS1,
> > +					       ppg_rdy_status,
> > +					       ppg_rdy_status & MAX86150_INT_PPG_RDY,
> > +					       1000, 25000);
> > +		if (ret)
> > +			goto out_shutdown;
> > +
> > +		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
> > +
> > +out_shutdown:
> > +		regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> > +				MAX86150_SYS_CTRL_SHDN);
> > +		iio_device_release_direct(indio_dev);
> > +
> > +		if (ret)
> > +			return ret;
> > +
> > +		switch (chan->scan_index) {
> > +		case MAX86150_IDX_PPG_RED:
> > +			*val = ppg_red;
> > +			break;
> > +		case MAX86150_IDX_PPG_IR:
> > +			*val = ppg_ir;
> > +			break;
> > +		case MAX86150_IDX_ECG:
> > +			*val = ecg;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		return IIO_VAL_INT;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}

> > +static int max86150_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +	struct max86150_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = regmap_clear_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> > +				MAX86150_SYS_CTRL_SHDN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_WR_PTR, 0);
> > +	if (ret)
> > +		goto err_shutdown;  
> 
> Blank line.
> 
> > +	ret = regmap_write(data->regmap, MAX86150_REG_OVF_COUNTER, 0);
> > +	if (ret)
> > +		goto err_shutdown;  
> 
> Blank line.
> 
> > +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_RD_PTR, 0);
> > +	if (ret)
> > +		goto err_shutdown;  
> 
> Blank line.
> 
> > +	ret = regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1,
> > +			   MAX86150_INT_A_FULL);
> > +	if (ret)
> > +		goto err_shutdown;

For these stacks where there is only one thing to do, it may
make more sense to use a helper.  Typically called something like:
do_max86150_buffer_postenable() 
Then you get this function as something like:

> > +	return 0;
> > +
> > +err_shutdown:
> > +	regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> > +			MAX86150_SYS_CTRL_SHDN);  
> 
> Not checking the return value of regmap_set_bits either.

In an error path I'd not bother - best you can do is say
oh look a second read failed. (I agree with this feedback
in lots of other places!)

static int max86150_buffer_postenable(struct iio_dev *indio_dev)
{
	struct max86150_data *data = iio_priv(indio_dev);
	int ret;

	ret = regmap_clear_bits(data->regmap, MAX86150_REG_SYS_CTRL,
				MAX86150_SYS_CTRL_SHDN);
	if (ret)
		return ret;

	ret = do_max86150_buffer_postenable(data);
	if (ret) {
		regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL,
				MAX86150_SYS_CTRL_SHDN);
		return ret;
	}
	
	return 0;
}

> 
> > +	return ret;
> > +}


> > +static irqreturn_t max86150_interrupt_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct max86150_data *data = iio_priv(indio_dev);
> > +	unsigned int status, wr_ptr, rd_ptr, ovf, n_avail;
> > +	u32 ppg_red, ppg_ir;
> > +	s32 ecg;
> > +	s64 ts;
> > +	unsigned int i, j;  
> 
> You can remove this line, see below.
> 
> > +	int ret;
> > +
> > +	ret = regmap_read(data->regmap, MAX86150_REG_INT_STATUS1, &status);
> > +	if (ret)
> > +		return IRQ_HANDLED;
> > +
> > +	if (!(status & MAX86150_INT_A_FULL))
> > +		return IRQ_NONE;
> > +
> > +	ret = regmap_read(data->regmap, MAX86150_REG_OVF_COUNTER, &ovf);
> > +	if (ret)
> > +		return IRQ_HANDLED;
> > +
> > +	if (ovf > 0) {
> > +		/* FIFO overflowed; timestamps are unreliable - flush and discard */
> > +		regmap_write(data->regmap, MAX86150_REG_FIFO_WR_PTR, 0);  
> 
> Please check the return value of all regmap functions you call.
> 
> > +		regmap_write(data->regmap, MAX86150_REG_OVF_COUNTER, 0);
> > +		regmap_write(data->regmap, MAX86150_REG_FIFO_RD_PTR, 0);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	ret = regmap_read(data->regmap, MAX86150_REG_FIFO_WR_PTR, &wr_ptr);
> > +	if (ret)
> > +		return IRQ_HANDLED;
> > +	ret = regmap_read(data->regmap, MAX86150_REG_FIFO_RD_PTR, &rd_ptr);
> > +	if (ret)
> > +		return IRQ_HANDLED;
> > +
> > +	n_avail = (wr_ptr - rd_ptr) & (MAX86150_FIFO_DEPTH - 1);
> > +	/*
> > +	 * When the FIFO holds exactly MAX86150_FIFO_DEPTH samples the
> > +	 * write pointer wraps around to equal the read pointer even though
> > +	 * OVF_COUNTER is still zero.  The A_FULL status bit disambiguates
> > +	 * this wrap-around from a genuinely empty FIFO.
> > +	 */
> > +	if (!n_avail && (status & MAX86150_INT_A_FULL))
> > +		n_avail = MAX86150_FIFO_DEPTH;
> > +	if (!n_avail)
> > +		return IRQ_HANDLED;
> > +
> > +	/*
> > +	 * Anchor timestamps to the interrupt time: sample (n_avail - 1) is
> > +	 * the newest and corresponds to ts; earlier samples are back-calculated
> > +	 * by one sample_period_ns per step.
> > +	 */
> > +	ts = ktime_get_ns();
> > +
> > +	for (i = 0; i < n_avail; i++) {  
> 
> for (unsigned int i = 0; ...)
> 
> > +		s64 sample_ts = ts -
> > +			(s64)(n_avail - 1 - i) * data->sample_period_ns;
> > +
> > +		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
> > +		if (ret)
> > +			break;
> > +
> > +		j = 0;  
> 
> What is the point of having j if we always know the buffer size is 3?
> Can't you just do buf[0], buf[1] and buf[2] instead of incrementing j
> after a write? Seems awfully redundant.
> 
> > +		if (test_bit(MAX86150_IDX_PPG_RED, indio_dev->active_scan_mask))
> > +			data->buf[j++] = ppg_red;
> > +		if (test_bit(MAX86150_IDX_PPG_IR, indio_dev->active_scan_mask))
> > +			data->buf[j++] = ppg_ir;
> > +		if (test_bit(MAX86150_IDX_ECG, indio_dev->active_scan_mask))
> > +			data->buf[j++] = ecg;
> > +
> > +		iio_push_to_buffers_with_ts(indio_dev, data->buf,
> > +					    sizeof(data->buf), sample_ts);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void max86150_powerdown(void *arg)
> > +{
> > +	struct max86150_data *data = arg;
> > +
> > +	regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1, 0);
> > +	regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> > +			MAX86150_SYS_CTRL_SHDN);  
> 
> Also not checking return values here.

FWIW there isn't a lot of point in a devm callback. Mostly you can
do is print an error.  Everything is going down anyway so we tend
not to care that much about regmap errors.

> 
> > +}
> > +
> > +static int max86150_chip_init(struct max86150_data *data)
> > +{
> > +	int ret;
> > +
> > +	/* Software reset; the bit self-clears within 1 ms */
> > +	ret = regmap_write(data->regmap, MAX86150_REG_SYS_CTRL,
> > +			   MAX86150_SYS_CTRL_RESET);
> > +	if (ret)
> > +		return ret;  
> 
> Blank line.
> 
> > +	fsleep(1000);  
> 
> Why are we sleeping for 1000? Add a comment why this value exactly.
> (Datasheet reference etc.)
> 
> > +
> > +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_CONFIG,
> > +			   MAX86150_FIFO_CONFIG_ROLLOVER_EN |
> > +			   FIELD_PREP(MAX86150_FIFO_CONFIG_A_FULL_MASK,
> > +				      MAX86150_FIFO_A_FULL_VAL));
See above. Bring the 15 down here.  Maybe it's worth a macro to convert
from what people actually want - which is how many entries are in the
fifo when the interrupt fires, to the value that goes in the field.
If so that would be something like
			   FIELD_PREP(MAX86150_FIFO_CONFIG_A_FULL_MASK,
				      max86150_fifo_thresh_to_fieldval(17));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Slot 1 = PPG Red (LED1), Slot 2 = PPG IR (LED2) */
> > +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_DCTRL1,
> > +			   FIELD_PREP(MAX86150_FIFO_DCTRL_FD_LO_MASK,
> > +				      MAX86150_FD_LED1) |
> > +			   FIELD_PREP(MAX86150_FIFO_DCTRL_FD_HI_MASK,
> > +				      MAX86150_FD_LED2));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Slot 3 = ECG, Slot 4 = disabled */
> > +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_DCTRL2,
> > +			   FIELD_PREP(MAX86150_FIFO_DCTRL_FD_LO_MASK,
> > +				      MAX86150_FD_ECG) |
> > +			   FIELD_PREP(MAX86150_FIFO_DCTRL_FD_HI_MASK,
> > +				      MAX86150_FD_NONE));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* PPG: 100 Hz sample rate, 16384 nA ADC full-scale range */
> > +	ret = regmap_write(data->regmap, MAX86150_REG_PPG_CONFIG1,
> > +			   FIELD_PREP(MAX86150_PPG_CONFIG1_ADC_RGE_MASK,
> > +				      MAX86150_PPG_ADC_RGE_16384) |
> > +			   FIELD_PREP(MAX86150_PPG_CONFIG1_SR_MASK,
> > +				      MAX86150_PPG_SR_100HZ));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(data->regmap, MAX86150_REG_LED1_PA, MAX86150_LED_PA_50MA);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(data->regmap, MAX86150_REG_LED2_PA, MAX86150_LED_PA_50MA);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->sample_period_ns = 10 * NSEC_PER_MSEC;

Which register write is this associated with?  It's nothing to do with the ones
immediate above or below this line so seems odd to have it here.

> > +
> > +	return regmap_write(data->regmap, MAX86150_REG_SYS_CTRL,
> > +			    MAX86150_SYS_CTRL_SHDN);
> > +}
> > +
> > +static int max86150_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct max86150_data *data;
> > +	unsigned int part_id;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->irq = client->irq;
> > +
> > +	ret = devm_regulator_get_enable(dev, "vdd");
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to get/enable vdd supply\n");  
> 
> Just keep enable.
> 
> > +
> > +	ret = devm_regulator_get_enable(dev, "vled");
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to get/enable vled supply\n");  
> 
> Same as above.
> 
> > +
> > +	data->regmap = devm_regmap_init_i2c(client, &max86150_regmap_config);
> > +	if (IS_ERR(data->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> > +				     "Failed to initialise regmap\n");
> > +
> > +	ret = regmap_read(data->regmap, MAX86150_REG_PART_ID, &part_id);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Cannot read part ID\n");
> > +
> > +	if (part_id != MAX86150_PART_ID_VAL)
> > +		dev_warn(dev, "Unexpected part ID 0x%02x (expected 0x%02x)\n",
> > +			 part_id, MAX86150_PART_ID_VAL);  
> 
> dev_info() instead of dev_warn() is better.
> 
> > +
> > +	ret = max86150_chip_init(data);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Chip initialisation failed\n");
> > +
> > +	ret = devm_add_action_or_reset(dev, max86150_powerdown, data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->name = "max86150";
> > +	indio_dev->channels = max86150_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(max86150_channels);
> > +	indio_dev->info = &max86150_iio_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	if (client->irq > 0) {
> > +		unsigned long irq_trig = irq_get_trigger_type(client->irq);

No need to go through this dance.  The IRQ core will take whatever is
coming from firmware and combine it (if appropriate) with flags you
add.  

> > +
> > +		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
> > +						  &max86150_buffer_setup_ops);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Cannot setup kfifo buffer\n");
> > +
> > +		ret = devm_request_threaded_irq(dev, client->irq,
> > +						NULL,
> > +						max86150_interrupt_handler,
> > +						irq_trig | IRQF_ONESHOT,

Hence IRQF_ONESHOT should be enough here.

We only extract the type for cases where the interrupt polarity or type
can also be configured at the device end.

> > +						"max86150", indio_dev);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Cannot request IRQ %d\n",
> > +					     client->irq);  
> 
> Just return ret instead of dev_err_probe() - it's already called in
> devm_request_threaded_irq() on failure.
> 
> > +	}
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}


