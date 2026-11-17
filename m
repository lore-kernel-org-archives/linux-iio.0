Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904205;
	b=aptY/8YU/KmhUyHIYaIQRO5Kq4A57hHtdrvzH5QoY3oINnoqY5KvsfDqaQesw1iXb8Zf
	 jBj1gb+NjYc8TuHGQnLWwSvlyGpPn5+fpVKQkq2Inl2o6B945Vq0zLNhBOD8EdckfyKLI
	 gftA6WiXTl0J6y+u7Mo1AUXBWFT4GxXVsFOCd8soBUPLSFfe9XwtBulVurzBNJY0CyF4/
	 3S6vKSeqkJ99yxBP2m55lyeroHsI8LlLTcjV/gEpG60vZ40urQM4otwwH4Rk1F1zIAqqm
	 Hv015j3i2kTtJtN4BDDlvC6WWoYQHX/9QCjrYgcFLQHK4GAIB3otgOU6ZBVaaj4wZ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904205;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=WvbcWrpjqSDvS2um7Xu478IOh50A3jH/Cfrlx6TfPRY=;
	b=QF/KSBmYa3DdpWEafowLuAUYrAfg8MMGOqgqkp90Iy6g+OMLAPUtAvQ+tXHmpyUjGiSE
	 MbOO8GBpx0+LVhktkbMqXRJRxb69sVX/AMPF2Dhq5gzMlDOTde3NPAB1Jo7ueUQlGB0TV
	 v2J7jRfoVBtIktmEpIcoljXgfXhIOvBRgaGyLiLrDTrHkVPxLeslv7GlHQrEcPt2CRVsv
	 LVpAKN8ovQMh2bbSFAew8c1YNb/YfNOvI5q545jSbcw3hvOGcW4xy+mdNdWHKtMhQfFCe
	 VRDIt2XVKnplp3+84EnCDNnFG4nnscHl4GvvBkokk9JeivwbCJbiH/8f9/e08sIAisw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ONU0jlVl;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1394606A338;
	Tue, 17 Nov 2026 08:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1394606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ONU0jlVl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794904205; x=1826440205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0lIdPd6IyKJkYAiE/OiCejr0WMkmIdh3UxqDW7OEk+w=;
  b=ONU0jlVlduL5ckGJtchDBYa2odb6VP82NiVqBAJmAMjRSIm+O+1ZGp9t
   /YhT/a1RvlK1uLo2mV8F+T49mpOuaUzwjWVTDeibdYodGqTvG8UOBQx59
   7dR0nG3Nua2pOtka3rJgqzPQJ1r2UheweBcfy5BZjBlDxPqExlTpKhgpO
   T2FCG5jzoyDrL14ueqLl2I1TkloQBCXgnnCpXEHVBcPqvtm9A1oUnL1J0
   YxJCML0neYKGaFhmcMY1RJfjBJv3xQrFkBfCb4pL7B9Tqx+hPKOp5hHvu
   YP+/kk6PZXjDBbwEH4WMb5sy9enwoVP63dL2NWrG2//VyBPp5vOUDVjXp
   w==;
X-CSE-ConnectionGUID: u34RSIDORDuHijAlVOdhXw==
X-CSE-MsgGUID: 78iZ9mw7ScymzbuiyWqn3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3575794"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3575794"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 00:13:31 -0800
X-CSE-ConnectionGUID: 4zHiwDGhT920ANQtqejjLg==
X-CSE-MsgGUID: s0fzIzRQQU6EWdf4f2DlXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10090228"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 00:13:28 -0800
Date: Tue, 17 Nov 2026 10:13:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joseph Telaak <joseph@telaak.dev>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: potentiometer: mcp4018: Report the available
 wiper positions
Message-ID: <avwMpV3sCvMQNA0b@ashevche-desk.local>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
 <20261116-iio-ad5246-v1-2-ef6b7c06d4b0@telaak.dev>
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
In-Reply-To: <20261116-iio-ad5246-v1-2-ef6b7c06d4b0@telaak.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 05:59:51PM -0500, Joseph Telaak wrote:
> Implement read_avail for the raw value, as ds1803, mcp4531, tpl0102 and
> x9250 already do. User space then sees out_resistance0_raw_available,
> and an in-kernel consumer can learn the wiper range with
> iio_read_max_channel_raw() instead of hardcoding it.

...

>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  };

> +		*length = ARRAY_SIZE(mcp4018_wiper_avail);

Take a chance to add missing headers at the same time, id est
+ array_size.h // ARRAY_SIZE()
+ bits.h // BIT()

-- 
With Best Regards,
Andy Shevchenko


