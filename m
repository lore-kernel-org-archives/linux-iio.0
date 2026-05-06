Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099953E276D;
	Wed,  6 May 2026 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056547; cv=none; b=kgJamgunxa3QxvtYKxTPkmbHlfn3J+3r1CmlArbqjWszW7sIobN1uzsBcDUkJtXqaYxm8w4jfAP0q7pDTBigiw5uPRh0vJpg6PErVLmvyOK6KGGVErizs3LTK9YubxmapUKSFBDVRA31JQ266fUCWVqlbTIfVUNaedPa8PDukyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056547; c=relaxed/simple;
	bh=92qkhIIrxQhUouJCspGQ47f3ZV9XiF6VStKB3T6Ej7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCsWrJ/xpQxpOsKs1+mEzQBJhBPc4ScpZaK5dDYU9801rilffysmkP+L8vY/nW1Nzk6mSeNmq7LxBpQhWurfpNlJAMZABjgeFMkQzi0Q6Ox8WdJHC3iZNIv2BD/0cB7OsKpCVNlRMm05GczFCzv/AJ8EHeNy30QqWbpVGTba0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ri6BWjmf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ri6BWjmf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778056546; x=1809592546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=92qkhIIrxQhUouJCspGQ47f3ZV9XiF6VStKB3T6Ej7I=;
  b=Ri6BWjmfiQIY5ejDOcAGD3itjgiphbiGcyrUCS+LLYx546yFALtx9Lqr
   N2EoGn+843Fj78py47jMbYJTrHXCWRh7B7jldqMMk3bqqwfgpER4BpJ/z
   JUr9+06Y3hTCchJM+pzLjiV0Gzc5U/HrgqjMXn8j6OILobrGnQt/WrqNk
   RN+9aXyeBxDCM7ZMkeifBTWsli7WRhaZJJ5kOzF23+t1v8bkYot2Fu9by
   Rlgb3VCaXIwB9zU8E/L8/h5U5olYweTLLPV/R1vRu1vNehBrD+y76j+al
   nyaYB9+KJfxKdFBrzUozLPEg3tmSMoXaSX++3AvctW254SuNmQmIB6DaY
   A==;
X-CSE-ConnectionGUID: aJ05hUQaQlOQMTJ1sa+DAg==
X-CSE-MsgGUID: 3M9/GDR2QKaSgD4s27y6yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="66510650"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="66510650"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:35:45 -0700
X-CSE-ConnectionGUID: 036HcBilQemCgkn4cPx2TQ==
X-CSE-MsgGUID: WWLPnTN0Q8GCKguVxDlhag==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:35:43 -0700
Date: Wed, 6 May 2026 11:35:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: viperboard: Fix error handling in
 vprbrd_iio_read_raw
Message-ID: <afr9XW_OLVnqyvhY@ashevche-desk.local>
References: <20260505211751.102563-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505211751.102563-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 10:17:50PM +0100, Salah Triki wrote:
> The driver proceeds to the reception phase even if the preceding
> transmission fails.
> 
> This uses a goto error label for an early bail out and ensures the mutex is
> properly unlocked in case of failure.

...

>  		if (ret != sizeof(struct vprbrd_adc_msg)) {
>  			dev_err(&iio_dev->dev, "usb send error on adc read\n");
>  			error = -EREMOTEIO;
> +			mutex_unlock(&vb->lock);
> +			goto error;

Printing message can be out from critical section (yeah, the guard()() or
whatever change may do it differently, but it's unrelated to this patch).

>  		}

-- 
With Best Regards,
Andy Shevchenko


