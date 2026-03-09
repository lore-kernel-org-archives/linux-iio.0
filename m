Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD23A63E3;
	Mon,  9 Mar 2026 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056464; cv=none; b=VYsnUXu2M9f1K2FGzghk6JGggYMXi+n8qjQ/IvM7fCYoRjzcNB0AEvgwdDJrHN6ju95j9XNZBQmp7bYELIsDkG6LcUvp5/2I+WpI0N32PwURhrjqgC95k0Oll64Zbb47c32bmX+V00iPBu+h47FEJ+RfOgpZXFgxny2+kvuj9sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056464; c=relaxed/simple;
	bh=34zyK8tjSBMpWSx5VTGSqMJvCDJu09r1pBdTG++FqUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ue2Ssi3YcLVB+dEWrkvKq85AUnEqW8ScH8i6XgThKAU/q2lVkXhaefX+sYJEn/5+0oWcQoPF5jU0A1Merxwot0bU1UaaWcLnmrJQ7MYgPGWgK7UY1kDGN0GwS0QAHLPm4M+ZV8kazQAaoiiaxMfJA9hcwuPqdMPgR6t3LH9pxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cgugp7sP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cgugp7sP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773056462; x=1804592462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=34zyK8tjSBMpWSx5VTGSqMJvCDJu09r1pBdTG++FqUQ=;
  b=Cgugp7sPphmHqhSediWJUVWkRckC6hYiuHKpHcpFiGJwQZ2/LmCKe2Xc
   KhctZ19JQaebOo7bexeHpcN31vwVa9pDPVWJAScUodN47s6lP4qQsHJTr
   xRu19PUj/dlrj5ejn6rreiR7DFur2ZY4GkRZJygO41BJwIAMWC33fa2qH
   f1ak4AZlDFY1tvSQoZCFnfE3G3hAPwMWsQSZb6RJkpGxuQ68cvC8ST9qe
   HIKtfn4YB2tYstO8b6aiVrqfMSPQm/Bx+UULEvsGMwrb+Y6wq5LZS9FMj
   tOW0SQkl+zslz6OO6q1Z+9Fh7jg7147u9lXPeoZrTcHv1knuN98wrPXRj
   w==;
X-CSE-ConnectionGUID: xjM3BixERhS9ahXeidMtlQ==
X-CSE-MsgGUID: GcoM/OQnTIyI6u2qcA7AEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="77955272"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="77955272"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:41:01 -0700
X-CSE-ConnectionGUID: qpLsMJT0S5mCjD4+q5/2TQ==
X-CSE-MsgGUID: QzczfYylTwWnBKhgTHd5jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="218869767"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:40:59 -0700
Date: Mon, 9 Mar 2026 13:40:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 6/6] iio: common: fix spelling mistakes in comments
Message-ID: <aa6xyC0uXdq9P5ZC@ashevche-desk.local>
References: <20260309104513.40359-1-i.shihao.999@gmail.com>
 <20260309104513.40359-7-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309104513.40359-7-i.shihao.999@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 04:15:13PM +0530, Shi Hao wrote:
> fix incorrect spelling in comments

You should follow English grammar and punctuation. In particular this sentence
is better as

  Fix incorrect spelling in comments:

> - exepects -> expects
> - fuction -> function
> - theoritical -> theoretical
> - appopriate -> appropriate

...

> 		case MOTIONSENSE_TYPE_ACCEL:
> 			/*
> -			 * EC returns data in g, iio exepects m/s^2.
> +			 * EC returns data in g, iio expects m/s^2.

IIO

> 			 * Do not use IIO_G_TO_M_S_2 to avoid precision loss.
> 			 */
> 			*val = div_s64(val64 * 980665, 10);

-- 
With Best Regards,
Andy Shevchenko


