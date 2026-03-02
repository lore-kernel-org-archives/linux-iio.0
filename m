Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3261B38CFEB;
	Mon,  2 Mar 2026 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442004; cv=none; b=tYA0zSd7PVSUXAsTnSzrtUX90t4Wzxm3bzOBxBQSTEBjtKyHe0wGa2Ero7oGT6ks+zDxU0fRCYa1Rlzmy+LEvMTFoTakrqL78TM6qo37JkZl77W5MwLA6rtmRv6aVO3r4Wl5zPjsgnYxH840RPYHxKffwHfTiWek5olzc64ytCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442004; c=relaxed/simple;
	bh=flwlcCVT4lNNPg9ZyMqaMoPNC6RYf7vdkppu1+vK674=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D61XkEG7j7WMPOy2QA6OdGqWtJ62fXTyN4v0cI26AOliuQ5sQwE8685BVvU80yFEfTHo8okvaxp7nXErMO73XZeUgxIjQhyM91Abbf2riMI9wGAKZlpZIdtMaTcxgl8a3EQBftGDFFm4WiY9ZU3b4YAfFaWJn2BcNHArvbylEwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jshWP0X5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jshWP0X5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772442003; x=1803978003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=flwlcCVT4lNNPg9ZyMqaMoPNC6RYf7vdkppu1+vK674=;
  b=jshWP0X5DQ26mNfcaUm2WA8UjRYN148RtD5uVQy3k1l4I7DCjdKcwlDI
   EDlz3FdRdNVDyfQzZ0J+8JlUHQ85663u09S9GNHfq5f/vczi6Uc697+b1
   KYOLVfvP9a5iCetxhPJzraGY2h708lBoV2zENKmHxhzfQ4+Y1UtEhMwVJ
   LDLsXbNIQ/2bc66/1t8HgbDWgm5lgvlCr4Yr3SSqh7gg17Vm/0fVmLpjx
   ifHei79BwmUXYOpluRyPp+Qaai6IWfsE12gQcOZ65Psh7O4NjurIjxKvQ
   xkNJgNhoJ9p/vu7yEPpn3+O1Ga4H5If7bsf1m7wfBBxeW0ctKTLLsSRrx
   g==;
X-CSE-ConnectionGUID: URcY8Oa5SGCWNUsuufbrEA==
X-CSE-MsgGUID: VMzxxAurQMSZr5DsQgzUBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="72644790"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="72644790"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:00:03 -0800
X-CSE-ConnectionGUID: hC9ZZNtVQIyagO2oPumBcw==
X-CSE-MsgGUID: FtDLpEptSu64n0caS/YBcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="240607165"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:00:01 -0800
Date: Mon, 2 Mar 2026 10:59:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: bno055: add explicit scan buf layout
Message-ID: <aaVRjr3ntMHYq-k9@ashevche-desk.local>
References: <20260228-iio-imu-bno055-repeated-element-v2-1-888676158804@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228-iio-imu-bno055-repeated-element-v2-1-888676158804@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 28, 2026 at 02:15:51PM -0600, David Lechner wrote:
> Move the scan buf.chans array into a union along with a struct that
> gives the layout of the buffer with all channels enabled.
> 
> Although not technically required in this case, if there had been a
> different number of items before the quaternion, there could have been
> a subtle bug with the special alignment needed for the quaternion
> channel data and the array would have been too small.

Cool thing!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


