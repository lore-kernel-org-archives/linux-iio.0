Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6713B585D;
	Thu, 18 Jun 2026 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765995; cv=none; b=AOFv1FgbUQ4+k/BWtXsKMFGiOf8+80C8Y/CiRt9JlwBWfIIcbVjiKm6rDFq4tdFRbkxSALytlEGUVMJnDYUPAkrmI1klN+iV9rdJyWdhyv6NqZUAdmFazR5SCa6TqZSJwnHf7FNF58d4EBjIkUimJyhhpZJFp5+b3SXeNbdiDpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765995; c=relaxed/simple;
	bh=lH3Zh6Es4FkWk+YPK3I8+cqyf8VUanqFmRA7LiMO14I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAdwyeAaCm5Kbu4yl7pir85web+ZGGR446gIGytGYAx1ohPTVfK13S8jcqkhczXf0lkeUNE4XZL3+rRWbeBUsW4/qjrLV/7KegTSC5Ujlo71hJKa3FNVY2OxfXDx4U3b4ASHrSixTbJVbdveEPJuTqUvQ+ottWq2YjhaVQdTjaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQO8fn36; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQO8fn36"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781765993; x=1813301993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lH3Zh6Es4FkWk+YPK3I8+cqyf8VUanqFmRA7LiMO14I=;
  b=QQO8fn36llwbaE04wpYva3tKTfxn4qpBczfiNXJA4DMCgjDsvPaFkWKo
   bRVwF60QQlc5D/PJQvI9OWMnzIYGZ1kTi9fiHi8NjheNBmxPGYrGTSsD3
   GTaLa93pU2CehTg4cJtfawdaF3vzzxhbxz8GJg3+aHtNVjWmyyTdTx8kl
   IAdDC0d0WB9MmwfVLhANRK86ScPkyHSZ6Us3lv5Y0uUznSsnoagcq4dbl
   12ZMIwuUZKHep1X8b7QEEIgmxn2v+CcCjPcMLYaneF7LeLmObQ/5JXn61
   /nK/eW8v4WTXmktqHj3aAjLI0W2HkRqMpycmxo5eC+nQM2jGXSKqXGs9g
   g==;
X-CSE-ConnectionGUID: WcUvLjt6TMmjLXTKnVtRyw==
X-CSE-MsgGUID: m4a2oK8QQsOrTUtHNN+3wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82702775"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82702775"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:59:52 -0700
X-CSE-ConnectionGUID: rH/Mb/jyT9aqLhtsVgP6bQ==
X-CSE-MsgGUID: vycDvgxPQq2qKh+/d/cALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="253385848"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.10])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:59:50 -0700
Date: Thu, 18 Jun 2026 09:59:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	m32285159@gmail.com, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: chemical: sps30, scd30
Message-ID: <ajOXY1s3F7dUCmVd@ashevche-desk.local>
References: <20260617172138.114572-1-tduszyns@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617172138.114572-1-tduszyns@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 17, 2026 at 07:21:37PM +0200, Tomasz Duszynski wrote:
> This series replaces old email addresses with a current one to
> make sure changes show up in my mailbox.
> 
> v2:
> - add missing mailmap entry

Please, split it to patch 3.
With that being done, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
to all _three_ patches.

-- 
With Best Regards,
Andy Shevchenko


