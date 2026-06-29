Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FEB379C26
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753809; cv=none; b=X9lUUHSQdKBmUuclfX4Y8sDdeidP5XAxd7E60GrMYkhy8wfx0IKO3Ahz6A3QiYU4M6wsYCGX1NMoxFywYtQx2cJazuofAr1ncXa/Zx9t4jdqq6tlKnrzm8zCItsqJ3fQ4Vz5lfjhHZbZESLAxNs1d9bI/EW8ASr1EH1+IdmRbB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753809; c=relaxed/simple;
	bh=wLogVLxxVch8Fkbii3b/mYIoiPa/KTD4atZpaQicUN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nubap1GMnFSKlkpTapyg2BatlPLUhiRaq5FMuQ1/Q/3i/8LAly5MDihT53BdHT7Fh+w0fLHKwQSEQW1f5oTtcLHXaAVfXUwZfEhgDndBmExmg6RkroYDjF7eGtpVqrOPveI9G6iSyJq8wB2mausgZZZC8h4dNJ9ikAZ/yYGuJ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L00WSB9V; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L00WSB9V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782753809; x=1814289809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wLogVLxxVch8Fkbii3b/mYIoiPa/KTD4atZpaQicUN4=;
  b=L00WSB9V4Exun8049Sr9FNvGeGHzq/2U0XQh4AaUSmyUzi4t81CQvPE5
   xrCTIrvOp27PJuRdYFyn5X0Umbeh590zLo+4PSQnt0n1PLYY1uw2g/JK9
   +eioT/WW/DW8F9j52VdjsMUcJ33BypOOz4FUDUHkSTP3AIMLhPG5xWcmw
   QJ0ZaTWx5yCCJVSmV0JLdjPPRobVQ2FLKQXef33LYWub4eASTGS+TN5pm
   cgDQpxsLJE44OuwIhD6Kem5ao/al4mHuwhqYQQ0fRyCUCK+mCGXNh7cTA
   vn/HgSqB1QTUungaEYCmZhQEYPc08tblqiSVmrL3B5Bx+8BwR2ogztvNx
   w==;
X-CSE-ConnectionGUID: kWCJGHE6TduUMr8W96Npqg==
X-CSE-MsgGUID: Y6ex1ljXSHuYbNLR0buoeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83227466"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83227466"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:23:28 -0700
X-CSE-ConnectionGUID: LmVu6TgHTxKqIz04M+BdgA==
X-CSE-MsgGUID: 6Jv4FLq3RS6eKtRYbkH68g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="253925575"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:23:26 -0700
Date: Mon, 29 Jun 2026 20:23:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 0/3] iio: dac: m62332: header cleanup and guard(mutex)
Message-ID: <akKqDEjzUV5CIqpF@ashevche-desk.local>
References: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 28, 2026 at 12:48:08AM -0300, Erick Henrique wrote:
> This series cleans up the m62332 header includes and converts its locking
> to guard(mutex).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


