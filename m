Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB483D0C07;
	Wed, 19 Aug 2026 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123977; cv=none; b=iXHdDAtkYANY6FjNjJ79HifUf5tMOstC4fkx5VbJxuwhNq22tCL+X4zCCKjSfhfkpVH4roBb8/r376DHOnXosKHXMQ7s6n8HTZi3yaOXwH4n3Ru6m+RkgU61l3SzyXUVyBNRuUsN3QPWQpJ0tuTBEQ3ehfwZWjEevXuuWGpapPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123977; c=relaxed/simple;
	bh=0LHSfQrJ0hE8SAWt/bJ2lltily29zhoRIQldeqI12Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oliZIIti/RfxZRPCs+jZvyGmqsj5i/yJUjyFxCN2w++eq5xarQ4zN6GUz6vDAElYZ+EZB2vtVz3KPdzp5Nsblr9r8hZhxkUBO8ie4iu/nXfrS6cVumMbJ/dVlpR/QEFRzlR8QfShHfq8+loyw/+Gy+0Av3WBRWmlCUcNsRIl/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPXA935w; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPXA935w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787123976; x=1818659976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0LHSfQrJ0hE8SAWt/bJ2lltily29zhoRIQldeqI12Bo=;
  b=CPXA935w8mGbtIfn/TAE21Ljzdau4KfxuOiu6KyrkBO8studgnb0BEoe
   z+QUWodck1qG/KHP5qIkjUygVYritJqbBXQyu7nA+8HDBZp3m3X56qtzJ
   o1/+41NpePOo9Lp01DoWF+NLad+mysaLHTdsE0mc5hpsxs0f2olMUX9ZP
   Vj/v4adxy3KHf7Rgu9TlpIs9UeUdoPYa4B2CfqZTuYvf2LfINLqInc++Z
   yE4FZNjN+Bx42rvox+urG4mlf69JoMqkvIU78osw3DIopqoKs+d6hlljP
   6LBUSidyhKZmZTC+1efQHnMdxlFwtc9b36iKUztPEhVWWNg3aRCPLXQzS
   A==;
X-CSE-ConnectionGUID: V9ulcl4tRBOH7zjdSscraw==
X-CSE-MsgGUID: q15s23j7S/2N/+Q2H/xOEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="90147933"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="90147933"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:19:35 -0700
X-CSE-ConnectionGUID: G9zFhxtATVyIB/9kFt8KGA==
X-CSE-MsgGUID: kqw+WNQWTcuWYA109+MCTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="269732926"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:19:32 -0700
Date: Wed, 19 Aug 2026 10:19:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Rondon <grondon@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: accel: kionix-kx022a: unify staging buffer
 and convert to iio_push_to_buffers_with_ts()
Message-ID: <aoVZASgQc8itDIyI@ashevche-desk.local>
References: <20260818215122.52715-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818215122.52715-1-grondon@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 10:51:20PM +0100, Gabriel Rondon wrote:
> v1 was a single patch converting the two push sites to
> iio_push_to_buffers_with_ts(). Reviewing it, Jonathan pointed out that
> the driver carries two separate staging areas holding the same thing
> (buffer[8] and the scan struct), and asked to fold the cleanup into this
> set.
> 
> So v2 is a two-patch series: patch 1 drops the redundant buffer and
> routes the one-shot read and the triggered handler through scan, and
> patch 2 does the deprecated-API conversion, now with a single buffer to
> push at both sites.

Good job!
Assuming my comments are being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


