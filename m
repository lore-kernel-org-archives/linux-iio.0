Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8E4DC55F;
	Wed, 13 May 2026 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694502; cv=none; b=n/cDoIwOKrsohVsOIupfID56FGIUJPCPr3sSBnJ5mkJRyYYDLd19L/fL8HrMdKUbSphCA16ljil9D/H8pwTQbusEIPpP0qEAGNaRYwmGJvb2cwjPjTL54AJyPpEVyAsY71lW+wK5XOt+KewwFYaNA8vhn6eKleKnc3O8IJqfsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694502; c=relaxed/simple;
	bh=fF6REr3h5Pi2RL6LPgAqzchRdE/dzqgGnbwHYAwXtCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdXBYI28kDHQ0NEGNjCYYGWx9tDp9aNts+WpOqo/xSRZDCTP25EtQN0Wkq+0XtAugk+9CetFZzFtJwMXX0SZomVhdaaUFX9xvXO+FBu84qj0iro3CRH0l0SLiNdbgyy73lCxZeSoMPw9qwmdAZacmG5JAxffwqiSOwY3Tq2kHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noOWNe7J; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noOWNe7J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778694501; x=1810230501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fF6REr3h5Pi2RL6LPgAqzchRdE/dzqgGnbwHYAwXtCc=;
  b=noOWNe7JuDjIFa/oaAooTMziurZuI5xxSfkvPzyRszrb2U8rUbaO0NhN
   uLBxy1kVpSH+boWhohgbH4WqZl5vH2iW3y6l4V8UWecptYs6E9TpY1srx
   DA0ywuPAW/TYxwe3RGpqm5AqGxNa0Lc9gekakQve2c+N2oqyL2kwAVf/9
   sKnuNsKppQSNbOmS8BCPRH6RWjq6RcbAVR0ef9zK6ojCQONm+lajHwSdj
   S+Al5ycH5XOMdEXPDzfSvn4V0BQa+qAvyXXR9SCLTMBgPbbSEIcs51ptZ
   qJ5npLzkHtxepAoQKDCeqZEZn9dOUDCps+zVJivKES437IuYIrVvZePco
   w==;
X-CSE-ConnectionGUID: L/FFIacZSzORbW8vl6bg7A==
X-CSE-MsgGUID: 6HMv6wyWTh+IaVv6GjWyeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="91092702"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="91092702"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 10:48:20 -0700
X-CSE-ConnectionGUID: OzdiAfUDTzOR5znuYVB3YQ==
X-CSE-MsgGUID: 7EketAXhQUujw4pp85xiAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="233698492"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 10:48:16 -0700
Date: Wed, 13 May 2026 20:48:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: light: veml6030: fix channel type when
 pushing events
Message-ID: <agS5Xu8ORtEwuwOB@ashevche-desk.local>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-2-4703ca661a1d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-veml6031x00-v2-2-4703ca661a1d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 05:49:42PM +1300, Javier Carrasco wrote:
> The events are registered for IIO_LIGHT and not for IIO_INTENSITY.
> Use the correct channel type.

> This bug was introduced in the first version of the driver.

Unneeded detail, if it's a bug, use Fixes tag.

> When at it, fix minor checkpatch code style warning (alignment).

...

> -	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
> -					0, IIO_EV_TYPE_THRESH, evtdir),
> -					iio_get_time_ns(indio_dev));
> +	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +						       0,
> +						       IIO_EV_TYPE_THRESH,
> +						       evtdir),
> +			iio_get_time_ns(indio_dev));

AFAICS the indentation is still broken. Why not doing like this:

	iio_push_event(indio_dev,
		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0, IIO_EV_TYPE_THRESH, evtdir),
		       iio_get_time_ns(indio_dev));

-- 
With Best Regards,
Andy Shevchenko


