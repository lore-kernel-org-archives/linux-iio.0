Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614989;
	b=159LYYzHgq9XOtSPTeHzdlhv2xkOxC/M13Jqu6bpiAr/pO5FJY7TuGIzwFnybK00bT6A
	 cp/KM/Bx/P36r+GLxCNQZXB30EJXoUVnw05E6lsyPvtSFmQD4I60oLoBG4wT6Mw02dpx0
	 s9OdWMYT1wVHyJ0dGSCVJPAn5jBjK/5ojTq29gvaxjYPW3ClsR2SMdVMOW2JYKoJ7RIVQ
	 buD2sapwuAfsYxoVtYq27VEWR8AM+qGGWjF89HarvgGlEaaIxc8epe5Zn0/AK9S1HQtg9
	 fGWjKxECexWpIJ3lnquPZpQIA1zXsmPHHg4twkO7d5sPydmaFNjwFNzxlIoVHMFWLow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614989;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=0aBqMxJDgvMz7i6AIJn4XzKKfdX+IDbRJyfCRCeiBUk=;
	b=ardaFRcW6/tINL8FBN2vkln6yP/so1VCBdK6QP+dDv/74eodhfwgCasi8tY9aPQdrQJH
	 jwFr8s/wGMMyXG1sSwDzCtf0nTUfEgosFf7MZj3LFkftZQbwIciLvJKLm++lMLjZXZ0Um
	 vEHP3g5p2Kc8VZoy8gnPGsPBjQq7LUj3VYHVZt+7bQN3aG1/REKh3Xkennz0df9VUdRZh
	 m5FiSttb0r/k1sBkOEi9UaSLsfuj6cL4pHeRNQpomNG+dSEjjk9v/wfGZdwnMXlANW/6n
	 5t4dm928ClxKdUPQC0sC++gMUI8MR3EMxHQlkxqEC5L8JjHoyWXW8G9KiVSrP/DQ6qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bVCKhqj2;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C26606A31E;
	Wed, 25 Nov 2026 13:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C26606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bVCKhqj2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795614989; x=1827150989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q2j7sJN2VX0ocB6DN0v8l2ZUgx6RTf6tkLY8172U/34=;
  b=bVCKhqj2hhnUvVmFqZw/DFQs+rmYx3526Kqus0Yf9hwG8nCyHpguTFEF
   ZwsUES+uVS3UTlbN+8BuiKpeI8rm/XbzhBmOSbkbSLmlqoxm6v8oXcyzc
   u5e46HbO5ZwJE4HT+9rypwUXy/tDyeiUAY39jZbCYQSgCJPynhg8nzy2H
   L7VCOK6Y40tzruCswBtoaDCvRLN0HdGbpSdc1OONEwQhxMJGdt1xfQuXB
   JfGb2zTvnGLGrR5U/QGmDBDCa1NOrPeO8EIlZidmAI18a1ZIkLR5WwKhf
   nYxe0DvSanBi5v+wcc6EXI9IHj2CdsI5I+FQ2N4NprS8pRFKM+GiounkN
   A==;
X-CSE-ConnectionGUID: rNJWgOHGSbW/+XoGVDhXtQ==
X-CSE-MsgGUID: n+A+upzWRyKnEjg0y7D4dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4372742"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4372742"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 05:56:28 -0800
X-CSE-ConnectionGUID: CkpgHFkZQ5eqf98NxGmH0w==
X-CSE-MsgGUID: FiWqEJ7oSZ6BoW8opDBKgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11870000"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 05:56:24 -0800
Date: Wed, 25 Nov 2026 15:56:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Gerard Marull-Paretas <gerard@teslabs.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Subject: Re: [PATCH 0/2] iio: adc: stm32: describe the STM32H7 temperature
 sensor calibration
Message-ID: <awbpBtAeQl4i-YVy@ashevche-desk.local>
References: <20261124202220.23721-1-gerard@teslabs.com>
 <89f43760-01c7-43e8-9682-b7363ffc931f@foss.st.com>
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
In-Reply-To: <89f43760-01c7-43e8-9682-b7363ffc931f@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 01:56:35PM +0100, Fabrice Gasnier wrote:
> On 11/24/26 21:22, Gerard Marull-Paretas wrote:

...

> The DT is deprecated and are going to be removed [1].
> 
> [1] https://lore.kernel.org/linux-arm-kernel/2afd5f78-0174-4955-8c1b-be18aea3800b@app.fastmail.com/
> 
> So I'm not sure the dt-bindings update is useful.

But as long as the code supporting old DT is in kernel, the update needs to
those versions, no?

-- 
With Best Regards,
Andy Shevchenko


