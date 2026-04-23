Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D12178372;
	Thu, 23 Apr 2026 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930675; cv=none; b=lb7IbxLWNLbSsXu2AEKp3iV/qTnpAiTX+uejSKxnzRduRuod8QFOyD1iKwfgFT3Tf+RceMteArqIwGY9P5wPuaP5E2oS34enaLTgIBogTqWKmRcf9j28F0jq/asBXVrGUeyuCqQEmQhU5AFf/ZczdU6LFGPgPRl/BuBJ7hYkryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930675; c=relaxed/simple;
	bh=xuLwZuuTypbJn1lu0ZUZOuR+xB0AmlyFNC4+1TplaSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTgeQhr17gVGDcsBFKg36HA+XGv2Lp8hwr2x+nTVgVCt4/77HGiNxOrgCYfyofKYLRV5WVKjts24nuCxjlOAjOwBCDuWe5LSqzQ00n0E8mbKlGADAeNVlTANhw/pBkqXlzy5wHhsIM0d/5J7LZcJ5FlTOqMvQ9FqZLOMFo9dQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADmk4ngQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADmk4ngQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776930674; x=1808466674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xuLwZuuTypbJn1lu0ZUZOuR+xB0AmlyFNC4+1TplaSc=;
  b=ADmk4ngQVYeOF5QNipG3ZUgMW/0B6K9nBuRSdP22fcknsUQ6TmzzqX7A
   GMSeaYdoznJqUKazY0WL7u9Rjc5ptYVMrWxyeOHZZlTV958ruZwvrj8Zf
   9+yr8/metuitVOJesDWCv035r/NDSIqqXdyS3qyTzJuv1mfP/SKX7ny8+
   23g3D/McuiOrAskOtq2uJ4CCl4hHBBIVS9aBLR73LW7Lo9ujFhETPh/Ob
   nVDN0JWBvxZzOoNmlhPjX5KqJkf+55KE6M88p/77YVNGrzXb+64qwUqM3
   vyM08uv7ktPzhwmwmcF0NG4oMknzMFjAPwC2Xo6VM4jZqP7Vw7CsHZCXz
   A==;
X-CSE-ConnectionGUID: TuCgdwmUTx2T/mhrSVPUpg==
X-CSE-MsgGUID: e855oWVNR3KxsmQ01PQVmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77772115"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77772115"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:51:13 -0700
X-CSE-ConnectionGUID: KS4N2qAgQqamn4fGdaomFw==
X-CSE-MsgGUID: 72fLrZ78SbqtM+NZ4d+56w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="237570335"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:51:09 -0700
Date: Thu, 23 Apr 2026 10:51:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: accel: mma8452: use local struct device
Message-ID: <aenPbdqSifpsH5HR@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
 <20260422165643.2148195-4-sanjayembedded@gmail.com>
 <aekjBaFT8xvM64zh@ashevche-desk.local>
 <BA5F2EF9-C439-47A2-BE91-4ED6E12F2EBA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BA5F2EF9-C439-47A2-BE91-4ED6E12F2EBA@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 23, 2026 at 08:06:20AM +0530, Sanjay Chitroda wrote:
> On 23 April 2026 1:05:33 am IST, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >On Wed, Apr 22, 2026 at 10:26:40PM +0530, Sanjay Chitroda wrote:

...

> >>  	int ret;
> >> +	struct device *dev = &client->dev;
> >
> >Keep it in reversed xmas tree order.
> >
> Understood, along with headers would attempt to keep all local variables also
> in chronological order.

I'm not sure. What does chronological mean in this case?

Reversed xmas tree order means to have longest lines first. The assignments may
have dependencies, hence must follow that first and then the reversed xmas
tree. Returned variable might go last in some cases even if it's slightly longer
than other variables for giving it a better visibility.


-- 
With Best Regards,
Andy Shevchenko


