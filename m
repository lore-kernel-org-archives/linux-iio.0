Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092873A873D;
	Wed,  4 Mar 2026 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633290; cv=none; b=tzXx+RtLxsnt97gmjdWvcCm/Pdoqa4Rkvxtc2rVmM/M2ucL8kjqoman8y8r4aQhPMQXNqpbnFW5QAyzdNfPjBLtSgOZqY3uxHWkVozUaHbdRiaZto+OJ22O1zlL1WPFqUq7JFfp/6aZg7Xe6n0tX5CajgETpI3WDTGULohzHOIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633290; c=relaxed/simple;
	bh=pTIbvqd6tINGHg9ee5csX1l/vIeEn7N0MZ4qlL2EBuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWldLjthoeAyIluEK/rOMvt/74GkRNvSgYfWq6C0/lMQ6nwnXpi66J1HcK0P2Htwx/6rLS/eb8yRYUFUttRtiS9SHf3nPtoZQE1RJl/wUfu8LivlYypZWBT5EfrCwh6Pjmb+He2lDIj8gim3VpeTgT0DncpatREdNxleo9N1BJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSviZZuJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSviZZuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772633288; x=1804169288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pTIbvqd6tINGHg9ee5csX1l/vIeEn7N0MZ4qlL2EBuw=;
  b=VSviZZuJ6BxYXd16CKsbpfHxKbNJzu30USxErzSQ9B3fjrT1UlY5ubgL
   e4nbFESMf9OXphaUNWmqrtygIXsiu1loWlssrprfi7BxS3310SjkRoEdA
   bgBB+GxoIineeuVC8RtdCu2ZtWA8YbOmJIkE+R6soytdlvKeZxfPLAT0N
   RkdNUkiGWr0PIOFBkakP2h7uIsh6ykWQmo5sHhVjJZfFiek00dO9aDhdq
   +aIjdC6Qsy+ySuCnUq0D2P4sw32UnnMGwEBkz6qoCHEkCGQysNw7xq0Zc
   1q4nLNAMUmZLsJt/9Z+DmzHPClJiLWk7fehptRV78I9v79oaE5DFODxRg
   A==;
X-CSE-ConnectionGUID: 1eaaBndhThK98bGJo0KGTw==
X-CSE-MsgGUID: 0D9kGZwNRmKI8AVntnvdRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72718869"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="72718869"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 06:08:08 -0800
X-CSE-ConnectionGUID: P1gfJw6HSJ2gGMeO/DL0hQ==
X-CSE-MsgGUID: 0EqeYp2NTBSrmPtjBVDdcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="217510303"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 06:08:05 -0800
Date: Wed, 4 Mar 2026 16:08:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: frequency: admv1013: fix NULL pointer
 dereference on str
Message-ID: <aag8wjoXQ135LRoL@ashevche-desk.local>
References: <20260304095818.5459-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304095818.5459-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 04, 2026 at 11:58:18AM +0200, Antoniu Miclaus wrote:
> When device_property_read_string() fails, str is left uninitialized
> but the code falls through to strcmp(str, ...), dereferencing a garbage
> pointer. Replace manual read/strcmp with
> device_property_match_property_string() which reads the property as a
> single string value and matches it against an array of known valid
> strings, handling the missing property case internally.

Same comment applies as per v2.

TL;DR: We may reuse the original enum. See there how.

-- 
With Best Regards,
Andy Shevchenko


