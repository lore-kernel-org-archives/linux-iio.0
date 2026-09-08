Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581F019F115;
	Tue,  8 Sep 2026 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788842531; cv=none; b=tC0+FUFCjNnAeHN+496YRYCxJOpVFA9XJJrlpCeSik04PT7T7bfYCaxBUoP333rzFjLo2AvG7KamjnSS1sy6aUc9Ss5jp/VPl2SXLyaeEXm5ZZR9mUoQCafOe2JbF8Vj/ARr3IvJ4yLlkCrubh2g94bWvQCVR63vBXggy7CTdd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788842531; c=relaxed/simple;
	bh=28KEfHZQubJCqkuF3j8i5ST7J8PcLZEDC45QbvJxTjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksfdZXbXYYtcHAh9CKslMfdRaqVo9iWYOkyzEuZ8PTRGn/SOiRqPIEuA+LIegnWxdMZpBoJk4PBy+fBdrx4YO0mdtN1AarvbyVKVEoEdGFE6tSF6IzrMc0b4j0BljgBvI+szfYKLWqvhGTpvVwY6xI1DEmoA/7W5Msv9Ov1jtrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bdsvceo9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bdsvceo9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788842530; x=1820378530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=28KEfHZQubJCqkuF3j8i5ST7J8PcLZEDC45QbvJxTjw=;
  b=Bdsvceo9PH/PN/rFGo1BZwN8gLnDLBBWnhcXnPCfpFQUPKnfFcqoDSdi
   GLbnSsmJ48t/TP56+E5yG/DB0TUZgxLnInwHiy5irDpsXmVBsNa2J0qEE
   LEl0RQaXj6/am4RB7jnWs8WI+MFsdbBzaygNADqOgEaBhnZo9x4gQahZf
   ce9AkEmmBtltV/d4/7Y/gFhqobZsJAi0UA+xliKj0lKMDOFH9SwXziAqI
   0Hkj+oHB4LDk27ed1/Dz9WaYY5+FckNyAZq8bH7WBTnoGKqw8X9FTc3Kb
   /K24Z+PvJCMsFH+xld67WHkbAFPJRinHbmV51Gn0Jn8tRiQMW9kwmESxm
   w==;
X-CSE-ConnectionGUID: 10pqnl3CQOaJXOzMEtjwEA==
X-CSE-MsgGUID: FMrQ0JLUQQ2s2U9guTlKgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="93098330"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="93098330"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 21:42:10 -0700
X-CSE-ConnectionGUID: Tqzd/EOhTH20o3M863ZiaA==
X-CSE-MsgGUID: AvTSL9l5Sh+a38XIPC2R5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="271390537"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 21:42:06 -0700
Date: Tue, 8 Sep 2026 07:42:04 +0300
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
Message-ID: <ap-SHC4A5_3f2eod@ashevche-desk.local>
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

ADC

> chips. This allows assigning distinct names for each channel which can
> match the schematic signal name.

-- 
With Best Regards,
Andy Shevchenko


