Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD101DF970;
	Mon, 23 Feb 2026 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837628; cv=none; b=m51MCX1W5+fjAP9DNy1J4rAciXILUBv5LH9mnEXGzIk5Ko5AnHqZ71/BKUSImcHSXou9K6hhN6EjP8hs722tbOuDRdhtb15UpHrj9vEi23/+YLGrBPwM72FYDhqdQFLIj85Z5E7S6yXWn5G1/sTgBEGV747u6HvCeYymSknHoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837628; c=relaxed/simple;
	bh=d46aqTnDs+Mm/zbGQlxidnLRgvcQt9C4yPZWw2w+sAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSgIIYK+urt1sU8rJHHN/Z6wrY3mk3ZCDwcvjWjLx2r9DkQtjWF51wFtB6TGBU79oHAPZo4gQSR8EuvT6D+nnvNysvExfPZwz3Yh7Bj8XelZ3W024UJcDXiD8KJkdGrUJg9yrnFqpLoeoqdyzJ5i3ic5MBKgmtCZB5BhmBp5D80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeoP/tJY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeoP/tJY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771837625; x=1803373625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d46aqTnDs+Mm/zbGQlxidnLRgvcQt9C4yPZWw2w+sAU=;
  b=VeoP/tJYNi3PKy1+LB4D6apjF4LWEl1Z8Bg4wvqqn16H2WpEktzbdiLW
   RJnhUn8q5gMda//608kSjXZlEG2ZU0w/gDB5VUg+bL/oJnvtRDgHXIZtZ
   5SObQFkFj/UdiPADYLRZdR1TJvoTJnpZXLz8QycXklEdT1TzBgOCHulDy
   +tDlSzGvjtkSOyDd5UKvR+uXKiObUk3tS7EQ4x7TuQZW/9AMrRtcLci+2
   v/TfluMHIPWXHt9CEhNPzNf8blxDgurAL94dejBk1/8Tg1N252fUnO62J
   4eCmgJ8Bs1hmpwEdZpYCLekiqqlH3zKfLdAvtqXegw9PEldlAEdxiQz+V
   Q==;
X-CSE-ConnectionGUID: EJAs5FpoTquPXvpaXGTwbA==
X-CSE-MsgGUID: ARXcX07sQ1aIO3WZt0Znhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72888631"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72888631"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:07:05 -0800
X-CSE-ConnectionGUID: CfqNt2H3TlGCu3hiLiRfdA==
X-CSE-MsgGUID: foi3RX4STLar/wmYx6XyXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="246095289"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:07:01 -0800
Date: Mon, 23 Feb 2026 11:06:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
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
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v7 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <aZwYshRxNgSh3CWk@smile.fi.intel.com>
References: <20260216-adf41513-iio-driver-v7-0-b0ed387ab559@analog.com>
 <20260216-adf41513-iio-driver-v7-2-b0ed387ab559@analog.com>
 <20260222172912.60a103c0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222172912.60a103c0@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 22, 2026 at 05:29:12PM +0000, Jonathan Cameron wrote:
> On Mon, 16 Feb 2026 15:02:17 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
> > to parse numbers from a string.
> > A helper function __iio_str_to_fixpoint64() replaces
> > __iio_str_to_fixpoint() implementation, extending its usage for
> > 64-bit fixed-point parsing.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> Hi Rodrigo.
> 
> This looks fine to me, but given earlier discussions I'd ideally like
> to wait for a final review from Andy.

It all depends on the series from Dmitry Antipov.
Can somebody help reviewing the patch 1 there?
https://lore.kernel.org/linux-hardening/20260212125628.739276-1-dmantipov@yandex.ru/

When it's in, we can continue on this one. TL;DR: for me this is on hold.
But if you see the need to have the driver being in IIO, please add a big
fat FIXME to make sure we will get this all being sorted out in the
(nearest?) future.

-- 
With Best Regards,
Andy Shevchenko


