Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B321FE471;
	Mon,  1 Jun 2026 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324626; cv=none; b=WAI8nC9OyOIIzNj12CLkRu4G3MdIkgMKZ+6F0JQsJv5w9FaN3Y/FRmDvil4NovPAXxmW88+6bflTCBzEtGLEhHT6zeYe9tUbnbt+TP552GIaxB1GM2IyQt4QSF67E4uerixWi8Yw9Q3Yf8X0/9NJHWZKBiai6v6+ABs4TH9uONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324626; c=relaxed/simple;
	bh=er1+Lg5jVqGAOFZjlfjw3tGg3PD17c9/Q8Cm+VMmfgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEEC3UTYjUjoCQsYbhPRa1YDxSmNZabb160Htf6ZW940mfsJQHpMP2yGVQ1DIgmACKMcpEUs78bS1WXV6+NjC5Wi2MKfGkVPKjsLhXZFNzX3/GQ4tMdNiVx5gEwWaRQD/Yfs3rTb3TB1FA2iE+uGQBANmHTtL8Lq2bzayDb4Uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXmuItCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXmuItCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448C01F00898;
	Mon,  1 Jun 2026 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780324624;
	bh=ubas+bjvIuU55A7dM14hTJtwDFJpbeNaIcu4sXl6KAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CXmuItCMD5y7xj9dj1CisefneeO7DFX2/XahyzZ2/1YO49T3rU1UXft1jlLHAACCc
	 Cou7qmprT+DdGo1ZJ3Oetxj9zn17/8nvhdHoS7rN5u7OUnDZi3hZtGJnJoxu2jE8Zp
	 NosGyKtGi2yo5oKuN1s9ai3l65fM9batWrgmCC1qhT74Xs7k5pWbas1Drfs5I5jJqM
	 bSXGMK6rEmIc/0n33hDYqMqOaA3Y/WK5IWAdEDn9TkS69VX6Es8Abke5ko6unycrTn
	 cZfhEopRodHSL82xgME9bERKoUlx+jH8ruGV3P1jxFS5ns070PGJ2X1gAfMt2CCJ1w
	 g4tocVHqB2p4g==
Date: Mon, 1 Jun 2026 15:36:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V9 06/11] iio: imu: inv_icm42607: Add Buffer support for
 icm42607
Message-ID: <20260601153653.698c9c58@jic23-huawei>
In-Reply-To: <PH0PR19MB997338785108348427BBB2B7D2A5152@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
	<20260530031739.109063-7-macroalpha82@gmail.com>
	<20260531133801.481e173c@jic23-huawei>
	<PH0PR19MB997338785108348427BBB2B7D2A5152@PH0PR19MB997338.namprd19.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jun 2026 08:50:02 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Sun, May 31, 2026 at 01:38:01PM +0100, Jonathan Cameron wrote:
