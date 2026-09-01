Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C68A47143D;
	Tue,  1 Sep 2026 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250418; cv=none; b=VfkAg/A8Mu5ogaa4rClq9oN/KyXKwWM0zT78PgvT+ogI1gzeXVUj966CYtprhDqRg0zqvtC/w3I9hi9yzZKILVvZxaLxTqNCkJS1ub5tPCLEdsF4wMlIcpj2iCDPBle3QN/71Zf0FsEry4+VH/I+j9lolUxe+2vZc+PexWjygcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250418; c=relaxed/simple;
	bh=1f9nysRfz/QcucqWxxSunsNyOyUcqiNvoHA7rzPhFSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPxYeHLIRY/2c1UtatUG0OnAcTz2TGbcBtX8aTxs0rmu9BkJg5K3KcVakHRqrDiBTFyFNiKajLzzD/2Cv5UAeQAgDq2VjMNmB0uUxTj+7Qjqm4za13UhSqG72VtPpDHh8r0qm/kb2/4PVtyZNR17VYWZVDamorcJoC0sbSsBOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+w9uyCv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+w9uyCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788250416; x=1819786416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1f9nysRfz/QcucqWxxSunsNyOyUcqiNvoHA7rzPhFSE=;
  b=J+w9uyCv3uKyadHPDOrJsOT/2WMKgk4fOqaW5mqhg2Wu65w3aT6So7RH
   uyNKl3E+elrZNwZNZ8GF+w4QCRsxD75xP0VEfXae+bGxGuK/Efspej2t0
   v+UMp93UBRDclvMLX2irgAy5bLPqoW6JRspMrTDMbkYBc0jCHU23Qndih
   KrZRdh09mqBiYFgjYHGOrvEIRZOxQEcazJw/JtV2AjHk1bcG/ve9KCZAw
   mgx9NBFKcuLUGogoakfo79l3ytby2VzgDWmQoeZ0zkLfHgqRP5ZHnemOI
   C1AJedprnEqLThx091SRbGceXdEtwMkLntM5/rKSSdpPr6HIxbcLBnKNX
   Q==;
X-CSE-ConnectionGUID: rBMD1oirRHmDt+jWFl6DRw==
X-CSE-MsgGUID: 8vLJPef8QQyX0T8M9sN+KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="91184555"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="91184555"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:13:35 -0700
X-CSE-ConnectionGUID: inkXJ/hCQ2mj9LyvStU+GA==
X-CSE-MsgGUID: SnzebwgpRaeN7GaqZcXrUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="307241438"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:13:32 -0700
Date: Tue, 1 Sep 2026 11:13:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, gregkh@linuxfoundation.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org, marcelo.schmitt1@gmail.com,
	danascape@gmail.com
Subject: Re: [PATCH 2/3] staging: iio: accel: remove adis16203, merged into
 mainline adis16201 driver
Message-ID: <apaJKc4kbxgFqe3V@ashevche-desk.local>
References: <20260831184201.34416-1-shehryar.amd@gmail.com>
 <20260831184201.34416-3-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831184201.34416-3-shehryar.amd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 11:42:00PM +0500, Shehryar Ahmad wrote:
> The ADIS16203 is merged with mainline ADIS16201 in previous patch of
> series, remove the staging copy and its build system entries.

This is the ideal patch!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


