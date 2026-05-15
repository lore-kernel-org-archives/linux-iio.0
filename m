Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1C477E23;
	Fri, 15 May 2026 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842753; cv=none; b=KyYQa/DLzUeWmDBOd2PFaY06Ndf/8yXPKeEdLxPhy8p/9t2bczLUNyN9zga1xC/as5t1g5okpGkcQ4zQn3y4HzKniq8rgQJxAUPqG/gj6jYnk+cvu2yAbM7tqdBDM6sUqtRBaYw377hBMkuVBqVDlS+GjPzmDgQrANtuAcvTzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842753; c=relaxed/simple;
	bh=4jqNKlcyDLNP0H9XvSwJ6TiI0tKmDB0nTdQ87STpK+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiP0kKls+maNR6m/GsbffhD8D+xR4S+JGpp8VuBtcH1IuwbYq5i2spE38clk3yZxup9zk9XpMYgMQzmhZQf8YEcw4Ilxp3yw6eAKWuyhxyToepgWFQZXsNHJmUbseKU6FM2L5jBIWElxEkEaMKwZ1TQGiWytLYcEpZ1rRXN3EBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWwLA4nD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWwLA4nD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778842752; x=1810378752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jqNKlcyDLNP0H9XvSwJ6TiI0tKmDB0nTdQ87STpK+I=;
  b=NWwLA4nD+4L283Svtnz0MxGLr2KdDBuFq5co4j1n50nwCvzRKjQI7FwU
   vDfaA+7k4zWKwj4zrLWF4ViAjCsOkD8FvuXDXT4oOIiHryQ8NbKosdzaj
   +VF7R3Suqu01P55JB6/3VvvTcc9TbYicWICVsXi4K0WdWqmvUJp1WSlgS
   Q3G0Bhd2js1RagyOPS/S4LFNWbETpVFozFA6snKhzO/kvCIoVvPqTwXAh
   MIfKkxGbzJb+E0GqC2PRp1Mi9aNxT/fHHcmvbWrnFQ5MSwRKXJNEQuzGu
   4J2c2saupm+/U8GH9Y7q7V/bDXkLqJxYAwdAy2UaVSa9bPZau+EbbA3cE
   A==;
X-CSE-ConnectionGUID: e4K964+5Q72tpJ9ZNS7cgQ==
X-CSE-MsgGUID: k7dtlAFqTLywEZlcR8ftkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79825002"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79825002"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 03:59:12 -0700
X-CSE-ConnectionGUID: YVPTwRT6Q5GmSrHOMhBi0w==
X-CSE-MsgGUID: mnIghHqlQnWYhRfSgIh66Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262183744"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.33])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 03:59:08 -0700
Date: Fri, 15 May 2026 13:59:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: corbet@lwn.net, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org, hcazarim@yahoo.com,
	linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: iio: fix typo in triggered-buffers
 example
Message-ID: <agb8enneR8dWE_uL@ashevche-desk.local>
References: <20260514085157.20327-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514085157.20327-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 14, 2026 at 01:51:57PM +0500, Stepan Ionichev wrote:
> In the "IIO triggered buffer setup" example, iio_triggered_buffer_setup()
> is called with "sensor_iio_polfunc" (single 'l') while the function is
> defined and later referenced as "sensor_iio_pollfunc" (double 'l'). Fix
> the misspelling so the example is consistent.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


