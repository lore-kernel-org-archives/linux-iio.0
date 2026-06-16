Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41230D40E;
	Tue, 16 Jun 2026 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605952; cv=none; b=UHC0s0dAeT+Qa0DmC3WuDHwbD92Yudk95aIcRmKrznDEMb+WsC52BrBQEJ8irn5ikHrf2UM41ebEE9W8dVurtT+88tJF0BuPqNC59ENNNw9YWuTqDIAIUiwS60on95PHf1kQab36oMn5tzXsk0z4rGlENKK4V6c6qQCi/42QhzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605952; c=relaxed/simple;
	bh=QS7264d7E5K3+fnqdbxWEuO3uKgrIUv5mU32zMC2+gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8WzPY/ugFjVuP+VPAJ8J0OVNmnAxKC9DMOrQLZmMkEqEPuzebBf0yXIMaHt/I+it4P1/b0GqdQsKoCBGzuNUQ5CwJsjQ0CHgae/z5LmPlxS+NpZy7Drc3o03A4/H1M5cJNkSzC/pgcZquEaNSWBMWku9QtGhQTwoHFH1zlh+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqQKVA7n; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqQKVA7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781605951; x=1813141951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QS7264d7E5K3+fnqdbxWEuO3uKgrIUv5mU32zMC2+gA=;
  b=ZqQKVA7nc1WtAOF0oRrsVkfSlAD4lsavTpZKpn2OAJ+JAY9auPy+5Xa4
   gsb4/bPfKcmkQ5A3ybiOqaKN0v0HZfC4Gn253j3jVI3KXNd6UZ+xwr44h
   zkSR0O7JCKQAv9A81Qt0uOpwt+4d/n/Cxw4DR6zeFzbu9kH0YEJREjpHa
   jlVypMAtCGsMkCPN9xxPdLfqKYp2yjwonhESDYyNoR6twfBL15ZAdrxkV
   CsScEjqLETf5vm4YkAzcBdo42fk5QzNFWEImNvd9Zj2BfvNh0GHOlKpEk
   SJfkW94+N0TsQ55w9Y1JzYXw/ZeMBcALAjUpHqpLZPTinZSyOR14HGA4o
   Q==;
X-CSE-ConnectionGUID: lZpY9g+eS9eYiXU+T1kMGw==
X-CSE-MsgGUID: cVrCkXR6QluqHKccNSgiPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="99939566"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="99939566"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:32:30 -0700
X-CSE-ConnectionGUID: TikQX9rpQA+Zk8GOrIVCzQ==
X-CSE-MsgGUID: 3yzAtVzZTZ6KDPCd32AlNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="246854830"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:32:27 -0700
Date: Tue, 16 Jun 2026 13:32:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 07/12] iio: dac: ad5686: add ldac gpio
Message-ID: <ajEmOCh8hdmfTHKW@ashevche-desk.local>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-7-f829fb7e9262@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-ad5686-new-features-v3-7-f829fb7e9262@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 09:21:13AM +0100, Rodrigo Alencar via B4 Relay wrote:

> If wired LDAC, should be held low when unused (pin is active-low), which
> allows for synchronous DAC updates. This will be used to update all the
> channels at the same time when adding buffer support.

...

> +struct gpio_desc;

+ blank line to decouple generic declarations from local ones?

>  struct ad5686_state;

-- 
With Best Regards,
Andy Shevchenko


