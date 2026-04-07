Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2215E3A5E82;
	Tue,  7 Apr 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571749; cv=none; b=VyOxjc/q9r+2Z1K7r5a2BPsxF+QWhLbP9T0uQt4tNaa2jK5Dtzn2QfzKJWaKulegtxMgSrRdEqwvQ75/XHr4bwAXFg6ptEijOlJjp3nctSuC71+sBWQRlIHbVDcLbnnzfnARvL44LHif6tF8yr9jA+OGH6QnGeVdYa5b9kaSuVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571749; c=relaxed/simple;
	bh=8sNRg7XUdo0qRFfRTqk3c5peTpEyAXoEefSE9dDLxjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3LAla66Q0IluFQ7HDhB+aNTkFXzaL0D2HLoP29kqP4fncqFYEYa4e7dEnxPz2WVLkkA7VuJmL2XwF9Zsqvq+/FXBjZKEgezZjXAgG+2tnis88vHHwgybEMM+rnpmKDOIcxZHc5FeeCxTtN5TTUwiypehr1KPBat2gb1WfBNGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d07TYz5P; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d07TYz5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775571748; x=1807107748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8sNRg7XUdo0qRFfRTqk3c5peTpEyAXoEefSE9dDLxjY=;
  b=d07TYz5PR31TE+J6bDKMDCHK6hjd0VwAJp1lVSLeA7PYROnlLu96tRTq
   WtsYN3ECGvdLrx4ufkoM2W3oU4T0RlXGwkfWw7zoqGhSRfSgp0IjTAfy/
   qS4j5v1X8o4/ifdcbEiT1XdBE9ieRtcjoMFhc4/Ha6cpqizutRDziLoQ2
   fkknUdePEFN3obtCNKNaOCCmRX1oH4PP8H2q9q/n1iemHv+FJMba7Qq0D
   1QURMz6byYTWrJ3qLhxSiPwQ+XwPqmcSguCImbvA7z8Jnrlz33z8hrPe0
   FQFPYBTy+GkurdfwYErTakQEVtoI/+UzG/I7WuTTkVFj0EuIWBGT//KTC
   A==;
X-CSE-ConnectionGUID: DfyulRmdRXuEKj6vtbH6Qg==
X-CSE-MsgGUID: kZuPQ2xlR3aK1thL6sE4BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87162378"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="87162378"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:22:27 -0700
X-CSE-ConnectionGUID: o/d/HHqsTqi2yjX5CV1tsg==
X-CSE-MsgGUID: TzpnxJGmQ1i1KosLEq41Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="225000394"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:22:24 -0700
Date: Tue, 7 Apr 2026 17:22:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, ktsai@capellamicro.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 0/2] iio: light: cm3323: fix and cleanup
Message-ID: <adUTHgDEQ22ff5yx@ashevche-desk.local>
References: <20260407070053.9359-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407070053.9359-1-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 07, 2026 at 09:00:51AM +0200, Aldo Conte wrote:
> Series fixes a bug and does a cleanup of the CM3323 
> color light sensor driver.
> 
> Patch 1 fixes data->reg_conf being incorrectly initialized with the 
> return value of the i2c_smbus_write_word_data() instead of the actual 	
> register value. Tested with i2c-stub on a Raspberri Pi 3B.

> Patch 2 converts dev_err() to dev_err_probe() in the probe path.

It's your responsibility to carry the given tags or explain why they weren't
taken into consideration.

-- 
With Best Regards,
Andy Shevchenko


