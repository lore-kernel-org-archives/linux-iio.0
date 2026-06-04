Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79DF387372;
	Thu,  4 Jun 2026 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563233; cv=none; b=Vx1dziRX3UT6H9GyID8Na0Lynit1DnR/BGAMG5yynS0pSVVmK9h3pBFjwreoyB+enJwBVoJ8FfzlqfNU5rS5dJ/Dm6NadW22Bpo2FRgwSMyO33aNhYR9l819sWUdEr9T27GMy9THO0ZdXkZ4mmPfuQy/owvDAbnHvjeqRBJ4QpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563233; c=relaxed/simple;
	bh=27Hx/I+FZJvMLbtvyHv3evL+ddwk+n7RoBOYihns5cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0zZZumZ5eyv4/NQX+ONEVJrxuIuKBlOOYBYm6dQeN1gy2eCLbUVatqCq5zYK9KI0AMAcsDLEAeLxJbNy4boEFK8zhQcZ6Ue0mS7s+2rGH1ioo21fc4uPDfvZFAjQLJZz7L00NjxmsTc/RXw+H/YeE5ejq0vqT8GqLEAX8zZnvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNnH8Agj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNnH8Agj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780563232; x=1812099232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=27Hx/I+FZJvMLbtvyHv3evL+ddwk+n7RoBOYihns5cU=;
  b=DNnH8AgjdJon1by1yheCz2RaKb1XE0x0+xCA5unf8LOKNdPV79gHO/UH
   hxTvaNrN8anQoBqaEuzvhvQkJ8EsN1wEUkIP1LhL67qFOatB+5A4VY9li
   W8DX7GlPSAkhMTlCq9UN7Uvd9o09NhyDFMAQW8GiXuiDpHyuveVOjgk3t
   wuj5A9uEnLr6nnYCZ7bP7dvqLOqEoNWyO6A9dAu1VXtzp27qJVg8Tqi2T
   Jm7EunkQtctTiWeMds9VAZNxeg1qytf0QM+zWBg0Hc10BXSiXCcCNWTjG
   7Fepqa9DwrbYm6LiczqRdEBFnBsjm+dHbW+FTAVBwkjmwe2fZK/gDcH4a
   Q==;
X-CSE-ConnectionGUID: 8vQQTwj2QhuzK+ok18sTXg==
X-CSE-MsgGUID: oHOI8vPXRb6o+WmyB87Lbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98960079"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98960079"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 01:53:50 -0700
X-CSE-ConnectionGUID: vZ/cBMvWToGGhuWyhwiDsQ==
X-CSE-MsgGUID: fOOrQdsKTD2/XFKiVEzfWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="248837263"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 01:53:47 -0700
Date: Thu, 4 Jun 2026 11:53:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, dixitparmar19@gmail.com, waqar.hameed@axis.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	limiao@kylinos.cn
Subject: Re: [PATCH v2] iio: accel: stk8312: Update includes to match IWYU
Message-ID: <aiE9GGtvgBY48LIw@ashevche-desk.local>
References: <20260604070053.299221-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604070053.299221-1-limiao870622@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 03:00:53PM +0800, Miao Li wrote:

> Update the list of included headers in stk8312.c using
> Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
> and add missing headers such as array_size.h, bits.h,
> dev_printk.h, etc.

> Meanwhile, sort these headers in alphabetical order.

Usually we do sort in a separate change, but here it's just about a single
unordered item, so I believe it's completely fine to combine (in _this_ case).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


