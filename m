Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8715349CE;
	Tue, 22 Sep 2026 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072822; cv=none; b=GSHNWMhKghMuTptNSOS4Tbyy3LahcIW9e4O80v178dPwRtejwtqsIrNMATkWWwp/4pDp/hv/stsffj6rKgME7H6QC+HprJfbugoVCsfwapBcjOd8JqnDBlwGq9O/rSb8Jptn3bsBN8b08P4OfwzvFZCwwI9k4hJ+dESzJP7Ta64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072822; c=relaxed/simple;
	bh=Icklkf1mpch5Iw+UOu7Yq9Mryb/MWAFNL9D09km3ees=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxlKZmdPTahK/qvSYTn11B1rEPE4Vu7c+m23i+tI6UDZAqEnH9jTrSFTnKNw10mxNGGbaCkwaaK0oiGy8LKiNPOh2OMH6x88h6MmrE+T1PugpiJtapeTKI3mMtRM7PU9SEC8oFOqTUdUiOA2gBJvvilgjUdBRLFZg6gYe1xjC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFtHI6hE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFtHI6hE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790072821; x=1821608821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Icklkf1mpch5Iw+UOu7Yq9Mryb/MWAFNL9D09km3ees=;
  b=RFtHI6hEZ4Cp+rkYt/4nX4Zh2/AhZXoIhnjx06+QwHnuuWpfmMb5Fekr
   A/4/8ZsuJIHr+rx0wC3pknC79aoKgSlZSBq1nmRt53TqtN4t6p9MqTASF
   VTiWX4eTVVcpZodtbdDD+eSQ/2YMsBqRc79APUcinMYcqo+/muepeacyG
   E2Uj4f+KhNKWTSSNz9+5xmJQcYI5zPceN8TDUWKq7OaXahDHZf/T59kg6
   mzeK4Ez1iyRQSetriOq13DfAktubVDmzvLRasHmsn7n0e0khw+Hf9dYE7
   bmZvTLPvIyRC44R60hf1q+e/OOHmLMfB37S4hAqYM4mobyWp8KjcdPcuG
   w==;
X-CSE-ConnectionGUID: L0V32GGjS+KGfP6GqgWJHg==
X-CSE-MsgGUID: NgkCdcBYRAW0C8BOCML4oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90679204"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90679204"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 03:27:00 -0700
X-CSE-ConnectionGUID: E0Y2EYeNR1eXPsZt9wkmZw==
X-CSE-MsgGUID: FlrqSx3BTbi9FmdUn2EcHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="273240535"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 03:26:57 -0700
Date: Tue, 22 Sep 2026 13:26:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pengpeng Hou <hppiscas@163.com>
Cc: nuno.sa@analog.com, michael.hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: cdc: ad7150: fix OF matching and publish module
 aliases
Message-ID: <arJX66ZmCWbZ_4RV@ashevche-desk.local>
References: <20260920033303.11879-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920033303.11879-1-hppiscas@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 20, 2026 at 11:33:03AM +0800, Pengpeng Hou wrote:
> The OF match entries use positional initializers, which initialize the
> name field rather than compatible. Consequently the advertised AD7150,
> AD7151 and AD7156 compatible strings do not describe OF compatible
> matches. The table is also not exported for module alias generation.
> 
> Use designated compatible initializers and publish the OF table. Keep
> the existing I2C ID table and its device-variant selection unchanged.
> 
> The issue was found by our static-analysis tool.
> 
> Fixes: 89f2d5b080bc ("staging:iio:cdc:ad7150: Add of_match_table")
> Assisted-by: gpt 5

Assisted-by: LLM

> Signed-off-by: Pengpeng Hou <hppiscas@163.com>

Same to other patches with similar tag.

...

TBH, except the commit message I can't see how LLM could be helpful to the
code. It's quite a simple change...

-- 
With Best Regards,
Andy Shevchenko


