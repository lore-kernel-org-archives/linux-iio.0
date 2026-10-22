Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687934;
	b=AB/WutC8cKZUmeqcK/mPaz7pQ+AZDKuGbi4KS+vsbc8YGLyLz+0qSV9/JQx6McBerbWT
	 nuGBF6HTwoijdeTfb3GZucl8Ztl/PrfWVRS+Jp9xNscP99MwXuUxgcO8tfs9mjR0iD2ZB
	 3jz8GyrhIGRuLk5U5soK78ZSWQdbyjtUxGv8Lvn90wPxTJGPx63qctRX6qbcgrd+tWWSp
	 OdU0VuC/vEssy639uZdmaMnFGGipvNeAIi+XepG7qqbvBAYzlVp5KEgonh+VuD+DVCWJq
	 x+clRKN7dUslzkRB9R65uiak1eZb18A0L7Vgfu/E5wBbCVOUCVXq3l0JYWiRefM7rdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687934;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=YlHTqIQTFSvA7XwtkNIK5+yrdhg4LuKCGQ8c62WCAWc=;
	b=OmCSR9dijbsOp8q+kibQN1bVJ4uwCbmSdcTs3mLYtlM1WtL6S+O1fU8Q+aQ5xUtRY/nv
	 GcWHnhkZrYIAW8DFW8n1lYoD5FGk/qMkuDYMdKh+Mg9oB5ve7Ik3vMHSMVTBuHhjApc+F
	 /8o95NllrgoLH7eGirNvIKXFs+nnLFYGG4XkH2LoKa3GXNWcMxZ6i9kKUObC+8Zo3WiKR
	 ou40L7banLUe8+nCoLrc3fszxDIOEdNe6VvpA24eCCNzahRHPZv6zZetX9d87ji8Sxszg
	 SbHuef4Dn+3Q5lyhQvWzw7IXy1naWZmRM0aoXiD7fIWPTJXwjWVCiL6I46dmlJm4oLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DXYgQ0b6;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D4606A31B;
	Thu, 22 Oct 2026 16:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC9D4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DXYgQ0b6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792687933; x=1824223933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3fOlkl6I0V+PQGecGED0jdaF8rzz7oSeC6hSjF39LF4=;
  b=DXYgQ0b6kEE2higE2jZwBShlrJXZLaLGH0P+bnjHRmkVYk59TLPDEl5Z
   umzj1NKzwHFAAz4eGzSijBnlsDrPdP42cQwndKCGujKGyY20P6GfH1kz4
   Km/I/g7zzbdVlacANGBIIYDQRJ2MeNXqeo76D4aC+oLr/0pIqbK08PC3X
   eQKyZJ4/iZlzaA4SR2a0753Bw4liCRFM/L+ch1uHwJYG0wP4lXdNEKCdW
   wateHN0Co8y8zvuLDjJeqSc8jWYbBcrgrgRIi6pJK901OsVG0h/fOHtii
   7Z8A4GiKbG2WXvzvutnqCM0wLIy4ofUgAaLiA3+puS1+0/DY2LGuvhjS9
   A==;
X-CSE-ConnectionGUID: J3o0V0b8RQWa3X9HBB4XUQ==
X-CSE-MsgGUID: oa0+iHrxT0OTeH7+FmaeRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1344812"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1344812"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 09:52:12 -0700
X-CSE-ConnectionGUID: TqTDPdHbSBCEawVVFoQuhg==
X-CSE-MsgGUID: ccZFqEN2Rm+uAnPCXYH0BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3353608"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 09:52:10 -0700
Date: Thu, 22 Oct 2026 19:52:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jan Remes <ciakval@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Remes <jan.remes@mycroftmind.com>
Subject: Re: [PATCH v3 2/4] iio: light: tsl2591: add I2C device ID table
Message-ID: <ato_Nza0anAXxCU5@ashevche-desk.local>
References: <20261022-first-patch-v3-0-b792e89a429a@mycroftmind.com>
 <20261022-first-patch-v3-2-b792e89a429a@mycroftmind.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022-first-patch-v3-2-b792e89a429a@mycroftmind.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 01:53:58PM +0200, Jan Remes wrote:

> The driver has only an OF match table. Devices instantiated by name
> (e.g. via the sysfs new_device interface or i2c_board_info) have no
> firmware node, so the I2C core can match them against an OF table only
> by comparing the name with the compatible strings, and it does that only
> when CONFIG_OF is enabled. Without CONFIG_OF such devices can be matched
> only through the I2C device ID table, so they never bind to this driver.

> Add an I2C device ID table so that they can be matched.

Please, squeeze this to the point.

Example:

"Allow driver to match devices assigned via sysfs or through board info
 by adding a currently missing I²C ID table."

-- 
With Best Regards,
Andy Shevchenko


