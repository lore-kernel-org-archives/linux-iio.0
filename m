Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1DC3603D3;
	Wed,  1 Jul 2026 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920739; cv=none; b=V3nm8FPCPMAAEbCHOKUKzGcbq58Plo7Tf86bzzGz4td7K7dxKz3zVib8+g4sxjyBZoZSH+Wiwfn4UgrB33OFtnmCUmJC2OrenXlcrXtOrk1uW40bVpbxU1/2yaZYXFR72M1TGyoVRPToebWU3eGdq5lBmNkrv2g5UoIp5GP5Bps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920739; c=relaxed/simple;
	bh=UJE+JWORWU5d8lD5bqAZvMqSL6QYVgXsNgg9KIlzTwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6UcpSkZxBg3IxFJ/qhNU08BslRBHR2Ra9GLKbCAbz3JILSiARSmMmErclOH22Nm7dTyzTlyiN//PgbdiMtnq+rRXmMp9c5PfVUGuhxMpJjGUjOGWpb7zppJtyXPTx+i7o1h208O8whKGvdA0bDizLqunAOnaX3sPG6eXJN/SXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/C0Mqxy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/C0Mqxy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782920738; x=1814456738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UJE+JWORWU5d8lD5bqAZvMqSL6QYVgXsNgg9KIlzTwE=;
  b=a/C0Mqxyh1tmQdWGr/b2Il0xuHWoVt2ExbGrq7HbKLQNaT7ijlAWzgnl
   Ov3diPpLd+22I4S0qj/31ZStxPedp76bZa1P7X4HrK4vM0MFTvyOq6QTM
   PaSdKiVhTHgdYHe0qB7jS79pKKyLdN8QrnwbEJDSxci1bz0PAkT+09hli
   MtgGCBOWoMH9khreCLpN1J0QrbiUMWgL1YdBDopjLSbSJC4gilL1u6HV1
   +VhrwX4QmAFZL80eGB89Ea0m+LOwu8HNV9jauv7kNVrXdv1vESt4i/SnN
   eumtf6C6p/ZNm5dHhREACC6UCtJ1qQPubF1eAVeuG4DnZKJrNFtJBuPUC
   A==;
X-CSE-ConnectionGUID: ROshe08YTGGBPgSjzvERfA==
X-CSE-MsgGUID: nxUSkpteQkyCJDVcCgNmag==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="94810540"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="94810540"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 08:45:37 -0700
X-CSE-ConnectionGUID: zhpxIMkQQxKEnrJEnrhaaw==
X-CSE-MsgGUID: tOI6lAr1QQq8Uxov10VtmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="290718023"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 08:45:35 -0700
Date: Wed, 1 Jul 2026 18:45:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Anas Khan <anxkhn28@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis16480: fix 'temprature' typo in comment
Message-ID: <akU2HEdjH1zsRjrQ@ashevche-desk.local>
References: <20260701152054.22748-1-anxkhn28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701152054.22748-1-anxkhn28@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 01, 2026 at 08:50:54PM +0530, Anas Khan wrote:
> Correct the spelling of "temperature" in the comment.

While this is good change, can you check the whole folder iio/imu for typos?
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


