Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286930B50A;
	Wed,  6 May 2026 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049246; cv=none; b=E0Mf+U7xjwxG9UHJrxQWS80zF96Q6ElVt4dMRcgbIYG5/wwViGOTIsDvsSEe/k6ZstWk+WctVFJxQMGK3MN8diMMcvK2mwPnHui9jlju7lyZ2TsaIVz/Gsio8NN3+9sfqBPD54nUWlnUK8bFeZz+EjTBHXLhOTAGGkZCfrUGY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049246; c=relaxed/simple;
	bh=q8nWgKtXBvx/mfIZ9bFG+C2AmxuxICqBZOOjbgMbssk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCMc9jg96ZR8trmfw1SlmoS7YSW4pr7mHUOFbbJp8VKQ1K8aH/5unExnIp5BeUxGQkfnvTs+hwPa1pn5OJ29p/CYDNNK7X0hR0JtJJMeNwuhPs+nVcbPe5p54JtbHtHnQXbkmPQv1c3zhWJvV41LPx0ulSIz1lsKR/ujtN7ktfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPJpzAii; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPJpzAii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778049244; x=1809585244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q8nWgKtXBvx/mfIZ9bFG+C2AmxuxICqBZOOjbgMbssk=;
  b=aPJpzAii+jrNG3aampSaZZ8tmJiNnB5+OswPyrXSUlmmUjEpD4nMMJuU
   wPoIbuSr6f+ygdV6EQ1oYd4Z6iAPpuJJeIrAf89rJKzrQKAxrqIyynttf
   WX7ZvvULnIY+LO4KAG/wudOgvBATwIzJ2Lph4J08thzo8q7U4N17TkffO
   jBrqQ0Si1z7VAyWlQwUK7MjFP+uLIZuIY8CYXyhon/T0Mf1eBrzgkqsHc
   fnKfQ9ilXvMsP7Bm126O4uLR8bZAAA8MprtpLEgrmE6S8Pi0zXbCkWUC9
   TbqWDPspIV8aM3oNoksQv7ekkNYYhWBFGBYWNJvcfOdxH9QGD7LJTIb2q
   w==;
X-CSE-ConnectionGUID: Hzj5ioBEROiYoreg9c36PQ==
X-CSE-MsgGUID: WqofcrUkSEiBdZL43o+9rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="66476269"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="66476269"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:31:01 -0700
X-CSE-ConnectionGUID: AO0yb5IuRkCWvQvLUW+7bQ==
X-CSE-MsgGUID: KjN5eBzZRBONM2tXEn3xog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="237832152"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:30:59 -0700
Date: Wed, 6 May 2026 09:30:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/18] iio: magnetometer: ak8975: change 'u8*' to 'u8
 *' in cast
Message-ID: <afrgHtgLZMEDT1j1@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-4-831b9b5550fc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-magnetometer-fixes-v5-4-831b9b5550fc@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 01:46:00PM +0200, Joshua Crofts via B4 Relay wrote:

> Change 'u8*' cast to 'u8 *' as the former triggers a checkpatch error.
> Also fix the indentation of parameters in
> i2c_smbus_read_i2c_block_data_or_emulated() function.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


