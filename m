Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686966;
	b=Z5dn+wKKFTBbUCB4ePXQ34xfVOJjJ0kVoDgAICI6Y0OdYY/Fiae4Q6YyM5W7STf+Xkos
	 HckExLWo4N4XorBv0FAEAufy+jW7QR6HS8TJz9HMeJx5o+UYjkxtBUUMOlrqhAqBzhARW
	 2Th6+jqDBKR7HAH8MkFyGCRT7nVJqUfsdg2okr5tKu8tWj5MxCsjfQ+Snzuj7YvUSzI4q
	 ZHAc+TOav64UgientrISwxUOBQTqGOHzgFvDlrq8pWJt5BjGy9oSe1QStNhtgm/IO1Y7P
	 muBjByT9laVQXgEazgXbyBkuZBjYwxXN2dwqmRHIcFVb9yY9R2R8gCyqFk342OfnV5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686966;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=w878p9VACeLLpl7740pkLWeHcq6k++Uy5zzDlCAnlQs=;
	b=mDS3FvWT5eyTpo0D1zJL2m29zfs30eFCeXvreTExhsCdytg9FHObDAzCVY+yc+9EA88B
	 vAvrxBq25CMRGU1odRw7QmAkmd8k8OLOtSGGJ3wwt5KU0ysXerfwpJl6r4txHmDjuE76K
	 hw+tlV3JY/5G7tRDlD5xksPtHfRcuQXQnb/sgD1Uknx8esNcJERzQEwNEl2h6Vk42ZAKv
	 HEZ861uKf4QNA5FtleE46FPsr0dYY36vhCHyrzt9VLLomspdUaNWSGCcQOOM4/QL3JvEI
	 7JMWAxTQ+ADuI9Rzox09lnGNyQ1Kyif7vD5kdDkl3Z35zRSVGO9DXCuMNVaWsgb0yUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fFCyMLfp;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C2606A319;
	Thu, 22 Oct 2026 16:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D7C2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fFCyMLfp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792686965; x=1824222965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LEUYGSZsLTD/SVvD/2c4iL2H5I6h5X2TitS2F7JiFls=;
  b=fFCyMLfpFO/7uO2kYsseMJFBNSxh9IGSehfgTR6WmUiC3nnByd839Rhv
   kFHg7RYwHXk8oOoo56Lg4nTwJ8LtflmWiZOmO6bBHgGbK/pLrDTeox1YQ
   Ku29kO3w0U/Kp9uiuw6yCNVJlcgl/78S2E38wGyErX8tZZt8ZoyGdtTbq
   HkI09rxhxe6xelKQvxSocI7NvG8wxEn1B/EOqDX7UO+XLO2pYKkqo+otf
   juh3P/K/5hdDg/w7AwHF9D4dVlD4kScIWOuo9MGzRbxHSw8Ca7yfKkxEv
   Dn7DGvy8/GTQLvQkfHLf5pZipvTD89wMwY1t/5TroFA2cv0pG7g5XH5GV
   g==;
X-CSE-ConnectionGUID: nCegt4iDSROe10TCKgBmmA==
X-CSE-MsgGUID: I5qaOOL1RSaLp7WG3+HBww==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1322238"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1322238"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 09:36:04 -0700
X-CSE-ConnectionGUID: 4Fy5l208SZq9IlKmHFfDBg==
X-CSE-MsgGUID: 8NNYp9l+TBSxuX5D/cFFhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3478948"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 09:36:01 -0700
Date: Thu, 22 Oct 2026 19:35:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: check the return value of the
Message-ID: <ato7b3ydggC9X0_-@ashevche-desk.local>
References: <20261021225450.628499-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261021225450.628499-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 04:24:45AM +0530, Arnav Kapoor wrote:
> The driver ignores the return value of all the regmap accesses. If one
> of them fails, e.g. because the memory mapped registers can't be
> accessed, the driver just continues with an undefined state.

Can MMIO actually fail? It can give invalid values (due to HW being off or
wrong MMIO window). It can give a page fault, or some other error in HW,
but the read itself most likely never fails.

> The most severe case is the read of the FIFO in
> mx25_gcq_get_raw_value(): the destination variable is not initialized,
> so a failed read leaks uninitialized stack memory to userspace.
> 
> Check the return value of all the register accesses and propagate the
> errors to the caller. In the interrupt handler, where there is not much
> that can be done about a failed access, just don't use the content of
> the status register if it can't be read.

I consider this change an unneeded churn until you come up with real life
example of how MMIO fails (at least on this platform, not exactly with this
driver).

Yes, I aware that checking for error codes of regmap is a good manners and
style in general, but would we do jsut that in a standalone change?

-- 
With Best Regards,
Andy Shevchenko


