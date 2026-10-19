Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436643;
	b=YVzw2eeCthL4RZ1plAwvMPqYbcid0zy4qPOlYTIZ3IsrcK07p52Vw8rMNQvw08ygvAPA
	 7RNG3K/YlrdmC7KHgeozOTMDyG7pFPRHxs9AeHPl7W4xTQEyhlGPtArGgbRZMnV9NJQMb
	 gCNmbFzC2+kJDcbS2pK62QvnrPVjpohblqZWLlz+JdF3IYQcTayofHqXX4kh0LgVIySv2
	 7o0vjE51QUTrnGU9c9Ox4ZA4fRCC7peQOFqCPU5pBe2f0lgIgL/PlwLhT3noSfhDZW/w6
	 wJj8nPHBVI6pZBeLJ8e3UeUGG6OXMQGGUs5wtzz51/Nv+os5ZvZGEpLSajZ18w/IhhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436643;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=dL8ZGUobikYXfeavA/hCoH0m0XNsNI0h4JXi+H04Ge4=;
	b=w1byPiLT3QicaMDc74213dnBVHuBU1VcGZv0Xh7+zfv77Z2sCKWhcC8Pm15yPThdv50J
	 XAyrLAgGAoxIUPhgXHXgrchOYicDb/vaIu5sCRSQuC1KH4MhXjHOWA9td7LHzTywQI7Go
	 erxwMg+nP68KeCSeszZNSCfM97abVDF/EaZLhTj6AVbAe9R/NbaSU87vA0swTpnkt0NBP
	 UXT29YuZ4MvjyFSJeU4uuAVbZ5aGYe02vmKmexaRjbZsnf2z0bnIO4lnyZbZU0ENX/FUC
	 ICQxWY98KZEwpM/FC7dW5uAsO2ec6ILDbxJfpo7JNPLDIZyFldwAoGjPFVD8ty7k7Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Liz8OJdp;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2CC606A320;
	Mon, 19 Oct 2026 19:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E2CC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Liz8OJdp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792436643; x=1823972643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J+FWQwTwrvLkVXTmczbs/r9eIiKcg2wlsFRu0rFmGOA=;
  b=Liz8OJdpPD1tPYnlcOdsa4gqlBAjMM4horDj7xNL+hOFsMrcoNUhNXZ0
   7AApGgM8Ou0I34oq81pnjdErnp5OXAlJqmWuSLCotbqMWuazFY7JVitvP
   Pl+v1dD/WX2esAn/r2U8uex4hhMtlNDQokpQQTVce1EqswKiAZUA3dGY7
   9eEBOn8GVzR9vsrWmlgrKU83GEO7HyehXGuF/mPgMveKjsfHvO6lf35ws
   GyCG7dsfg4HYA/WR3ySSDcIe7YEHWzrUzj3ufWkDcxK7uCLyz8QR6GIe1
   RmByG85g4e5V+6dsacuU4zQYPrwVj+1YAkXc/G90ABYqx5XIE0cSpnz6U
   g==;
X-CSE-ConnectionGUID: 3RVBW4zQSDyFC9pdrhh/oA==
X-CSE-MsgGUID: uayJRRENQMeTfRYoCMFnJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1009432"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1009432"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 12:03:45 -0700
X-CSE-ConnectionGUID: DaLQB0JGQtiDRU5HnhCXig==
X-CSE-MsgGUID: Ty9MtHA9QCqcz04CqgeBSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2619666"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 12:03:42 -0700
Date: Mon, 19 Oct 2026 22:03:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: amiratefabdallah1122@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: frequency: ad9834: use guard(mutex)
Message-ID: <atZpjGgTBcdVMtQJ@ashevche-desk.local>
References: <179241934543.347.7026859519510388428.20261019-ad9834-guard-mutex-v3@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179241934543.347.7026859519510388428.20261019-ad9834-guard-mutex-v3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 05:15:45PM +0300, Amir Atef via B4 Relay wrote:

> Use guard(mutex) to manage the state lock in ad9834_write() and
> ad9834_store_wavetype(). This simplifies error handling by allowing
> early returns instead of setting the return code and breaking out of the
> switch statement to manually unlock the mutex.

If you want to continue improving the code, you can research the use of
sysfs_match_string() and rather use it as an outer check.

static const char * const wavetypes[] = { "sine", "triangle", "square" };

	int wavetype;
	...
	wavetype = sysfs_match_string(wavetypes);
	if (wavetype < 0)
		return wavetype;

but it might be actually worse than existing. Again, it needs a research to be
conducted.

As for this change, it's good enough.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


