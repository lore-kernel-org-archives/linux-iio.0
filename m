Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378163D5649;
	Tue,  5 May 2026 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972030; cv=none; b=V+0hUZOppdRjdd9dYask8rrb8fmLhLwRaL5KwuD8aFPRs/lnpCYWYAS3Je+7TcCr+DpIvAIquD8ptGqHZng7hGB8kko7Aa9DDiaUa3eyoiDtgGLDO52Sf3/zLGLPB0651qYcmZ8MTi0MEks7A7C2UDak1Yowy9AuEAqXS7+utow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972030; c=relaxed/simple;
	bh=75UBNf0LCH1rR0S0wDVkqPbmeYclbjMd9+E0Fabrsvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6j5O/Hthmp2+dh0Zx+R8LqHibRHv5eRF0JlQA2Ui8u87wHpJgeVtML6EwmDnAAl6zROnJjsf//1+W8pcIBOeqoyvqOmie4Yh1HyjIaENC0alXG6cO5Aush49CFDAQX8i9L7DxYtmLB3CoerioFpPacrvcMtaoKhaFB07MJWKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3BZBHCT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3BZBHCT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777972030; x=1809508030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=75UBNf0LCH1rR0S0wDVkqPbmeYclbjMd9+E0Fabrsvo=;
  b=a3BZBHCTLdZIbZAnWSgm6QZCgxLAVq6QqhPn5igHblbSX3c2/eZXSpfK
   KBXRMlA2K388B68PdnJ0gRv9yy8jw8UdmSY7XtaGxPmd28pvPu2aoXWlN
   SuUWJ/6l6OQKJTrfQnI7tbxDejb6QojMZ+rMm871FSEJlrTXOwt11wPRp
   l7aao3LI3OTcFbkEjrkIsbVSjtXHTCO16YE2QpyRAsU+gXyByHvIPF02l
   QpxHaT8WVZJTl7ixgt+s/6reHTN0zUet64fg7vRxg4QJlydwPTIKgVDq/
   kxjgN6895917YVK4EDTo7RTgVA8Bta1TgSx3PLug7bj2mPcihFWsJUZsm
   Q==;
X-CSE-ConnectionGUID: U9uMgSsbTemVrTzDbqQszg==
X-CSE-MsgGUID: xj0bma/pQPudFVUKUBUjDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78862257"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78862257"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 02:07:09 -0700
X-CSE-ConnectionGUID: VzepBk9pQuuERsx5NkQ7pg==
X-CSE-MsgGUID: YMpaSh6+RMmm1ghS3vquFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="240736592"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 02:07:06 -0700
Date: Tue, 5 May 2026 12:07:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: ens210: Fix missing I2C functionality
 checks
Message-ID: <afmzOM3s_TCYxXyt@ashevche-desk.local>
References: <20260505090247.74555-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505090247.74555-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 10:02:47AM +0100, Salah Triki wrote:
> The ENS210 driver uses both `i2c_smbus_read_byte_data()` and
> `i2c_smbus_read_word_data()` during the read and probe phases.
> However, `i2c_check_functionality()` was only checking for block reads
> and simple byte writes, which could lead to hardware interface
> incompatibilities or errors on certain adapters that do not natively
> support SMBus word or byte data transactions.
> 
> Add `I2C_FUNC_SMBUS_READ_BYTE_DATA` and `I2C_FUNC_SMBUS_READ_WORD_DATA`
> to the functionality check mask to ensure the adapter supports the
> required operations before communication begins.

Can we rather modify the driver to use SW emulation for these cases?

-- 
With Best Regards,
Andy Shevchenko


