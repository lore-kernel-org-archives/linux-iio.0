Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF943E49B;
	Fri, 27 Feb 2026 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208426; cv=none; b=YdhYpidqEpkbaXsLUni0+BMJs+SA95fKZ9AC4bs73R9FaH/shcdZcrt7/uStYQhypLW9zG42/o6RTJx2+vsRs6qv2bgFbYVhARqctMxIFMfX5fqx+c79bAe/TEWOBrSaM9T6cqiARvwHh9kLEeZj6oN7lvL9NRJNmEtSLKeFVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208426; c=relaxed/simple;
	bh=Wf9CbiOYqKkA612DIbpvEIeS8PIJAQaFnOK84uTePZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmZqhwfmwfnrw4SrrF2nR0VMLnPEPd+9uJTFp8NhA//GHpFhoidV43L3v/6i1A1RaS40ZWeDNk6BbqJ0esqfUVRaj192LsG9z5bKxEP+X+wZ/brlvYCMxnt5FBbxYhhNxqpJ/g9LTtbGMCI5ZH+53fCUGewj0QE81T1n8eTThww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fb/6wdby; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fb/6wdby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772208425; x=1803744425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wf9CbiOYqKkA612DIbpvEIeS8PIJAQaFnOK84uTePZE=;
  b=fb/6wdbyJkG7iri6hw7mTn+DdP7dHVUPJqei/zsc5XP5Tle3nH5aCurz
   w8rXg5svJLAXNfDSucqvuf2XFBqZlTLhWe8vnKqCNljXt4olr8tDAFKD1
   4hKSVv/QqHiP1UOeXQiuHPXyYvbf/H2inuyRPlC6J2ugJHsu2r5Ba81Sk
   JxZfacc8VWGmsaM1q16kPKUkHeHjLC7BCjYhzL1LsW9TS6DhKcloqX4my
   ChALLTq3b+EAYb0+XpcRQXIdllVajTN808d1qa84rNoXPJdIEn+Vd5Czk
   KzPLZqOfThOncgbPu9dBUutv+aWHmWSp3w3PzF54ZsS3+DUk8cBbvHnCE
   Q==;
X-CSE-ConnectionGUID: R30qPXO0Q6eGZP/lkULvGg==
X-CSE-MsgGUID: VNbvf4wzQjWAcqSMhwxTcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="75896308"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="75896308"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 08:07:04 -0800
X-CSE-ConnectionGUID: nli+o9wvTfaa9l0Jvlqpmg==
X-CSE-MsgGUID: T6JvYvztS2WsE4frp4f0Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="216950749"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.180])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 08:07:02 -0800
Date: Fri, 27 Feb 2026 18:06:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: filter: admv8818: Add missing error code
Message-ID: <aaHBI9lqzxP73NQ4@ashevche-desk.local>
References: <20260227061424.1135505-1-ethantidmore06@gmail.com>
 <20260227061424.1135505-2-ethantidmore06@gmail.com>
 <DGPJFWN3WNIG.1DDAHDOZ7TTK@gmail.com>
 <aaFCWLknDa9MSzXS@smile.fi.intel.com>
 <3c4964b1-9592-401b-a44b-22dace6cf81c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c4964b1-9592-401b-a44b-22dace6cf81c@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 10:01:25AM -0600, David Lechner wrote:
> On 2/27/26 1:06 AM, Andy Shevchenko wrote:
> > On Fri, Feb 27, 2026 at 12:42:11AM -0600, Ethan Tidmore wrote:
> >> On Fri Feb 27, 2026 at 12:14 AM CST, Ethan Tidmore wrote:

...

> >> Just realized I should have used -EIO for the error code. Will wait
> >> however on reviews before v2.
> > 
> > Why -EIO? Is it used in the same situation in other cases in this driver?
> 
> I think EIO makes sense here. We are reading from a chip. And if the
> values we read aren't one of the expected values, the mostly likely
> reason is the chip is malfunctioning or noise on the wires.

Makes sense, but needs to be properly spoken in the commit message.

-- 
With Best Regards,
Andy Shevchenko


