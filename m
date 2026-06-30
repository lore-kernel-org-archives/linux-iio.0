Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29D407CF5;
	Tue, 30 Jun 2026 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821440; cv=none; b=CMJwkOCCE0vvh/STPDwrDpHpG0/xgH9CR94moSu9oDpZHmVgNadPReD7qORDRQPdHI19MKPG3G0G0J/9bcpqAbLHHNsx2mR+s0LHKVc6TahEXpV71mbLMBPd5UEtdNEbT2DuObOG6kULr/swm6XoZmFay3q3MYRTugeSV1F8MBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821440; c=relaxed/simple;
	bh=+9+rfU++LXQxcsZV/JfS2wQ7t6TWgJObw+ukW2DA2Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeGGSwk7I0ss8fjzPnmWPbRbqbFHjuCz28IC7nU8k21O6pv6+LwxDZZVS4feKJ+eHnrOaZYMxecj04mKe29m7PYCBNHM6w8cyV1a9FhhzCu0KiJTkykiMAnrJ5weN5qAgVRQm4TY0hDpl7KK0+Q+kVe6m7zRN7nJ0xpe4EyIGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbkFa01d; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbkFa01d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782821439; x=1814357439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+9+rfU++LXQxcsZV/JfS2wQ7t6TWgJObw+ukW2DA2Uk=;
  b=cbkFa01dXKs8eF/sBM55hS/iZYsdz8k13WbzMfC2jSHW5LMylNvLOFaZ
   2ayj9q6pyTlWItWk7SSOylO7ZMk+5O1jq8Yf35/rvKnResYHwiupPb3ST
   NFSuTEPVzjPE8Ef11BRznxBw5jpYbtYPRRi13uEB9SgSmWVeB+GJvgTRX
   lelB1tpqNPGXtO6MnIz2mjRmyT3tpXGUVYYrmv5E96Cn6xHXqFf4B0r2/
   DWH9d7TBi2UP0kLP6GbZXWE/b6yXxDFZJo55r2Xf3B3oaFdiHljFUugbV
   OZwPO61uPabtKpk4CX7vUxcgqPU1F1AelwjHAXZg5j4uY8zGKHwZ4tyYf
   A==;
X-CSE-ConnectionGUID: nNHpjQqWQqCdAm299LsPQA==
X-CSE-MsgGUID: lTh2XNRSRvKlrh3qJFN4rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="93888682"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="93888682"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:10:38 -0700
X-CSE-ConnectionGUID: Tjylh6dqRHWiHvkgMf3MBg==
X-CSE-MsgGUID: VdWKTO4/RbeLD8myL2Ikxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="256643782"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:10:34 -0700
Date: Tue, 30 Jun 2026 15:10:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Wil Stark <wil_stark@keysight.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: temperature: tmp117: add TI TMP119 support
Message-ID: <akOyN3-1YFxW2pME@ashevche-desk.local>
References: <20260630-tmp119-v3-0-cfdb50e2e99f@bootlin.com>
 <20260630-tmp119-v3-2-cfdb50e2e99f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-tmp119-v3-2-cfdb50e2e99f@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 30, 2026 at 11:26:35AM +0200, Romain Gantois wrote:

> Add support for the TMP119 temperature sensor, which has the same
> programming model as the TMP117.

Fine with me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


