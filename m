Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E8384252;
	Fri, 13 Mar 2026 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394916; cv=none; b=PPGeaw/nTmXAA6av1OVkQQJN5eFB8tZaysSF1xVxj9fRQ+dHw9X39sAKV2KPY0MIuaMVukde/twGQr4JP8qKqZqqR6v8Rdl7wAK3BbJb0cJfiY6VpaKb3e+HCVEh7nloIdLnS60YszhCMVq1u2UqY2TcbHaEv9C7Ewlb22c246U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394916; c=relaxed/simple;
	bh=G5eSnV4Aejd+wy7lvfOOhso0bOBsSlAaBXNAxtnljHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPil7uas+lyrmVB0762EpyIFxGWYHNXM0FDU594AFe5m5Q5cTvEkJNvKEPj1++LHYZUQweYA2i6J79vBo7OY6MAc9GS2fYDf9NzfqDVa4LDqf9jnInUMK9hw8UH0RVz0g3uWf6/1e5eApPL1cNQVi5Dq2oMhVTGzETeXbw3xVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ea1TE9LB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ea1TE9LB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773394914; x=1804930914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G5eSnV4Aejd+wy7lvfOOhso0bOBsSlAaBXNAxtnljHU=;
  b=ea1TE9LBB1UoGb1bQq3NVIDo92cumGtiTnTpOyCEb0jm6m1iU++7hBbH
   zuUzLYXZ4CmnjzOFGk/3dBpYHgA1/5Vs3FK0w76KZIg6tHbNqoweR4tSq
   UTRprK8hGCBnDgLuGYq1LlRM0rfPK1yEJIXY6nkmbEXo7eupPRwnJ48GZ
   J9YZZvpOrwyfktB0v92GGyUA2ffXglJ6iNpqpvT+cb+8jHQWn56dp006W
   e5sU4ABfwFg1TaFFp0t6w46L025Fg8qVmW5MUkE5kTXevJecN4Xi5a5i/
   0bGwoL4EpfUpoddlqJCDQSwcVZMmetM3km44FJvs0DBrF2QUV7HOH2bQr
   Q==;
X-CSE-ConnectionGUID: HRKWqDAFRqe3RoVfEZZUhg==
X-CSE-MsgGUID: 2/MHK9CsSdGSUH63FFXOcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74688555"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74688555"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:41:54 -0700
X-CSE-ConnectionGUID: 5ko3woMYR3+/vpDH9P7qcw==
X-CSE-MsgGUID: oBRwA15vSw6oMC/AZvq5NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225237937"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:41:50 -0700
Date: Fri, 13 Mar 2026 11:41:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Mircea Caprioru <mircea.caprioru@analog.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl313: add missing error check in
 predisable
Message-ID: <abPb3N1wNUAa-R8x@ashevche-desk.local>
References: <20260312112025.57554-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312112025.57554-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 01:20:23PM +0200, Antoniu Miclaus wrote:
> Check the return value of the FIFO bypass regmap_write() before
> proceeding to disable interrupts.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


