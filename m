Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503B434983;
	Fri, 11 Sep 2026 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114771; cv=none; b=u2PXLtGjDPXtARcvvmtlbKhiTgzch3Y/mkD7XIsOf+zRF414U2Lq6KXSVYvX7s+UDeCNuDPFHBPjToFCwYK6PHh3iuS9sACrHWmRhTJgkFTCCSF/vuav82mWQTr8C80ny1ejaXo4xSNNVByxoOhkpYuo1RWbUwtY0wW3y/xPihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114771; c=relaxed/simple;
	bh=ePVUWYy1WmpEjDl6lK+lvTdr9681C/JJnc/TLu9nOSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADaoIOxv1xAUkQH4yVsTZ6irWyoe1Cjt28GMvlucXWpqDcOtJPomAfudXld4SZVckc7oEJpVJ2vvLnY8jhHurt0lIzjMiP2LZekQwMj8uLwonjoXEzMKjaP6g6YL9xtX8c1UmDzjlJS4tTPuC7WTbpzjSRTwpPX3r3g6EEGzTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxtrHbyI; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxtrHbyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789114770; x=1820650770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ePVUWYy1WmpEjDl6lK+lvTdr9681C/JJnc/TLu9nOSY=;
  b=UxtrHbyI9WOuNew7RSBGkRsPn358RbdFZ4/EByR3gEYcTzXvdGVoYccR
   kV9U8l3MuTAn+eRR+AJ0lMh67KmINm+AUEIPkXC3wKy4izEmZk+dySK90
   EoJiP5N17NkE7ZQcDiiooHeewv+ypQ94xX4DX+BFVR8a2BGivlfjdgNEZ
   H1C62QVrkeL89slb5fL+72/Oh1VLScfZsiv67VxjPnC0uWiMK5gOJAjK5
   A9ALcLz4PoW1zLO89QNY0Q51O4R7cU7zZL3RaX+wrDEfArxVsrFJ8FdV5
   Ga8kVRJxwDhXOLP3gjdyJAxVkeXNlPMMa6cnFuTj1EoXda30phTSmxWyU
   w==;
X-CSE-ConnectionGUID: 3b9HGguHTxG66jGoS3csGw==
X-CSE-MsgGUID: sRLQkicBRc2e3CZphbnyaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="85832"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="85832"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:19:22 -0700
X-CSE-ConnectionGUID: YtiXrPu5RpKImt1K5sLzFQ==
X-CSE-MsgGUID: KkU2ZgFSS5WnRiBieYr5jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="301758984"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:19:11 -0700
Date: Fri, 11 Sep 2026 11:19:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v7 04/17] iio: adc: adi-axi-adc: Add support for CRC
Message-ID: <aqO5el6eRuMW7NuK@ashevche-desk.local>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
 <20260910-ad7768-driver-v7-4-7f70b07627e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-ad7768-driver-v7-4-7f70b07627e1@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 07:36:22PM +0200, Janani Sunil wrote:
> Add support for enabling and disabling Cyclic Redundancy Check (CRC)
> processing in the AXI ADC backend. CRC provides data integrity verification
> for high-speed ADC data streams, ensuring reliable data transfer between
> the ADC frontend and backend processing systems.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