> > On Fri, 29 May 2026 22:17:33 -0500
> > Chris Morgan <macroalpha82@gmail.com> wrote:
> >   
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > Add all FIFO parsing and reading functions to support
> > > inv_icm42607 hardware.
> > > 
> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>  
> > A few things inline.
> > 
> > J
> >   
> > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> > > new file mode 100644
> > > index 000000000000..e065d60ac119
> > > --- /dev/null
> > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> > > @@ -0,0 +1,483 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Copyright (C) 2026 InvenSense, Inc.
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/minmax.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/unaligned.h>
> > > +
> > > +#include <linux/iio/common/inv_sensors_timestamp.h>
> > > +
> > > +#include "inv_icm42607.h"
> > > +#include "inv_icm42607_buffer.h"
> > > +
> > > +/* FIFO header: 1 byte */
> > > +#define INV_ICM42607_FIFO_HEADER_MSG		BIT(7)
> > > +#define INV_ICM42607_FIFO_HEADER_ACCEL		BIT(6)
> > > +#define INV_ICM42607_FIFO_HEADER_GYRO		BIT(5)
> > > +#define INV_ICM42607_FIFO_HEADER_TMST_FSYNC	GENMASK(3, 2)
> > > +#define INV_ICM42607_FIFO_HEADER_ODR_ACCEL	BIT(1)
> > > +#define INV_ICM42607_FIFO_HEADER_ODR_GYRO	BIT(0)
> > > +
> > > +struct inv_icm42607_fifo_1sensor_packet {
> > > +	u8 header;
> > > +	struct inv_icm42607_fifo_sensor_data data;
> > > +	s8 temp;
> > > +} __packed;
> > > +
> > > +struct inv_icm42607_fifo_2sensors_packet {
> > > +	u8 header;
> > > +	struct inv_icm42607_fifo_sensor_data accel;  
> > Good example of the need for the inner structures to be packed  
> 
> Are you saying I should set the inv_icm42607_fifo_sensor_data to be
> __packed? I think I was told in a previous patch not to do that, but
> I can add it back.

My understanding is that it is necessary. Just add a comment on why
next to the structure.  Otherwise typically the compiler assumes
they are aligned and doesn't work around that.  Alternatively just
use an array of u8 and get_unaligned() to extract the values.
(read on - on I suspect this is the better path forwards)
> 
> >   
> > > +	struct inv_icm42607_fifo_sensor_data gyro;
> > > +	s8 temp;
> > > +	__be16 timestamp;
> > > +} __packed;
> > > +
> > > +ssize_t inv_icm42607_fifo_decode_packet(const void *packet, const void **accel,
> > > +					const void **gyro, const int8_t **temp,
> > > +					const void **timestamp)
> > > +{
> > > +	const struct inv_icm42607_fifo_1sensor_packet *pack1 = get_unaligned(&packet);
> > > +	const struct inv_icm42607_fifo_2sensors_packet *pack2 = get_unaligned(&packet);  
> > 
> > Hmm. Sashiko points out you are messing around with pointers here and it's not those but
> > what the point to that we need to worry about alignment for.
> > You could memcpy that data into local structures.  
> 
> I still suck at pointers, sorry. What exactly would you recommend here?
> memcpy the packet value into an allocated
> inv_icm42607_fifo_1sensor_packet or inv_icm42607_fifo_2sensors_packet?

yes. Copy it. though given the result has unaligned internal elements so it
doesn't really help much.  I'm thinking simpler to just treat it as a byte stream
and access each element directly.


> 
> > 
> >   
> > > +	u8 header = *((const u8 *)packet);
> > > +
> > > +	/* FIFO empty */
> > > +	if (header & INV_ICM42607_FIFO_HEADER_MSG) {
> > > +		*accel = NULL;
> > > +		*gyro = NULL;
> > > +		*temp = NULL;
> > > +		*timestamp = NULL;
> > > +		return 0;
> > > +	}
> > > +
> > > +	/* accel + gyro */
> > > +	if ((header & INV_ICM42607_FIFO_HEADER_ACCEL) &&
> > > +	    (header & INV_ICM42607_FIFO_HEADER_GYRO)) {
> > > +		*accel = &pack2->accel;
> > > +		*gyro = &pack2->gyro;
> > > +		*temp = &pack2->temp;
> > > +		*timestamp = &pack2->timestamp;
> > > +		return INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE;
> > > +	}
> > > +
> > > +	/* accel only */
> > > +	if (header & INV_ICM42607_FIFO_HEADER_ACCEL) {
> > > +		*accel = &pack1->data;
> > > +		*gyro = NULL;
> > > +		*temp = &pack1->temp;
> > > +		*timestamp = NULL;
> > > +		return INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE;
> > > +	}
> > > +
> > > +	/* gyro only */
> > > +	if (header & INV_ICM42607_FIFO_HEADER_GYRO) {
> > > +		*accel = NULL;
> > > +		*gyro = &pack1->data;
> > > +		*temp = &pack1->temp;
> > > +		*timestamp = NULL;
> > > +		return INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE;
> > > +	}
> > > +
> > > +	/* invalid packet if here */
> > > +	return -EINVAL;
> > > +}  
> >   
> > > +/**
> > > + * inv_icm42607_buffer_update_watermark - update watermark FIFO threshold
> > > + * @st:	driver internal state
> > > + *
> > > + * Returns 0 on success, a negative error code otherwise.
> > > + */
> > > +int inv_icm42607_buffer_update_watermark(struct inv_icm42607_state *st)
> > > +{
> > > +	const struct device *dev = regmap_get_device(st->map);
> > > +	unsigned int wm_gyro, wm_accel, watermark;
> > > +	u32 latency_gyro, latency_accel, latency;
> > > +	u32 period_gyro, period_accel;
> > > +	size_t packet_size, wm_size;
> > > +	__le16 raw_wm;
> > > +	bool restore;
> > > +	int ret;
> > > +
> > > +	packet_size = inv_icm42607_get_packet_size(st->fifo.en);
> > > +
> > > +	/* compute sensors latency, depending on sensor watermark and odr */
> > > +	wm_gyro = inv_icm42607_wm_truncate(st->fifo.watermark.gyro, packet_size);
> > > +	wm_accel = inv_icm42607_wm_truncate(st->fifo.watermark.accel, packet_size);
> > > +	/* use us for odr to avoid overflow using 32 bits values */
> > > +	period_gyro = inv_icm42607_odr_to_period(st->conf.gyro.odr) / 1000UL;
> > > +	period_accel = inv_icm42607_odr_to_period(st->conf.accel.odr) / 1000UL;
> > > +	latency_gyro = period_gyro * wm_gyro;
> > > +	latency_accel = period_accel * wm_accel;
> > > +
> > > +	/* 0 value for watermark means that the sensor is turned off */
> > > +	if (wm_gyro == 0 && wm_accel == 0)
> > > +		return 0;
> > > +
> > > +	if (latency_gyro == 0) {
> > > +		watermark = wm_accel;
> > > +		st->fifo.watermark.eff_accel = wm_accel;
> > > +	} else if (latency_accel == 0) {
> > > +		watermark = wm_gyro;
> > > +		st->fifo.watermark.eff_gyro = wm_gyro;
> > > +	} else {
> > > +		/* compute the smallest latency that is a multiple of both */
> > > +		if (latency_gyro <= latency_accel)
> > > +			latency = latency_gyro - (latency_accel % latency_gyro);
> > > +		else
> > > +			latency = latency_accel - (latency_gyro % latency_accel);
> > > +		/* all this works because periods are multiple of each others */
> > > +		watermark = latency / min(period_gyro, period_accel);
> > > +		watermark = max(watermark, 1);
> > > +		/* update effective watermark */
> > > +		st->fifo.watermark.eff_gyro = max(latency / period_gyro, 1);
> > > +		st->fifo.watermark.eff_accel = max(latency / period_accel, 1);
> > > +	}
> > > +
> > > +	/* changing FIFO watermark requires to turn off watermark interrupt */
> > > +	ret = regmap_update_bits_check(st->map, INV_ICM42607_REG_INT_SOURCE0,
> > > +				       INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
> > > +				       0, &restore);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* compute watermark value in bytes */
> > > +	wm_size = watermark * packet_size;
> > > +	raw_wm = INV_ICM42607_FIFO_WATERMARK_VAL(wm_size);
> > > +	memcpy(st->buffer, &raw_wm, sizeof(raw_wm));
> > > +	ret = regmap_bulk_write(st->map, INV_ICM42607_REG_FIFO_CONFIG2,
> > > +				st->buffer, sizeof(raw_wm));
> > > +	if (ret) {
> > > +		dev_err(dev, "Unable to change watermark value: %d\n", ret);
> > > +		if (restore)
> > > +			regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
> > > +					   INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
> > > +					   INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);  
> > 
> > set_bits.
> >   
> > > +		return ret;
> > > +	}
> > > +
> > > +	/* restore watermark interrupt */
> > > +	if (restore) {
> > > +		ret = regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
> > > +					 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
> > > +					 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);  
> > 
> > set_bits
> >   
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}  
> >   
> > > +
> > > +static int inv_icm42607_buffer_predisable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> > > +	int ret;
> > > +
> > > +	guard(mutex)(&st->lock);
> > > +
> > > +	if (st->fifo.on > 1) {
> > > +		st->fifo.on--;
> > > +		return 0;
> > > +	}
> > > +
> > > +	/* Set FIFO to 0 since iio core ignores teardown errors. */
> > > +	st->fifo.on = 0;
> > > +
> > > +	/* set FIFO in bypass mode */
> > > +	ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
> > > +			   INV_ICM42607_FIFO_CONFIG1_BYPASS);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* flush FIFO data */
> > > +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> > > +			   INV_ICM42607_SIGNAL_PATH_RESET_FIFO_FLUSH);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* disable FIFO threshold interrupt */
> > > +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
> > > +				 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN, 0);  
> > 
> > 	regmap_clear_bits()
> >   
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int inv_icm42607_buffer_postdisable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> > > +	struct device *dev = regmap_get_device(st->map);
> > > +	unsigned int sensor;
> > > +	unsigned int *watermark;
> > > +	int ret;
> > > +
> > > +	if (indio_dev == st->indio_gyro) {
> > > +		sensor = INV_ICM42607_SENSOR_GYRO;
> > > +		watermark = &st->fifo.watermark.gyro;
> > > +	} else if (indio_dev == st->indio_accel) {
> > > +		sensor = INV_ICM42607_SENSOR_ACCEL;
> > > +		watermark = &st->fifo.watermark.accel;
> > > +	} else {
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	mutex_lock(&st->lock);
> > > +
> > > +	/*
> > > +	 * FIFO enabled at update scan mode for accel or gyro, and
> > > +	 * disabled here.
> > > +	 */
> > > +	ret = inv_icm42607_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
> > > +	if (ret)
> > > +		goto out_unlock;
> > > +
> > > +	*watermark = 0;  
> > 
> > Add a comment on why this needs to be set to 0.  Normally that only
> > matters at all if the fifo is on, so I guess something unusual here?  
> 
> I think it's just resetting the watermark to 0 when shutting down,
> not 100% sure though.
> 
> > 
> >   
> > > +	ret = inv_icm42607_buffer_update_watermark(st);
> > > +	if (ret)
> > > +		goto out_unlock;
> > > +
> > > +out_unlock:
> > > +	mutex_unlock(&st->lock);
> > > +
> > > +	pm_runtime_put_autosuspend(dev);
> > > +
> > > +	return ret;
> > > +}  
> >   
> > > +int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
> > > +				  unsigned int max)
> > > +{
> > > +	const void *accel, *gyro, *timestamp;
> > > +	size_t i, max_count;
> > > +	const s8 *temp;
> > > +	ssize_t size;
> > > +	int ret;
> > > +
> > > +	guard(mutex)(&st->lock);
> > > +
> > > +	/* reset all samples counters */
> > > +	st->fifo.count = 0;
> > > +	st->fifo.nb.gyro = 0;
> > > +	st->fifo.nb.accel = 0;
> > > +	st->fifo.nb.total = 0;
> > > +
> > > +	/* compute maximum FIFO read size */
> > > +	if (max == 0)
> > > +		max_count = sizeof(st->fifo.data);
> > > +	else
> > > +		max_count = min((max * inv_icm42607_get_packet_size(st->fifo.en)),
> > > +				sizeof(st->fifo.data));
> > > +
> > > +	/* read FIFO count value */
> > > +	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_FIFO_COUNTH,
> > > +			       st->buffer, sizeof(u8) * 2);
> > > +	if (ret)
> > > +		return ret;
> > > +	st->fifo.count = be16_to_cpup(st->buffer);  
> > 
> > Might be ok to assume this is always a multiple of the scan size, but 
> > maybe sanity check it to keep sashiko happy and remove that assumption
> > of atomic update.
> >   
> > > +
> > > +	/* check and clamp FIFO count value */
> > > +	if (st->fifo.count == 0)
> > > +		return 0;
> > > +
> > > +	st->fifo.count = min(st->fifo.count, max_count);
> > > +
> > > +	/* read all FIFO data in internal buffer */
> > > +	ret = regmap_noinc_read(st->map, INV_ICM42607_REG_FIFO_DATA,
> > > +				st->fifo.data, st->fifo.count);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* compute number of samples for each sensor */
> > > +	for (i = 0; i < st->fifo.count; i += size) {
> > > +		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
> > > +				&accel, &gyro, &temp, &timestamp);
> > > +		/* Make sure the size is at least 1 valid packet. */
> > > +		if (size < INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE)
> > > +			break;
> > > +		/* Error if we are going to overflow the buffer. */
> > > +		if (i + size > st->fifo.count)
> > > +			return -EIO;
> > > +		if (gyro != NULL && inv_icm42607_fifo_is_data_valid(gyro))
> > > +			st->fifo.nb.gyro++;
> > > +		if (accel != NULL && inv_icm42607_fifo_is_data_valid(accel))
> > > +			st->fifo.nb.accel++;
> > > +		st->fifo.nb.total++;
> > > +	}
> > > +
> > > +	return 0;
> > > +}  
> >   
> > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
> > > new file mode 100644
> > > index 000000000000..b77deb66f8bd
> > > --- /dev/null
> > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h  
> >   
> > > +
> > > +/* FIFO data packet */
> > > +struct inv_icm42607_fifo_sensor_data {
> > > +	__be16 x;
> > > +	__be16 y;
> > > +	__be16 z;
> > > +};  
> > 
> > Sashiko is probably correct that this should be packed.
> > Makes not difference here but it's not aligned in the places it's embedded
> > in other structs and the compiler seeing this will assume it is aligned.
> >   
> 
> So I should pack this instead of doing the "get_unaligned()" call?
This whole thing feels like a loosing battle. Just rip the structures out and
use defines for the offsets.

> Thank you.

