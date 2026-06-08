Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB41347BC1;
	Mon,  8 Jun 2026 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919250; cv=none; b=iAREZyGGvFtOqpbPNj2nZMPtbH6FIQkapslm5Mxt3WF4Kf7hrjk0+z4QYFt8kJWNKmDGr7oJo+qQfkYxkYJCOT7rZ1sW+tH0WK+VjFYhl5O4xx+KnyR8frDM9QpWItAEbk2jHDh19DbtAYBPIjRZsQswrrNFJbeN13DEomuPPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919250; c=relaxed/simple;
	bh=CaMoWbxy1Acm/40iWQtcnXgEWbWN5Y9bTDMXnIWeI4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+gKOyRurLc5YVVZkbh3Zq6fSUWXD0TK98jeaNLBZAkk3H9DFKTjNjtE0JE0syubnISlgEDQebguwcuCGKSJ7vs6BqZe812NID4YEPOe6m02ii7cVZM9nDOj+fEeGwA6nwkh1HeJUP5MyBQN0EopQgrZf4hYQnirVwBLHoGwjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIZ19v2K; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIZ19v2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780919249; x=1812455249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CaMoWbxy1Acm/40iWQtcnXgEWbWN5Y9bTDMXnIWeI4c=;
  b=KIZ19v2KJEjjhxUwkk3y7B108c2q/qn9VABN7umZaMzGc6zt07nEoZqe
   jpcnu4EmXcPmpjy1Wdv6MYQj/KvXB5w/bQhtnre8W7Y8ozrxe9NVvyU6w
   z6IUvD9xR+qbRDHl0lfiwycKAlws4wcBY9x9XS1z7fpwJ9OJjClEVj3s5
   znlWGnlKHRh0YiJkNhbxgRIcdOOIDiL1WbYsai5bNXjf7dZyLkZOTvxhV
   hEliRUV3yn5lqOQOwIhr1Fe/sPCtnZXcnn2TrSHga0wgYrfQNu8LXa4Ro
   T6/ql27kC9lz+Uy+aNp/a0gcRP26OoBySSD46dCtPfZFxZmKREedx5W+k
   Q==;
X-CSE-ConnectionGUID: NyiWCeErQECbi5SQC7TUHw==
X-CSE-MsgGUID: 1ZL3cRISRkGgp2IW8BRMgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="92757529"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="92757529"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:47:29 -0700
X-CSE-ConnectionGUID: 3c4tQCdMQpKilFdtpplXpw==
X-CSE-MsgGUID: QksngxkkTOmln9oWt+4azw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="249826528"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:47:27 -0700
Date: Mon, 8 Jun 2026 14:47:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: use __func__ in error message
Message-ID: <aiarzOI6nzXV_LsM@ashevche-desk.local>
References: <20260607141435.60229-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607141435.60229-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 07, 2026 at 02:14:35PM +0000, Hungyu Lin wrote:
> Use __func__ instead of hardcoding the function name in the
> error message.

No, __func__ in non-debug messages means that the message itself is badly
written and/or not unique enough. Rather than use __func__ try to rephrase
message that it will be unique to this type of devices.

-- 
With Best Regards,
Andy Shevchenko


