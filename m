Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0457200110;
	Sun, 17 May 2026 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779005153; cv=none; b=UeBpjRqOxftFQhF+Te5lEMrc5Jfu7mIp2bzu9lwx5+GTtwVUG2QrLO5WMEvaaTqCIJ8hZUryG3Ix3fIXKKcwkepBuSWmQvKcOuXF784G+yj+PGRuqKHwoyC63KJMjD9lYNo/Y+atY3PAkL1VgZKtY/aB00wFb70ZTUd/CmmKOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779005153; c=relaxed/simple;
	bh=1WSgHm9gOTvdjDcstmgDVYHQthUv2I+5kVZl7FnE71k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeBNTR6pLVl8tLFwyn0X7S0izjyqyiLVmnT8n8/VZg/TJwuhIP3twixDsAw28cAZKj4n4LK6dMcsv3orFSUZfaRxByiOjYO2EU90nXSSVgQukLlWedL6EwVVzcEGLTUjuOVAnzjmCUlPh/UehJXKrYBvReceaof7V7f5CmhkTOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1BbtQki; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1BbtQki"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779005152; x=1810541152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1WSgHm9gOTvdjDcstmgDVYHQthUv2I+5kVZl7FnE71k=;
  b=W1BbtQkimXNNxTK1nxHz1+/0j9zRtiClb8tO7SiFkSnD64PlA81v0j2P
   8A8Ri8KbpoPd7TbiSrYxtWyBxaEzvK4n7VQmA8r+CBdNoWekc8zp4fvWg
   Dy6pq1iDMwPRFA6aQ4Wh+Ig0v7sBBil1VnUg99FmIt7rsJd0kUaRwMxuz
   6n7qz56j2a2YCLLpKo8aOonGUH1Jt3y0xfYA6YITmN0iTT4p7Tn5GQKyX
   EqMiTNMrXYXt5D+KvPNuPwfGeTzcMDNC0tILJKyPWdvlAShvDfRck6ivz
   yavsh4NagPHrdQ+3SNsi7M161sA3ykZESAKp3gXjDyVzfQrQ1E04fUM0V
   w==;
X-CSE-ConnectionGUID: 0kUnQV+WQ16pkpRDM0a5Nw==
X-CSE-MsgGUID: fn2N6v/GRdyTlG3Vm6YX/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="90589360"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="90589360"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:05:40 -0700
X-CSE-ConnectionGUID: IIQ8LWzSQC+RlXSYa4c25A==
X-CSE-MsgGUID: 2BPoWHjzT9+IGJqr1sefzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="269471596"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:05:38 -0700
Date: Sun, 17 May 2026 11:05:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maxwell Doose <m32285159@gmail.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: chemical: sps30: Replace manual locking with
 RAII locking
Message-ID: <agl2z1XM69s8bz89@ashevche-desk.local>
References: <20260515031343.56039-1-m32285159@gmail.com>
 <20260515151840.48a42705@jic23-huawei>
 <CAKqfh0Fi3+jDP_UeKuTvdc2QkB3jttgRa=mjhgPPppc9sMkc4A@mail.gmail.com>
 <20260515155721.0097be34@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515155721.0097be34@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 15, 2026 at 03:57:21PM +0100, Jonathan Cameron wrote:
> On Fri, 15 May 2026 09:35:03 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
> > On Fri, May 15, 2026 at 9:18 AM Jonathan Cameron <jic23@kernel.org> wrote:

...

> > TBH I'm fairly confused on what Andy wanted in terms of "what do I
> > wrap". If he wants me to put the guard()() into the function call
> > itself I can do that but see the (ps) in my other email.
> 
> I guess you mean:
> Andy:
> "Ah, I was under impression that this is (unlocked version) is used somewhere
> else. Since it's not the case, the wrapper is not needed, just use guard()()
> in the original code."
> 
> Could be read either way but I think he'll be fine with it in sps30_do_meas()
> even if the other direction was what he was thinking of.

Sorry for the confusion. Either just put a guard()() into the original function
(whatever its name is) or into a wrapper. I.o.w. as Jonathan said I'm fine with
both approaches.

-- 
With Best Regards,
Andy Shevchenko


