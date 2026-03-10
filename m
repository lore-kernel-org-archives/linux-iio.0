Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2B3AA4ED
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161695; cv=none; b=HmpT5wXVCDWvokEjKx/Ztv2kdKbFnA1aRCybOzHf+8PEMoi6m1Oe3dimVo+kF3RMtbYRgEZWoxFYp0QTiPIINSsz2gIEWu0LjdYfTaoN2XD2RuG913mDtR+sqpuQA6i49HonHWKzqhYY9Q8ol0ky0JCUfWZb16YWxzhUyShm/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161695; c=relaxed/simple;
	bh=APrnzY5AZOY1gTSeHTWIYqXG9uSJKf4Yt05OXOzkd8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho4rmLWN275j7i9OhSUIW+TNF4Dug20xvicolDsYUzMAktKpck1khwR2De4MRtkpQGPSZv1cSyJq4wvaOPNSa5HMTynSCedhYoWPZZ1+Z5X4PEhcjBY+/qBsFQy8seZmdCVcejYJFIFfIr4AH0LR8NtST28RZcDLApf0SjMUydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzRi9H1r; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzRi9H1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773161694; x=1804697694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=APrnzY5AZOY1gTSeHTWIYqXG9uSJKf4Yt05OXOzkd8E=;
  b=YzRi9H1r3CneZ7sZEWqga2Q23AJPTvg7bLj5rc6IpWzW+gZZjchKgCS/
   W2EsFId1fw3OlGXPYDt1V6i3WRtCN4qLRaOUQLWYLrm7QV0tRsHSr6y9C
   7ri1Emwdbh5KVM/aAQLcpNGedEsupFhiwjZ4QBcqJtzNyuoa+tF0gsaHe
   Ak+UmPTGofO1EiCVQr3vkD4AeB3LxzjoElC3Tm6sr099Q2Ts+/VoMakJj
   +tCw3kQGPEXrmZQ2D2v1qfu68v1H0RDqxD95eBICSpmfjw0818Q9RfkJ7
   YJV+M5ATTUjmaNmyFuciNoyTnv43m1V6HbM/qEki0By4bUfmVRartMvWP
   Q==;
X-CSE-ConnectionGUID: uJ0t0tE7SNW7saI5qn+ejQ==
X-CSE-MsgGUID: Ev1GSJ5ERj6tbWo0d+Pdvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85307684"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85307684"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 09:54:54 -0700
X-CSE-ConnectionGUID: OW6jABP9QOaqz4QA/Wtrfw==
X-CSE-MsgGUID: oY6p+BLFQuq23Yb+O6bQqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="258100094"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 09:54:52 -0700
Date: Tue, 10 Mar 2026 18:54:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: ChenLei <feihuacheng@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: till.kamppeter@gmail.com, linux-iio@vger.kernel.org
Subject: Re: Request for guidance
Message-ID: <abBM2Zh8krbOcWqJ@ashevche-desk.local>
References: <aa_yTUNAmkOUnN7j@ashevche-desk.local>
 <20260310143742.57870-1-feihuacheng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310143742.57870-1-feihuacheng@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: IIO stakeholders

On Tue, Mar 10, 2026 at 02:37:42PM +0000, ChenLei wrote:
> >We are already in the relevant mailing list, so if ShiHao wants to work on IIO
> >drivers, welcome!
> 
> hello,Andy Shevchenko
> 
> My name is FeihuaCheng, and I am a graduate student in Control Engineering.
> I have been studying embedded Linux and Linux driver development.
> I saw the discussion about the AD39113 IIO driver and I am also very
> interested in contributing to its development.
> 
> Would it be possible for me to participate in this work as well? If so,
> I am available to start now and would appreciate any advice or guidance
> on how to get started.

-- 
With Best Regards,
Andy Shevchenko


