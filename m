Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C634BB26D;
	Mon, 12 Oct 2026 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837381; cv=none; b=sc/E9ZBBuQLjuXaNw5wVXiqdqKlAHhVKR/IcHE1mLx2ff4B2iEpRAMxRLvl9VRzNEHMxSYOsiAqZnlSugx+3RZYRyfXAJ9U+1imVGo7f0r69RA+xohP/kDmU2wjtmcm+5nml8GIXYLvqv49JZiWt9G1AmgEHW4a+hKwGPSNxCiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837381; c=relaxed/simple;
	bh=Za46AbOZV+xNrt9erVZQ4GAFMCLmVmdunsegG5jW5JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQq1tZcHfEEUGm8sBTnO0Li/aqQQHBW3zxtZSUCLdC7UP3dl1o9elGMe7bUnXH8ky1YFRrqFmv2iv9O0RK+Mvcq9t4GKSMhLDmI4ptfJglQgoJ0woOU7hj3HgRhcS3YM/9OB1OobTT/eq8XPCc6ebdVuR4RyKJ6B4SAt88Eps9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTUTNKIo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTUTNKIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791837379; x=1823373379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Za46AbOZV+xNrt9erVZQ4GAFMCLmVmdunsegG5jW5JM=;
  b=kTUTNKIoRFN7v/zH+2Iy9AfTN0a/VYJp9HKGoAfppjJCLMed/ThGlsVV
   +MSzkFtWVzyuaax4VBfckpNeWNreP2uvP/iU+07xfaQcejFU4ALs/0Sp6
   2jYXdGxgjn1wKSwc9EL/bFinHCYzqtozmai6q8BYBdm+oEzikryfw40V4
   q2PMHMyuduPHzqddMr4jUuOhWUGpKmIL49VYqZYp92wfiZSB+xvGFRNCI
   /aN6jzTCY58tH+X2UO/oIyIRg28fMaDu1mcemSp4KocTR+HeN+FnuuegL
   h7P+dJl2fdYOs29Ubs5Zjx1w2xRXXM0rrpJ/C0bcOilwdFtLwEyd6kTkL
   Q==;
X-CSE-ConnectionGUID: zQ2mUdSDSXqBkCBnIE9B0g==
X-CSE-MsgGUID: 6ygZ/XidQXiXI4D+bGqmKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="561088"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="561088"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:36:19 -0700
X-CSE-ConnectionGUID: 9d/e+t5zT6So82zxI7yuog==
X-CSE-MsgGUID: 4JiFh9SiQ2CP6NJ5GAT3NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="944587"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:36:17 -0700
Date: Mon, 12 Oct 2026 23:36:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Liu Yufei <lyf98405@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: proximity: Add driver for Vishay VCNL36829
Message-ID: <as1Evs8-uQAwGfaa@ashevche-desk.local>
References: <20261006100943.78971-1-lyf98405@gmail.com>
 <20261006100943.78971-3-lyf98405@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006100943.78971-3-lyf98405@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 06, 2026 at 06:09:43PM +0800, Liu Yufei wrote:

> Add an IIO driver for the Vishay VCNL36829 proximity sensor with
> integrated VCSEL, connected over I2C.
> 
> At probe the driver enables the vdd and vddio supplies, waits for the
> sensor to power up, checks the device ID, configures the VCSEL current
> and photodiodes, and turns the proximity engine on. The sensor is put
> back into shutdown when the device is removed.
> 
> The following attributes are exposed:
>   - in_proximity0_raw
>   - in_proximity_integration_time
>   - in_proximity_integration_time_available

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +static int vcnl36829_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan, int val,
> +			       int val2, long mask)

Please, wrap on a logical boundary:

			       struct iio_chan_spec const *chan,
			       int val, int val2, long mask)

-- 
With Best Regards,
Andy Shevchenko


