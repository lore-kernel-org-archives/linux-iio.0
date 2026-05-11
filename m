Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309CC6FC5;
	Mon, 11 May 2026 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512101; cv=none; b=QmzBMVeFghT5fBm/zupP8qZAYVzedQvIwIgaDnvSuAtIG8LkOWby2xg+klcK5AMYSoNNgjYDahjDFbjQtHNwqTPkPY7SA6i+Qm+rnOECbF5pAcmeygilItd1c0OCOqMZFM5W2ILvcvuVdZy1qNbHg7/6vtSeMinz/T4oLPR8AeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512101; c=relaxed/simple;
	bh=XrJiy4Of5x6PwOlrooRvt5BslKJ9N+GSCRrhYCp7sOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6M4oej8EwXHU4LkL5w/D4B5SL8E4MNJXVzBzJboIPTBg4Lj+wMqPk4+t3Cr8asIVyL25RhxoMyk2xpqHXUEhD8W9vtBNCYUC1RMBdcwS9i3AcV/EQAMer6irXKJogpKzDvrF1DuCOeelFz3FuuZlGVGoMgeM+cWL99ow2baM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgdH2N5W; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgdH2N5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778512100; x=1810048100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XrJiy4Of5x6PwOlrooRvt5BslKJ9N+GSCRrhYCp7sOE=;
  b=jgdH2N5WzHZ7EGwVTj6zukI8Sz5iV/bUuJbcNKBGR664qDOu/2LHH6QF
   Wq37g8Q6XWY7uxNpXEEkUuG1s00jr3gwjQ/IsEyP4ZRApctODQ4lI8i4Y
   RRb8lBvLSb22wkZ0SOeVtcPDC9HbhXpGIIiwoRFYs+4dvfo+tFnp4POUX
   6bL5lGxjTOGtGNPWdWHhvUnS15nvubiuq3+jeOi4+mTgjmTOKp+h/X4SV
   Y3HyIlKoyEy+bKhU29FFL9kHr5kHbApr00LFJzWNT3stYD0HR6yCEXvu1
   tD9aHHHP/+onfSOEFfTQ+V08z332LN/GEP9LptQWNhax+0j9jMcZMyL+L
   g==;
X-CSE-ConnectionGUID: Bux0utzESmKugNGpglo/pQ==
X-CSE-MsgGUID: Xy22KwZOTtWsborytpO8FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83272556"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83272556"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 08:08:19 -0700
X-CSE-ConnectionGUID: 6CfwrRK1RPCo3crw4vnPxQ==
X-CSE-MsgGUID: m6OB2HxjQKK4nvQJfvOX2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="242441545"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 08:05:38 -0700
Date: Mon, 11 May 2026 18:05:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com,
	joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: iio-trig-interrupt: use devm_* helpers
Message-ID: <agHwQAn3iq7L7eF8@ashevche-desk.local>
References: <20260511060732.7728-1-sozdayvek@gmail.com>
 <20260511063229.1433-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511063229.1433-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 11:32:29AM +0500, Stepan Ionichev wrote:
> Convert to devm_iio_trigger_alloc(), devm_request_irq() and
> devm_iio_trigger_register(). The driver-managed lifecycle removes
> the manual error-cleanup ladder in probe and the entire .remove()
> callback.
> 
> Drop the now-unused iio_interrupt_trigger_info structure: its
> only purpose was to hold the IRQ number for the manual free_irq()
> call in .remove(), which is no longer needed. The matching
> linux/slab.h include is also dropped.

...

> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
> v2:
> - Drop the dev_err() call after devm_request_irq(); really_probe()
>   in the driver core already logs probe failures, so the message
>   would be duplicate (per Andy)

FWIW, it's IRQ core (not driver core!) that does printing.

> - Use a local struct device *dev = &pdev->dev (per Joshua)
> - Drop the "No functional change" claim from the commit message;
>   the resource lifecycle model changes (per Joshua)
> - Use .remove() function notation in the commit message (per Andy)

-- 
With Best Regards,
Andy Shevchenko


