Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1631AF14;
	Wed, 24 Jun 2026 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301296; cv=none; b=GjMUej8dFmM0WIOdgCEbYSgXHLmr+yKVOtmiD6VYwoh4X6tQOMRmWafHZWaESxWyzNrnro/hptXmJyw4sXsIHwcaP7jyF/PYMbCeQN6H7/bJeQCGLXSvdb3Z/r5ZXfPvSweSnajfMw62HHNxo0hDou6MkB/NTTe8vztiaZAvq1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301296; c=relaxed/simple;
	bh=PAUbYZo1AF++w2a2+FeM0lfU0sjb2EPhqkIa2CAQQ5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0vneVaovtDGsMSlKqy2BU7U/CZUaiueLjeNJDoP1Pu9qAXvAWwFeID2pMnbyaGjXAVuCvQewShLtn5fZ0M1UETKFmTxyjKyyIYzsXeHaRRZ/vPMsYzmYwIjbBxXkjwCsTn3tolBYXG13v+ifZ3gWsUaa5N5fBCETRZgiNBLkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yet08m3w; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yet08m3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782301295; x=1813837295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PAUbYZo1AF++w2a2+FeM0lfU0sjb2EPhqkIa2CAQQ5w=;
  b=Yet08m3w8PAUERBeUPnAZ1mR8BaYYxmQj8Ul2stGvZahiiU05O3xqAMk
   SYujqfuqdsClbJzHhR97eB5XVxlffwIMCa0mAiQILVZeax0NfNY8PVBt8
   CHpFnBGBepWZjoA4hu6Ir9S7aAQc9dFEKK+car+Y+Jr8VpxT1LMcezaxW
   EJpteu5cox5bUEMzWMc8C6G2Cmv+GR6RfNV9YEtG5DK40N+umy0awodRy
   q9cKAS2IDh+tuVCd9HbXP2SfTCkIl5Q4bNTTuYXI0OOn0tIDIilNn3QFv
   7l2gu19VqoxFmikkruok0QXt/H656I64Skx2BaiSktdj8NVGrSZA0ZXsq
   Q==;
X-CSE-ConnectionGUID: U1zANC4ETvGAJbp5zRqOjQ==
X-CSE-MsgGUID: gGb+37bRTJWwxZ2jBhFrmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94454976"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="94454976"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:41:34 -0700
X-CSE-ConnectionGUID: rzkYO4qsTqmnPByD/S1BRg==
X-CSE-MsgGUID: z4jFHUS8QWu2/TotzCLnhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="254792719"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.156])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:41:32 -0700
Date: Wed, 24 Jun 2026 14:41:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: Build mlx90635 with CONFIG_MLX90635
Message-ID: <ajvCaUKpmks5nqPy@ashevche-desk.local>
References: <20260624081309.77805-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624081309.77805-1-pengpeng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 04:13:09PM +0800, Pengpeng Hou wrote:
> drivers/iio/temperature/Kconfig has a dedicated `MLX90635` option, but
> the Makefile currently builds mlx90635.o under `CONFIG_MLX90632`.
> 
> This means enabling `CONFIG_MLX90635` alone does not carry its provider
> object into the build, while enabling `CONFIG_MLX90632` unexpectedly
> also builds mlx90635.o.
> 
> Gate mlx90635.o on the matching generated Kconfig symbol.

Good catch! Does it need a Fixes tag? I haven't checked if this is in
Jonathan's testing or togreg branch. If the latter, the Fixes tag is
a must.

-- 
With Best Regards,
Andy Shevchenko


