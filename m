Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A120351C1F;
	Tue, 14 Jul 2026 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019229; cv=none; b=D3s1Eo1LSazF5pLtN++DZ3IWrCgitdRdHUvvPvCui9qAcR6eiXReHS3GSZVOiuzohw1gaaJWHGMb0mPQ0plJ6jJ2M32WmbvriSGClR3IR/xJX+OnxcZKzqEhQpValfwuc6jNpGv0vp/HawaMcakBxp45mxSTm5zgoesPEpaYW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019229; c=relaxed/simple;
	bh=wvnGjhIKaWQrbbIAWubtSW8msoHJpHu9UeimnkbFuDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5yOdq2Ql38hhmS+N8MiqoSGs9cr5cBlZSiPgjWVJ+jnQCTikiWikw5ypfxa8Pklf0/JM6LyQ2Md/8abx+qhvhRvUiS5bK6hculWgknNXPi/9hcyB5UaFrOI3KrCqu4oUbf5HSrvXfPpO1v5GCG3CQ6NIpKt28PGvlZx57Nkcpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ou/tnuJu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ou/tnuJu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784019228; x=1815555228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wvnGjhIKaWQrbbIAWubtSW8msoHJpHu9UeimnkbFuDY=;
  b=Ou/tnuJuDlvvpVYJjDRlotXIpq5F6nQmvNiQr+wS31zyXBh07PjhBhzQ
   FcNwGRYcWXkcv+3FjXRWJgdc9lrLH3xA1GY9bqkwkfq56iCq+k/Wq+gQ1
   1T0Y6kZNQtBLWp6UufEkpCp0W5wkKBEm0GSekVshidE5hW9oS2+t2naYJ
   LlTTlzBKTPG3bXhEtPC8jceLW5uJoIOK6xvenrcOCBNaB+rN3L/PhSBTX
   YWVetG1vtgi7kYSJ6qJLrWXbWa4MUAPrhazyxNDonIijNRH+GjfM2Yp7D
   JrEodArevv2+KnrGt/9ePEpeObxYynDolnf+xfgmnhJxzXXqPh3F5X6fo
   w==;
X-CSE-ConnectionGUID: 2oMwmIuGQzOa/03htIjZ8Q==
X-CSE-MsgGUID: 3Hn0mjGkTCuwHVlnbyVFRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84601224"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84601224"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:53:47 -0700
X-CSE-ConnectionGUID: I5osEyNoQZyOwOcymRuI5Q==
X-CSE-MsgGUID: ll9MHauuRuimTqTkkQ3yZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="251388090"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:53:45 -0700
Date: Tue, 14 Jul 2026 11:53:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: OrangeBlack0765@outlook.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: tsl2583: migrate to sysfs_emit() and
 sysfs_emit_at()
Message-ID: <alX5FkSyqo6taYl9@ashevche-desk.local>
References: <OS3PR01MB82448EEC71E6AD3236F39E3FAFFA2@OS3PR01MB8244.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB82448EEC71E6AD3236F39E3FAFFA2@OS3PR01MB8244.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 01:08:33AM +0800, OrangeBlack0765@outlook.com wrote:

> Replace sprintf() with sysfs_emit() for single-value sysfs show
> functions, and use sysfs_emit_at() for lux_table_show() which
> concatenates multiple values. This ensures buffer safety and
> follows the modern kernel sysfs API.

...

>  	for (i = 0; i < ARRAY_SIZE(chip->als_settings.als_device_lux); i++) {
> -		offset += sprintf(buf + offset, "%u,%u,%u,",
> +		offset += sysfs_emit_at(buf, offset, "%u,%u,%u,",
>  				  chip->als_settings.als_device_lux[i].ratio,
>  				  chip->als_settings.als_device_lux[i].ch0,
>  				  chip->als_settings.als_device_lux[i].ch1);

Now the indentation becomes broken.

>  	}

-- 
With Best Regards,
Andy Shevchenko


