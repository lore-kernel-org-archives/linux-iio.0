Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F13806A7;
	Wed, 13 May 2026 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669741; cv=none; b=kSmyu5KQ3I4zpf8bFmfWrnYEAbQAlO9/7ebE/lcq2G1xLZghBR3AvYVQntstjoDSgastloSLn7r/TVvsSO6UzK6xr325FvXTZkzWOgJO+yEdwsMhKehvaG/4weHYTCGG1EE4hVYL473ObA2bxkO3UzMAC8s7b21R8AWN2JJPAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669741; c=relaxed/simple;
	bh=25ewgeTPa6XKOgYwQxiWFZpBia3tMhVkypFZfaLGri0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdUMo6dzRcClBDDmiFDbFutIiyhgOQuLDK+LMB74fJAtpYbAMcsTuRyc+e+y2xUfkBm3n9ggfy9VoNwudamt4LjwjTo9HiOkO/sPZYDKlKuzOBFvgPOJQ9kzp3PkC5gMwvY/nP3BUESMdYBMdC5kNwYoOv19zxJdQQAil7D/+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMZNVUNS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMZNVUNS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778669740; x=1810205740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=25ewgeTPa6XKOgYwQxiWFZpBia3tMhVkypFZfaLGri0=;
  b=DMZNVUNScoOLQPlz1d1Y0a7bzoH3MdZIYWq3stl6Cc4EHVd+HS9NGkzM
   L/Bx0yRoZc6LlqCS2E5yOEY5F2BqGkjHaY90cbqwM5/J8WFU6/DiQ84Is
   BYTgnGwtfQ0o3esret9yhETowzs1XW6Rz6+2idEOEjog6bAuQhtsLmHyl
   oCWimRCgEQicqpTG2BNVCSs3LNbUvNGhAv2o2ZmOarf98rfOZoH204F2C
   utuKxJrHxZEqWSehsoCcanAsmtrhU4WL1BUg5kVnGnrzEbC6NbByj6Dqq
   zfPN3izw3tuymJoTTHCf7fFORxofUDa+6qQOwEjxtlorNze6wysdP6EF6
   g==;
X-CSE-ConnectionGUID: tVJFHIIiSi6q9udp/33Shw==
X-CSE-MsgGUID: PYGIffLBTUGVd1N77I24qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79545044"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79545044"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:55:39 -0700
X-CSE-ConnectionGUID: QmSk2qzZR0u64dp5mDgWIA==
X-CSE-MsgGUID: tCBFVPsmSQ6p6ZB/jpYCXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="276158129"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:55:36 -0700
Date: Wed, 13 May 2026 13:55:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: corbet@lwn.net, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org, hcazarim@yahoo.com,
	linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: iio: fix typo in triggered-buffers example
Message-ID: <agRYppUhsyKs3WBt@ashevche-desk.local>
References: <20260513100657.8498-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513100657.8498-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 03:06:57PM +0500, Stepan Ionichev wrote:
> The function call example in triggered-buffers.rst uses "polfunc"

No need to repeat the file name here, see below what is better to use.

> (single 'l') while the function is defined as "pollfunc" (double
> 'l') on line 24 and referenced as "pollfunc" further down on
> line 56. Fix the misspelling so the example is consistent.

Line references are fragile, try to describe in terms of section and example
(names).

...

Code fix is good, nevertheless.

-- 
With Best Regards,
Andy Shevchenko


