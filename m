Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF6C31A56D;
	Thu, 27 Aug 2026 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813231; cv=none; b=FcExRSRYkoRQ0HBBP5jXH3D3e9oqkta6WJkARP2dlSmaXtE2II3KbeLYPt3v5u4j5eYPUNHntKxHie2wAGnqW/mbBQhapYANVrhsjBvyOMsdl7oyrsW2ysqD2T+1i35sNBWy9n5GBIRTTe/zI1ajGb+8GQFmrykFB7cxWvBzX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813231; c=relaxed/simple;
	bh=kSt6W/5M3cDSQBktWoLHLcYjSmqclTD3o0Eq7iZFzaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcHKfLUT5lGipe58N34zKPVjXjaVTVUm9lUgRLr+ZJ6h8K0YFuYJ5MIhVOfpYheeegTlzJeCJzEMJxafloYVCbhsXMzVL++zwjxSCLkGX777ip0lItNJ+m2HcYgtXQOgluUTX6OHroifJy3nRIpf056qm8p6kejsVC+LrSunm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzcLtvPA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzcLtvPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787813231; x=1819349231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kSt6W/5M3cDSQBktWoLHLcYjSmqclTD3o0Eq7iZFzaI=;
  b=UzcLtvPAE1nuyXo5O/cwSzTvwzbL49kCN0+bRssFcUyoIMVdngeee+QJ
   Cl1l5gNlpyo5Y6WYAlgplAq0EWt+mpX3hdhNv3ji51VRSCZDfTz42ybui
   FUnaiiCFucwdb3IsB4v49NX7ZbpolXwwjNpKgrmdPJ/fJR8WsHTYZo6JT
   /IuXfIs0MQtDz5fi2JNqvcraJdvDxliV4EgIoh9KxV5DXWEtpczu6x3pZ
   Pe54E488wPQKrtAQTOSJZL7xssDNtrc1f7tygoqCkgMyCkzatcLx76BwG
   ePWD1SVbllhQpoed7wCiOGvLA8y7WEA+51tRXME5eYwdgpCntkjkOtuXX
   w==;
X-CSE-ConnectionGUID: YPMyHfoHSTGKEKNxn9hpow==
X-CSE-MsgGUID: i+FRicWRRuCZ6dIa386Ibw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88332847"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88332847"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:47:10 -0700
X-CSE-ConnectionGUID: evhhczJPTFaMEyUIKD+ziA==
X-CSE-MsgGUID: 4dtn6Su9R5KhPCgQ9vkspA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="261660849"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:47:05 -0700
Date: Thu, 27 Aug 2026 09:47:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 3/5] iio: light: stk3310: move the data registers into
 the channel address
Message-ID: <ao_dZwSJB8gm8sqF@ashevche-desk.local>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
 <20260826175409.326131-4-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826175409.326131-4-jorijnvdgraaf@catcrafts.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 26, 2026 at 07:54:07PM +0200, Jorijn van der Graaf wrote:
> The RAW read selects its data register with a per-channel-type branch.
> Record each channel's data register in its .address field and read
> from there, so adding a channel does not grow the branch.

Fine by me
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


