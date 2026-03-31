Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809863D4120;
	Tue, 31 Mar 2026 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943417; cv=none; b=TyIIp23GRHgdkBNhsBLHId1de45iHhOc35jhlLodxJejXsmSneATAYSP8g/IuwaqbEkOsidkYRM3ZtzdB5PFsH+HZ2yekHLo76fdbhjk+f3EFPRKmFQV39KRT0uWHbQI5h6EivXBySilfpXXeUHFDYchFWuCRQ80L3rP43mG2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943417; c=relaxed/simple;
	bh=G/HZTGzE3tSZFMGJJXKO3Sdh4UD9dohg0OyBk4j+ROE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBsb2VG1AHjEPmm6nGj/qxbl1bpB3jndTkwyeshr5x07eu4lMHbcyv31XvG6QMZ9pCVUAnk0m2iCRlCo9CEqtO3WyIoaagw+cTtem2a2skDflF03YKdLknH5j6vlGxu1klo/hHcZjo5WrgHwdpvXy7pKOgo16/ZFUJZL0yOg/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHg7is0f; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHg7is0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774943417; x=1806479417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G/HZTGzE3tSZFMGJJXKO3Sdh4UD9dohg0OyBk4j+ROE=;
  b=EHg7is0ftmDVA3pHUHmtdOVfByh39C1+Ey3VGXjyBq+QWrfaOeHLmk8y
   I0BFfoMSl/rPjV2e1wdtD2TUoG+cVrFZmvcuW2NsaMpo+8ECi9byBlDB9
   v+Mc9XrP+98u2h30XrAHw0lzxA32Q4sdFZu/BK/Wz20/Fa0e0FHbjaxPi
   PaV7FodX3ToiiXKFH8Af5QWfKRlQW6h7HECCJxzArtsfWhmECuvGz0hCM
   TbTlX3YpVyZgoLZX2+THpRkRbl7c4+7HgIj1cP/qyVeezHjVzAWjMt6mi
   gSVRAh0ZIYTiQa7/TsegeP0c6x9r7ZiEcrLnEiDqqMu7ZHKP87R5ObTGH
   g==;
X-CSE-ConnectionGUID: XXhl+OmnSYSdygkVi1Mrrg==
X-CSE-MsgGUID: O0S0N867QiaSE9LMPBg0lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="79548874"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="79548874"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:50:16 -0700
X-CSE-ConnectionGUID: 0jnJaHnNSY+rfXSagGCFAg==
X-CSE-MsgGUID: OsEwIYjSQPKocxsJsfbrDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="223411832"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:50:13 -0700
Date: Tue, 31 Mar 2026 10:50:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] staging: iio: adc: ad7816: replace sprintf() with
 sysfs_emit()
Message-ID: <act8s5Egt5lpmvjp@ashevche-desk.local>
References: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
 <20260330181710.23258-4-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330181710.23258-4-mdmahmudulhasan1511@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 12:17:09AM +0600, Md. Mahmudul Hasan Mabud wrote:
> Replace sprintf() with sysfs_emit() in all show attributes.
> sysfs_emit() is the preferred way to return values in sysfs
> callbacks as it is safer and handles page boundary checks
> automatically.

...

> static ssize_t ad7816_show_available_modes(struct device *dev,
>  					   struct device_attribute *attr,
>  					   char *buf)
>  {
> -	return sprintf(buf, "full\npower-save\n");
> +	return sysfs_emit(buf, "full\npower-save\n");

This should be replaced with a for-loop, printing all from that array.

>  }

-- 
With Best Regards,
Andy Shevchenko


