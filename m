Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB7367286;
	Tue,  2 Jun 2026 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397014; cv=none; b=bFdc+nU6VzqDu6Q1yshR1FBl9j1XwcGomat2wyJAb5VBC/iZpNYIMcV0FgCw/W7L7MIpZ6E8fv0qxBVdo6rIiXzaAkiOOC1n9xTLlj6RKQtlqK9+oOKlo9/E34Ni+9ksCSAHlX/opos2cF5C37xWBbhL05cVzYsjHCmni+i1/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397014; c=relaxed/simple;
	bh=YRWTi4xRvzepkWPCxMmpszWNsFE8440j8WHQjY9EUNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji4OvHp2jkYMyMGjPEzrzK1/bYczfmZHyqfdp0fBtGdviMjZXBgjrWWW6Xh63niNxsirtgdYEsgBFwMk6VwWHZiU/+wPtWLzWSWGfitrMasiTj16zoun8s6O07mCt/uVSSndRXY3Iv0jN/yh/HWF2hwCkeyM49b1qzMx32m7D2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SScZuYcT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SScZuYcT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780397013; x=1811933013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YRWTi4xRvzepkWPCxMmpszWNsFE8440j8WHQjY9EUNM=;
  b=SScZuYcTh96j4m/MzNX6nzXrGboEehFjtyVozQKqDwKpWWZiZCREhsLH
   Xt5SujS/jZUz7U0ADJrzDwM0qMxd0SKpZgYHwuIX58MPBENwWO5RRDqCw
   nUxTtV6kO8gRGBnkXeaDveCchtgTMKd9/m7CmuY0AMIatKRvYFwhkW8aC
   KhqEIV5Yh7AgAeyQs2nvOfGLGYitf9sm5WWOQRMEwdpFR5c12WB+HeryG
   cyXmctlRGNlmWFZVvx48zUKXvLX6MCxbbT7nCIfZOwkDUatoYRi8JBUJ3
   N+/zLIz5rtsPTc23FAAJ+gaY4AgCBfzhyq7WNQZXNFw0yYsQFNf+PRgWj
   g==;
X-CSE-ConnectionGUID: +NXuK3TNQp2ftpAMCtf69g==
X-CSE-MsgGUID: XSSzNjZET3W5gRJrT3lN2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81079366"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81079366"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:43:32 -0700
X-CSE-ConnectionGUID: 28XAJnLFQCaC+L4MZ9H+vw==
X-CSE-MsgGUID: bQgrOIwpTc664lUVSqB5zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="239432562"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:43:29 -0700
Date: Tue, 2 Jun 2026 13:43:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/8] iio: light: opt3001: use local struct device and
 i2c_client variables
Message-ID: <ah6zz6AtxKmyFibn@ashevche-desk.local>
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
 <20260525-opt3001-cleanup-v4-2-65b36a174f78@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-opt3001-cleanup-v4-2-65b36a174f78@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 25, 2026 at 10:20:16AM +0200, Joshua Crofts via B4 Relay wrote:
> 
> Switch the driver to use local variables for struct device and struct
> i2c_client and remove struct device member from struct opt3001, as the
> former can be derived from struct client.
> 
> While at it, ensure that parentheses alignment is correct in functions
> that were changed in this patch.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


