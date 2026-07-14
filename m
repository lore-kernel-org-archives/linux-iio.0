Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8D35BDC7;
	Tue, 14 Jul 2026 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029602; cv=none; b=lRwmfQNRqXmXYWuh8oGkJpwSvZXIqAH+jkcIVF4II8KhmobCoUsHXCwVjyDXIuRjAjg9NUrDYmLO9uKgMmScRI/W+Cgf+oF/d/M2obbnss2XPLjPvR39w4v6VMbOXD586HgJzaiQlTV88wlFWuKPKoZz1R1Q6jKCBy323SciZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029602; c=relaxed/simple;
	bh=SuvH0R0BK+/0Ae0Mp+igWDU48vvsC5mEiQoQxHn1sBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCkGaYWApOPFxydJpFe4nKv0aGPPllMioLPgT//6UpmAQFM0+5g7HHmzvsYY92e1A/agzqHPUuQOKtsUhjfeyO7mjP9O72F55GLH15+a4bg5Y1Wi2Yt2yrSGTAQxmhUcFb8IuGcaI17biH9u+TOfu/MghZjbOq8+43XB30Dv5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4MAnEao; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4MAnEao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784029601; x=1815565601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SuvH0R0BK+/0Ae0Mp+igWDU48vvsC5mEiQoQxHn1sBM=;
  b=A4MAnEaojvoOKCrFwEaEU2VSDmLGPSwpk3way50gXMEpjtYfYBwJq/Db
   wC96cIw7nydxtbbwFmuvUKLaXeNLyOdXRBDX3wCKDPMTqsjMq/+CD30QZ
   0YG1znZdKYlvcCHWpDiGlPwkraFqiaVqmE/u8m22jEJ9b5OoqvSa3CEwO
   nD7eSeYWFf8x4iatRLvUm5RiIA3wFVQc8Vx4eIlKkgMkKGXn8+AJgFPC1
   tnY8PIyk9rFrq5eX1Qu9KfnDG9DAmgTTQm3e8hcWPcJPeBUYZgX8pHAvy
   ebQrqPProBY+xW0D24hKM5jkCiujRwF6DCAyhXEVUEZcVaGftlhwPisYn
   A==;
X-CSE-ConnectionGUID: 60E0xN9bTt2qse3fXPtQQg==
X-CSE-MsgGUID: HaUt82+DS/SGOVUmE4u9ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88470446"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="88470446"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:46:40 -0700
X-CSE-ConnectionGUID: RWzRhk1qTOWgY9v/MBMjwA==
X-CSE-MsgGUID: PFof6ymER0SXkV4IgFNRHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="257801627"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:46:36 -0700
Date: Tue, 14 Jul 2026 14:46:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v8 06/17] iio: core: create local
 __iio_chan_prefix_emit() for reuse
Message-ID: <alYhmR7y7xlMqLJ1@ashevche-desk.local>
References: <20260714-ad9910-iio-driver-v8-0-36939c3c07d2@analog.com>
 <20260714-ad9910-iio-driver-v8-6-36939c3c07d2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-ad9910-iio-driver-v8-6-36939c3c07d2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 12:02:46PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Move logic to create a channel prefix for naming attribute files into a
> separate __iio_chan_prefix_emit() function for reuse. The dev pointer is
> passed to __iio_device_attr_init() so that dev_err() replaces WARN().
> The new helper is going to be used to expose channel relationships as
> sysfs attributes.

...

> +static ssize_t __iio_chan_prefix_emit(struct device *dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_shared_by shared_by,
> +				      char *buf, size_t len)
> +{
> +	const char *type = iio_chan_type_name_spec[chan->type];
> +	const char *dir = iio_direction[chan->output];
> +	struct seq_buf s;
> +
> +	seq_buf_init(&s, buf, len);
> +
> +	switch (shared_by) {
> +	case IIO_SHARED_BY_ALL:
> +		break;
> +	case IIO_SHARED_BY_DIR:
> +		seq_buf_printf(&s, "%s", dir);
> +		break;
> +	case IIO_SHARED_BY_TYPE:
> +		seq_buf_printf(&s, "%s_%s", dir, type);
> +		if (chan->differential)
> +			seq_buf_printf(&s, "-%s", type);
> +		break;
> +	case IIO_SEPARATE:

> +		seq_buf_printf(&s, "%s_%s", dir, type);
> +		if (chan->indexed) {
> +			seq_buf_printf(&s, "%d", chan->channel);
> +			if (chan->differential)
> +				seq_buf_printf(&s, "-%s%d", type, chan->channel2);
> +		} else if (chan->differential) {
> +			dev_err(dev, "Differential channels must be indexed\n");
> +			return -EINVAL;
> +		}
> +
> +		if (chan->modified) {
> +			if (chan->differential) {
> +				dev_err(dev, "Differential channels can not have modifier\n");
> +				return -EINVAL;
> +			}
> +			seq_buf_printf(&s, "_%s", iio_modifier_names[chan->channel2]);
> +		}
> +
> +		if (chan->extend_name)
> +			seq_buf_printf(&s, "_%s", chan->extend_name);
> +		break;

Can we actually do the validation first without dirtying the output?

		/* Validate differential channel settings */
		if (chan->differential) {
			if (!chan->indexed) {
				dev_err(dev, "Differential channels must be indexed\n");
				return -EINVAL;
			}
			if (chan->modified) {
				dev_err(dev, "Differential channels can not have modifier\n");
				return -EINVAL;
			}
		}

		seq_buf_printf(&s, "%s_%s", dir, type);

		if (chan->indexed) {
			seq_buf_printf(&s, "%d", chan->channel);

		if (chan->differential)
			seq_buf_printf(&s, "-%s%d", type, chan->channel2);

		if (chan->modified)
			seq_buf_printf(&s, "_%s", iio_modifier_names[chan->channel2]);

		if (chan->extend_name)
			seq_buf_printf(&s, "_%s", chan->extend_name);
		break;


> +	}
> +
> +	return seq_buf_has_overflowed(&s) ? -EOVERFLOW : s.len;
> +}

-- 
With Best Regards,
Andy Shevchenko


