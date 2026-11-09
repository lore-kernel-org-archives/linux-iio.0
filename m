Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226832;
	b=03JmE8FswWp48ZkmBPL6IyWPhBKppHRUj0aSKY6rwBIc23gXgb0HQzytX0uDesF1x1Xf
	 kVbCB3V9qcHDEgAMtuubFAyfYJZngTQIWWotPEkksHJwMP/MKjJKMvKQk0bKsvrbrHNrY
	 HGU5r7aLVzdacYiCDcjxLn1yecPGoMgrUe5I+uv++Bgujlchef6tRP4iBOn8g7eAAYSQw
	 KAFC0VmV1j9e6U/pzYLXY+k2NP5ia8BSj5+/w1eR/XhcZRn8qWUfhVsJINqn2zmB2ub3K
	 0nxkbgP/NGVfK47qf83E12uuHjAbWJQSFOiaDG3ROXxHohcCj3szxjTWmj9Q6kYKhRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226832;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=kE0/ygUG6OzgulQ1EncC7piIzJkfHZsxcepIiOM66SY=;
	b=i+T3taSCErKbq61MUKXMjtGgP8/mKbPi6ovg/vhm0cQwBzzQNL7+VNuMF12c2d2je5JG
	 7CJFCf+eTs+i5Vxog2L9/WlpVWzwFFvE9bEj80vrfDb7SI7bKSbzZpb7JjpxTjG4uShwg
	 EW+DAqhWdU4lj6gGoGDYkQHygFwMXHimv5PUrx4VDOlxPBf/6eOEKbi4vNTrRQWp7XZeG
	 cHabBMg8x4QgBjrWPvtuQEVYVZjs1e3xBMqX981nHlR1CUcZOEpwfTtgzdoW6i1JXFTx+
	 K8nkf82ubc0cJy2WTN94l9b0tePHlCSJYKEiMqRCUStAJPaiHpzQGZhV1RK13uSSozQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MgHoO1Y8;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C00606A338;
	Mon,  9 Nov 2026 12:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8C00606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MgHoO1Y8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794226831; x=1825762831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sAUoNYP2fqQVvNPq10oZ3ofWU7N+A2Mo3q9QoET+I0E=;
  b=MgHoO1Y8UyLmba0u3FYxRNsDM8OAKhaQvn4rjq20IdE4jLPXsAHsocOH
   0mseL6CzdDjp9raKHwoPdtbQwM3osWsSjUAOy1CEG/vUGJv6vj5kK+P8O
   0eVXwH5BzXeUNxxvNvxBjAJkz6j2SEx8drboispyZ2V9ppzpBB+vzwnLW
   dKVG/olDfxi/wrNixPjI+65iV2k1dRYlQEF6kOU88s3YjwCvl5F2QNclZ
   IqbEXKshunsKf5nJQ0gYjRCpZ77efZdfCedBBOplzpkdOztkMmMgtju98
   fwLRmiJ5hxqZUlYckIMhoan6If7paNeAUte3r6kXNJH5ym5vEZJuohEBX
   w==;
X-CSE-ConnectionGUID: f6yEzodlTSu7hcoVgdhRag==
X-CSE-MsgGUID: 56HXQBUJSgeA01yalJgYxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2828824"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2828824"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 04:20:30 -0800
X-CSE-ConnectionGUID: L2GkJ3hlRCCgs9mkzPu5NQ==
X-CSE-MsgGUID: ppIOps2dQbGIrJDpQXi7bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="9602986"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 04:20:27 -0800
Date: Mon, 9 Nov 2026 14:20:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akhilesh Patil <akhilesh.patil@linux.dev>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, crofts@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, alexandre.belloni@bootlin.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
	akhileshpatilvnit@gmail.com, akhilesh@ee.iitb.ac.in
Subject: Re: [PATCH v2] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <avG6iHBBDp0ATTsi@ashevche-desk.local>
References: <20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com>
 <20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com>
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
In-Reply-To: <20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 10:44:43AM +0000, Akhilesh Patil wrote:
> Move to my new linux.dev email address akhilesh.patil@linux.dev
> I plan to use this email for kernel development going forward.
> Also update email address in few yaml and driver source files.

...

> --- a/.mailmap
> +++ b/.mailmap
> @@ -1030,3 +1030,4 @@ Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.com>
>  Zijun Hu <zijun.hu@oss.qualcomm.com> <quic_zijuhu@quicinc.com>
>  Zijun Hu <zijun.hu@oss.qualcomm.com> <zijuhu@codeaurora.org>
>  Zijun Hu <zijun_hu@htc.com>
> +Akhilesh Patil <akhilesh.patil@linux.dev> <akhilesh@ee.iitb.ac.in>

It's not a rocket science to see the order in this file...

-- 
With Best Regards,
Andy Shevchenko


