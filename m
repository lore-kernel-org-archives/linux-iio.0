Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0D272816;
	Fri, 23 Jan 2026 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179865; cv=none; b=E+jxrczKG2Y7ipNiUhuMWACbiEns9n+bnPffWthWLNDqG+XqUoCyCroD4q0D65xAAUD+dEa+INV1ZghyTplO/+L+/KH4dvukFex6g5NV4ygAW5Io3DJglVE0+eC6mi5h1g8EcZfBv87xz8V9YzYjlZkAX3mbOUIvm3YkoqkIPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179865; c=relaxed/simple;
	bh=Nkq1ssyoAUXiTJldlGQRhawsxqIkukgn5IWGdl3M+00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1CXy85Zfk86MnpPs8dvAK6gqnnzISrjC//CWWNMR8WZFe4bD/lniI85foNXk2H3o88FprxNT0JHZEVQgb3VPK/Pn8mDZy33W9E1+mWhjjEDEj5oVjLqmtPwCquACzDsAniP8qM7BwbEXVBMpyz3fP1aZosazGG+KcbJbltC9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+a3eRSX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+a3eRSX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769179864; x=1800715864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Nkq1ssyoAUXiTJldlGQRhawsxqIkukgn5IWGdl3M+00=;
  b=X+a3eRSX9ptEj/d9L6hQRNzZh349scM8kZlII5APHr8xuZvPyNZ2wCKA
   mRnDfGycQYs47piro1FubFaqjNhT7+tpWFWIBOLI7d+ybM2KdQrxrvs97
   jnvWw6Vbza+G7gOFWf4YHKnlLSLWaOECCdWIdtryJERMqbt/iU5lL1Afg
   pL0bdcQAG2i0wI3WrhryNU6zh4CKGXBEbcfO4lLmrhlIIJbOm8brgrqsp
   hVNSPE8z972tR289PyDc+DuDQleNEUhWFIipRKbUXOfOXTkpUosf8AlRz
   TRVUYiQ4t/t8aOFzCIp8lIzfBXChLRR0qvODOtY6aVLAmadV/7kEAB8yZ
   A==;
X-CSE-ConnectionGUID: az6JrvGmRpekHT5U1Teqig==
X-CSE-MsgGUID: NkP3E/qmS6iDDqo99TTqiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="87851052"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="87851052"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:51:03 -0800
X-CSE-ConnectionGUID: yQWCzWrnSWOBUuedVrKAng==
X-CSE-MsgGUID: mIKrBn/yQMi7uJB58kaOzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211544932"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:51:01 -0800
Date: Fri, 23 Jan 2026 16:50:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 19/21] iio: Use IRQF_NO_THREAD
Message-ID: <aXOK0vqIQbCAw7mx@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-20-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123113708.416727-20-bigeasy@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 12:37:05PM +0100, Sebastian Andrzej Siewior wrote:
> The interrupt handler iio_trigger_generic_data_rdy_poll() will invoke
> other interrupt handler and this supposed to happen from within the
> hardirq.
> 
> Use IRQF_NO_THREAD to forbid forced-threading.

...

> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: linux-iio@vger.kernel.org

Same comment about Cc list.

...

>  	ret = request_irq(st->i2c->irq,
>  			  &iio_trigger_generic_data_rdy_poll,
> -			  IRQF_TRIGGER_RISING,
> +			  IRQF_NO_THREAD | IRQF_TRIGGER_RISING,

Maybe swap their positions as it's done everywhere else for the consistency's
sake?

>  			  "itg3200_data_rdy",
>  			  st->trig);

-- 
With Best Regards,
Andy Shevchenko


