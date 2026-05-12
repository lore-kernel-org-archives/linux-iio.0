Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379CA3EDE44;
	Tue, 12 May 2026 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608281; cv=none; b=Hwq1/BV/gfShAYKOWr6Fes+vc5RdMkuJXcHJbRZEqo4iAqcJZ4L53OWivP7j4vwNN4RbbnLZrhu/9Q1/aeKaAJ+a1ljUipOWXlLK2SjCnDdUxU9vMGUqHEAvdRzWauxRhiZsb0/L/ZOxwVkqc05PKSZUYL6extCjgMJrfEXBKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608281; c=relaxed/simple;
	bh=bvCUcVn0iz8TaziT0OwkzCF7LWKUIolBmuyiRNVGJKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPXpR/4pkKGuyormCsQ2HVGjfH27DUn+DRp1YCjE0KLY9nonfMrF1GCfpTudNgVbhjh5Pd7FEu1gameeB8ETuLJ7nbdjxe9/ItWvibQN7kDJaRhyg9EH6HnIWfnv/iN6a3m5s1l0xOcwLbfPBaXnmQgqEyDJ8PwKV23ZEzdZdx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmoUTQYJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmoUTQYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778608281; x=1810144281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bvCUcVn0iz8TaziT0OwkzCF7LWKUIolBmuyiRNVGJKk=;
  b=gmoUTQYJ2oZisHfwmga8+NanWKLI9TT62joXBQbJ4hL1xO/1Kfnxg0WP
   p6nFeiQUKQKOV+E46L2aW5z5uQRdCZlhDAjQK0AgVUTQC1HREQwacNhtW
   wlSIKs4LRHbFZ13b2HwNf6qj8eEXuKYZXWcZYSHKqTPtqk46r06riTR9x
   SPB4KF5sA/0ngVK+bRUcz8HX7CS6ZNv74qXxxWSdS6/uAQLZBb01kssWR
   fvNk9WQ/EI6PU12IrDWYnPqLl0jdWupHWFETmLKSMYWIXIsqVlVNHz4LG
   R5zc5/wj8wP1U+5LlnGUT6zwYgKo29EG3YAEWHFwfS1NoMynjVQggdjUZ
   A==;
X-CSE-ConnectionGUID: Bz/tJAMQQT+n/37fDzD/iQ==
X-CSE-MsgGUID: wPJxq4kXTi+G3do6vS6lIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83399359"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83399359"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:51:20 -0700
X-CSE-ConnectionGUID: duHizHbVQ0yTS4fddgm0kg==
X-CSE-MsgGUID: VsDxFZLqSvKkOMBd6iNnNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="241847653"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:51:14 -0700
Date: Tue, 12 May 2026 20:51:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
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
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v12 06/11] iio: test: iio-test-format: add test case for
 decimal format
Message-ID: <agNokGNa1wh-kIHb@ashevche-desk.local>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-6-34af2ed2779f@analog.com>
 <agM7CT4RjzwliKmb@ashevche-desk.local>
 <zugkmatjsacla7l7nguekmclfdkzsshr3gs434a3liccgokxb4@xg77y5tkts5c>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zugkmatjsacla7l7nguekmclfdkzsshr3gs434a3liccgokxb4@xg77y5tkts5c>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 06:02:22PM +0100, Rodrigo Alencar wrote:
> On 26/05/12 05:36PM, Andy Shevchenko wrote:
> > On Sun, May 10, 2026 at 01:42:24PM +0100, Rodrigo Alencar via B4 Relay wrote:

...

> > > +	iio_val_s64_array_populate(24, values);
> > 
> > You want to test this first...
> > I think the previous patch needs new test cases.
> 
> This is no complex stuff.. those functions are straightforward and
> goes into accordance with what the format function does... which is
> the opposite, before populating the buffer. The assertion on the buffer
> content accounts for that behavior.

You never know what BE32 / BE64 architectures will give you...
(but okay, it's simple enough to check the implementation),

-- 
With Best Regards,
Andy Shevchenko


