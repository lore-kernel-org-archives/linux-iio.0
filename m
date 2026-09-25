Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC93B059B
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790355046; cv=none; b=lJv7a9itVLRlrdD5pilz1SSe9aCrZ/FbrbBl5ESim0lziiBKpZuj23S/GDhlZQfila5LFJDh6ZgYnRA8mhie0Gmr3pVb+449lPjt2FKpFURWy1LYexonmujJXq8OffHc099gVtoSOK4kgKq5LMTTOHOZ6ksS9DPWSQjm4Fe1JIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790355046; c=relaxed/simple;
	bh=AijuS674GNj9ucBspIt9zL1mqsXgi05Q3wO9u8J9kFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uguidbLwtcbRRlcPliMkAE2WXMMppAlV5ks2Q/gQABs6G9ZWkn7qzrdx8nqKsmCmcvdN2GYbFM8KFfLnwA5YFjN1MkB+KEqtTPObhkM2maG4roIRzStk1dSTtCt9FFppEa1HH85muhP4af/o7Pqmo/s3TcULEeJBFLsHfmBkADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1DpQ9Jv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1DpQ9Jv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790355034; x=1821891034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AijuS674GNj9ucBspIt9zL1mqsXgi05Q3wO9u8J9kFM=;
  b=J1DpQ9JvivW98w/pnU6KmLjDPwRYkJzFKKtzIeTWkHJYfxtLQo8/zvlZ
   FDBeVA/pJar762UgODR0RrQ9hvGoQCUCZ+W6d9G47gFbgdL89UIlFOwjo
   96mmOIgYZW4oYJEIndC1ahII3BJBUtZkcnWdMvExJWvwJxfoRzEdA/+hG
   p6nb1BF9w7mMJVgqVrX86XfQoSfSLujES8ey4OmR3fqeq6eBiAFLP29DY
   6zkADNKB5t7cE5GdZf5I46H9CclI+ASDAK4lYDv6hGk65Ko6DXRWNrbom
   cP3XJVGs5kGZ/d8zoyCEuGMyIDURJDNr0J5egtuTSlziIJNlAIW4xZD+4
   A==;
X-CSE-ConnectionGUID: bG2xacsWSza12XH4Em63Aw==
X-CSE-MsgGUID: W2ytmJRlR5uypToS8/dgvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="78702517"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="78702517"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 09:50:28 -0700
X-CSE-ConnectionGUID: yl19up0tQzW1mBCLJD2Nug==
X-CSE-MsgGUID: OfhWr+omSyu+h7lTei/xnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="273937864"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 09:50:27 -0700
Date: Fri, 25 Sep 2026 19:50:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Yuval Saar <thefireking@gmail.com>, linux-iio@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	maxwell@maxwelld.cc
Subject: Re: [PATCH v2] iio: adc: mcp3422: use read_avail() for available
 attributes
Message-ID: <aramUCE0h5Y9-xzU@ashevche-desk.local>
References: <20260919195507.94130-1-thefireking@gmail.com>
 <20260920160247.1224672-1-thefireking@gmail.com>
 <20260921044709.27d59a97@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921044709.27d59a97@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 21, 2026 at 04:47:09AM +0100, Jonathan Cameron wrote:
> On Sun, 20 Sep 2026 19:00:29 +0300
> Yuval Saar <thefireking@gmail.com> wrote:

...

> As above, please make driver_data point to a structure (you'll
> need a cast, but this is very common so lots of examples to look at).
> Then we can introduce model specific data.  Often call that something like
> struct mcp3421_chip_info = {
> 	struct iio_chan_spec *channels;
> 	int num_channels;

unsigned int

> 	bool supports_3sps;
> };
> 
> Then just have an instance named after each chip with the appropriate
> data.  This may seem overly complex, but as a driver gains more part
> support this pattern has always proved easier to extend than IDs and
> code that picks between them.

Otherwise fully agree with Jonathan.

-- 
With Best Regards,
Andy Shevchenko


