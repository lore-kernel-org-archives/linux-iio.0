Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3424338CFE4;
	Mon, 13 Jul 2026 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941937; cv=none; b=rtnQWowrpWgdAu2LWwFF/w950PJUZsNnY/6wLpKdzWDbWDQh49yLlgeyvKaXIb5Ka6dXQCi0hMs+D3rgjgDh3mJuCEXo+wUHsZ8GHWkhyqNdyTzrcoEYJTwFY1mk699Ks44OvhG/vLGzaajNiVQHYZFPxwj5zCkQjMvUNqFnt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941937; c=relaxed/simple;
	bh=ro4N7zF3u8xw8ldiRKiwH8VTeu+sXM9egBFpIp8d9RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZp3Nkxx8VBnDRj0lUoRcfqZlRbZSkRo8N88kxRJJYQgkQwvEwpW8Zw1ii2kR3I/a0L2HMJBCiQXOq/V11G+1SklukSkYBG+2gsXHNrhZakMWXU25PsPEwnAaPBl/SlSWU8zcKnVS9XvK8ouGmK/4KONyWMMquO0o6rdiSq09xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJ8xABxs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJ8xABxs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783941936; x=1815477936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ro4N7zF3u8xw8ldiRKiwH8VTeu+sXM9egBFpIp8d9RA=;
  b=EJ8xABxsu65m/TO4+LjucowObQ951kEegS1zmPvoMhyJKZhIHALyUzgz
   E38v72a13SHJJi3qyQH3NY4tbLueIVRO83v14cGHnj9fd64KBN/9ub0T6
   0RFnvhaj4CGMPRGAmxC8qGn34JZVxhgbIjkqiQUkp9mjkzaPEk5FSPdxC
   CyTo2WOlVEdHql/n563kXoVDkVBtEJoSfCPtaiX4oApPFZSCjnJcnUX4y
   5xT0M6NCXIaAmdqNS8yLlRTzQCCIB4QJQ+MvVwCK+/9LwoTRNBtF/wMsT
   56VMYZTJkXv5E4PAWLO036EqAwNg3KTy4Byqy5a+MBInQlSaGGqnMtoMW
   A==;
X-CSE-ConnectionGUID: vU/9KaMFSc+ZNbsYBqL8vg==
X-CSE-MsgGUID: NwTlcDxpTRmB+3M12QVV9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95916786"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95916786"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:25:35 -0700
X-CSE-ConnectionGUID: TFMlj9U0QDqscX0Yb16BGA==
X-CSE-MsgGUID: noVdQzSmROaHuWWlXYk39A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249165168"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:25:34 -0700
Date: Mon, 13 Jul 2026 14:25:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] iio: light: opt4001: Fix reversed GENMASK()
 arguments in fault count mask
Message-ID: <alTLK220iMW25v6p@ashevche-desk.local>
References: <20260712202451.20822-1-nikhilgtr@gmail.com>
 <20260712202451.20822-5-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712202451.20822-5-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 01:54:51AM +0530, Nikhil Gautam wrote:
> GENMASK(h, l) requires h >= l, but OPT4001_CTRL_FAULT_COUNT is defined
> as GENMASK(0, 1). The define is currently unused so there is no
> functional impact, but fix it before anyone builds on it, and add the
> _MASK suffix for consistency with the neighbouring definitions.

...

>  #define OPT4001_CTRL_OPER_MODE_MASK      GENMASK(5, 4)
>  #define OPT4001_CTRL_LATCH_MASK          GENMASK(3, 3)
>  #define OPT4001_CTRL_INT_POL_MASK        GENMASK(2, 2)
> -#define OPT4001_CTRL_FAULT_COUNT         GENMASK(0, 1)
> +#define OPT4001_CTRL_FAULT_COUNT_MASK	 GENMASK(1, 0)

The original indentation uses spaces only, please keep it the same style. Yeah,
it's supposed to use tabs, but here we are (it might be the material for another
change in the future).

-- 
With Best Regards,
Andy Shevchenko


