Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E356331A7A;
	Mon, 16 Mar 2026 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677505; cv=none; b=L08YYvXRHlxIqn2H9RZdC8UWTYYwYGMesbDNJPfuGtNJABtGiHpEBssvurhc1gI8QnxN/Frush8/V3h+81PhhUjTe0IF0TFwOMOKaxCvZS+thQX3k0J4RxqMn2h1hQ59VcGmnOrur4ZnI8ZQ5Aw7ZEoKrECNg+qblF1kRndlNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677505; c=relaxed/simple;
	bh=UB84hQMbp03dmy/yCFXXiQtH1mgxF6/X/mKhpi7mMJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCjKj8pJx9UQEmA347BFsfWU/b9pQFfLV7hoCGpaqkaXEvcWqxnAVKa5lEOcy8YPvN7qplqaxq8OVOaR4dSjSSeX9v43NnrMfrl2O1+fp291YnOinK/mZMKyoP9AVPkIAphswbVXQFox0WRZC16v/wNpFTrbuXN6KqNCvHLF72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c11+BIa5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c11+BIa5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773677500; x=1805213500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UB84hQMbp03dmy/yCFXXiQtH1mgxF6/X/mKhpi7mMJM=;
  b=c11+BIa57KzegqsfwBHvkOgy9DDX11exvK4UjxVZ3ITTSa2VrqgIoxlp
   F6QB+In8j/xfxT7zxyCURA7qi9uwQPcRDudAeci93w+x1mP/2MRs5m3nx
   uRIaUo/dLbLiMKHg7FGKACTXvS+79AxE9pvIcy0mVbsTKgsUb2ftoV5Ke
   szF1QASoBphXpEZFi/SNKPttOWUEayqRxaNsRJ6SVS7GUpzvtTZzlfNUn
   WPVJ3tq5gU7Uwd8Nf/W8LODv9ZAWigA+7wNRTwXwFAPwIJEqut3lrkDGq
   u8oI9AksiQK35xFt73kFSTyGMjPelq1+90IdelRZRWsrBHD/N7KnZyYw1
   A==;
X-CSE-ConnectionGUID: lffIovIfRsupSwNnSQdr2g==
X-CSE-MsgGUID: LzdguILpQ+2eNv9+AFizSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86051370"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86051370"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:11:39 -0700
X-CSE-ConnectionGUID: xpQ8C0N5Qv6JYSUQ0htK+g==
X-CSE-MsgGUID: GfC7LPO2QUWc8gHA8uPzpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217773472"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:11:36 -0700
Date: Mon, 16 Mar 2026 18:11:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, cosmin.tanislav@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v2 0/5] Add support for AD4129-4/8, AD4130-4, and
 AD4131-4/8
Message-ID: <abgrtX9_BJqB0lxZ@ashevche-desk.local>
References: <cover.1773311639.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773311639.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 08:44:54AM -0300, Jonathan Santos wrote:
> This patch series extends the AD4130 driver to support additional variants
> in the AD4130 family: AD4129-4/8, AD4130-4, and AD4131-4/8.
> 
> The series introduces a chip info architecture to handle device-specific
> differences. The AD4129 series provides 16-bit resolution with FIFO
> support, while the AD4131 series offers 24-bit resolution but without
> FIFO capability, requiring triggered buffer implementation. The 4-channel
> variants feature reduced analog inputs, fewer GPIOs, and sparse pin
> mappings.

I found no issues that need an immediate addressing (can be tweaked whilst
applying),
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
for the patches 3, 4, and 5.

-- 
With Best Regards,
Andy Shevchenko


