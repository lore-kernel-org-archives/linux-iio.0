Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1354376490;
	Wed, 29 Apr 2026 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488816; cv=none; b=GvE4xI08ipjtcsUzADUbKArSyLgGxHrz4KVQxYETmN5/dybWY9Lf4FjZWWIGybW7eU3MxcaIC3S3ElzyYVwloD/1XgvSnSOVLObRCZTzJMpRlBlHtJGM+A8o7Jdhm5F+kHVRTby+E8mSZqwWRg3/MhbnajKTOJlZypzD87ADIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488816; c=relaxed/simple;
	bh=mvixaMZGyj8ae6pqkvLsDsP9m7C//PdI0e3Su0SuK2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM5R7wYIzoNjYculx3Zdc4JDujNlkaT3cPO313/Anpt9W6Gl8QK7IqvorD8uwwuFWZ7PMt7soYQ+++H2TVZXW8+4D/P2AL/E2GMG86bOolv/K9Uthce6xj16rXQAiOQkcP7rZcR48DMOPPfVHTqpwTHy7TdgPbjr9gt7tuw7lzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlUvtZsr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlUvtZsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488814; x=1809024814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mvixaMZGyj8ae6pqkvLsDsP9m7C//PdI0e3Su0SuK2I=;
  b=HlUvtZsrlpg8sZbSNQkfuRahPidM0nfg/yG5HCtBrgdpLsFGt7Low/Zy
   1itakx1ePJfYu5oVWyDHii+WHiF3dlKmWF7Yt5bgud6FDCCYP1OoR83Uf
   Evcv8Vv5CyVsa50oabHKdyld2tS3MvsjbTVbSCmABxRs45vlcXSVGuAN4
   lyrGKNcH5wQsbqUAXIYMf4E4RsfSKdL/O9nRzAszC7edj33gGBRr9ePr2
   jjutkhZnQx+1H8lM0NQcOriMqPTfZsRQsbH6W2EKXncyb5pirVLQyOOQS
   ayDYPN1JuI++6M6YV5UPGIB1ubSaFXhU9Vg6r1ebyGZLlgOrQXEiRINo7
   g==;
X-CSE-ConnectionGUID: diHKd7qdRHO60k2GLxGUow==
X-CSE-MsgGUID: 4IyklfoIQxCLCPdsee056w==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89025999"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89025999"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:53:33 -0700
X-CSE-ConnectionGUID: FyTL8xhQSy+plZOUFK0N1Q==
X-CSE-MsgGUID: V3c9bjpXS22RJdgH2W6skw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="233324321"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:53:30 -0700
Date: Wed, 29 Apr 2026 21:53:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/11] iio: adc: hx711: pass trailing pulse count into
 hx711_read
Message-ID: <afJTqFta_m9Bjbb8@ashevche-desk.local>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
 <20260429054544.123862-8-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429054544.123862-8-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:15:40AM +0530, Piyush Patle wrote:
> Move the trailing-pulse selection out of hx711_read() and into its
> callers.
> 
> This is a preparatory change so later variant-specific code can pass the
> per-channel pulse count without adding a separate read path.
> 
> No functional change.

This one LGTM.

-- 
With Best Regards,
Andy Shevchenko


