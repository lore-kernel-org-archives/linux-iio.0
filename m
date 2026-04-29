Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50941E32D6
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492900; cv=none; b=F7oRis7J6SasSgW2u66F1WmzjVbFlV2rQZvLUjrbF5kcBM5NvvG+ukNAuHObHi0HvKSvlZKAvCODVTQF678U40GZVYKwLk2mgslPVNpdqr+WY/ez0DAj40Mo9WwHmI5EIQx38jwb0NCUzrFXYtSJdKVGmW6fuDbIuifTyCQus34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492900; c=relaxed/simple;
	bh=jbRy/J5qBxzCz9Y547K5TWc7oQNjP3P0wcoGXRnbBTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7X3fzW71HIoR5htWlBXXar5gu++CyNp/B16Oyg+oXVI0F/FXqyqyuABxWkY4SSq+lArjpqZNXZwfnVaa0/e+VOG7utGzCFGne16B8bPU1tNswhbTThOqMtUpSsPV1viLJhtrqDu5HvJHc/U2dLA8fsgZhycy0jwi8qfIgzEm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfYqRejT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfYqRejT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777492899; x=1809028899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jbRy/J5qBxzCz9Y547K5TWc7oQNjP3P0wcoGXRnbBTY=;
  b=mfYqRejTOu+iAH/6hWACwDL5TP7wVmfIjkI5ZiYxvpZzrUg4KXPyT5sC
   +GPkaRm1Jua+HXZHLFMtDGxQ0/qV1oSJO1h12jlYD4gGXCAurGhGnDOQ+
   3x6coAZffTg57f70akttny86q5wUp1lkRbtLZ0qxucjlC+vPDZqfW0V4R
   xT4LyKi9x7pU7WK2OhNvNkilzKP+maYDpOkYs/quPnl2hgyNz/8BJmqOZ
   Jm7OgAlmzYaKyxYYB/ldrJt0RWji8eu3Ff3+XTWax6YxGHdmmEwRiCqNF
   xJm1q+yr3sygpGuyqII5rThoBD+/WYYBJsnHK1ciL40CuwkQOl374FM7M
   Q==;
X-CSE-ConnectionGUID: o+IK4kn7QZmgzkKJzgZX8Q==
X-CSE-MsgGUID: JZ/ntg+3RRWikOvhXhYtfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78454121"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78454121"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 13:01:39 -0700
X-CSE-ConnectionGUID: piFRtkmaTjqhGA5GpdaJUw==
X-CSE-MsgGUID: 9IRbuxlMSjOvhDAq3aEt3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="233523895"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 13:01:37 -0700
Date: Wed, 29 Apr 2026 23:01:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pedro Barletta Gennari <pedro.pbg@usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	nuno.sa@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: light: iqs621-als: use lock guards and
 prefer early error handling
Message-ID: <afJjnq4z76XFaEBF@ashevche-desk.local>
References: <20260429013640.26870-1-pedro.pbg@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429013640.26870-1-pedro.pbg@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 10:29:53PM -0300, Pedro Barletta Gennari wrote:
> Use guard(mutex)() for handling mutex lock instead of manually
> locking and unlocking the mutex and flip 'if (!ret)' to 'if (ret)'
> to handle errors early in drivers/iio/light/iqs621-als.c
> 
> Patch 2 depends on patch 1

Both LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


