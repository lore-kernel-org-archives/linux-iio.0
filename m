Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74257369999;
	Sun, 10 May 2026 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404535; cv=none; b=l2dXQcLfcJsh/n8mOFzlZtXVkW+dEqenFSRmWhw8V9cZRGCoHF+5FhWna21CxoGVoBZ+vZxjoBEfVcUcKaFlx0oIej9X4LSPu8+knDhSw6YM9KwdWWhET+khRLdBpZv0bxmhkywx4Xul6XERoJWl0rFfzCTDaoGzpysbsTvf2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404535; c=relaxed/simple;
	bh=U6F/U4NS7VSEsA8AMXLMHMbfZESNteTRbtpClgkGYQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/SsyRZBjkcknGRQNdjDvcjlvgwSi8FjFdljTiurUdLEC3DEDtlcel1OFc8mxqIhRjwhSyCzaGszCw0p8tNqG8LiUuIKXSW7KHBv0OtSik23k5nN6osXORQlMOzEm9jjaQLSBRWwoTRSoAXSTk3Jo5QdOY9JxWiTu3Nvu+5kTUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/t9eWW7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/t9eWW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778404533; x=1809940533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U6F/U4NS7VSEsA8AMXLMHMbfZESNteTRbtpClgkGYQA=;
  b=f/t9eWW7SyrXn0TaVSCipG75STXnltPnaXflYFi6lVUtgA4crma+oVRI
   GR2lEf25mvRn0DQeVgSn8bQvT9Nxrihk+D19HPMosxmAETizV4Vl7540M
   6ecw8JTu8qpqj9F3SGxEUhUSagm2pX/BPr116MrLKfbze3/xrvOqWaoBI
   CZnKfJLwF4yEwgo4sD+XOwk8XcqSMAt4b0R6OH+oH8OFewV42NCC5+hx2
   GNWzoKiZKLGTlpI9bAbImf9z4OnBuenrOXYJWqurAok6ofaraD9xh0m7H
   qwB5rbzHnnCxCIcaxzPQP28QGr9SCdy9dAMcM8K4pJ7o4fOA29CbIFUzA
   g==;
X-CSE-ConnectionGUID: vKO/Kf4ERgK93ctz3Yi7Wg==
X-CSE-MsgGUID: HZZE74zKTvqCsqKqvHnDVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79043136"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79043136"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 02:15:33 -0700
X-CSE-ConnectionGUID: YP6JxZF2TR6byB+dTQTRgQ==
X-CSE-MsgGUID: +qUh2xFPS3m5G/yrWTj0LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="234120797"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 02:15:30 -0700
Date: Sun, 10 May 2026 12:15:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: chemical: scd30: Cleanup initializations in
 scd30_float_to_fp()
Message-ID: <agBMsBIHknCVhut7@ashevche-desk.local>
References: <20260508225501.86448-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508225501.86448-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 08, 2026 at 05:55:00PM -0500, Maxwell Doose wrote:
> The current variable declaration and initializations are barely readable
> and use comma separations across multiple lines. Refactor the
> initializations so that mantissa and exp have separate declarations and
> sign gets initialized later.

The change LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  ps:
>  Hi Jonathan, I noticed a potential divide-by-zero bug on line 241 in
>  scd30_read_raw(), where the value of tmp is dictated by hardware.
>  If the scd30_command_read() call on line 236 assigns 0 to tmp, then
>  when we run:
>  *val2 = 1000000000 / tmp;
>  we'll get a divide-by-zero. Will send a patch for this later.

Have you checked the Clang and GCC compiled code in that cases?
Do they put anything interesting in the binary? (I.o.w. can they prove
the division-by-zero at compile-time?)

See the (somehow) related case in the 7e5c0f97c66a ("iio: adc: nxp-sar-adc:
Avoid division by zero"), which is in Linux Next only (for now).

-- 
With Best Regards,
Andy Shevchenko


