Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9703B14B2;
	Thu, 18 Jun 2026 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765935; cv=none; b=AUvG+77rMoLIEIspxNeu7IETt/KO0a0ZppF6o00vzjNxmt9HRdUOLqba9V2Qa9AsafohOz+Uxo0w+0idhXrvLJKd1bZD3jc4D4LHT3id5G/0RbeS3QJ1yLWWgEqaEptdc32cLkihZNXJ9dkJXg8M988GKuD7KCs4Th6b6z6AN34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765935; c=relaxed/simple;
	bh=Tq/dT8JFO6HS4UbFJa31X6TBwZiDgp2XMEg0iJqJqF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SM58EoflSZXlfsgBu86FhoFTfBraRlqZruN59odoF04H5oO7p3U3+fFhuBZNtmX/xaesdxRx+m/ZkIBe3qdiPb5lm1FEpKuIlrifHzC/ghXXF4AV4R4apxqdqi4BsXkruwQB6vgEAWuxuKDLIeCGa8xSRFlxHcSS1KX94UPEF+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCELgPZp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCELgPZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781765933; x=1813301933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tq/dT8JFO6HS4UbFJa31X6TBwZiDgp2XMEg0iJqJqF4=;
  b=dCELgPZpqXqEpVs05XbxHohhJ/YajbA5O62q52MsGCCY59vSRQNTD6CL
   zsmZF6LcerG9EtBjnXvct7RFXvTT7QekSOBZOM4XDtKblM2X4h9xn3dPE
   +Wgj2pvUwpdliXT31Ksm7819uX4SuEuqVS7g18iZqW8vCj7MsIILRTmMn
   R9IzoM6H81V0KAEafp9oI5RXV7V8h9B4xWltphIM9tJXvaotuJm7Wk/vy
   qsnAOO+E2AXqslkfhsy820RrGpUNAiLXfKnFGehTW3Na5DcfnLZNzokG4
   kVA/4YKHO3SYTHL2ecsedET/tsKXUvMrpUZmfK6k6G7n43g+si5m1LS9e
   Q==;
X-CSE-ConnectionGUID: hRVOOnYTSbqrhjhJhPkfqg==
X-CSE-MsgGUID: C6oLX4mISC6dhgx4skqCIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="93191391"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="93191391"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:58:52 -0700
X-CSE-ConnectionGUID: SFCaozCfTwinXXvlheVnRA==
X-CSE-MsgGUID: hQTWXFcPSUS+AnFaSFHkpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="247138515"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:58:51 -0700
Date: Thu, 18 Jun 2026 09:58:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	m32285159@gmail.com, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: chemical: sps30: update email
Message-ID: <ajOXKKDWrTURPpro@ashevche-desk.local>
References: <20260617172138.114572-1-tduszyns@gmail.com>
 <20260617172715.115019-1-tduszyns@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617172715.115019-1-tduszyns@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 17, 2026 at 07:27:15PM +0200, Tomasz Duszynski wrote:
> The old email has been inactive for a while. Replace all occurrences
> with the current address.

...

>  .mailmap                            | 1 +
>  drivers/iio/chemical/sps30_i2c.c    | 4 ++--
>  drivers/iio/chemical/sps30_serial.c | 4 ++--

I don't care much, but the cleaner approach is to have a separate patch
for .mailmap and put it at the end of the series. Otherwise it's confusing
that it's related to a certain driver, while changes are applied across
the whole tree.

-- 
With Best Regards,
Andy Shevchenko


