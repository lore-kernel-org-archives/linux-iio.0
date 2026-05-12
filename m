Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7053A5994;
	Tue, 12 May 2026 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591588; cv=none; b=de4VC14D9zBwHbX0reYysUBkRX/D9/t+mxJR8RrKtK4X+UQWja0wq0N0xcE0v9KNdwROtLu8rSmYV8McpKd3ALeUxkBtCzeQXuZCsxW0asEwGp1qb2pGvyScQqgpBZNDHzSIpC0n50o90wTYc9CkYNFjZ2CCFPWl7PgCXRlvOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591588; c=relaxed/simple;
	bh=wJT4v6gWN2FDSAFVtjbMcwPyBY13R3xdWR2y1oTEGXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQtS+pHlK45fapE+Q966OxfWQ4yLl4PnZTH4RSP6uzRm4Ftjp3xj14Ak7oKnfdkvz8UVzoaocyMWIfRml1fVMB2loiWAmmx3gqcsy2GkutEvDlsXKKAa1jakDROBM2OVuvq8WsPY30xDb1MBOY2pfEkWzEZvFHlXdAB5trjNx8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/DCWe4D; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/DCWe4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778591586; x=1810127586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wJT4v6gWN2FDSAFVtjbMcwPyBY13R3xdWR2y1oTEGXA=;
  b=S/DCWe4DJxnbyYmrWiNSMixJmuz+MvPZIWKLKzDPx0ft/HQHvGpj5Xsl
   6fZZAp474qqiGfo3VRMWBdbUY7ZDoimRRTFnnTJNjiJNwAz59tzqE2mmJ
   /IEGHQ5X79+JinCYnXBh+ogtG8t78Y/Gno7iMew7J/X7/kqRo2TmDXCnb
   07Uey1EMFRSYekSMhOn5tsZ4wqWpjvmKbVIkHstfJrh5OLuveqvbQmO0+
   FuuZNXfUyFKBRJi7Jo7BTeSzbE3JFedH3/eJInGRw9m9DE8J8RgCittWI
   YXQkdgLLX8m5zog/eEo/sYfPY+xmN1noVB1hdoSTdbVsiKDIgxDd6t7st
   g==;
X-CSE-ConnectionGUID: CvypfPS5Q/y4z+54KySMkw==
X-CSE-MsgGUID: ZPNwYf1kSXKRwhXiXd4wHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79215682"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79215682"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:13:06 -0700
X-CSE-ConnectionGUID: oLZvXZ8xRpemZGu9n9+HJA==
X-CSE-MsgGUID: P8ynEVxDR/KGECxazKp+mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234702732"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:13:01 -0700
Date: Tue, 12 May 2026 16:12:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>,
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v12 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <agMnWzMjW1LwCSyT@ashevche-desk.local>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
 <20260512123953.40d80bc9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512123953.40d80bc9@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrote:
> On Sun, 10 May 2026 13:42:20 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > precision). After the decimal point, digits beyond the specified scale
> > are ignored.
> 
> Whilst Rodrigo has already replied to say there will be another version
> I'd like to request final feedback from those who were involved in the parser
> discussions.  
> 
> They got very involved and I'm far from an expert in the right way to do
> this stuff.  
> 
> I don't think David Laight was +CC so I've added that.
> David, Andy - I think you two were most involved in that discussion:
> Any objections to the end result? 

I already said a few times about the naming. I do not like the kstrto*()
be semantically different on how they treat the input. Second point is
to avoid code duplication, but this one is less of a concern since the
new code is in the library close to the other potentially duplicate code
piece and hence can be addressed later.

Having the test cases is a big benefit, and that part I like the most.

-- 
With Best Regards,
Andy Shevchenko


