Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323E139DBF5;
	Mon, 20 Apr 2026 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705806; cv=none; b=ZubiAGcrIcJjO++AWDSWRBBni9amEmaS+qxJ0akL24Y8Y8zHpOQaKROKDrE17IKzIpYntauQbLzi6qaMdtWmNgBAtjuzMGcV+iiKFRCVNWSvEZzrZY3cmarX3eXt4FjtrfJQixcImjwOpgQI8NKl1NfsEzXYTD4jXa+RUeJRxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705806; c=relaxed/simple;
	bh=VLQXVP7uxIdeFSh4FZdoPXGRazkFkTg+qK2MYeiF4SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjUf2Mqv6gh3QW2Cug0JEywyFFXIHDU4lhCxKpQV0CeYM1jxBoSwqdcAiEOBnw0EVDgCXMY9U4iwKeYUGIUf+AtH859Sc4V16PK9JrymT+JlRhOxs7Tq4GgjYRQpThWbBOLzp2h0L2HArswcyiipVf+OPP+b+1cGCoAq0DGtwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvGCGzy4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvGCGzy4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776705805; x=1808241805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VLQXVP7uxIdeFSh4FZdoPXGRazkFkTg+qK2MYeiF4SA=;
  b=YvGCGzy4RNsLZGjNQNqm19yQcGbOTfSZcYGmgf1NzLccJnKPKiOQYN3D
   TnyB6WUgXLpDU8tVmnciwy0fflmqamunJQTutlNHuPw5saF95vDKhUlFi
   bIE70EohTd7jX1dEBxBwGomNqkT33Odq6Rs0d4dSstx0NtD21dq25XE7q
   Yr3Bg1dQ4UWrlfsDPvc4fcW9/D68Uxab51tt6qJME0OiEJRXvyoH2hvIZ
   RJ9D6ktRVR4hhlZZS2clVQEBSlkMFq+QpPlwZ67aqq/r7JpWibT2Br9MM
   3Ta0ReYTBPr6i8M5Nx91WjRJlZkvQjQ0Lr+D/leRpFqH4s/OI+YH0OleK
   Q==;
X-CSE-ConnectionGUID: 13bZ7hJASSCGKzQYD2deNw==
X-CSE-MsgGUID: HJ3NvYP1TYeBVTUQYlPMDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77702909"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77702909"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:23:24 -0700
X-CSE-ConnectionGUID: AJPuBNAkQgi4jdyBEwP+Fg==
X-CSE-MsgGUID: P1AYLBHYRj609cJzKU0Q7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="228625934"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:23:22 -0700
Date: Mon, 20 Apr 2026 20:23:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: magnetometer: ak8975: change 'u8*' to 'u8 *' in
 cast
Message-ID: <aeZhCM5YJqHbigmr@ashevche-desk.local>
References: <20260420110804.1353-1-joshua.crofts1@gmail.com>
 <20260420110804.1353-4-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420110804.1353-4-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 11:08:03AM +0000, Joshua Crofts wrote:
> Change 'u8*' cast to 'u8 *' as the former triggers a checkpatch error.

...

>  	ret = i2c_smbus_read_i2c_block_data_or_emulated(
>  			client, def->data_regs[index],
> -			sizeof(rval), (u8*)&rval);
> +			sizeof(rval), (u8 *)&rval);

Strange no warnings on the open-ended function call on the first line
(trailing "("). That said, I would rather see the result as

	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
							def->data_regs[index],
							sizeof(rval),
							(u8 *)&rval);


-- 
With Best Regards,
Andy Shevchenko


