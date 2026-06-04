Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB63374726;
	Thu,  4 Jun 2026 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602057; cv=none; b=BvwPPIHLNLQFtw8BW2RBWyy8UHbqnG3vfsQwr4L9+wWsLJP7oDfe/64EoFl438C30r9t4WfjlHJVo5URlKlHrbXEigF1Qm0cbJ1UtbJnTYdGXJIyc71jwUJ21XAnYFVWYCiiZaPN+RgrVybeZ+xbth+EVbvEdBQMQNJo0JqC7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602057; c=relaxed/simple;
	bh=Y9wjbRT9w94Gcp/bzW1GMOk9EUx5ovP+IYIpAbYawNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rExwIlndEWihsmxvMlVSvT7c10q2pu8uHhW4meHF5C6aviIT6OZS9p+bfC5+7zw0204wHs6MaI0m64KA1PznkI/ilA2ppmfXmLl1Fgko28nb8hpoTzLS+dhVqJb6Llx1NcObCt2SlFxKUWMxQUdx1U9IWa+7GcPmPs+BWehQTSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFxbvpvn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFxbvpvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780602056; x=1812138056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y9wjbRT9w94Gcp/bzW1GMOk9EUx5ovP+IYIpAbYawNs=;
  b=GFxbvpvnno7gdU4ugw+cgfpDgnoJv8TJr1yCtB4f1su9XJ5rS2/uYFX2
   k3B72L1oRmuMol4GIG+4nKDTPnqgjCKpaIlowSi0YOz1/G+cGeo6voS9e
   9mMfTwr7znxND6zIKM+Mjc2iANSYRRSh01IiGeRYXTeTeIOj4Pi7GVSJd
   MsV5xr43uTrLgSLS19Wt8dsaSOTVQgdA1T3BDdutW/7Bz6eJCAq6zPiuI
   Fg2IvyfTpf5iVjwNifaz/GA/DQU/IPG/RSb+EJqABz1hPV0LkESdyOTbU
   0wftH9jE3yZMOEwhfmqcvjgWMln7T4DELHV0w4mud1sD/2CpVwZauqPyw
   Q==;
X-CSE-ConnectionGUID: K7kQhUZKRoORhIobMk7LzQ==
X-CSE-MsgGUID: K51GNdLYRjip6ycrZRuAKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="80577597"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="80577597"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:40:55 -0700
X-CSE-ConnectionGUID: QFwM7w91QJSjNZj3WfltbQ==
X-CSE-MsgGUID: fwQvEaiPRcOYj7CA0byi4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="268565706"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:40:50 -0700
Date: Thu, 4 Jun 2026 22:40:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux@analog.com, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v16 05/14] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <aiHUwARy7g3cSv1t@ashevche-desk.local>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
 <20260604-adf41513-iio-driver-v16-5-1a7d09143bc2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-adf41513-iio-driver-v16-5-1a7d09143bc2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 10:58:59AM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> precision). After the decimal point, digits beyond the specified scale
> are ignored.

Okay, this seems universal enough, follows the semantics of kstrto*() family
and gives a good results. Let's make it sail!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


