Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E626393DEC;
	Tue,  3 Feb 2026 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107253; cv=none; b=VstPF5mn7g0pREcc+09h3f21r39bCza+2VM7qko+/56nRY812h+0+OzEbzSps9POTMkyCxbXmXc8b4+VzUgjvF+7LMGMfKiqf3uKwHzu4nfGZ5dG8X31+Mtt0t6TtlUJboUueWyw2lZhUI1/p+xvstcVLt3vYLRNAO94ovsqQDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107253; c=relaxed/simple;
	bh=wZTaHaiF/33npmdzG3+D2AHv/V6GwJLxWU605064i/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enusoHLPD/MuXLtVAAb9VVv6iQCoXOb3Mci9bMM99Nzv0NuqJ1RVibhSfhAy5bZ6AuExWMjbaKxNY6WbbnKD2SVgbCPv+1PLjbhDN1XxolyhWV8H7GLBcJV57pyRpLV0Qp8KVi8uyerKYCDakjSE8C0lG5jd9zyA4ESySGNzHgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVkHE7ao; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVkHE7ao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770107251; x=1801643251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wZTaHaiF/33npmdzG3+D2AHv/V6GwJLxWU605064i/E=;
  b=lVkHE7aolsXiq0IOPcDypYD7rCaFNjJ1YSd2G4N/d7LiqhUHJMXtojvb
   Cae63JNBtv0oaPwP0S6GRih5OmKLOWh2aoKro9IPptsJQVDVBVxDDbG10
   h824vU5IjhPn/khMWLERW38RqUlk7ugOLogrsQP/ClwHaITTax4GoerlK
   pVG57q013ru0+ZNP++vhlNoUFZf3ZwNALECCu/ln/jrh/85ZaffjYALWA
   Twzbdnz0ezBp80tkU/R2GkCLWS+RIrSV1yilCSbwCxG0IJsvNTQSMs5ZC
   rzJzseVuEcpZ9XRGysTiR+tcnhpG+fWGuY9kqklm1LZBWIVnJyTXbrhAD
   g==;
X-CSE-ConnectionGUID: gfcqgRHUT4CybsTHJ2NVXw==
X-CSE-MsgGUID: mJK3cd+yQAupbRVyhHz9mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71312039"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71312039"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 00:27:29 -0800
X-CSE-ConnectionGUID: aD5McrngSIGmkzeMyGfegQ==
X-CSE-MsgGUID: 97j4Y0uwQ+ah2PIPl84nZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209565370"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.13])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 00:27:26 -0800
Date: Tue, 3 Feb 2026 10:27:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Waqar Hameed <waqar.hameed@axis.com>,
	chuguangqing <chuguangqing@inspur.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: ltr501: return proper error code from
 ltr501_get_gain_index()
Message-ID: <aYGxa1E9WnYLXlet@smile.fi.intel.com>
References: <20260202120715.25625-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202120715.25625-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 02, 2026 at 02:07:12PM +0200, Antoniu Miclaus wrote:
> Return -EINVAL instead of -1 when no matching gain value is found
> in the gain table. Update the callers to propagate this error directly
> rather than overwriting it with -EINVAL.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> static int ltr501_get_gain_index(const struct ltr501_gain *gain, int size,

>  		if (val == gain[i].scale && val2 == gain[i].uscale)
>  			return i;
>  
> -	return -1;
> +	return -EINVAL;

I would use -ENOENT, but I'm not sure if there is any ABI involved (id est we
return this to user space).

>  }


-- 
With Best Regards,
Andy Shevchenko


