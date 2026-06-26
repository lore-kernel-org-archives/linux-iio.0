Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB983E0088;
	Fri, 26 Jun 2026 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476479; cv=none; b=uOmqlgE6pnI0ZmuhrKvLCF8EQdO/GeR7ucLVr8AQUAzY3HZxAneddhJr7hdPHD/nUZOpgVpTQfILPwzVw7UOongAlzsZA6u7nQzp3Xj12ctpxfm1n3Xo/1oN+cpC32JhH/jq9e79bM3Bkp9aHatYLXXaF4PJeu6/4BqXzan4ajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476479; c=relaxed/simple;
	bh=SptznqXWjbT4fzKHiQ49zcjAdRt7WpV6zf/4aJhKybs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezMzBRvn+UQcMxJncxGM5FfRliAfS0/CnXmW95zWCcdy5VcIHM1vEQt9QXmKR9m6dqCNr3f512gPYjGsAa2DHh56NAKBleYRl83+Wo+HGqjy9p4VRt9SzYgUgnuDizhfDiWDSNv4S5DVuqhFag2BnF68vQH42UFWTtrH5Jlsn1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jtx5V9hv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jtx5V9hv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782476477; x=1814012477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SptznqXWjbT4fzKHiQ49zcjAdRt7WpV6zf/4aJhKybs=;
  b=Jtx5V9hv1/6DvayZw+ybjAJWqQ4CB61eqt43qynQOUtgKCgBHYXzCW4M
   at88yGvATGAaFzFZlZLvzMVqWkdT7r2jpMbbhsaV5INyPda2vYFItSHPO
   DkOJncCN5kK5sRZYQ6D1Q1An5sVKxo2H7S+TFumr9eOpIm5S7ig64k7BA
   1ybQMtCrzbQzODWCC1V5jboMtsAxMoRNlQ8QbReE+ND9QA35mirWytore
   yCjI7uJKIdgs2StC1ycvw96OrjA3LVQRhyZD8M8of9JN9uGqmUh7tyXzX
   AJ4R3HCbaiUbalnSXW+JtqRy1L39LzZUdkN6+7Hi1Rkk31L55qClEAJHT
   A==;
X-CSE-ConnectionGUID: fh6hGYIvRB+JGdZavFXBzQ==
X-CSE-MsgGUID: iHg4XgNQQpiITp+k31XQ2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83276726"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="83276726"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:21:16 -0700
X-CSE-ConnectionGUID: F2/o1s5iQIS7oYuGeMZ1sg==
X-CSE-MsgGUID: jyVmemE8QKOG2cdqWCP2bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="255729374"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:21:14 -0700
Date: Fri, 26 Jun 2026 15:21:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shardul Deshpande <iamsharduld@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: veml6075: fix UV index reported at half value
Message-ID: <aj5uuCO3wPxhuEJm@ashevche-desk.local>
References: <20260626110400.68885-1-iamsharduld@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626110400.68885-1-iamsharduld@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 26, 2026 at 04:34:00PM +0530, Shardul Deshpande wrote:
> veml6075_get_uvi_micro() normalises the UV index for the configured
> integration time by dividing the summed, responsivity-weighted UVA/UVB
> components by the integration-time scale factor relative to the 50 ms
> base case (which is returned undivided).
> 
> The supported integration times are 50, 100, 200, 400 and 800 ms, i.e.
> the register field index int_index in 0..4 selects (50 << int_index) ms,
> so the correct scale factor is 2^int_index == (1 << int_index).
> 
> The code instead divides by (2 << int_index) == 2^(int_index + 1), which
> is twice the correct value. The reported UV index is therefore half of
> the true value for every integration time except 50 ms (handled as a
> separate case). As the driver powers up with VEML6075_IT_100_MS, the UV
> index is reported at half value out of the box.
> 
> Divide by (1 << int_index) instead; this also matches the undivided
> 50 ms case (1 << 0 == 1).

Can you add more datasheet references to this?
Also I assume you possess such a sensor and you have seen this IRL, correct?


-- 
With Best Regards,
Andy Shevchenko


