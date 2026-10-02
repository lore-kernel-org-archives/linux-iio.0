Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A7ADF59;
	Fri,  2 Oct 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928062; cv=none; b=Hle8y1Zvy2oh8+Bxawkao5qmuIgBgeYG29L4L+zSpLFVgAnbmiMF7fDuHiBY6F4aDGcttC2qDamZF6eoYVjL/YkKy7pmfJ8g69aPCV1PdkOvWNDZUUlK0wpArx7UQtCM4fxe6bqG312wgXIzR36lX0yLsPrOpwyNEZjTuX3Fh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928062; c=relaxed/simple;
	bh=/xWJpEeJD5AJW9yH/EyOrkr7+kDg5DrQbP93o7p6wFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge4FJ9dOY2OqnLhlqTPvFtcJonB9yzZxaVDSAV2+9w1vvdmVaAa+pIxvMaaSz4smpvEybRUCiDwht9FLxeaANQwLTcOawYjAC+NB3ApWjri1P7DupOL90C1FLiZG+KPrNu+GL9CujcW9di3zHT72aWZw45tI7rI0Q769rCt8Y6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmfQKwno; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmfQKwno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790928061; x=1822464061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/xWJpEeJD5AJW9yH/EyOrkr7+kDg5DrQbP93o7p6wFo=;
  b=kmfQKwnoN/k5urfHn32wg5lnselEAMaVloffvInR95/OldFwXJ3IvS6B
   2MuuHOvuVmGanPIPCz27+Zb5UDjogaB+YWMihJZvuVhz6OGggGCJOazbl
   E/dEC493ZwtvPTC+CXjY5eTqsFz/j3W/bLENPBw7Ey1X/gXQHpDFCB6DM
   Z735Z4bcr05WYvpsHt+6dhoXnHcYfOINy9KDQNZ1hE8AaKFp+nMl3uTl+
   MMWSMtm1RuiUm0sLqWLFS0k0KhCETjVXC4RXVs0TWqO0YwofmS4jFUA4A
   ZHgSagdgs0FhePvsEIZ5i2H28s5D/UsLopJsuSlDu8zdL8Z/U5M49CDYf
   Q==;
X-CSE-ConnectionGUID: +CPnOfUvRHWoFuuFHFn7rQ==
X-CSE-MsgGUID: 2MITto9LRu+BKKw+NwTMrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="109179215"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="109179215"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 01:01:00 -0700
X-CSE-ConnectionGUID: dQZU25YVTo+VvkkW3QgIww==
X-CSE-MsgGUID: 20r7/UEIQb6U2JmGcVj8Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="229607"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 01:00:58 -0700
Date: Fri, 2 Oct 2026 11:00:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 3/3] iio: core: use kstrtodec64() to parse
 fixed-point values
Message-ID: <ar9kuHwnTM8jdkqR@ashevche-desk.local>
References: <20261001-e-notation-v1-0-75187bf06c10@analog.com>
 <20261001-e-notation-v1-3-75187bf06c10@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-e-notation-v1-3-75187bf06c10@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 12:34:58PM -0300, Rodrigo Alencar via B4 Relay wrote:

...

> +	/* fract_mult = 10^n, so ffs(10^n) = ffs(2^n * 5^n) = n + 1 */
> +	unsigned int scale = ffs(fract_mult);

Hmm... It's not obvious. Maybe you want to use int_log() instead?

-- 
With Best Regards,
Andy Shevchenko


