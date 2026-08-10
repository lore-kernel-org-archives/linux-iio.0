Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC438657E;
	Mon, 10 Aug 2026 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381473; cv=none; b=BDU1hr2rWiIx9U06PNEZ5Ni4NyOPxKwm+N7Kp6x2s9bgQFm3zvJEv8QY4xYDql6Ol62/TTD0IKK4grRJROEiiVblWVmBhNM2czlFcgdh4KV7E7vXd+5SFNOlwzimHqIycOXHBsREsgO35SgGrGInj61EytgdsKyClbiwWTRK18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381473; c=relaxed/simple;
	bh=GWx5cWR77+Aur8AsrliPdyoIYO3RJr9tjfz1Bv9lfsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQkLL5bjmhgtGoXI7wRqm55kO40n4dN6AS5gu/XzUcCNbdS4AE3R6Y4deoNqKI90X4fcfU/rhnkowUpWZ6i0LoaC8yOOob0Q3qQXdvM5AAzKBqnbO5+hGDWWc49IW/Yuwj7+J/7+ERdrJrln7gMMhsgaSKWm+EBTlHb0yDR8/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbcZ/jN5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbcZ/jN5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786381471; x=1817917471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GWx5cWR77+Aur8AsrliPdyoIYO3RJr9tjfz1Bv9lfsE=;
  b=FbcZ/jN5vLglGtZNyM/evJ/1OMRfYnmn19NZ8MqyKgUIP2TfzvQ7xPtY
   ulPStwjajsJjXHk+q3cwNvhlDift0pp8tD4Nm8ZZD399V1LvX2RqcJDhT
   NxYbL4PKjcyZ2vAOQSTx/+DY10JgDkVbjhn+gcU9XnsnuQJGvDV04TcMg
   CjMQkgWB8/x5j4R+QwqdY6rd+w4Tk64XrXQ/B8I2gl9pA4YPw4MQOIM4W
   oPugRN2RlbRPOpwKPLm4feqIDrhQBAnTayrOOC6x/Hui4vssUXlQlZT68
   I+2nJ9iMaMOCAJBFdHzmf+SToJ/FLB6y0v/kaeaSKZIY9/STXsRzxNy2A
   w==;
X-CSE-ConnectionGUID: lXPjsMIwS4SGMDm/PdnEJw==
X-CSE-MsgGUID: lUouIA5FTgST8gZVdgSWeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104294955"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="104294955"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 10:04:28 -0700
X-CSE-ConnectionGUID: yCith6j/Th67/Kt4sHy4Fw==
X-CSE-MsgGUID: h8dytrhmSxukfe+zi9SU2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="301326206"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 10:04:26 -0700
Date: Mon, 10 Aug 2026 20:04:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: max1363: sign-extend bipolar differential
 channel reads
Message-ID: <anoElwDzKRBoHTcA@ashevche-desk.local>
References: <20260810164446.2555239-1-congnt264@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810164446.2555239-1-congnt264@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 11:44:46PM +0700, Cong Nguyen wrote:
> MAX1363 differential channels are bipolar (scan_type.sign = 's'), but

The (...) can also be dropped, but I leave that to Jonathan, no need to resend.

> max1363_read_single_chan() masks the raw value to the ADC resolution
> without sign-extending it. Negative differential readings are therefore
> reported to userspace as large positive values (e.g. -1 as 4095 on a
> 12-bit part).
> 
> Sign-extend the masked value from the resolution bit for differential
> channels. Single-ended channels are unipolar and are left unchanged.

Now looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


