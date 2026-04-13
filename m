Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B733ACA6F;
	Mon, 13 Apr 2026 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075389; cv=none; b=PvMdM2TORFgJA9q55zcnu1OnN9qvixwe35hFHTuXSntt9Y0MDTSty1MTxVcQTC75WZjwKbpQxsymbaicpEwPul0bP4dmW7Wx2BUbElPLJtbOj2Jo42H9ydivSDNXbsEZ7btmzROtikHPVZ+z15yFEuuqr6WDK1urqA8Dx9kYvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075389; c=relaxed/simple;
	bh=/bkBQa/AVsoD7tyQ9xHQhDcj6E7IECVHtRH1qN+hb20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIoK+KqKZNSSshJK+5yzx4KWbS4EOLf+hm0tCFtMr02Wi2wqYQ+EfPFQ4ZHEz06aQVg2r4nmk1BthI8eIkSzWZRZE7yyX/97SwXUYwc9S9aU/qoEu1gfh3zxkB+nIgbKdoJdddGm1GmwNppHl88Y6OR7qfarKY2DYC3XYmKGU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvR5OvPT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvR5OvPT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776075388; x=1807611388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/bkBQa/AVsoD7tyQ9xHQhDcj6E7IECVHtRH1qN+hb20=;
  b=KvR5OvPTsnG8b0q4FhNjCWJNYn1ohQcuDGPkNAPxtjC3jagQp49JiMEf
   Wjb19krzoY5QoTeAF//dSrP+o2DaENluiIDRDGBuEC0wexY+ME4QM2N/K
   CtZf4S5/CWR7QGms5/aDokkoKHbpQJhEj6xN6ACvmD+zL8VUA2BrPJ7Jx
   EjjUacitm2z1UZ0HBAHvQhVwQ8zh5KFF19sXf2emXNmYsJTxdvn78iuNI
   ACBMvrnjDjA78R/Ejbv9a9fQY4eVUFUPDLb1Qvdn3N3dUuHGZelN6yU3P
   03DKcX4l4BrXQYGzF1gjWPi5AzuGmZVxL+yB1JrTclE/4V1+pY4Us/XQz
   Q==;
X-CSE-ConnectionGUID: v0fAFwwfRiO5IAZTwO2B6w==
X-CSE-MsgGUID: 07HfiJ7aTLeHxDDnBX7uhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="87707771"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="87707771"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:16:28 -0700
X-CSE-ConnectionGUID: 3wuncLQGR8emApfrcpCFFA==
X-CSE-MsgGUID: KiSmNNFORtaGP4o5eP7w1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="225463341"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.7])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:16:26 -0700
Date: Mon, 13 Apr 2026 13:16:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: light: vcnl4000: make pm_runtime_enable()
 device-managed
Message-ID: <adzCd-0Cg-jeIxTJ@ashevche-desk.local>
References: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
 <20260410-vcnl4000-drop-enum-v3-5-2ea2bc6f5dfb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-vcnl4000-drop-enum-v3-5-2ea2bc6f5dfb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 10, 2026 at 07:11:21PM +0300, Erikas Bitovtas wrote:
> Replace pm_runtime_set_active() and pm_runtime_enable() with their
> device-managed counterpart to remove them from vcnl4000_remove().

This sounds like almost no changes, the little detail is that now in case of
iio_device_register() failure the pm_runtime_dont_use_autosuspend() will also
be called, which I think is fine.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


