Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525EF43C05E;
	Wed, 26 Aug 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753398; cv=none; b=sjub0UGpbS/CsvI4iostv0Oq3kCX5wB+dTv0jHCa9ARP0RepsjQCiwvxTiHeeMuuRWIdzhSDin/NthcvT0eUqeA6uZHsotjN/qT7lCXqmxkm8XCmNZ2G4jCQorVWA3maYv2v0FDKpd5ml4LQsasIGftBKGriEqlSZN3wXSP1GCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753398; c=relaxed/simple;
	bh=TsgdAh1ZW5mboVObCKU7OCe5ya/rsFkTdST1Fg8G1Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Se9TclKiwJpW0MUlCYKct5TDzLFuic5nyQQM39mr1hmGWHf9y0T5ZEhWsqgNpa0oN1IBWwkVZNN6jxJ2I9+GUFRvjqTJNRsL/A+X+kMJelSKYmJGa9q7P7EW5SiEzjaACFmSXDRw5EQLFSaYP6M6jG1FLOzxGT9OGk82ynUceKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLkPyoTn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLkPyoTn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787753396; x=1819289396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TsgdAh1ZW5mboVObCKU7OCe5ya/rsFkTdST1Fg8G1Mc=;
  b=XLkPyoTnSrURo87Omw3Bu7xxPgTs70lXF0w1603akSc1R78XGkuxs5rh
   a+5bzEhrZ5yj0bbCWI5mNC75+i4V5lmfEqgi4OJk4T4NYS37RSrLkWMaM
   pebnmRr56xAMdJqnMBpGAn/8Xv2yvhV+8rUhhJs6aAopu+6dHgOpUdG1g
   a9Xzgp3QowbO2FKO0D8AUYWzEn7tOYE5rAARpuh1a4PYMPkJKJfs4veoA
   hqkyG8RSMqEnRF0bgtQcoSer0Q8uzOuJxL0vGS7+IHibIph88/GuYUZoe
   Kq1TQtvOM2ZlsS6z0jA4yvGo6mwkn9clMXghKToFt/3JVW19FNNPHCHgD
   Q==;
X-CSE-ConnectionGUID: qIMddGDgTZi5yugrwr8tKQ==
X-CSE-MsgGUID: DO6iMzBCRianmShJ47rAAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88001484"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88001484"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 07:09:55 -0700
X-CSE-ConnectionGUID: 0nxUi951Tzeqh1SQ7A1dJA==
X-CSE-MsgGUID: tdDgCYNxTbanasoCRHAZ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="271391214"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 07:09:52 -0700
Date: Wed, 26 Aug 2026 17:09:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yang Zi <2959243019@qq.com>
Cc: lorenzo@kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hts221: fix division by zero in
 calibration data parsing
Message-ID: <ao7zrbXG6f-pPxIB@ashevche-desk.local>
References: <tencent_0F43B1BC41CE4066DA52B7B25FBC04C41A09@qq.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_0F43B1BC41CE4066DA52B7B25FBC04C41A09@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 25, 2026 at 05:21:10PM +0800, Yang Zi wrote:
> hts221_parse_temp_caldata() and hts221_parse_rh_caldata() compute the
> sensor slope as ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0). If the
> device reports cal_x1 == cal_x0 the division causes a divide-by-zero
> error.
> 
> Return -EINVAL when cal_x1 == cal_x0 in both functions before performing
> the division.

Do you have HW to test? Any fault injection perhaps?
The problem with div-by-0 is that it's implementation defined, meaning
that it's how compiler decides. Now, the question is, what will compiler
do in the current code (no patch applied)?

...

>          return err;

>      cal_x1 = le16_to_cpu(val);

>  

I would remove this blank line as it's coupled with the above.

> +    if (cal_x1 == cal_x0)
> +        return -EINVAL;
> +

>      slope = &hw->sensors[HTS221_SENSOR_T].slope;
>      b_gen = &hw->sensors[HTS221_SENSOR_T].b_gen;

Ditto for the rest.


-- 
With Best Regards,
Andy Shevchenko


