Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17417225A38;
	Tue, 14 Apr 2026 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776191831; cv=none; b=Vcs4vNiTo9JJRcm+VT30fp7S8wsJeMf1FHjN+3lAnpBZ/26B5FYMCB4W4YET9h0kH8UNRqTkfT4jR+20MRdtEfHonzscGEhmdO4IH0VOsNSxIPYDoK/TH4uyiOgqQOxJb3vihwiKUWmjStnwwEbeoj4zpN2UBHj7ByUDgPsU5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776191831; c=relaxed/simple;
	bh=+z4szrI8wNpQTGK93+rDAEUGrK79H8kuR2I7Oz6xiDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9lMJUholNzHxgvK6bhyupfBVEjm5IYg4ZDxtfwmRKYYddG3YwDpKa0936DfYEsRxXaaIGD+CYXHz3PmXsfY/PFNV5U23T21hyG/rRNpUu9kTTa/YIfSDHAow/3W1aGO6SiihPOczlblgW9nUguXo7/3YB1I+Je/0oHEBF9eK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHEu3vrL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHEu3vrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776191831; x=1807727831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+z4szrI8wNpQTGK93+rDAEUGrK79H8kuR2I7Oz6xiDw=;
  b=mHEu3vrLEvE6BfCF6HfhXqaIb9OrJvM73+wvoGcQYHMeP1sxxJCxl7LR
   YEOTJKKJtQdMZrpfKnUQ6+1h0P/rhvMv6XhGT+E5iSuPvAhpL4b3zuZmG
   K8GUZAYuh0QOTt8eURzr/tD3hOV+0UWg2XZPBRpJqZt28fsfLrbQBSjp3
   XIa+QqL0ZYV98QlKA58TLYFiPbxXSIx5QwE+489oYRdQHCAHky4nkUyyN
   2+oxlTJR6Bc31v+4Yt38euZR2FwW/HWvTO7u/unHZ6bnXGPg5Tfn6h+R3
   b2knVGKwxrjIxCsDHn+HJGNCJsJOIMrNmUPD9EshRJhbahD6hNeYZc5cJ
   Q==;
X-CSE-ConnectionGUID: Af5IM6SjTviW+QcZwto7Vw==
X-CSE-MsgGUID: TQTbO9IyRtmK1a5k50TdZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77036884"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77036884"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 11:37:10 -0700
X-CSE-ConnectionGUID: j/kMmFV3TuS4aKTnxxpCUg==
X-CSE-MsgGUID: SS2HCm0xQUu61aZDwAgUTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="231925127"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 11:37:07 -0700
Date: Tue, 14 Apr 2026 21:37:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Cc: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: xilinx-ams: fix out-of-bounds channel
 lookup in event handling
Message-ID: <ad6JUHXNCyB4J6QZ@ashevche-desk.local>
References: <20260414093018.7153-1-guilherme.bozi@usp.br>
 <20260414103316.18455-1-guilherme.bozi@usp.br>
 <20260414103316.18455-2-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414103316.18455-2-guilherme.bozi@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 07:29:17AM -0300, Guilherme Ivo Bozi wrote:
> ams_event_to_channel() may return a pointer past the end of
> dev->channels when no matching scan_index is found. This can lead
> to invalid memory access in ams_handle_event().
> 
> Add a bounds check in ams_event_to_channel() and return NULL when
> no channel is found. Also guard the caller to safely handle this
> case.

...

> +	if (i >= dev->num_channels)

The '==' is clearer. Otherwise, please justify the '>' part.

> +		return NULL;

...

TBH I do not see how this code is not a dead code. But for the sake of
robustness it might be added. I leave it up to the maintainer.

-- 
With Best Regards,
Andy Shevchenko


