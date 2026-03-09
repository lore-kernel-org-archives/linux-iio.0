Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184322356C6;
	Mon,  9 Mar 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073824; cv=none; b=B6xqh9NO+UjdoyqP2B66iE8T5AlUHsFkqSj5ibUL/r5sdve+XSNz9Idft9rZPag1GUil/xr0oFnboGyfjWlFItwmrq5LfKavEgWw4mRQklqZ0vMhiNLaAxTerDXpbdTSxeBvZbNPpyz43d78Jk7XBrAdvnJm0asN1Ww0u+7EoLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073824; c=relaxed/simple;
	bh=MA7qYsy0c5MCWCD0YP1f/iI4EumfIwG3KUR/2xV1Xzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8fdhuoNscQIHr4iPNG37PviFUoPrPQVpERdkldoRyXHeCF5S0Axxbwx2amgQ62JVPwVoa2/lQqC7qMPaKVWiExETiKPw3fCPFHptECLpoixKBdjiJO+TqeKXO2UTa5y8p7SWNxiVobKX+n0XhHZXvPRz37si+xRzxdMmPQXAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEwI6CfN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEwI6CfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773073823; x=1804609823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MA7qYsy0c5MCWCD0YP1f/iI4EumfIwG3KUR/2xV1Xzk=;
  b=DEwI6CfNXj5ShvDDZm1+ziCpLZLz2ugogCFyLp2OXTytGJmZEM/HYYz/
   6/sqyZL6WVm6kRd02R3RqlNhZt1L4kq9COqbZzQdmhmfirkeme+yvmJgv
   Km2oX2o+eU5D4hjWLIXo/wTW/gz2pcqvmoXXSniMBS62TsogqmZNEpJUn
   hQ5CODuSBgWyeC5ARtecq1IVzPgQBwKmsE23vsPTLmIhNkUSKnkeBOCVV
   vuPdNT9CNwpv4NarHooWf3o/33m51mtkwDjhbFFPDTLLtf6lkyIfg7crE
   U4uGyoVCYFfKVG40ifmYR7FlTyi3CxbZbNWhtb24b6tAXBvwc273vzYgf
   A==;
X-CSE-ConnectionGUID: H486zroDS7iHNwCDDC7PSw==
X-CSE-MsgGUID: /Tn4WWPjRHivmJwXkw3XYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="76708353"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="76708353"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:30:22 -0700
X-CSE-ConnectionGUID: ExbACH5kRwmMvdl96dAwlw==
X-CSE-MsgGUID: DfJxjHYTTLOtZ2vKa9TvhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224501461"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:30:19 -0700
Date: Mon, 9 Mar 2026 18:30:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, waqar.hameed@axis.com, linusw@kernel.org,
	sakari.ailus@linux.intel.com, harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com, andrew.ijano@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: accel: convert to guard(mutex)
Message-ID: <aa71mdKAc74CNhdd@ashevche-desk.local>
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 09:04:04PM +0530, Rajveer Chaudhari wrote:
> This series converts manual mutex_lock/mutex_unlock pairs to
> guard(mutex) in two ADXL accelerometer drivers. Each conversion
> also simplifies error handling by removing goto labels and
> returning directly on error paths.

> Alphabetically Header alignment dropped in v2.

Why? It's valid change when in the series.

And again to make sure you got it, send a new version at least 24h later than
the previous one, not 2h.

-- 
With Best Regards,
Andy Shevchenko


