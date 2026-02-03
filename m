Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE4395261;
	Tue,  3 Feb 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132194; cv=none; b=qEiRg3GHhSKv75e70szY9DVvYkaWWmE1OyS/BMld78P2Nxk03l16PKUOKiJNEAuiEY+9CZe5AYQJ7Cef3pIUsLDlQ0WATPLlDgfOWcED3oWhMFezTX25a0Zn8/84PIpExjnwaFYMol/Sj2nNkf/Xtg3gvLKNcX2dT7sepzlDWHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132194; c=relaxed/simple;
	bh=NN5030PyaAstHhiq4FoPE4QAXLmF+c4x5MzkRqvoOR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E33kglnnGs4EFjMQr1JJDajQDtLXesXU7If1hlTTyjOF+Q3FV0E0wkie/ySbEGa6N6scaJ5/Qk82i5QDo9M0ZwdqA0f/8wfJXFflkuFez/rWON4svd/xhKhEPZvHTMn33VQ0RTTwSe2UrJyJ+BPMcpLPYJSlfRj28T0TFWXpi2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DaTarvfZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DaTarvfZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770132193; x=1801668193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NN5030PyaAstHhiq4FoPE4QAXLmF+c4x5MzkRqvoOR0=;
  b=DaTarvfZgASXwctyj7UCLT9DxTgjhFnEIrVcQ1WKchzE6lb9M+twxm9a
   6b8VBvsL8nC/yasVYF2paRSIw0SQbkCM6LCwmf1JOAqk5ctPW6Qyg+IzF
   5XXL1Z2eUaD/feveg2GEAG+CHdkDUWY83v66bP6VXMraMwjbbBmj0wriZ
   ZtZGyvZG6XMCWWhivs+ce4vRkjlTf7+IBbADrrViYfvTxbR/G7l1Z+sWb
   asOz+1TY9D8Kl+Ndf05ZXoNOBQHq6Yg1Cl6tucl+BRMVIzN8JW+UPHyfm
   V3tC4O8vLID/5tgp/ctw+jRb9DHU/oip67yXE/x65lAgcl/S+WJYMyp9U
   w==;
X-CSE-ConnectionGUID: 8+e1vyWkR9iS4Rzys7QeqA==
X-CSE-MsgGUID: XcLE2He1RHuFK7uOnXnjng==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71205236"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71205236"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:23:12 -0800
X-CSE-ConnectionGUID: K0IasoVSQSeosm4CZ8px6A==
X-CSE-MsgGUID: Hj+9GXA8QkqZMJbPVEFPpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209909451"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:23:09 -0800
Date: Tue, 3 Feb 2026 17:23:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Ijano <andrew.ijano@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH v3 next 6/6] iio: sca3000: use guard(mutex) to simplify
 return paths
Message-ID: <aYIS2oRIw9jXMB_r@smile.fi.intel.com>
References: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
 <20260203122109.689669-7-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203122109.689669-7-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 04:20:50AM -0800, Harshit Mogalapalli wrote:
> Switch sca3000_stop_all_interrupts() to use guard(mutex) to simplify the
> error paths without needing a goto.

...

> -	if (ret)

> +	if (!ret)

Leave the standard pattern to check for errors first.

-- 
With Best Regards,
Andy Shevchenko


