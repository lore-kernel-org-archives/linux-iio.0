Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250151;
	b=n6bUwwRYVdLMJ2dQb8tL6ciZoCEHl8gx7YGQqQWQEwcxQH4OvbfPe+rUUxxp3LeazGHg
	 6BEjJuAZD5mlkmRDqE7N9z7+wVAX0KQTHpkCobbF8TyyOJbaVDTx+++cORdPj+EQXTBGh
	 +5BmUDOuhh/ydsIxTiLo4PPSrW7iz31M0CUP4vnhwDyfFTKvKk2Y8S7ygCbXn1KQIiyEW
	 JzRh8HeY8Nb6WM1Qbm2CSH0YU06CdsozD4lvKh+yuhfZuZG8nZaZj/9RwV0ukldMsoiID
	 bPNsUQbu+4DyVjC2SLp9O4eKEtpnOGX7Agr+SG4kirLKqMiZ8zxQ6A1aTU2w3B/kcOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250151;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=dQky7WjEtI31dpNTnPOhPEozQxBYxbvd30Nr4hlihLU=;
	b=NJ6OVcpnzKvivzErcLle7Ur4KQx0aQSvxyu8GJMFyu91xO/R4OOvozlKii3xsycmf0pe
	 ar4hUaZHOXM/yfYdD4SenBHvSLu2tHDqt4pCdIrsBHk11wa3b1eh9Fz2TkufsoZncTkgu
	 kjpa+m0WpNU5EsXf0POjOJomAopkahWSgVEg/Etz3mRaKYWjRGdY/2ysOOUX6Bg7YCBQE
	 KPz+POr1XSTBrIKqIismBdyL6Irb0qYu0HI0vH0R+jau5joSgLCt8Fkq9kNbd9gPiTqat
	 ZTeGhnSgXW8niitnWj4VMGqQahzTV9xdgyfJL0bjzsm6qhmyaTLBSl4kgOMi1QYfjkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iDQM6KTh;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78120606A321;
	Mon,  9 Nov 2026 18:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78120606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iDQM6KTh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794250148; x=1825786148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tMYyACM5F+lNXcxwo++s8f9YUQLur2eK3nc07ezo0JE=;
  b=iDQM6KThEqZNXwzgngyqaVeM6CYC4wsm9A4NWs7cliEKg3CM9AshZtjy
   82sT+nvyGvUJunkQDqOR6XJblzntR0aEgeO6QvyZtfEErowApxuV/lhgj
   CUKLjMqqTNav/xfISU3JfV3DGwu/hXTaONQfqhPmicNaNLrjgvnAiClU3
   81mWtIW/Y2+Kg2EuBhx9f1mTNC+ayfPdRdcZ4ZZ3cw9LfNe6IZBshJsoP
   MBCoGQ/j8N/13LWjQWDZEYarBVCsnkECEJtoXZVHY46VBoMaVo2S9uLcw
   FxNMSdHqgjb0Vn7nm8Ysn31eT8iA0XBgurAJ4jNrw61EDEm1riNvFopXW
   A==;
X-CSE-ConnectionGUID: G3I9DYnjQx6bt5LG3jCC/A==
X-CSE-MsgGUID: tzhuV/mcS4+gIgatDT1PeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2981615"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2981615"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 10:49:08 -0800
X-CSE-ConnectionGUID: txjmXJtOSbiPVdPpFDktug==
X-CSE-MsgGUID: JtouFjO0T3e9wIpAmod3Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9797587"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 10:49:06 -0800
Date: Mon, 9 Nov 2026 20:49:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: proximity: sx9310/sx9360: reject
 out-of-range hardware gain values
Message-ID: <avIVnx_JRD0d7SY1@ashevche-desk.local>
References: <20261109165200.305266-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261109165200.305266-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 10:21:51PM +0530, Arnav Kapoor wrote:
> sx9310_write_gain() and sx9360_write_gain() squeeze ilog2() of any
> integer into the register field. Values that don't fit wrap around,
> and 0 and negative values turn into the maximum code, while the write
> reports success. Reject those. One patch per driver, as the Fixes tags
> differ.

I would change the error code to -ERANGE which is clearly states that the range
for numbers is wrong (like mathematically). -EINVAL is way too far overloaded
with semantics.

-- 
With Best Regards,
Andy Shevchenko


