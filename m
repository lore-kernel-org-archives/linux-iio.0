Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325DE423A76;
	Wed, 29 Apr 2026 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490088; cv=none; b=evzuwBRUhiH0uwec9tep9OHpp66tKzJfkL5Zus9Eg/dCQ0sMg1tdQfzRLHyNbNXSCB2Z6kb+S7ENPxfGEB4TIB8GRtHW1TMOXivfvt3QmMHzRakTaMXeCv9hSv4pnYvUKLKOBOUQ0Ztf7S8KXO+xVpyK8FQWOwlDDVd454aKNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490088; c=relaxed/simple;
	bh=U7/umELpHjaAtOb1ueEIEuBKkjPxztH+EvjvOFTQz6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S++Xg9JDuC1j8IZfX6wCmm2emkHJc2o0Le5BnB0oqz0Ej/sZFyH5tzreOiFs6kdLngpH5smWx/QeEt5LOl5aR/HPYJ/BdPZ9phat18AYZxK+3YzjIoL1+Fzul6cMZ61eAzPiQsGJH+B3XQzM0OqGPvSBu53PfaVhwvfykkMGFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqpA9zAr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqpA9zAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777490087; x=1809026087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U7/umELpHjaAtOb1ueEIEuBKkjPxztH+EvjvOFTQz6c=;
  b=CqpA9zArOIDw+ReKaMGEx3p4I0vLnAXdi8/ctN3aQ9ulDf8/5o7hRKbK
   B2whtzRNrtjR5PyaGUSwJaZPGxkkWY8LqBJeJzCEkKhy9vB0Q+mHzf6fa
   uu1aFZpOkfXZvdvFpGo6nyzUbOrxnoHtixaQPmjHTxt9VU3pB+TfgD+rP
   DBbxJopiv3JgC7C+083fBkBrEu6A9JlJvb8O7ipPOwMDmtscOTunL3/WT
   B2bcpQbfHe6LmRmfWj3mtcUABhQtr+AAQx7jIy9gcxWosP67FB6qpqEf5
   3NHHVVHzmiSEbfqK7uumkyHqgVn9W5szt3ckFvAxzYOAsn6qlpC/oMZD9
   Q==;
X-CSE-ConnectionGUID: OncxDVbSQ3GKE0PS4IfxPw==
X-CSE-MsgGUID: kqKE249eQMWvry3rTY1kTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="101093595"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="101093595"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:14:46 -0700
X-CSE-ConnectionGUID: k4nunEonTV6oivrrCKmFrg==
X-CSE-MsgGUID: f54PogfvRiuGmvC9aGpmmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="236130958"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:14:44 -0700
Date: Wed, 29 Apr 2026 22:14:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] iio: light: si1133: remove unused macros
Message-ID: <afJYorALBCO0eXu8@ashevche-desk.local>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
 <20260429-si1133-checkup-v3-1-469f21d960eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-si1133-checkup-v3-1-469f21d960eb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 05:04:49PM +0200, Joshua Crofts via B4 Relay wrote:

> Remove unused macros to improve readability.

Perhaps needs elaboration that these macros a purely Linux ones and has no
(direct) relation to the HW.

> No functional change.

Suggested-by? (I am fine without that tag, up to you.)


-- 
With Best Regards,
Andy Shevchenko


