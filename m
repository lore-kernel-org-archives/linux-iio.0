Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88F3BADB3;
	Tue, 16 Jun 2026 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781609232; cv=none; b=N1Wy6HoXTs8xAsUr/87no1sUQMWWTLvPbZkrk++E5XU+R0S2wtL65QCFLk0cU53E+LJ+rpmSXOU97oakT0hZ8u5uthBH5VjiQwxUGBCrfPAhW3KGx/OZTUiaWaYv9RAwNTVRy1iN8TO9ulNci5i1tc5ZkRvmkjX5dKrQU/2SIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781609232; c=relaxed/simple;
	bh=vBU0oeoznmrBzgpbfqa2fHCeWcntu8zCrigJTO3m+qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLfC/XXn1tG+YhVHrR5yRVKJdQ6PAm5R+0N4x4jaxAizL0iFshsGj2dcRr9EizF7c8TZyDMFBIlpUIpKPhA4h/g4ZBc7bKepSxoEJSf4/F/oEXViWc3n+dUg7449o61K5SFqKvZlFA3xkRbkYOMKWe96tHW/CAtFaBMC2rEUolw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPhl90TI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPhl90TI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781609230; x=1813145230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vBU0oeoznmrBzgpbfqa2fHCeWcntu8zCrigJTO3m+qs=;
  b=PPhl90TI+MRY/yg+MTpJlmtG4cBt13g/BcvJo4TQTsKenu+trZ6awQnX
   SmaX0UG+xsuZ7qkWUKScFZDhN0AsO6EN3b/QNDCNIVmErlrY7OeKpbLP6
   g3TZG/klw1tiY/vRBxjglWThEmsSVjpTFXz6ijfBIxk0Wiu8yCiuz52xM
   A8X2DLt5dJEJmCjHmX2R28BKLbB5aJzzfoE8kt3QQR1C6dRKccgoT2oA1
   ekFRDW6xX/+Dkiz20JV3iRKiQXcSMHjdXjGfutS5OgY5SPWqR3DTj+Ark
   9j+yyrsTM/jUTqbXsanK7JejRsIg1q6gcX053hyMZ/krUFIm/FlBExJMo
   Q==;
X-CSE-ConnectionGUID: 2GWHPu94Q5OjSCRIiD21dg==
X-CSE-MsgGUID: e+h/E4rJSCCCEmQh4WLGbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93042589"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="93042589"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:27:10 -0700
X-CSE-ConnectionGUID: enHVA23sSiG9X+FenkfaxQ==
X-CSE-MsgGUID: qDSE1rUpRieweaOCO/haTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247804024"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:27:06 -0700
Date: Tue, 16 Jun 2026 14:27:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v5 5/6] iio: osf: add UART transport
Message-ID: <ajEzB4EC53vRk9vY@ashevche-desk.local>
References: <20260616072242.3942-1-kimjinseob88@gmail.com>
 <20260616072242.3942-6-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616072242.3942-6-kimjinseob88@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 04:22:41PM +0900, Jinseob Kim wrote:
> Add the serdev UART transport and the initial OSF core receive path.
> 
> Enable the required vcc regulator with devm_regulator_get_enable()
> before opening the UART, keeping power handling limited to the simple
> probe-time requirement for this RFC.

...

> +config OPEN_SENSOR_FUSION
> +	tristate "Open Sensor Fusion UART IIO driver"
> +	depends on IIO
> +	depends on SERIAL_DEV_BUS
> +	select CRC32
> +	help
> +	  Build the Open Sensor Fusion UART receive path.
> +
> +	  The driver receives OSF protocol frames over a serdev UART.
> +	  Frames are decoded and validated before being passed to the
> +	  driver core.

> +	  This patch only adds the transport path.
> +	  IIO device registration is added separately.

What is this paragraph supposed to mean?

...

> +static int osf_core_validate_capability_report(const struct osf_frame *frame)
> +{
> +	struct osf_capability_entry entry;
> +	struct osf_capability_report report;
> +	unsigned int i;
> +	int ret;
> +
> +	ret = osf_protocol_decode_capability_report(frame, &report);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < report.capability_count; i++) {

	for (unsigned int i = 0; i < report.capability_count; i++) {

> +		ret = osf_protocol_decode_capability_entry(&report, i, &entry);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

...

> +int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len)
> +{
> +	struct osf_frame frame;
> +	size_t frame_len;
> +	int ret;

> +	if (!osf || !buf)
> +		return -EINVAL;

How can this be called with osf == NULL?

> +	ret = osf_protocol_decode_frame(buf, len, &frame, &frame_len);
> +	if (ret)
> +		return ret;
> +
> +	if (frame_len != len)
> +		return -EMSGSIZE;
> +
> +	switch (frame.message_type) {
> +	case OSF_MSG_SENSOR_SAMPLE:
> +		ret = osf_core_validate_sensor_sample(&frame);
> +		break;
> +	case OSF_MSG_DEVICE_STATUS:
> +		ret = osf_core_validate_device_status(&frame);
> +		break;
> +	case OSF_MSG_CAPABILITY_REPORT:
> +		ret = osf_core_validate_capability_report(&frame);
> +		break;
> +	default:
> +		if (frame.message_type >= OSF_RESERVED_MSG_FIRST &&
> +		    frame.message_type <= OSF_RESERVED_MSG_LAST)
> +			ret = 0;
> +		else if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST)
> +			ret = 0;
> +		else
> +			ret = -EOPNOTSUPP;
> +		break;

You may invert this and return directly

		if ((frame.message_type < OSF_VENDOR_PRIVATE_FIRST) &&
		    (frame.message_type < OSF_RESERVED_MSG_FIRST ||
		     frame.message_type > OSF_RESERVED_MSG_LAST))
			return -EOPNOTSUPP;

> +	}

> +	if (!ret)
> +		osf->last_sequence = frame.sequence;
> +
> +	return ret;

No. Use regular pattern

	if (ret)
		return ret;
	...
	return 0;

> +}

