Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829398;
	b=vFJmZEwH6xPKDL4R4k4zuXtlFzNEVtq9FVEyMmQKxP300AWaTeywotcFaRT9Ynhliakb
	 nUqUVIJB6jWUmqO765+9swphKmfitiZt7YXJnRomucAYuHh+FoIMT5UxaIu9XExUE+XWA
	 K+jhZ5UoH18Dyb5DKRm74w1/07Be5DsQGMR0lXjjskU5Ve9vWu+6blQIo8TXqswNXZ0qK
	 Yx8ycSDsxFppu8ypXOOJPH1m+6009NRuo39HqGfgBZxV+pkcMWrEi8Fc2Wt4GYknJAtdO
	 UBLHYqrF1qUBIAdZqVozjaen38hlAe4JhwjIwPKGmkF0qz9LmhRDg+e/Of35DJLc9PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829398;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=lyULvWtDThTQAb1RiR8ZaH27ef9iTlrFyCHnHoMzbvw=;
	b=yWI6KmeA8FEfyJNK/ZMUvKwM7Bmvrwa/NNm0p2hK+f/VZlmbpEsqcu26A6cjf/ApOYEN
	 2PkPWKBQ4VsABI5c45EtNcuc/2R1I5WAU4u8JhFQ3Ef4AWy3URHuGyCICIU8HsKy6+neU
	 l12MV1JW1T3I5c0Lw2WRW6Y/WC3/Wvi7BE0NcB3l7Ve4kpTokYP8pW1aQzzqMJ8IFSgXg
	 RgDQEZQWzaFmD1po7PPDw6gUUtXKj3mq0552Tpj//8vxvPRUcNXAlfH1ilOv0BnnS0Qc1
	 wf5Ss1LB7gVQ7j8MCQrNAR6cI8n0nUMHW0LkJazvuV2RReHwiDqXdF4Zn0jEdqbqv+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LWd1FvfF;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45CA606A853;
	Wed,  4 Nov 2026 21:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A45CA606A853
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LWd1FvfF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793829397; x=1825365397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q6fLSk71kNlmRe72jzBR4F8ycctOy8HBQDiLrJKK8DU=;
  b=LWd1FvfFV0Agn9Tn6oMefj0wGEQEi6Fb9PByJMNyXYUAOHtadf8ZqyoL
   ZDLkCGgBJjnr4ssOzePzBs8ni8T2y8VGdrlUjiKvHjC2H/iuyqSjkVRhU
   tCDg69vUsYLjEGXdHNDR7hXn6PvXaphZmHMzvRJfAGuwkqiQkWTxZD5/T
   mezYxqZzO070fq1TLE4bcpocyE+7Bptmf9/DVNOazqlyF9Muc4KyYT5CY
   BwLlJLnMHZDIucDucuif3sdpCmkRYIBSfmfC7e1uIAxC+WT5r46901ReY
   fjQttpOwPVML85/2NbYjKv52HKDDMSbMC/JfFXHYrUeJ1IxCvnahGlEoI
   A==;
X-CSE-ConnectionGUID: IHASxW91RRK/YY2EaehIKw==
X-CSE-MsgGUID: G31o3gQrQoW2qIojai7PHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2635095"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2635095"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:56:36 -0800
X-CSE-ConnectionGUID: NnQoCZS3Q9qlVLhL5g1zwQ==
X-CSE-MsgGUID: W6VEmGpQQNa0zpifZ5A40g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6945251"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:56:34 -0800
Date: Wed, 4 Nov 2026 23:56:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9360: use an int array for the
 sampling frequency range
Message-ID: <auuqD75_H4OVHqva@ashevche-desk.local>
References: <20261104175608.205872-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261104175608.205872-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 11:26:04PM +0530, Arnav Kapoor wrote:
> sx9360_samp_freq_interval[] is an array of struct { int val; int val2; }
> that read_avail() hands to the IIO core by casting it to int *. That
> relies on the struct having no padding. Declare it as an array of
> int[2], like other IIO drivers do for their available ranges, so the
> layout is plain and the cast no longer drops const.
> 
> No functional change.

LGTM,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


