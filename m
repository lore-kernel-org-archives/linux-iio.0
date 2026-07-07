Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF3431484;
	Tue,  7 Jul 2026 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440052; cv=none; b=s7xTACwfb3oSvnUes3cPJxlVS5mZguYZ1TlfWatvanixXthcCsEznk4X5XmN5D72e58ztC996M+ps9PIocfQ1IAPXFH/O9OcycFVM10ks9UNwbptIiHo316LpzFo800Y1S+cxDOZ3tr/OhcWRJoQtlOFFE0e2XNyRWHvALR/fUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440052; c=relaxed/simple;
	bh=ChJRypsr3Dcq8r3UD1/SH4cIoxbNZOBcguf/Rdix3Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfkStqIC6B0EIx+MqEvtHsvXnt5ofUpSl044Jo47Fr0DYAOi9xrTNf0+KauxiB/zpuH55TMzzbA/NuhZKMDtu/+aaLvMYIvvhPxzUJhslgfqRYDS64UaxriJS6aCCpUntL0fkyhiJY6HrxVcsSYviPENmxTTZCFo3YOTApVh1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBIT2Kmz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBIT2Kmz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783440050; x=1814976050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ChJRypsr3Dcq8r3UD1/SH4cIoxbNZOBcguf/Rdix3Oo=;
  b=TBIT2KmzESWNM0oZ5zKnfOcnCwX7PyF5icosspqXv6HvDT7kZN9kn8jK
   DGCMq37vocr45Mc6ZDyn4y8ASce7l2UQzlPNIwTJvEIURVGyid9dKEDBO
   XIWVIs/l+zDUg/asqAl32Ew3zLT5rdZXPzYqIVpTqqTWe0NGiKKD5mvk4
   LzZUXA6U5N58Gn03mbtsArTWe8D5e88wFqXVd5UkhCBQona/Cfn/bdKV9
   Zx0kWANirioZryRIhRhfoUvhbmBeDuC3K131KD7t7SJBB3Cs3WJn6M0gm
   cUtyrIz8AgFoNfKW7RTsHyJg+QV+TlUjzDpeoKZy8VH4U3c313FhgCj1m
   w==;
X-CSE-ConnectionGUID: La/cKO59RBW1n6//2HGoyg==
X-CSE-MsgGUID: ZI+DyjD2TDKH5IS3z7uy6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95606865"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95606865"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 09:00:49 -0700
X-CSE-ConnectionGUID: 6wMFz189QgOFRSpef6Dblw==
X-CSE-MsgGUID: oPwpGielSgeqE+pcYxtbmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="250674850"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.36])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 09:00:45 -0700
Date: Tue, 7 Jul 2026 19:00:43 +0300
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
Subject: Re: [PATCH v7 08/17] iio: core: add hierarchical channel
 relationships
Message-ID: <ak0iq2KGgGnjTgfr@ashevche-desk.local>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
 <20260707-ad9910-iio-driver-v7-8-a4ec30f63700@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-ad9910-iio-driver-v7-8-a4ec30f63700@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 03:04:29PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add parent-child relationship between iio channels by creating a parent
> pointer field in iio_chan_spec struct and exposing a sysfs attribute that
> returns the parent channel prefix.

...

> +static ssize_t iio_read_channel_parent(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	const struct iio_chan_spec *chan = to_iio_dev_attr(attr)->c->parent;
> +	ssize_t len;
> +
> +	len = __iio_chan_prefix_emit(dev, chan, IIO_SEPARATE, buf, PAGE_SIZE);
> +	if (len < 0)
> +		return len;
> +
> +	buf[len] = '\n';
> +
> +	return len + 1;

	buf[len++] = '\n';

	return len;

? To me this variant is more robust as we don't forget about \n in the len
count.

> +}

-- 
With Best Regards,
Andy Shevchenko


