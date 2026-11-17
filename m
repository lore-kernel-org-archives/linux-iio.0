Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925286;
	b=mL5aHWa6aYdantz5wIa4S8otKH0dasL0HwzZerOLr0FzpcdPPvZvb8ZESfON2orQU6ak
	 aT1oHTk76a9bJtjfoSunyjOD7SH95Gpj+BTAfL7oDiroA1Zq9nQYwKVHOc4TNE1AVOmHQ
	 xMvGQm6iepcmRQF9qgGomSDqStBMV9ynHoy1NNsz9KfOkMC9kItmrx4tIFYP9w++/FIOw
	 2q8o7NFei/p26mK4WrFS0kqNzTlRXffbi07Q5Z0a03nvvD20sT3r3tQVcgkx4tQS/kZXG
	 5jBvU4AtD3kWtEZ28Wp391QRdTAeQTUdlqumf/PQBpklAl0UhPp816wtIKBMN2Fjk+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925286;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=vQlW3HcAvUYTSDMtzPIfL+5cXdgkn/vcngSliC7Vl3Y=;
	b=lfgVDXRGBe0DTyVHd4b9142HjQcp0w0X+5iOzQ+sxFy7ZjaFCGLdzZUCI0mJ7/biSGOs
	 Bm1m8cV1+xsy6vkAFUvfJfuAj4keUZ/wblibJeDWGqcL5Rb9nWuQXe8LmlcPfO6/g4NR5
	 k3zJXuXCV1ooICrp4s4QWAeOoZszN6fudRwYW+eId4fW7NUQ+hApOLP5n0VS4Ex45qiKz
	 FjtPSXMsBNvsNrCJgcp2ARQURcZ8reQO8cu99+XLiFoVq6jLUuKYXTziRNByKFl6gDr67
	 hTF6SDor4KwZ1YC25AmarqSQZDHawXKK/4vdEgDzYcPZF8tzIUt4jZQJljO6lZNtdJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hBoOTdNy;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486B606A323;
	Tue, 17 Nov 2026 14:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D486B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hBoOTdNy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794925286; x=1826461286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X4cEMJVbzMx7e08dMmt6YaI8y5O0EyX0kqJSe3RMcDg=;
  b=hBoOTdNyFXZpsIFagmiXEpGqmdAXW7p3UzqqJJ2xY3jKOdb3E1bNAmyW
   +gvJFrdNzHQjtaHjWJ9NzHPX4cgvcO9ezkJO+gm8/QH/FwKRU7ic9B/tz
   wOtjG7qx9jJ5TXvuyZfKVIjSwBrqrbJtu9oq3YCnYoZSiqKDcEr89Wngq
   f87RZHT0EDbGy+JqnIdsqlUsaYl6N1oWB5qd0cc3qKEUV19VyygLIwJ1K
   3Nl6vmF1PP4ku6MJf+mHt7EXmcPFhwSmiliooj2TPLL1Cjpd8Ny+U2img
   RyhVFrnGMaojd+/k/RI7S9CxyFmwtg7SMa/MJsh1DW7Vsamd5wElYIyLE
   w==;
X-CSE-ConnectionGUID: CWoLQPXKRxy043WAHspX5w==
X-CSE-MsgGUID: +0MlMCPuSSyaDR8BClnytA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3611441"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3611441"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:21:25 -0800
X-CSE-ConnectionGUID: zKwbuzF2SDa6Gehcl2GiGw==
X-CSE-MsgGUID: 5Qeh2TKtSYq4L4KiwjX+IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10025942"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:21:23 -0800
Date: Tue, 17 Nov 2026 16:21:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: bh1745: fix 16-bit register accesses
Message-ID: <avxi4BBJ_Ztg-aN7@ashevche-desk.local>
References: <20261117110327.198084-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261117110327.198084-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+ Cc: Matti (even he is not listed as maintainer) for possible another pair of
eyes and/or having an answer why this was missed at the time of the driver
submission (from my perspective this patch is correct).

