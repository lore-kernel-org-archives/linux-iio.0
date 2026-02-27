Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626737BE8F;
	Fri, 27 Feb 2026 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183268; cv=none; b=fqAfIO70vVtQdK3J09mgbHyjC1LyDwczV0KI5uzKNECZBEO2IfI24NymSXvQLQPIdJv8IfOp1tlQWl8Ad9SQFnrysCAZrSyisejPOIoRtLM9694pfcWmQkc4MUOXcsldzJJ9RIFYNvDzICU0bXLP3hCLa73Bw9AcBGnj6zIUSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183268; c=relaxed/simple;
	bh=VaS15UbZ9jg6PAOzxI8Liex2xWtQkmKh0ZaO8bdZfFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otZ4ZWqoLx570+YkcNH+cD9Ykfr0iyG8y0XiaQAOHhYhfljBEmux/bES+8QypC4/uU9BpU3BXWJ7s2pzmlqB7VMluFZm/rKMCxveXiZAZFzb53L5tvYRQSFgd0NYDEbg8/r1BnG/PowpkdWEFxpazDSljqujFpXUx5emzpoSGn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WaVttjRu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WaVttjRu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772183269; x=1803719269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VaS15UbZ9jg6PAOzxI8Liex2xWtQkmKh0ZaO8bdZfFk=;
  b=WaVttjRuQdzKr05lMA7Xguh/TYL0Ae+9AqrVvgwnAqbpVl6jN6vt3+VZ
   2xveJFVCL6G3H7UQJI/62x0o7s+j9KyOSHGXS83QyboUQGVxPbG8fubKq
   F3NtBE1J2GKSISnFx2ZMRFIECwQWtOS7jIxm1sL8xfi2vmrxZu6obWGmb
   pNJ8sIbL0ImEgo3UDG8TBecK1wCUphJ4X+kKI6sCrbthqFxpuleIzH13Y
   +M6YqlDpobNaZRJM0HVyYbqas88H0HGwaPip7lLvC+8HMCp97qwciDclw
   xVTQMgvO+ApNW+jBSGEvJQOzPmFS4JSVqb8jE2A8gexQxP8SU5mbO/ecY
   g==;
X-CSE-ConnectionGUID: wLEqAj7MRyqrNwQzbiDyPA==
X-CSE-MsgGUID: 2V1DoDVhQq6VtrZtrpz5Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73231086"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73231086"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 01:07:48 -0800
X-CSE-ConnectionGUID: 0R95YB0JRfOIR5AgFYmSog==
X-CSE-MsgGUID: nHIqeACvQiKNU/xjRK/gBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="221844340"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.65])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 01:07:45 -0800
Date: Fri, 27 Feb 2026 11:07:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ade9000: remove unused
 AD9000_CHANNELS_PER_PHASE macro
Message-ID: <aaFe3oFDGFr4gGze@smile.fi.intel.com>
References: <20260227085813.46417-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227085813.46417-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 12:58:13PM +0400, Giorgi Tchankvetadze wrote:
> Remove the AD9000_CHANNELS_PER_PHASE macro which is unused, has a
> misspelled prefix (AD9000 instead of ADE9000), and has an incorrect
> value (10 instead of 11, there are 33 total channels and 3 phases, so 11
> for each).

for --> per

-- 
With Best Regards,
Andy Shevchenko


