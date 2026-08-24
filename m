Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4393AAF7A;
	Mon, 24 Aug 2026 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560181; cv=none; b=CoZcTt+ejDoQa0Y/TL40s420acZ8o3iXJiZezxkJ4Ux5Bio+7l7Ca5iwqsqgu0ArxrFsuHPVuCFJdQoI1MhMagzOlzv4TQKnTAAiui1RQtXvHUgbWjgMURy4vTAUMEDIoK19zHxlymo6CBeb+Lx5t5CGcNN2ef5fQjliEDgAt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560181; c=relaxed/simple;
	bh=VppoN4a/N2pQKyEWXBcqbkSC7iG/3u4igmX7UfMxAjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELlMJ3SfwFBkkBBQ5Rzomdp6UzbXYSMne/jfBT7b0Qgo0PD6leW3gIzgzQgy6sFej4IRwk6n7zywWJ10Fsnfvjh0vNHh2xrlsLK46//1tSARPN3aoKVbY25dh33CXrw/gs3zpLrTyO/hSiVFut+EcNNwUCHn9MLwYYauN6YzjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXe7mfLe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXe7mfLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560178; x=1819096178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VppoN4a/N2pQKyEWXBcqbkSC7iG/3u4igmX7UfMxAjE=;
  b=jXe7mfLefsOU0hqRYJJxACRxFVxWGiggO9eYn6iyTRudkU3ZkwfnnHAs
   afQRJQoY0z72BVrIVtkqPiX65EB/ihCem86bT2tam//GVFPqzaH64VlZr
   vQHIkPKmMqge5hJvC+gt9B61oI0IVzxEmOTtDCIanGqI8IagjYOrN5Xdc
   WkyhyNFB6o1NpUYxy1YuIt08RGZuGsshaFxA6XouPOZub6X2DbLUiH6za
   knTzgBtGjxutCpnf5s54pSOPhsCmV1XvG5u56to2V4Vl+Khkhtvi0Y8Yr
   ShkCPCWJWmNz0DLiFUGMBvjhxPuQSPflIqiVytkACwWXQIYC84TB1LPLK
   Q==;
X-CSE-ConnectionGUID: 0ZGo+ZMpQ2+ysfwfcf/iNw==
X-CSE-MsgGUID: 3HBSKCBcT5q0BVcHtpDxXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88024372"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88024372"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:29:34 -0700
X-CSE-ConnectionGUID: 9hzQGmujTm66zrDOYrGpRA==
X-CSE-MsgGUID: M48RuCIHR8aH9QC4c27SaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="305139704"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:29:32 -0700
Date: Mon, 24 Aug 2026 11:29:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arka Mondal <arkamondalofficial@gmail.com>, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, venkat.prashanth2498@gmail.com,
	rohitsarkar5398@gmail.com, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: adis16400: fix unprotected debugfs reads
Message-ID: <aowA6WnmgpZwdl6z@ashevche-desk.local>
References: <20260814090728.965922-1-arkamondalofficial@gmail.com>
 <20260814090728.965922-2-arkamondalofficial@gmail.com>
 <aoAmduhNrHoJdmn7@ashevche-desk.local>
 <20260822223753.21b1b417@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822223753.21b1b417@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 22, 2026 at 10:37:53PM +0100, Jonathan Cameron wrote:
> On Sat, 15 Aug 2026 11:42:30 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Fri, Aug 14, 2026 at 06:07:27PM +0900, Arka Mondal wrote:
> > > The serial_number file operations are open coded and never call
> > > debugfs_file_get(), which debugfs_create_file_unsafe() requires.
> > > debugfs_remove_recursive() therefore does not wait for a read in
> > > progress, and unbind frees the iio_dev underneath it.
> > > 
> > > Use debugfs_create_file() instead.  
> > 
> > Have you read the code? Have you read the commit message of the "culprit"
> > commit?
> > 
> > NAK. Please, revisit all your patches and be careful next time.
> > 
> FWIW it is curious that the original patch didn't touch the serial number
> declaration whilst touching the other two.  Superficially that looks
> like an omission we missed in review.

I see, yes, it some strange case of missing piece during review.

-- 
With Best Regards,
Andy Shevchenko


