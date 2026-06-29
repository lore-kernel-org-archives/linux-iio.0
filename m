Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910C224B15;
	Mon, 29 Jun 2026 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741934; cv=none; b=ug5ddtsSAQz2NMDvjHir6/GfoZMNqH6JTKFX0MHe/Ovcmsqeg/JumYL1aJTz8JcVPojI6GlCCi3DNtwuE9NjI92pEYBYt4BPkIToSIC9ldZbsNboIDCkNxr3fWJxIXIRnvAMtj3bHu0SQ2n/bPFx37j3qfg1tLcW104JQv1gxbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741934; c=relaxed/simple;
	bh=c5scqsKrFR923loW0LJkY5W0jRYL4ryhQKo4XfRhyYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ6l4MN6xtjbGNOTNIXKHj4EHgNoXLOC3wMxL1EvQT1zPPcoe+5Bbcy9SJt6jv9K6Tabz5ubA1893V+g8Y7/NNV7Lh8Zqv0LvPvbF3YkzRIrmtvPFkOu3pGtKN4+bnurL2xJy+ijACGXq9vD+Iepjmy6VIq1tgaWUhPNXbOMo4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RpX260gs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RpX260gs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782741934; x=1814277934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c5scqsKrFR923loW0LJkY5W0jRYL4ryhQKo4XfRhyYI=;
  b=RpX260gsvp2lt3nXY9rz3qhR2ipPusHxZj8y+6NQHdLFq2cd78vkU83i
   /Xc8X4LnLyx62ehJbw/lCNzv17oxAJ5G7mpgwcPUN3oRhps5S5kkE7Xxu
   xj/t0QIW4ig2yvCiAwMycIP5AUD8w183qwqkCq0DPCojkCuHi4vLB6Hmc
   mmvuvib1gP6WimCVlu0KoXAUDZgXWLJqgb70ET1wMcyLZE4QxLJyYmHbc
   qxEXV2YWCc3sTt6jPw6Jn8BDns1Jaq/lXto3KFb5LStPxgI5KYoql7QNg
   Mlpi3Qt1XRrlFuAMYxgGIInTRYJalKQO7qGYz3OjbbQdRitFioxiTMqv1
   Q==;
X-CSE-ConnectionGUID: iiRb8/+KRUumIiicUngCJg==
X-CSE-MsgGUID: ugdVhjuOQKmoBFeDYXAgEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83437526"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83437526"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 07:05:33 -0700
X-CSE-ConnectionGUID: D2WYEo3GTRqDo8mRszrxIA==
X-CSE-MsgGUID: BXYOOxUDQuWINzIO0K/3dw==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 07:05:29 -0700
Date: Mon, 29 Jun 2026 17:05:27 +0300
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
Subject: Re: [PATCH RFC v6 3/5] iio: osf: add protocol decoding
Message-ID: <akJ7p17eay2mnW-Y@ashevche-desk.local>
References: <20260628191337.937-1-kimjinseob88@gmail.com>
 <20260628191337.937-4-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628191337.937-4-kimjinseob88@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 04:13:35AM +0900, Jinseob Kim wrote:
> Add helpers for decoding Open Sensor Fusion frame headers and supported
> message payloads.
> 
> The decoder validates the OSF0 wire magic, protocol major version,
> header length, payload bounds, reserved fields and CRC before exposing
> decoded frame contents to the rest of the driver.
> 
> Use explicit little-endian wire storage sizes and designated
> initializers for decoded output structures.

...

> +#include <linux/bits.h>
> +#include <linux/crc32.h>
> +#include <linux/errno.h>
> +#include <linux/limits.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>

...

> +#define OSF_FRAME_MAGIC		0x3046534f /* "OSF0" little-endian */

#define OSF_FRAME_MAGIC		0x3046534f /* "OSF0", little-endian */

(mind a comma).

...

> +int osf_protocol_decode_sensor_sample(const struct osf_frame *frame,
> +				      struct osf_sensor_sample *sample)
> +{
> +	u16 channel_count;
> +	u16 sample_format;
> +	u16 sensor_type;
> +	size_t expected_len;
> +	const u8 *payload;
> +
> +	if (!frame || !sample || !frame->payload)
> +		return -EINVAL;
> +
> +	if (frame->message_type != OSF_MSG_SENSOR_SAMPLE)
> +		return -EPROTO;
> +
> +	if (frame->payload_len < OSF_SENSOR_SAMPLE_BASE_LEN)
> +		return -EMSGSIZE;
> +
> +	payload = frame->payload;
> +	sensor_type = get_unaligned_le16(payload);
> +	channel_count = get_unaligned_le16(payload + 4);
> +	sample_format = get_unaligned_le16(payload + 6);
> +
> +	if (!osf_sensor_type_valid(sensor_type))
> +		return -EPROTO;
> +
> +	if (!channel_count)
> +		return -EPROTO;
> +
> +	if (sample_format != OSF_SAMPLE_FORMAT_S32)
> +		return -EPROTO;
> +
> +	if (get_unaligned_le32(payload + 12))
> +		return -EPROTO;

> +	if (channel_count > (SIZE_MAX - OSF_SENSOR_SAMPLE_BASE_LEN) /
> +	    sizeof(__le32))
> +		return -EOVERFLOW;

Dead code because it's always 'false'? Hasn't compiler given a warning?
Always compile your code with `make W=1` using both compilers: clang and GCC.

> +	expected_len = OSF_SENSOR_SAMPLE_BASE_LEN + channel_count * sizeof(__le32);
> +	if (frame->payload_len != expected_len)
> +		return -EMSGSIZE;
> +
> +	*sample = (struct osf_sensor_sample) {
> +		.sensor_type = sensor_type,
> +		.sensor_index = get_unaligned_le16(payload + 2),
> +		.channel_count = channel_count,
> +		.sample_format = sample_format,
> +		.scale_nano = get_unaligned_le32(payload + 8),
> +		.samples = payload + OSF_SENSOR_SAMPLE_BASE_LEN,
> +	};
> +
> +	return 0;
> +}

...

> +	if (capability_count > (SIZE_MAX - OSF_CAP_REPORT_BASE_LEN) /
> +	    OSF_CAP_SENSOR_ENTRY_LEN)
> +		return -EOVERFLOW;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


