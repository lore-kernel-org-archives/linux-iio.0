Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F94B4890;
	Wed, 16 Sep 2026 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552291; cv=none; b=a30r20Stm2nMvFP1nT0/m2XjkqaO63ZaMM8mZMKz1Qj0UZnLA0A+WNrncc+4S4oa642D/f5s6IkmYSfUGbvb5T4vCpRsCpFBz9rXHkUWYtYW+VAaNdJlB3Xt41vAMcfZf84eUttAG4aNlv7PlP0C0LaOKDeEil5p9fnZfB+qZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552291; c=relaxed/simple;
	bh=UIwWPNKRQ8FW7Bu3jbEPy9yWyv1Y+CRFZBuPobR95d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7LbdMbZXlW0Wy8eWDDfaXGDnJ/XJbvA38UP9S7MlfrYacrI6GLo8lrmGOG47YrfgsDgSQWykjzcWgteAqK7HBRRCwwoolxWi+BzMu1zQJrOdML2jc3sFpTzYQOX7JCfIY9/FYFPG1y92KJoUKgjqD1QlfXYTrBZpMXkymHqdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdk0yPsi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdk0yPsi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789552272; x=1821088272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UIwWPNKRQ8FW7Bu3jbEPy9yWyv1Y+CRFZBuPobR95d0=;
  b=jdk0yPsiUehhv06oNoymxFlAux/tGdJ3Ns1z4zbevzWt9o/aSJo/RcNb
   N3POKAyuS8SxqIB2z2v61VDfuAHu3hXglq/gXnx/qRotIw+3iWMqfG5au
   HmU580FOCNyV3DLyAUOkKuOohyh4UGN9DS3WRUL9+RKKjylILT7aBFCcB
   A3pqz0RBp25np3UDOalyjJThqoP8jUwYHg3OVKGe7NMMKfQk/ALWtB/h1
   ulosZyq3IUlVanQOnDlQAJZpUO9efkeKiSajQ3wEf92voBrl3Eg8WJj49
   j5V3w1YfvwEoblx7LxAQBcPwb3ALBdfu0xS5lyQMq7v695BOg7Aw1ahxs
   g==;
X-CSE-ConnectionGUID: XC4inCXJTFevNHqHxERtYw==
X-CSE-MsgGUID: GLWqJ4TvTkCRG5UaI6+6jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101270147"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101270147"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 02:51:06 -0700
X-CSE-ConnectionGUID: KfvqFqviTauBpXirtJ5MXw==
X-CSE-MsgGUID: RK56W2AkRI2hfojlaoS2QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267080866"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 02:51:01 -0700
Date: Wed, 16 Sep 2026 12:50:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, mfd@lists.linux.dev,
	Roman Vivchar <rva333@protonmail.com>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>
Subject: Re: [PATCH 0/3] iio: adc: add mt6397 PMIC AUXADC support
Message-ID: <aqpmgliQW7FW53o5@ashevche-desk.local>
References: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 15, 2026 at 11:15:25PM -0500, Ryan Brue wrote:
> The MediaTek mt6397 PMIC has a 10-bit AUXADC that nothing in-tree can
> reach. On boards built around it that ADC is the only path to the battery:
> the SoC's AUXADC is wired to board thermistors, and the charger ICs these
> boards use have no ADC at all, so without it there is no pack voltage and
> no state of charge.

This doesn't explain why a brand new driver? Perhaps we have existing code that
may be updated to support this device?

-- 
With Best Regards,
Andy Shevchenko


