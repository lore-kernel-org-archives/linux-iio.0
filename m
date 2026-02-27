Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476313469FA;
	Fri, 27 Feb 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214213; cv=none; b=q4j0nqT97M66tsawqbc7Ey3477pmtWzIYRmfYcBo1wXi3kxW5QuyLe0bOEw4KocpbQMVywLBmXMDRN4p7ZfSzRy612nEhRUBE25MJQg6nn21DiIBjRF5EyHHdfLa8Bkd+6WK1utbA1m/BveXxncCc/vjCSQLY/bJ3xvIIQXcfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214213; c=relaxed/simple;
	bh=un/5i450Ou18z5phpdhmNIyhCrOODsboVnbv4vk4s8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1IXk5I4ZSSly2YfTZDiUssguUegDxXqpLtPWcBqma3RgefI+OYCnaGv56gZDF6X+1Bf5fUE1yiL4c0hjmIzVLkKdB2085XWNC0P5GRGIIpSJpD+b0/9cUT9dI/Wx31c/5I94a3rB/swhj+LzJgBe3vj5KjRFTDjcCYXVkHjuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ja+EicOx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ja+EicOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772214212; x=1803750212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=un/5i450Ou18z5phpdhmNIyhCrOODsboVnbv4vk4s8A=;
  b=ja+EicOxkor2bR70HVzP5IKUSf5qwlQyLCW1sGneKUvVGWlAYnIBafdc
   nDlg8pKXHCZt9Y2wCthmcPj1VJlTrKGJeUPUTNQpZ10g1+wCNUGF8K9SK
   zuphLzfu8aJ97BQFZAiTgaJ/YXEJPnX7Lh4RBHfCZifTWaiEoehcAwsWV
   2H9S1zayKq6Fqxwyg2qGYUKMsx+dyisVpMtOQAZW9okLha4dmLp7kfYb3
   gqJsj7r+IlfwiDYOTvah3IDFgFNJmGwMFEO4biW+NpLsIDEjjDp3N8b5/
   ZtuHH6X732aosuVNRWd1akdfMAExlqu/N9kSfSGy2SMWMcjPlzXeFrz4I
   Q==;
X-CSE-ConnectionGUID: DbgGeTqoQ6e2lOWgtZYfMQ==
X-CSE-MsgGUID: rC0g4jJuQ+SnF2/jjQHeVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="83633192"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="83633192"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 09:43:31 -0800
X-CSE-ConnectionGUID: 0sJ19TptSByz7ucYTWzaHg==
X-CSE-MsgGUID: vGxg6ccwQ/yhy7aqg6PapA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="221101117"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.180])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 09:43:28 -0800
Date: Fri, 27 Feb 2026 19:43:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ammar Mustafa <ammarmustafa34@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs: iio: ad7191: Correct clock configuration
Message-ID: <aaHXvvorPCZ3nBhJ@ashevche-desk.local>
References: <aaG6Rds7GAf9ZtF8@ammar-VM2>
 <aaHA8U3HrIbg8D46@ashevche-desk.local>
 <aaHVB1lLuXIw3pwt@ammar-VM2>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaHVB1lLuXIw3pwt@ammar-VM2>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 12:31:51PM -0500, Ammar Mustafa wrote:
> On Fri, Feb 27, 2026 at 06:06:09PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 27, 2026 at 10:37:41AM -0500, Ammar Mustafa wrote:

...

> > When I see such a confusion in the documentation I propose to replace HIGH/LOW
> > to active/inactive or asserted/deasserted.
> > 
> > And no need to swap the entries.
> 
> I haven't seen anything in the documentation to believe clksel is
> active-low. I agree that assert/deassert would remove this confusion. I
> can resend the patch with this change and without the swapped entries.

Please, do.

-- 
With Best Regards,
Andy Shevchenko


