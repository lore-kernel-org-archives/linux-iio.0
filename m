Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671DA18A6A8
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776472455; cv=none; b=dFByYEkdzvxQ3pVh6LFuvrhSlHLgnXq5h9gk/FP8eYuYJWSZOqSl4gL+jfTV/AfhNUF1Z+Um8XO3NZ3Y9OSUnr2lIRCEOMRomVUxPSWkoet0a08LXg0JNp+XxtVARSIVANO5ZVUQnOJUm3LH3vHOIYP1wGi/e79jWDQB8o7Aadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776472455; c=relaxed/simple;
	bh=WO8hRJ7KCsodO0D7OkJN5Xe5KFhMrZyl2ubuS8KlJmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StaZvNxY1OoYUu4lWb+ScB5RQ+8UtrhxzDvW2jgm++0CgXiZ+JZdhzdBVv5NidObavTFNn9qUf7k9Fq/NK0/O1n0SszLOkA8dxjBRusMOllxmFWIGVA1bJnZ6/UClE4mC70P9HOczBsNhBqb/94ZTMnopayyE3pXCD/nKzcYKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFbYzi7n; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFbYzi7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776472452; x=1808008452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WO8hRJ7KCsodO0D7OkJN5Xe5KFhMrZyl2ubuS8KlJmk=;
  b=HFbYzi7nsA3zRt7s/BsHubYIaFNLjpDe2QuWmFzz4dllAbMNgbkV4PTE
   WYX26xlM2E9KbxLpNO+jwDmAnRbto+DBXPrrAatPACv3c3ovLn+NaoWN2
   W05qzgtUi9Daa/y0SWoREekLPKQxWK1fMCMcqIA6Ryz7V6aR2rMjQbjdS
   JVOHYG42BLnOJrkg28HWduH8Y0TbnFhDGd2lx8Kw0WPH5rpqLPRD4ITkD
   NrCUMBZjq51VGgho/ivGJgwELQoAA+hRDLBpCZfDeBCiTofoHpo4VuDWi
   coY6JMnzXUsALGDw/UG55ZxKu8sbSzZ4Q9J8D19J4YSfgrNRf/jeAN11U
   Q==;
X-CSE-ConnectionGUID: LmTs8ffpSIGbydo6msFOdw==
X-CSE-MsgGUID: PJCftZShSomMt9jqeleDwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77563342"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="77563342"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 17:34:11 -0700
X-CSE-ConnectionGUID: XVL//FWFRT2GD2b3jxp2Sw==
X-CSE-MsgGUID: QR07AGEQQnmUCXyePTvirA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="226494931"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 17:34:09 -0700
Date: Sat, 18 Apr 2026 03:34:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Machado Lage <marcelomlage@usp.br>, y@ashevche-desk.local
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	nuno.sa@analog.com, Vinicius Lira <vinilira@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: mcp3422: write bit operations with
 bitfield macros
Message-ID: <aeLRfy4k_9hLhEpG@ashevche-desk.local>
References: <20260417165747.507487-1-marcelomlage@usp.br>
 <20260417165747.507487-3-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417165747.507487-3-marcelomlage@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 01:57:47PM -0300, Marcelo Machado Lage wrote:
> Replace manual bit manipulations with FIELD_GET(), FIELD_PREP() and
> FIELD_MODIFY() calls. The resulting code is more readable and
> maintainable, and 6 macros previously defined in the header are not
> needed anymore.

> Following a request by Jonathan Cameron, this version of the patch
> has 3 less macros than v1, now replaced by inline calls of FIELD_GET().
> Thanks, Jonathan! 

This paragraph has to be in the comment block...

> Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
> Co-developed-by: Vinicius Lira <vinilira@usp.br>
> Signed-off-by: Vinicius Lira <vinilira@usp.br>
> ---

...id est somewhere here.

>  drivers/iio/adc/mcp3422.c | 51 +++++++++++++++------------------------
>  1 file changed, 20 insertions(+), 31 deletions(-)

...

> static int mcp3422_read_raw(struct iio_dev *iio,

>  	struct mcp3422 *adc = iio_priv(iio);
>  	int err;
>  
> -	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
> -	u8 pga		 = MCP3422_PGA(adc->config);
> +	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, adc->config);
> +	u8 pga		 = FIELD_GET(MCP3422_PGA_MASK, adc->config);

Please, use common practices and be aligned with the already used style in this
driver. These lines:
- has to be part of the definition block (no blank lines)
- use a single-space indentation approach (no need many spaces before =)
- be located in the form of longest line first (reversed xmas tree order)

-- 
With Best Regards,
Andy Shevchenko


