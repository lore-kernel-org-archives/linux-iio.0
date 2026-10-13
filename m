Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FBD34041B;
	Tue, 13 Oct 2026 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901111; cv=none; b=SadqxFoR7dnlz3BOelkzjRQPs+s2DRFeoRJX+oO3ch67XQZPbBnZsdCS1iNsYfKSwSDezgvFQaGyGUiM8N9dbSQlGCiLB3R8ieZ/tDv39rsCH7oijHQwEn/e3QKeUk7MARbmPOK+wasBlIx1Am93hAHx+HGaxO1eb6pFJw7SclQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901111; c=relaxed/simple;
	bh=iu7vzEUNaWtd6PLXnUp/EFtC6DDFXqR8i72hIpAUdgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULOOFZFEE3wLTHumYGaxKvc3XIC6wKEQEfrqhsvbZ4XMA8GVTECqE8+p01dKc00NYJHl41ih3Hd6eqYdwULiDkQNHyVeLtiKG0ZFi1O1mqgReYJa2I36eAGRQub7h4JxxNSfd5BXZ8XWOqecwNTDjczHUzfvS7bhUKFAn85DAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O68RXiyF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O68RXiyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791901110; x=1823437110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iu7vzEUNaWtd6PLXnUp/EFtC6DDFXqR8i72hIpAUdgc=;
  b=O68RXiyFkYgsQInZOStcC8fSXoXCJ4vQH5YGyTigyAty8HBbEJygm29i
   IuEfcAAeNjLgB9R8NuJZsowyi405xgQl6M7jMwKqbfiFP/32rx3TmDBGf
   VE/IJguqrRdAmxdN5G5kmurIlak14rEUV4iwaeeukmFAG0gcIXQSjCDjV
   3UsfdjXW0yrhB63Igq8VE9t/mdl1Tb7X89PaHi7rbSMNkxqIWzaOPMRl8
   YGWuPWjlg0pcEb/lPSOLXB9dSW6vX5O4Mcr1tfy3kVI/U90ML/iRZ2Em4
   QZeYuSFGfW3LZf14QZHMG6Muql9mfRGYIinT/bo/45srxNuZX8yLuOWrL
   A==;
X-CSE-ConnectionGUID: etypvG+wQVSk9Aj/Fd1DKw==
X-CSE-MsgGUID: 2RLJs9O8TguXBmUc/Vx+bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="637224"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="637224"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:18:29 -0700
X-CSE-ConnectionGUID: 0o1nk5W4TdWEWn6n7J7XAQ==
X-CSE-MsgGUID: GSyr8OidTSGCi0BaQVJ8Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1643268"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:18:27 -0700
Date: Tue, 13 Oct 2026 17:18:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Marius Cristea <marius.cristea@microchip.com>
Subject: Re: [PATCH v3 2/3] unaligned: introduce be56 unaligned accessors
Message-ID: <as49sFkK1CSl0JXa@ashevche-desk.local>
References: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
 <20261013-topic-sm8x50-iio-max34417-adc-v3-2-d3604ae4a229@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-topic-sm8x50-iio-max34417-adc-v3-2-d3604ae4a229@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 04:07:12PM +0200, Neil Armstrong wrote:

> The MAX34417, IIO driver, is using some unaligned 56 bit registers.
> Provide some helper accessors in preparation for the new driver.

No objections from me.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

(Yes, implementation may vary for all of them as to use combinations of existed
 e32/e24/e16 calls but it should be measured for the performance / code
 generation / et cetera).

-- 
With Best Regards,
Andy Shevchenko


