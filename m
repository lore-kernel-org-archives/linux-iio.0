Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6459372EE1
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655346; cv=none; b=OmyPYgykEAp4boo47exUgMe1mU7uQCUi4bb7CPj70pKaqmUNEAGWI+h9PQGK2YsWfH1RwhRXejPtTJwOpyxvbMcuiscMP3lJpB2xqg9ecjXhyhqzW2UkvtE1EJy0dD8lDRmo1gvCzKxrHP8g3oiYEz+0JJBCsFJ3zBigez9uR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655346; c=relaxed/simple;
	bh=EFKD+QmGTn6WgiR7QrjkRkHKEsRIL6fQSqx89vschW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRVj0ISJsbFvflWB/37TIAVvYaRx6SCgM0UjqiNBSfQiAqRJwMVyFksSL4A/BnJBXzOswCB52VDF8pYZcQgQ2JNFtAMRPQFJ1sb+JyGKOMs4GN6R4mk8QJd0BezuWcZs0f+u8Um635e4Jg9xfmWKVnASduponJm4p8QC4vVf93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GuvJOXFg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuvJOXFg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773655345; x=1805191345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EFKD+QmGTn6WgiR7QrjkRkHKEsRIL6fQSqx89vschW4=;
  b=GuvJOXFgStPS5Dn7XcQ4ima/3Ghhhn9ynpqkbud598YtdxZf6Qd9DFMh
   NYvsegsEVH3ZbWF628nrrzxmNbqzsj5lJAF6+UFo++0IkP2ova9k1tZeb
   jVyFv4rCPp/PIPNDqoXWqux8GUf7S7z2QGl8KwantsVBrLboU2DaEPj1f
   GIzmwlql+gpXenTnz8AuXRBvloNvAYHvKAYvhDoCLfoNONzQvqnaIUbgq
   xzyH2halgfEsfUyVH7rykQb7FwEGlHyny6CyTZy17yPP8eMo5ns3Q6UKa
   eyqYXd2k8MN/AgfGPTSrAZh08EczAfaLXeX6vwiRr7VX9Qr029TbCUHD/
   A==;
X-CSE-ConnectionGUID: FiiymH/rTu+UvkzEN5IlqQ==
X-CSE-MsgGUID: saAzL2LtTfm5RxbwZ0spvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="84983230"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="84983230"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:02:24 -0700
X-CSE-ConnectionGUID: FUfylNJqTvyxMatDDLq/vg==
X-CSE-MsgGUID: alXt5BKGTwa+rvPHWZkW9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="222067629"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:02:22 -0700
Date: Mon, 16 Mar 2026 12:02:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: Format block comments
Message-ID: <abfVKws8hF4bUbv5@ashevche-desk.local>
References: <20260314111250.223788-4-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314111250.223788-4-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 03:12:53PM +0400, Giorgi Tchankvetadze wrote:
> Format the multi-line comment in ad_sd_set_comm() according to
> the kernel multi-line comment style.

Assuming this is only a single issue of a kind in entire iio/adc,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


