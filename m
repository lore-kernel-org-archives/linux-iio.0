Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FFB3F413C;
	Wed, 13 May 2026 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679337; cv=none; b=LXZithycURrJZAFGWalBXid1Ymn0vjaEqcMEovN97mmcSSIVSagJBI/TjNPwOGWZ3KCw+f5a9ov2fFFPMo5NonoWVamkorFdDkRXE+wEaJNOZ7THW1HGnmvsoWywNC51gjhULs+lQDLWyAKiIa7klXGv0mWWcKMWlFWmdNbjXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679337; c=relaxed/simple;
	bh=m9bnNBxEWAPGWVDQW/6kO/Q86jZja45Wm51skwSpr54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiikHDBNyMBfxYQOLgTWreVnIx2PYDG7ZRPu1MzOYfDQBTOhKEXINVRKiS3lZWlpMTZQCdpHj/w8nHkxY3VKkEEXFKWpzkwjBpuYXeR8zJl6p0R7vn8Sz5zHTy6RlffaQQVwrCjys9yqBbOYiSeMeS5R6RoK6YFGicIBtK0kjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eARA8XBF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eARA8XBF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778679335; x=1810215335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m9bnNBxEWAPGWVDQW/6kO/Q86jZja45Wm51skwSpr54=;
  b=eARA8XBFb5kER+Qo6Ygg+fR2ZDiRqGOug7i1+IiFkb0ClfnbeQyWv9U0
   fEgj6DxAp7/jTidkqDg8qbh+ENNdXNdfkwgjDFAmfjfpLAcfGQv2FCz4Z
   E/z2rAAgXIngzs+Vkg5ph8un4k7fOhyrXhbf1Y2aKiGV3bpTW0PzrHojm
   J50GRjeJOPLof5SlvxcJHqoGUPpcKXuMAcY8O+JvRI29Yp3TVICByHHVU
   BC7Y6Lf3JR6xJOcMdlSbN07MvzjsjAzP0t2cPWX8SnPAM9dh9AiSI9Dx5
   3w0fglmrBQVFpBM7Y4Do3Jwkubv8CLT2iyka/RtGSg+MabCFHKaRS7PmI
   w==;
X-CSE-ConnectionGUID: KUlewN42TtKi8Y6b6o1yIA==
X-CSE-MsgGUID: O1jtZmruTYqZL5ubeZK5bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="78633488"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="78633488"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 06:35:35 -0700
X-CSE-ConnectionGUID: p8FjQ+m5Q7GmcXRrz0mcAQ==
X-CSE-MsgGUID: csouucPvSQKVloD07jTm1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="233820929"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 06:35:32 -0700
Date: Wed, 13 May 2026 16:35:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	alisa.roman@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7192: fix GPOCON register access annotation
Message-ID: <agR-Is0LLtfvhUne@ashevche-desk.local>
References: <20260513101332.8699-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513101332.8699-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 03:13:32PM +0500, Stepan Ionichev wrote:
> The comment next to AD7192_REG_GPOCON marks the register as RO,
> but the AD7192 datasheet (Rev. A, page 24, GPOCON REGISTER) says:
> "The GPOCON register is an 8-bit register from which data can be
> read or to which data can be written."
> 
> The driver itself uses ad_sd_write_reg() against this register in
> ad7192_show_scale() / write paths to control the bridge power-down
> switch and digital outputs, which matches the RW datasheet
> description. Update the comment to RW so it does not mislead
> future readers.

Makes sense,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


