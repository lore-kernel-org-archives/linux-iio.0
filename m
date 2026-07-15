Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502383314C3;
	Wed, 15 Jul 2026 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123736; cv=none; b=Wqwr6sZxu8YVpzB98mlfEHPG0pS4XB2NUOfF8TYpX4ask8ifYjhq34Frc/FsDOY+hHeq1zEABxuRa+VicRH9K8vsV1K6mI5NB1ddMfqY+rWh2+uIpm59KcjlKVrEEdNegiDe0a/207gl9fkMi9oEAItMhBymfLP3xf8GPM5+ZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123736; c=relaxed/simple;
	bh=QlUlmUTsTmJ/wVvbBaF5yPR3WgxqqxzU/dW9qLj2U44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsJwO4/nAj1HYF0ZT20x+RFzulLJaX1EoIJQpZPp4XtNYdwab6Ux1fI8GuS1Zo9nBkIUxeGYXQT+UyxbILWOwJ9fYXivhM5mNo4Db7YT/4hn7tT5vw7Qv6rL5BvS07BNlH/lqXcJC7Cjl4dRE4qU/5889Ozga/ZPVqrhaxd/QJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E74PtaOW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E74PtaOW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784123736; x=1815659736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QlUlmUTsTmJ/wVvbBaF5yPR3WgxqqxzU/dW9qLj2U44=;
  b=E74PtaOWcmSYU7Ok+KpGriALI21wrcC7tGVFzrmDd4Xsk5xkW1U9jWu3
   s/YJVO47p/A5moE/EK+kKbDr7BhhYuCMF5ZHAc4HjXGrRN6gIH7muQCAC
   7CLD+aj6Msxupyqx76Jv5TLjY7iOFWJowh3fCmr/JndC4jfVIvsdC0qEE
   k9imib087XAiwkoOuRc92Yq13SOq0Ow1cl3M30pP92Pf8rVU0BilzzlKu
   FWASHBFsxmG2OtNUjO2VsusJEw9TcPPUy/SuwpXpaAV/WaUNuk9hQ7GDa
   Uf+Y2kWkYVce5abFLL2jiJKByPcQEmP7tyL+EKYI+VIJC5K3VIJ6ns8ft
   A==;
X-CSE-ConnectionGUID: cQS3PAU0TtOWqxSXMrt0fw==
X-CSE-MsgGUID: IQEJGKn7RjKoAsBGsezqtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88438162"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="88438162"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 06:55:35 -0700
X-CSE-ConnectionGUID: hcXWkCx7SjWD8VR4CPyriQ==
X-CSE-MsgGUID: vGbMvvVBTjiIb4LLfxdIiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="258144643"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 06:55:31 -0700
Date: Wed, 15 Jul 2026 16:55:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] io: accel: mma8452: Allow open drain interrupt
 pin configuration
Message-ID: <aleRUWg9MZWgXMVs@ashevche-desk.local>
References: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 02:33:26PM +0200, Esben Haabendal wrote:
> Extend the mma8452 driver with support for configuration of the
> interrupt line in open-drain mode, which is needed for hardware designs
> where the interrupt line is shared with other chips.
> 
> Adding drive-open-drain property to mma8452 device-tree node for such
> designs to enable switching pin configuration to open-drain mode.

NAK.

Please, do not send a new version until everything is settled down in the
previous round. Let's continue discussion in v1.

-- 
With Best Regards,
Andy Shevchenko


