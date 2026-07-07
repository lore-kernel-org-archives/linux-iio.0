Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BC43031F;
	Tue,  7 Jul 2026 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439893; cv=none; b=KF6fxGAdCbjni+qEuj4+xQSefIHXts8L1ditRhcrIKvueGA6nayS33dSjbQAfkUoniLhKYFakHqPC7W0y9GWZyFjJ2/pqosxEnsuoxYAUHCBQKN9DLiR+h+Ww66lrBqYXoCmPXhFgHwf1O5InwkpT9yjae8tEWpl6K+QUfsJb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439893; c=relaxed/simple;
	bh=RbRMYiE9+daV0ts9FpBOpnXSHjXIEaEb4RzBHa2+DXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEmT1LvOCmjngvCAVb9dnonH70T7gljpCCbECLD9Re2TkoBZu+bRofVhcrRep4hx5ZOUz8NKCCeFz+MXvJZ6pEVMbO+Qf1DsJCTwKdh8zXBs/SRjRiKNpH6QDArQFgyZglT7B6aFH/UG9GszcpBXSAtKwh4gp1qoAGTG8tlzZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jf8aXEkr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jf8aXEkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783439892; x=1814975892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RbRMYiE9+daV0ts9FpBOpnXSHjXIEaEb4RzBHa2+DXM=;
  b=Jf8aXEkrjtn455xfOnbwFPvkkk9IjsKEe4cnlffFX/Q8GPp1NHUa6Viy
   w4ubPRmZMbeJa1mXpcLN6Cu+gVS7QY4tuhaUi4mY8UYfaD7woQqtLrhr7
   zRx5md8qeEBP0noDWMaFlRhr/5icZeDb1JWfuBOstdfQ2HIu7227qiO8S
   /7Av6JGbVUFNt987kL8ImODFuQHhc11ERUEfc19aLltOvpT8Hgnnmrx5o
   uZM/VOSRJ0nlLiBenWQxBInJ9CfsBh0Pm+oq8DflCn5eOKeEL+RzmQruy
   nUYdQ+8hZ05EjbynBHgHT0NiFUFRXrAHi2irzWTNT0nnh6kqxxBaQx9la
   w==;
X-CSE-ConnectionGUID: xbyVrNdcTvC2nKGBiirHnQ==
X-CSE-MsgGUID: J59ox94YRoqg4z1o3yvATg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84282025"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84282025"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 08:58:12 -0700
X-CSE-ConnectionGUID: BOFx/iMmSAGIsJHsIdTz/A==
X-CSE-MsgGUID: eeYuXCkrSW6NlXR8G4ksIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="247652662"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.36])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 08:58:07 -0700
Date: Tue, 7 Jul 2026 18:58:05 +0300
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
Subject: Re: [PATCH v7 06/17] iio: core: create local
 __iio_chan_prefix_emit() for reuse
Message-ID: <ak0iDafuEGoKMy-m@ashevche-desk.local>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
 <20260707-ad9910-iio-driver-v7-6-a4ec30f63700@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-ad9910-iio-driver-v7-6-a4ec30f63700@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 03:04:27PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Move logic to create a channel prefix for naming attribute files into a
> separate __iio_chan_prefix_emit() function for reuse. The dev pointer is
> passed to __iio_device_attr_init() so that WARN() replaced by dev_err().
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

> +		if (chan->indexed) {
> +			seq_buf_printf(&s, "%s_%s%d", dir, type, chan->channel);
> +			if (chan->differential)
> +				seq_buf_printf(&s, "-%s%d", type, chan->channel2);
> +		} else {
> +			if (chan->differential) {
> +				dev_err(dev, "Differential channels must be indexed\n");
> +				return -EINVAL;
> +			}
> +			seq_buf_printf(&s, "%s_%s", dir, type);
> +		}

So, in analogue with _BY_TYPE

		seq_buf_printf(&s, "%s_%s", dir, type);
		if (chan->indexed) {
			seq_buf_printf(&s, "%d", chan->channel);
			if (chan->differential)
				seq_buf_printf(&s, "-%s%d", type, chan->channel2);
		} else if (chan->differential) {
			dev_err(dev, "Differential channels must be indexed\n");
			return -EINVAL;
		}

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
> +	}
> +
> +	return seq_buf_has_overflowed(&s) ? -EOVERFLOW : s.len;
> +}

-- 
With Best Regards,
Andy Shevchenko


