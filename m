Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740610;
	b=rIcuRM4vE5L+rP3kLI/3RkbN88GT/4grPSvW4SCX0bfKpH3TGRFkJnlITVW/PqLZ72Oh
	 kTPT3UQ+ggJtw2gaO6GiOqC7nbaG9Yg3Ri5GjrzWt7Nns/S81p1Qzqe6zbKEachpQmLnf
	 SUNPKwLVdDIP0d9MrDJMXlsDzxOaTnaEZam6Vu2T0w4u2u8u3TLRmjAJqzze8RFsgWkOV
	 nn238Mn/hkfX5Ufs/H/n77UpCsj6XkUB4I9Y6RTUh4VwxPE4Yl6GcnC8x0VazQB+7OyNn
	 vwGhR9FiAjhlmjZN5dkvQk0y7tl9FtwjsoZoUsS7RmisDSGlVNKTMu0CSBXf++Pb/WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740610;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=skMjuWLYgrb3zbPFerLGDLtIB/YRl1mYtS8z9pIfhj0=;
	b=E0gg74tzw/NJeK8wp/xLMgR03pnPknRSHOlJ04FragYJh5dO9LPXZIchSnQl45JVI0jg
	 BAj4NX5Sv2g/VHIGfBpIg4l6OMuuVsA1A1enfuTyMjUorAo0txEbdV3RqWZOttqiVxe1s
	 T4EMLffjEVphuwQLo6J1I0cuX8+tR/ri+QstBnd+b2N6jSR+SrXh4qyV93Kgdq7Uc/VHZ
	 lnSZC+S7EQB69ZoHVwB07vEfQMiIwncT3sFCxm4NsaZIPw9P19qdhlochsmkZvyV9M6/P
	 /V9PZeXYuszBTYlrhbdnsNzZ8N/pXblL48iQqoL/Y7I5xaQ89sl+fcx9wt2fYX90r6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y9R+t3HN;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8634606A31D;
	Fri, 23 Oct 2026 07:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8634606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y9R+t3HN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792740606; x=1824276606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AFSNfPlYQzxZQ2cYehz2XsGR3G7XxBvKomZwfac7ZTw=;
  b=Y9R+t3HNG6UVEjVKkqPJhfssuQyUkow1cCGsb5xGXUqNX3XkKi+1dStd
   5Mw9k87vK/v9LrdAPnVPik8ZC6le95uxd9584H3PmHi3Cbra0l7gjbW4p
   sK8Mnia/uXk9ER6Ve/DSN+2pstexpMatNdhBwSPnKbv4ZXWBwL9A4az+c
   F0a3ugd5pDjqlvzwO7z0MGFvrzoCOFj73UHilJnC5Ei+gFSlitHu9SaEF
   8cjK4z5duF+K2SDdcEG8v8s6/rcT/XaYwbxLWS1fwCmxW24NSnIAoiXSx
   NEdLoIuCxSMcad4qUquXmvjpxCG3kslKNZQ0NtWD86tfpb84Guy4j0DC5
   g==;
X-CSE-ConnectionGUID: hECcbJtxTp2qeQVeuI/Zaw==
X-CSE-MsgGUID: NlZfJtxfQ7SvCX02kK0Dhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1388146"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1388146"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:29:58 -0700
X-CSE-ConnectionGUID: HK1YQdiqR/yQ5VChjDtp5A==
X-CSE-MsgGUID: R144Lw9BQm6LGL520UDakg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3687563"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:29:57 -0700
Date: Fri, 23 Oct 2026 10:29:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <atsM8hUovBz_DaCp@ashevche-desk.local>
References: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB25288BF227D6555AEE60DF73A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
 <20261023040143.2e7043bc@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023040143.2e7043bc@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 04:01:43AM +0100, Jonathan Cameron wrote:
> On Thu, 22 Oct 2026 18:40:32 -0500
> Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

...

> > +#include <linux/array_size.h>
> > +#include <linux/bitfield.h>

> > +#include <linux/bitops.h>
> > +#include <linux/bits.h>

The latter one is covered by the former, so drop bits.h.

+ cleanup.h // guard()()

With this, please follow IWYU principle (see other IIO drivers that has been
submitted in the past couple of years for the style of include section).

> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/math.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/types.h>