On Tue, Nov 17, 2026 at 04:33:25PM +0530, Arnav Kapoor wrote:
> The 16-bit colour data and threshold registers are little-endian
> LSB/MSB pairs, but the driver accesses them through regmap_bulk_read()
> and regmap_bulk_write() with an int or u16 buffer and no byte-order
> conversion:
> 
> - bh1745_read_raw() reads 2 bytes into an uninitialised int, so the
>   upper 16 bits returned to user space are stack contents.
> - bh1745_read_thresh() reads 2 bytes straight into *val, which the IIO
>   core leaves uninitialised, with the same result for the event
>   threshold attributes.
> - bh1745_write_thresh() writes the first 2 bytes of an int, which are
>   the upper (zero) bytes on big-endian.
> - bh1745_trigger_handler() pushes the raw register bytes, which are
>   little-endian, in a u16 to a buffer whose scan type is IIO_CPU, so
>   user space gets the samples byte-swapped on big-endian.
> 
> Use an __le16 buffer for all of them and convert with le16_to_cpu() /
> cpu_to_le16().
> 
> Fixes: eab35358aae7 ("iio: light: ROHM BH1745 colour sensor")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
> Changes in v2:
> - Include asm/byteorder.h for le16_to_cpu() / cpu_to_le16() (Andy)
> - Reword the trigger handler bullet: the samples are byte-swapped on
>   big-endian because the scan type is IIO_CPU (Andy)
> - Add Andy's Reviewed-by
> 
> v1: https://lore.kernel.org/all/20261116194214.45174-1-kapoorarnav43@gmail.com/
> 
> Compile-tested only (W=1, checkpatch --strict clean); I don't have
> BH1745 hardware.
> 
>  drivers/iio/light/bh1745.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
> index 2b8ff36071b8..e2c03cd0d1e3 100644
> --- a/drivers/iio/light/bh1745.c
> +++ b/drivers/iio/light/bh1745.c
> @@ -17,6 +17,8 @@
>  #include <linux/bits.h>
>  #include <linux/bitfield.h>
>  
> +#include <asm/byteorder.h>
> +
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
> @@ -421,19 +423,20 @@ static int bh1745_read_raw(struct iio_dev *indio_dev,
>  			   int *val, int *val2, long mask)
>  {
>  	struct bh1745_data *data = iio_priv(indio_dev);
> +	__le16 value;
>  	int ret;
> -	int value;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		if (!iio_device_claim_direct(indio_dev))
>  			return -EBUSY;
>  
> -		ret = regmap_bulk_read(data->regmap, chan->address, &value, 2);
> +		ret = regmap_bulk_read(data->regmap, chan->address, &value,
> +				       sizeof(value));
>  		iio_device_release_direct(indio_dev);
>  		if (ret)
>  			return ret;
> -		*val = value;
> +		*val = le16_to_cpu(value);
>  
>  		return IIO_VAL_INT;
>  
> @@ -503,6 +506,7 @@ static int bh1745_read_thresh(struct iio_dev *indio_dev,
>  			      enum iio_event_info info, int *val, int *val2)
>  {
>  	struct bh1745_data *data = iio_priv(indio_dev);
> +	__le16 value;
>  	int ret;
>  
>  	switch (info) {
> @@ -510,18 +514,22 @@ static int bh1745_read_thresh(struct iio_dev *indio_dev,
>  		switch (dir) {
>  		case IIO_EV_DIR_RISING:
>  			ret = regmap_bulk_read(data->regmap, BH1745_TH_LSB,
> -					       val, 2);
> +					       &value, sizeof(value));
>  			if (ret)
>  				return ret;
>  
> +			*val = le16_to_cpu(value);
> +
>  			return IIO_VAL_INT;
>  
>  		case IIO_EV_DIR_FALLING:
>  			ret = regmap_bulk_read(data->regmap, BH1745_TL_LSB,
> -					       val, 2);
> +					       &value, sizeof(value));
>  			if (ret)
>  				return ret;
>  
> +			*val = le16_to_cpu(value);
> +
>  			return IIO_VAL_INT;
>  
>  		default:
> @@ -547,6 +555,7 @@ static int bh1745_write_thresh(struct iio_dev *indio_dev,
>  			       enum iio_event_info info, int val, int val2)
>  {
>  	struct bh1745_data *data = iio_priv(indio_dev);
> +	__le16 value;
>  	int ret;
>  
>  	switch (info) {
> @@ -554,10 +563,12 @@ static int bh1745_write_thresh(struct iio_dev *indio_dev,
>  		if (val < 0x0 || val > 0xFFFF)
>  			return -EINVAL;
>  
> +		value = cpu_to_le16(val);
> +
>  		switch (dir) {
>  		case IIO_EV_DIR_RISING:
>  			ret = regmap_bulk_write(data->regmap, BH1745_TH_LSB,
> -						&val, 2);
> +						&value, sizeof(value));
>  			if (ret)
>  				return ret;
>  
> @@ -565,7 +576,7 @@ static int bh1745_write_thresh(struct iio_dev *indio_dev,
>  
>  		case IIO_EV_DIR_FALLING:
>  			ret = regmap_bulk_write(data->regmap, BH1745_TL_LSB,
> -						&val, 2);
> +						&value, sizeof(value));
>  			if (ret)
>  				return ret;
>  
> @@ -741,18 +752,18 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
>  		u16 chans[4];
>  		aligned_s64 timestamp;
>  	} scan = { };
> -	u16 value;
> +	__le16 value;
>  	int ret;
>  	int i;
>  	int j = 0;
>  
>  	iio_for_each_active_channel(indio_dev, i) {
>  		ret = regmap_bulk_read(data->regmap, BH1745_RED_LSB + 2 * i,
> -				       &value, 2);
> +				       &value, sizeof(value));
>  		if (ret)
>  			goto err;
>  
> -		scan.chans[j++] = value;
> +		scan.chans[j++] = le16_to_cpu(value);
>  	}
>  
>  	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> 
> base-commit: a6d9114f68c4b5507b2d945bd6d1e37415f913c5

-- 
With Best Regards,
Andy Shevchenko


