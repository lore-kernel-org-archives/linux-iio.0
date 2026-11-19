Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121750;
	b=lbcwfDz1GXtz49X7Mgf1j1Wdokegw/tFaIO6njTR8yReJkAdVFLmEEclkzq/iIVycOfb
	 NOMg+zPhiZ9WlA4Cv8OTH3aMbbeVu52ult/KgwI8jJEfVBThzKrrx9wCba1KdLiO373x3
	 YBOYuJx6OOQOkq0TdZ0n4UHk5mxKhNsa+TjlvCPW3LUDojoDu7XIxfSKTyLNJc5YL98XZ
	 /GLfOsMthX4FrXVwpR6KPbtaweP7FdNCPzcX/pwWLhu2AWwCpMo4Mipjb0t5dIwWs2yp8
	 0fKk+RgpNpX7eKkNgpQMRthxeVIsX8xZU/I6zZ9vdT6SBnhNeiaUNOKFEH7h6//vauA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121750;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=QdrchQaKEKwViPmtQruYJkhOojpzXcenKSVgwr0ZA38=;
	b=zhNhFQd3vXJOJn5P+w0sB6HqDsd6upNgKaaONhNIptL5CapKxusI/GkcUfpkcHhEgU7h
	 H82aimOgFMJVjXZFdgFaJfYYggCrr1ReFRusytwWmFr85ZR1rDm++CNu2o0csZ/5GJosh
	 W5WFpjbT0zmh5Ln/vXafEDJ1mC5msFcBIoZ9sbKI2M+Z2EzA/UvDluwrUvPxCQ1Dq6iiK
	 C+85FKMAJv/X8OEue9/pie56BEA3RrYfwiTqxT8pt/6HxYp/2wQGBdJAPjQl1vtpk+Kwe
	 8GBhX/OgkNkEQOlOFTm5kf0bTctwuhQ81VGExB2Ctko7BxjX1JCHI3OfoprnGvxxnsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eVTegxJp;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29161606A324
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 20:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29161606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eVTegxJp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795121750; x=1826657750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bg6pGHaGmsNmFSKgRQWlKpzCGyUBjyxuZQfCLbkshkc=;
  b=eVTegxJpRdPa36nOYdNslecoHP1NoPpRWled0wQ/jkp8JydwwDDXYApa
   FgvgvowBbjPAg1f+BUsiJ8jziMi8bTcMOScXZlBEADBYz5Tp6rfCG3hLJ
   NFNEcJtYXFu6B3agE7iB8kGIK6CMYUshk8CdWFlHap+gDWpHNqAJMEDqn
   skSjm0WXXdRPLOH4FZhV4+oESn2qXYZqSXz1j47Ez5hiyU9StAPCXP1T/
   Ww5+x72bnCiOUC9O3SvktTEsltBivjq9ezluFCeME4SXpZa5DWJrnkXJO
   +vrlr47o4P9arvunW+hmJf/NooGwOGZ2umo4V/lc5KjF3tohvGDkM13IS
   g==;
X-CSE-ConnectionGUID: W783S4/xRFO7Q29rWTUCfA==
X-CSE-MsgGUID: bzwnHIQlT7msbbHYANYnrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4031058"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4031058"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 12:55:50 -0800
X-CSE-ConnectionGUID: 3skp7vtXTjexJpn+jNxOGA==
X-CSE-MsgGUID: DUZa1IRLQnyRmeIGy407Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10754396"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 12:55:48 -0800
Date: Thu, 19 Nov 2026 22:55:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Himanshu Bhardwaj <bhardwajhimanshu2515@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] tools: iio: Prefer channel-specific scale and offset
 values
Message-ID: <av9iUQh2xbtS5dKF@ashevche-desk.local>
References: <20261119133821.949-1-bhardwajhimanshu2515@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119133821.949-1-bhardwajhimanshu2515@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 07:08:21PM +0530, Himanshu Bhardwaj wrote:
> iioutils_get_param_float() stops at the first directory entry matching
> either the channel-specific attribute or its generic counterpart. If
> the generic attribute is returned first, a more specific value is ignored.
> 
> For example, the MAX31855 driver exposes in_temp_scale as 250 and
> in_temp_ambient_scale as 62.5. Reading the ambient scale can therefore
> return 250, making the converted ambient temperature four times too
> large. The offset lookup uses the same helper.
> 
> Continue searching after reading a generic attribute, and stop when the
> channel-specific attribute is found. Free the temporary filename before
> continuing to avoid leaking it when both attributes are present.
> 
> Reproduced with temporary attribute files containing the MAX31855 scale
> values and both directory enumeration orders. The fixed helper passes
> 14 parameter lookup tests, including generic fallback and malformed
> values. All three IIO tools build with -Wall -Werror.

> Found, implemented and tested with assistance from OpenAI Codex;
> independently reviewed and re-tested with Anthropic Claude. No physical
> sensor hardware was used.

This paragraph should be after the '---' line below, in the comment block.

Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


