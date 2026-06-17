Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D573D3CF2;
	Wed, 17 Jun 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691626; cv=none; b=iwIUPbMxWbWWvSzncj9HW9yolNcWg2Zq7MdiH2cqlx3kcX3zBK4i+T/RMZKpdGw6hLY0hs8opIYJ6oFX1/UDhQPsLcfhwCYK5AWb08ccB00J50FF3AfgUAlIsinUOS1PNzJgK6V1ZaPBQdeM1MBON1a/fdmVEM+1RFLU0rzyNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691626; c=relaxed/simple;
	bh=ikoNf9OMvQ3Nq2/UVcweWpPVtHA+wJ8bWZDQtQ5wRgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCkCSuh1HD73DLpHEXxZs/bnVYJ1dzdK74D69d6sX3mw6xsDOlIxAFe4u4n3mD+hfk6JtY1tMvqoWk6spBpbQqly1+1WpBlmmEdFOVbXW5XoHuFFqaUMa5B7+SkWzeN042L+w961VsVC7XZ1/3QsH6tn2CK4qcRvyZhCODCsBf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iW48BsBu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iW48BsBu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781691621; x=1813227621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ikoNf9OMvQ3Nq2/UVcweWpPVtHA+wJ8bWZDQtQ5wRgs=;
  b=iW48BsBuKGXiyRAcxw0YbSbh9L5RewvLwIZItAQpb6RvgYiRhMYdOonb
   T6BX6o3Z5r7Q6hPxReE0XLorS5yU2aSaL77kxwTsWELUOVffvUjWEhMKq
   /y9t3m9pMCZWtehGxhEyfLSgUUjmKQhnkjMSjWwvuXq9L76tbeL9ZuniP
   ZYIu7OiHAS+ecfOREJffZiSxk5RkLdMpwAAX4gx7vJwk4S0SQdUt6aRBy
   zm8YVU5H+vJq57lAOeIZd7SBGB7PvWbo+kg/O4JOFl+SOkSTzR6kuEbYO
   jzjSDi5r2R074edgwR4tLQH5II31OaXZZTNkzosUzCdr55W/X5HWW5g7G
   w==;
X-CSE-ConnectionGUID: HkGYk8SURuOeKv8nL+6PFA==
X-CSE-MsgGUID: FELlp/V5RtafXRtEHGP53w==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="70012519"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="70012519"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:20:20 -0700
X-CSE-ConnectionGUID: oTT9J+fEQKO1Cr45wXGiVQ==
X-CSE-MsgGUID: GiOYRBS2Qr+h39tSTPe5lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="252332298"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:20:18 -0700
Date: Wed, 17 Jun 2026 13:20:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/8] iio: light: opt3001: move device registration to
 end of probe()
Message-ID: <ajJ04OXgPTQS-du8@ashevche-desk.local>
References: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
 <20260614-opt3001-cleanup-v6-1-e3f5901dcc26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614-opt3001-cleanup-v6-1-e3f5901dcc26@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 14, 2026 at 03:19:03PM +0200, Joshua Crofts wrote:
> Move IIO device registration to the end of the probe() function to
> follow standard driver teardown/setup ordering and improve driver
> logic. Additionally, switch devm_iio_device_register() to its
> unmanaged counterpart as current driver implementation mixes managed
> and unmanaged resources, causing potential resource leaks.
> 
> Also, add iio_device_unregister() to remove() function to correctly
> handle teardown.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


