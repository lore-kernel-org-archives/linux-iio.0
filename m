Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CE332EA0;
	Thu,  4 Jun 2026 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602694; cv=none; b=dCWH/C3v+mO652Hc7UDaUTEyek4rp9e0c7P1kVSwmbdEZQBymBmT3Dxrfox/vhLlOOutYIhLhzBV1rDILfWLJHf+Aaj7YYdiswdIjz+gSK3iWW8EiJ6vG4VXK/cleiP6rBe8yLqqKnfz1IkjtJM3kCqLfb9aw7rGDXDPGF7V1sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602694; c=relaxed/simple;
	bh=n6pBHY8sW/DBoa2DshNKKPArSOb9STl7RBpzQA1tYx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4aJsRU4Eu9BIJaw92Y07XS1lPH3z35+aGBcHNxuQf9ZH1E2fXnnSTyRBsJ/TVekRHkeoNZXuwU+//gmrBS67pBydIv8LhNsHGQJonj7Vsy2gDm8xGt7XGfKK7KwYQ3/H7eE2xeUDJGbryQ2cO30qNEI8+7ZPI0hIzkeDD1c2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWVRSmKX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWVRSmKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780602694; x=1812138694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n6pBHY8sW/DBoa2DshNKKPArSOb9STl7RBpzQA1tYx8=;
  b=mWVRSmKXhY6klCVfnnGt2CEj5mG027ic8P6V2btYHNrXfZtZDVSoxu63
   +UN+N5LYpxhAa5shx+8ZH5TlaRGNaY9+1mpkz/sugf8JnDyLQhBamUwU9
   g6piME2/dECu/0VFruT9JDlZKLOa+gerHMIvABDFFOq5X6uznUt/3eGw2
   eUHavNB/fjPSIDovPTx7ZJd2DGS/i6i5iZyAhYQFmhmi4HjFWioRSlUIJ
   N4Wo5o+6k6GtWY7Re7/q8aXwnVIYBI6yZadqb16uAf5UwEmUVJ9oaO6WA
   h1PsCp2bIgitckHCXOOeoYdwb7qyVmdSR8SdMj3EzrYIQkJd/g/FMu+ho
   Q==;
X-CSE-ConnectionGUID: CJW/MQV6TLWGWBsdoZ3xEg==
X-CSE-MsgGUID: wICcOQ77S+G7e0wol9G0Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81345604"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81345604"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:51:33 -0700
X-CSE-ConnectionGUID: sVK80jU7RxumhEUGqXHLVA==
X-CSE-MsgGUID: J20U/9/0TfKgyRuZVmVq2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="274889064"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:51:30 -0700
Date: Thu, 4 Jun 2026 22:51:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: =?utf-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] iio: chemical: change from %ld to %pe for
 PTR_ERR() printing
Message-ID: <aiHXP8hjF63Rmp58@ashevche-desk.local>
References: <20260604111921.106936-1-vo.kratky@seznam.cz>
 <20260604111921.106936-3-vo.kratky@seznam.cz>
 <CALoEA-w1W+p4gLawWrFxe_sN2cJnQ25yRBFPh02N_2NPVQbkaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALoEA-w1W+p4gLawWrFxe_sN2cJnQ25yRBFPh02N_2NPVQbkaQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 01:32:49PM +0200, Joshua Crofts wrote:
> On Thu, 4 Jun 2026 at 13:22, Vojtěch Krátký <vo.kratky@seznam.cz> wrote:
> >
> > Found by Coccinelle.
> 
> This is not an adequate commit message. Summarize what you did
> and why in short. Keep the rest though.

When coccinelle is in question it would be rather good to share (via link)
the actual semantic patch script in the cover letter.

-- 
With Best Regards,
Andy Shevchenko