...

> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

What is this for?

> +#include <linux/regulator/consumer.h>
> +#include <linux/serdev.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "osf_core.h"
> +#include "osf_stream.h"
> +
> +#define OSF_SERDEV_BAUD		115200
> +
> +struct osf_serdev {
> +	struct serdev_device *serdev;
> +	struct osf_device osf;
> +	struct osf_stream stream;
> +};
> +
> +static size_t osf_serdev_receive_buf(struct serdev_device *serdev,
> +				     const u8 *buf, size_t count)
> +{
> +	struct osf_serdev *osf_uart = serdev_device_get_drvdata(serdev);
> +	const struct osf_stream_stats *stats;
> +	u64 valid_before;
> +	int ret;
> +
> +	valid_before = osf_uart->stream.stats.valid_frames;
> +	ret = osf_stream_receive_bytes(&osf_uart->stream, buf, count);
> +	stats = &osf_uart->stream.stats;
> +
> +	if (ret || stats->valid_frames != valid_before)
> +		dev_dbg_ratelimited(&serdev->dev,
> +				    "rx count=%zu valid=%llu bad_magic=%llu bad_crc=%llu partial=%llu dropped=%llu ret=%d\n",
> +				    count,
> +				    (unsigned long long)stats->valid_frames,
> +				    (unsigned long long)stats->bad_magic_resyncs,
> +				    (unsigned long long)stats->bad_crc_frames,
> +				    (unsigned long long)stats->partial_frames,
> +				    (unsigned long long)stats->dropped_bytes,

Why casting?

> +				    ret);
> +
> +	return count;
> +}

...

> +static int osf_serdev_probe(struct serdev_device *serdev)
> +{

	struct device *dev = &serdev->dev;

makes the below look better.

> +	struct osf_serdev *osf_uart;
> +	unsigned int baudrate;
> +	int ret;
> +
> +	osf_uart = devm_kzalloc(&serdev->dev, sizeof(*osf_uart), GFP_KERNEL);
> +	if (!osf_uart)
> +		return -ENOMEM;
> +
> +	osf_uart->serdev = serdev;
> +	osf_core_init(&osf_uart->osf, &serdev->dev);
> +	osf_stream_init(&osf_uart->stream, &osf_uart->osf);
> +
> +	serdev_device_set_drvdata(serdev, osf_uart);
> +	serdev_device_set_client_ops(serdev, &osf_serdev_ops);
> +
> +	ret = devm_regulator_get_enable(&serdev->dev, "vcc");
> +	if (ret)
> +		return dev_err_probe(&serdev->dev, ret,
> +				     "failed to enable vcc regulator\n");
> +
> +	ret = serdev_device_open(serdev);
> +	if (ret)
> +		return ret;
> +
> +	baudrate = serdev_device_set_baudrate(serdev, OSF_SERDEV_BAUD);
> +	if (baudrate != OSF_SERDEV_BAUD)
> +		dev_warn(&serdev->dev, "requested %u baud, controller set %u\n",
> +			 OSF_SERDEV_BAUD, baudrate);
> +
> +	serdev_device_set_flow_control(serdev, false);
> +
> +	return 0;
> +}
> +
> +static void osf_serdev_remove(struct serdev_device *serdev)
> +{
> +	struct osf_serdev *osf_uart = serdev_device_get_drvdata(serdev);
> +
> +	serdev_device_close(serdev);
> +	osf_stream_reset(&osf_uart->stream);
> +	osf_core_unregister_iio(&osf_uart->osf);
> +}

...

> +static struct serdev_device_driver osf_serdev_driver = {
> +	.probe = osf_serdev_probe,
> +	.remove = osf_serdev_remove,
> +	.driver = {
> +		.name = "open-sensor-fusion-uart",
> +		.of_match_table = osf_serdev_of_match,
> +	},
> +};

> +

No blank line needed here.

> +module_serdev_device_driver(osf_serdev_driver);

-- 
With Best Regards,
Andy Shevchenko


