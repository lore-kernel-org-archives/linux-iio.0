Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A0149DF1;
	Tue,  8 Sep 2026 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788842511; cv=none; b=XypANUyg6up+8gOkTotG9lxIByQaAfHDSYzarOMPXjJyfLmTD/7psFwdSw5A5p7P0IxZBpb664eGZJbQ3YxO4E1jrkWm5VEf0w9vlgVqlTbelZfWS4J+bSf0FhMcT7/p9muN5vXnWT2ZTK0kGY5uniVU+CuCsBAEgykwrCD/h5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788842511; c=relaxed/simple;
	bh=G1l1vuBFRGiHGoBZtbowQ91CaJS+UlGJ4sd44Ndjyvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQYiW5IXdLEsBRA2Ayg1hBMnh/EtLobnRgGqc0cp1gfkmqqXpiEU7b3ST4hkE7wM9DNV21LEWVsMJDOQk1U5JwdLFZbTxooNQzuxB0mnhORYqpdwk3ADqSJs1eVh9UjjfAd9/j07KsflVAKXYrAV19NZB/tncBx1AaUR+uRyIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJZ7/1xU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJZ7/1xU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788842509; x=1820378509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G1l1vuBFRGiHGoBZtbowQ91CaJS+UlGJ4sd44Ndjyvo=;
  b=XJZ7/1xUZ2mFi/jhZkvSqY0/6YnmSc+ero6/34BOHLBSqHyC2ML2w7z7
   sRrlPH9mHvg4D1F9zkRBdFRbrvROoMSzALsBTeyUdom4qRzDTPecgX0Sh
   We9cJjF3Zlwx5IhG8rQ8rOA8VS174nIKNylPPA3skjoGV8R2dmTn6F5/s
   JuYtfaBJzyJE4bFhvoMpQAHuafggckdhc7hZffqaW2zkzC7/7OclxtEuc
   rZHtkWeu0Y4eJL1Ja0i8mEmI032NBCYu+HhT+qzYEma1kT4tPLonf9iB2
   r3ZpaRSihgvD9W+arlhqyTrB10caPc3MwqwjpOu5ZvAFxOBPNNP/EPPFK
   A==;
X-CSE-ConnectionGUID: fBLT2INFTyi9BbSRe5nMgw==
X-CSE-MsgGUID: 0+RoeqLmQjefQu+61McmIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="93098295"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="93098295"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 21:41:48 -0700
X-CSE-ConnectionGUID: BuHBherBThGhux+wQeZtKQ==
X-CSE-MsgGUID: tASrZNNWQSuoLzSDwAO0tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="271390500"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 21:41:44 -0700
Date: Tue, 8 Sep 2026 07:41:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: ti,ads1015: Add label
 property
Message-ID: <ap-SBhDIJGvFZqFd@ashevche-desk.local>
References: <20260907152304.4992-1-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907152304.4992-1-flaviu.nistor@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 07, 2026 at 06:23:03PM +0300, Flaviu Nistor wrote:
> Add support for an optional label property per channel similar to other adc
> chips. This allows assigning distinct names for each channel which can
> match the schematic signal name.

You missed a cover letter.
Try next time

	`git format-patch --cover-letter ...`

-- 
With Best Regards,
Andy Shevchenko


