Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF23456E1C;
	Fri, 11 Sep 2026 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112757; cv=none; b=k0pxaaBmEc0Bb6FEiVOyRxV1vA2n6iTY9ZNvuJabWC5mAKf/pAis+5o4xLSPyKWui0pRCScdWD9eixOMlb+W/C9CeIuoKfUbotInzBFYQn3KW6VKFz4VamHj5dJsyz8/O1l+BTi9Yruujfzjt2i+PVyQ8Rzses4q2PHkrYInn1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112757; c=relaxed/simple;
	bh=P613Qqkim9tvF/YDkqzlliqzWipz8NQJSKUjolASpwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev7RDoSNc3WptDYTRF/g8Lqz6zIXThL80bfQlOn4X4Mpwfbp/SUk1UEjm14dC6vgGTqc4iCHoLTqxPc9Z+zAqiSY51nQ346xDUEEtl00H+GnoNeoR2hzOfw0TPj8zCVfqlsZE1aEnFpVIYokD2sQoBH0pLjzBpwc5ZKZzh6F3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0TlGE9e; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0TlGE9e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789112756; x=1820648756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P613Qqkim9tvF/YDkqzlliqzWipz8NQJSKUjolASpwk=;
  b=E0TlGE9ewCoetNG79Ulvg6ocO5dIBeATNtUraDYNn+obW8drK8hsIYPF
   hwSx3gy/M+qZrJBQnFvp3FJGNrbMZrQt7Jjs2LvTyP0BuotPLq5U3+9MF
   pdTwuW5k1Xf6ehd+cmmPgXnAp4p+go8rfwWVjqxYvu6O24ym9AM5jJVLC
   0b3U8PnIQmLtHjwRsNJD5LqWWXLHQhufsBRbwyLFaeFy6Ywc61MzNXo+S
   KBrK9AmReYkMWU5+fcZO05mHlPVw38dwADG09K+RL2UKoHUNvb0pwDO0Z
   YgZEu74PvMQddMo4vJmJ176zZzXb8ydQ0Sd/uBd12y1MLgp3qjx5Tt6pr
   w==;
X-CSE-ConnectionGUID: 0IGW2WqPQu2UyqU05JV5wQ==
X-CSE-MsgGUID: nMCU+pUuQem1bg6yFaW1pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="93440933"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="93440933"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 00:45:55 -0700
X-CSE-ConnectionGUID: tSCyyJeiTOqZcPiDZfekrA==
X-CSE-MsgGUID: lj9+AHTzS82HOYdYLsMCqQ==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 00:45:53 -0700
Date: Fri, 11 Sep 2026 10:45:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, andy@kernel.org,
	robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 0/2] Add support for Analog Devices MAX30210
Message-ID: <aqOxriLHqs7E6c2j@ashevche-desk.local>
References: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
 <cover.1789032019.git.johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789032019.git.johnerasmusmari.geronimo@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 06:12:15AM +0800, John Erasmus Mari Geronimo wrote:
> Add IIO support and device-tree bindings for the Analog Devices MAX30210
> low-power digital temperature sensor.

This doesn't explain why a brand new driver is required. We have already tons
of maxXXXX drivers in the same folder, do they not suit to host the support of
a new device?

> Changes since v2:
> - Fix FIFO byte-count handling and sample decoding.
> - Fix IIO debug register read/write access.
> - Validate event threshold values and sampling-frequency register values.
> - Return the correct sampling-frequency format and reject direct reads while
>   buffered capture is enabled.
> - Clean up the Kconfig entry and device-tree supply declaration.

Changelog would be good to have a link to the previous version on
lore.kernel.org.

-- 
With Best Regards,
Andy Shevchenko


