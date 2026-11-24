Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509121;
	b=1uhtys6P4V1vKtaxQ+ZMeemb8LyDV+9LyrqzB5smZR4LYiuNMK+VI6Sdl5qFpVg0DAqR
	 olb+xvHOVqNZcvO/BzdFgGOC9vg0l77OcbIzFTbDsK6aFFUHwkoKicZr6434FWksyv0xS
	 ha/iPZzD6OfWLfht5heONfsGCxanSAJFV8o7n7jUBdlfdd84q2fXU92wwQ129xw5riozg
	 4AcW9w8ZxrYSYf2Wj5YyvvSDKP+nDlCkZwzEeL4crGBt8eWCbYXgX1cVhPTrrpLgCdCw6
	 8+rBVaTzGVU2tl6qDAFe/vvzKMSENhKdXrTqpc+zRzoH6RnVx56YKhfcVZfFr4XR03g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509121;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=i4PkAEHGCosxapS1OsCglkmN36mrS0bA4EvMEUyaMYs=;
	b=TzvYmA7eFv1jCNkl7JfJ6JjA6j8U4ROewKAsSMrYaCXmKTEuRZTmyhriPwVCoNO9WgZY
	 PBT+Aha9c/2mF833HL0EF+evSFNgkxwsmRreXkAWCrvtAWTd1gsZ7NqgDmtwEE0o+ZYEM
	 V/rvXaoQ6Id2TeES0M1SUMlU5d/C1TWDmyxSjN3Q/4qCmVYXIlQR1E/j8aRw70B4TlDGr
	 Id/1hXEX5LwNQyHn2SJbtftq2uklohkUWE/TON+IbY1B7rYqPK9UuG97zuGmw4qgfmf/9
	 /sx94FXRzsNL/9S0tjR85S+zh5uWpFZPKJepmyP2PscbOuOclSGUaGk3HqGLXerrGmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hYBBi8F2;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942E606A692;
	Tue, 24 Nov 2026 08:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0942E606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hYBBi8F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795509119; x=1827045119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FwQQJhdrq5aK4sLPsiCZvZvHWEMaIusJ1o57s2gXOQc=;
  b=hYBBi8F2nFK8HoVGwrn4l0GqrIL/+L9JHZJbDZEAYU7SpR6ecS/jYCiP
   CN9li6OPEubCfnr97S+BOmT5wXPKPXuQ3hnHlRTODjjxes7/32xQFJRPT
   MENHzy3fA5XI6OYYh+VUnFDDjk00eIoJYBj7KyquW8X45S2hARvbKc+3K
   Rbj8To8fpVNMyhAwAGCw1zcGIcFhJo3lxiiKlDLUKysQzrpN/if/QiQg6
   aQwWflH0IGQVQ1P2ceKMVKwKh2p9CSgpD7Z9JwjMpDVIlLFFCi2mVoWKX
   H+zCc+kcqnNq7nRUa5c8G6sxE1lvxW0iDa3TqEVoT87k9ELsvJ3MTVrzP
   w==;
X-CSE-ConnectionGUID: evsjJ89ET2Ssc31M1cih0Q==
X-CSE-MsgGUID: KwYWjuGrRYWQpHjL2+vcXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4385205"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4385205"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:31:58 -0800
X-CSE-ConnectionGUID: V8hKemf1TcqUZYJ8kkX3Yw==
X-CSE-MsgGUID: 7ZRJavP3QsWcibVFhspBAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11381833"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:31:56 -0800
Date: Tue, 24 Nov 2026 10:31:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iio: pressure: dps310: drop the unused
 i2c_set_clientdata()
Message-ID: <awVLeeD55OAcwOtX@ashevche-desk.local>
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
 <20261123220649.36887-7-zoone.rupert@gmail.com>
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
In-Reply-To: <20261123220649.36887-7-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 12:06:48AM +0200, Rupesh Majhi wrote:
> Nothing reads the client data back.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


