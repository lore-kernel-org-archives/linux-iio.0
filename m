Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BCC330659;
	Thu, 27 Aug 2026 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814495; cv=none; b=paiJMnEgcV1ujidIwgUQyvmbGfL+Fl5uaV802T4rPxD8poj3lntSNgu9WYwEKdcSMWdLXuKKL0rmq6iAdKUCKTEqYoeI95lt/E5jjH3qf0K4JLnSP07/96WvVUMSI9TVUj1CniwdCYnL3b5AZs5UiNfrjLYMq2b3ALab3RxiMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814495; c=relaxed/simple;
	bh=l9KEf0r5sCVU6nqwZPCowgL9QNHlmvVxYQkL4RKqc3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y42dvnFYFiTBsDfff7DJ4iLR7Ub6R1zgrd/40Paf9vC14EbHBL/HKntp0AyG4H28gzFggoQ4T11CeQJjGzErdvMC0VVCzLQogd/gXDro6ke46iasmYBuwan5c9BARYj7m9bIEEQzrLddHQfYW9q5mHh6fqufXAGn9AiJpauRnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EeDoB+Eo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EeDoB+Eo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787814493; x=1819350493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l9KEf0r5sCVU6nqwZPCowgL9QNHlmvVxYQkL4RKqc3Q=;
  b=EeDoB+EoJ00gRYvstoiyTNdgRFEQvIGAczp6qXjGcDDsA7o/F3C66hpc
   Kbwb8aQmDwsTn0v5+vU4y6ZqqzcHfJQhvFOWGGK6DFLi76C7c/AesaUpN
   lDjgi91V/lhoiuk30ImsoBvfzDU7qQqwBhLz1rf3CzoNYNB8k/+TaH//M
   Nny6O/qlVchq+AVUAWE991ryCCbyJFVGQ659lCMxLRMNhEOMrzwH3oCoJ
   04V20i7rsyI8TpJ+43YWgJVTsK/WF85w3KIJx/Z49yjZKQ4M4RAdPV0w7
   w7TwcbNGaMKKAYxsEYuy6WyihylY5NBlsIPSgQq9DxgOLGhQi0Rv6IM16
   Q==;
X-CSE-ConnectionGUID: /6fwVaPaQMaD+lpYwFql5w==
X-CSE-MsgGUID: deVhsyhkQWSH3CtTEkm4Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88335394"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88335394"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:08:13 -0700
X-CSE-ConnectionGUID: zhjCxEpOSAKsxWAsp4C5Ag==
X-CSE-MsgGUID: sVuUyIrzTQ22u9FihpLYCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="261666899"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:08:09 -0700
Date: Thu, 27 Aug 2026 10:08:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, grondon@gmail.com, linusw@kernel.org,
	hexlabsecurity@proton.me, sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: accel: bmc150: use
 iio_push_to_buffers_with_ts()
Message-ID: <ao_iV2xg-1Oc5Ttb@ashevche-desk.local>
References: <20260825085156.212042-1-yashsuthar983@gmail.com>
 <20260825085156.212042-4-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825085156.212042-4-yashsuthar983@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 25, 2026 at 02:21:56PM +0530, Yash Suthar wrote:
> Replace deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts() to allow source size runtime checks.

With this you might want to use IIO_DECLARE_DMA_BUFFER_WITH_TS() in the
definition of the scan buffer.

-- 
With Best Regards,
Andy Shevchenko


