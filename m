Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9651427A;
	Sun, 17 May 2026 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779002045; cv=none; b=keTqnMdvsRp6na0nzVse0VTM5jTEQTdCe6DFYrw60jtUXaeqtU+//3KzrRxteiST+qCWLEVlgrWIwvl54hvdKhDX+32RgRaZJmy5EpSmb65GGsti2j8tsUpCbzz/TI4kX3AJF+Gg/zTDzALusW10GNlfuLnFMF8q6nFAQsD1TbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779002045; c=relaxed/simple;
	bh=VNwiaPHmQRY8Dz3WVcFrx3+/8AJZAVA/HIuqnhBAWDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUsyyZtEjPBPoLkqd0FPkG5MunfkhY+MNRMHELvj3j+1/GbKdZ5hSYIZ/e4VFV0vVN3ctKoESYPj5+DIH1csV2zOUbG13oKukM63YwAaVo4LVbj30a6ymBNK0NCsmamev+8cPrpE0t/slhEF4y5GhMVMxuKJdJIzdru2vBupjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fae+FCtw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fae+FCtw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779002043; x=1810538043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VNwiaPHmQRY8Dz3WVcFrx3+/8AJZAVA/HIuqnhBAWDY=;
  b=fae+FCtwk0jnCvAEr7vsGjXKONFrUrTvRiD4MBxSbbfZreT4B4DPr5D5
   2KHCthewqjzBmbohsx0nm0pEe2iWcoGdcglEBqCZwuAa6qU1OEk2X5p+x
   q9P+QjjWH1UfVPzv4KTgs3P/W1Sv3Q9ua9XFUG/tjjbtiYjJghMr93/In
   Ywl418RHf04mhqvdc2C9AAr2qZikUP1pqlIBYa2pcU9rMIqsWDcAX0VOx
   98J7fxzPmpfk5uKhfobMM3oxMbcp7vuA8b9Yo/U6WAge2tt3rTANwBTNO
   ViCaR8L9YEMb/wVqfcbZPEMRrk8iFA2T/UoLMkujgllUNiI5m74rvFmbs
   Q==;
X-CSE-ConnectionGUID: OqPt/GDXS/K5fs1J+I4UNA==
X-CSE-MsgGUID: OW5zsCORQ7WUEOmbckOarw==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="83745861"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="83745861"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 00:14:03 -0700
X-CSE-ConnectionGUID: hdx7uat7QK+wJlqCT8+AOg==
X-CSE-MsgGUID: qvjLm5uMQ8KfPpo43KQXgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="244079041"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 00:14:00 -0700
Date: Sun, 17 May 2026 10:13:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, joshua.crofts1@gmail.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	gregkh@linuxfoundation.org, hcazarim@yahoo.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: iio-trig-interrupt: use devm_* helpers
Message-ID: <aglqtqECV8T1kFjB@ashevche-desk.local>
References: <20260511060732.7728-1-sozdayvek@gmail.com>
 <20260513083342.764-1-sozdayvek@gmail.com>
 <20260516122417.389add6f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260516122417.389add6f@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 16, 2026 at 12:24:17PM +0100, Jonathan Cameron wrote:
> On Wed, 13 May 2026 13:33:42 +0500
> Stepan Ionichev <sozdayvek@gmail.com> wrote:

...

> So wider question for anyone reading - do we actually want to keep
> this driver?   Meh, to catch peoples attention better than in this
> thread I'll propose a patch dropping it and see what responses we get.

I believe people learnt my opinion about code removal — always green light
from me (assuming no users)!

-- 
With Best Regards,
Andy Shevchenko