...

> > +static const s64 fdc1004_calibbias[] = {
> > +	-0x8000 * 488281250UL, /* min */
> > +	+0x0001 * 488281250UL, /* step */
> > +	+0x7FFF * 488281250UL, /* max */
> > +};

Looking at these data types, can you check if linear_range.h APIs
can be applied instead?

...

> > +struct fdc1004_data {
> > +	struct i2c_client *client;
> > +	struct mutex lock;
> 
> Add a comment on what data the lock is actually protecting.
> 
> > +	u8 samp_freq_index;
> > +	u8 offsets[4];

Swap these two, it *might* be that compiler can retrieve all offsets into
32-bit register (due to alignment) at once and optimise the code. You can
check the result with `bloat-o-meter`, btw.

> > +};

...

> > +	return poll_timeout_us(
> > +		{
> > +			ret = i2c_smbus_read_word_swapped(client,
> > +							  FDC1004_REG_FDC_CONF);
> > +			if (ret < 0)
> > +				return ret;
> 
> common convention to add the error condition to the exit one rather than do it
> in here.  Then check ret after the exit from teh poll.
> Tends to give nice code to read.
> 
> > +		},
> > +		ret & FDC1004_FDC_CONF_DONE_n_MASK(meas), USEC_PER_MSEC,

And please split on logical borders, also use 1 * USEC_PER_MSEC.

> > +		40 * USEC_PER_MSEC, false);
> > +}

Yes, and this macro should not be used like this. Your case is read_poll_timeout().

...

> > +static int fdc1004_read_raw(struct iio_dev *indio_dev,
> > +			    const struct iio_chan_spec *chan, int *val,
> > +			    int *val2, long mask)

Logical borders:

static int fdc1004_read_raw(struct iio_dev *indio_dev,
			    const struct iio_chan_spec *chan,
			    int *val, int *val2, long mask)

...

> > +	case IIO_CHAN_INFO_RAW: {
> > +		guard(mutex)(&data->lock);
> > +
> > +		/* Configure the measurement we want. */
> > +		ret = i2c_smbus_write_word_swapped(
> > +			client, FDC1004_REG_CONF_MEASn(0),
> > +			chan->address |
> > +				FIELD_PREP(FDC1004_CONF_MEAS_CAPDAC_MASK,
> > +					   data->offsets[chan->channel]));

Indentation is broken...

> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Start the measurement. */
> > +		ret = i2c_smbus_write_word_swapped(
> > +			client, FDC1004_REG_FDC_CONF,
> > +			FDC1004_FDC_CONF_MEAS_n_MASK(0) |
> > +				/* "+ 1" because the chip wants a 1-indexed value. */
> > +				FIELD_PREP(FDC1004_FDC_CONF_RATE_MASK,
> > +					   data->samp_freq_index + 1));
> 
> For some of these more complex values I'd use a local variable and build them
> up in steps.

...and this is a good advice to fix readability,

> 
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = fdc1004_wait_until_measurement_is_ready(client, 0);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = fdc1004_read_measurement(client, 0, val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return IIO_VAL_INT;
> > +	}

> > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > +		guard(mutex)(&data->lock);

Always add a blank line after guard()().

> > +		*val = fdc1004_samp_freqs[data->samp_freq_index];
> > +		return IIO_VAL_INT;
> > +	}

...

> > +		iio_val_s64_decompose(
> > +			sign_extend64(ret, 15) * fdc1004_calibbias[1],

Again, broken indentation.

> > +			val, val2);

...

> > +static int fdc1004_probe(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct fdc1004_data *data;
> > +	int ret;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> 
> I'd look at using regmap even though you only have a single bus. It provides
> a rich set of helpers and the caching functionality that will save a bunch
> of bus traffic.
> 
> > +		return -EOPNOTSUPP;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->client = client;
> > +
> > +	ret = devm_mutex_init(&client->dev, &data->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_regulator_get_enable(&client->dev, "vdd");
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = fdc1004_soft_reset(client);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->name = "fdc1004";
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &fdc1004_info;
> > +	indio_dev->channels = fdc1004_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(fdc1004_channels);
> > +
> > +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);

Why out of a sudden indio_dev->dev.parent?

> > +}

-- 
With Best Regards,
Andy Shevchenko


