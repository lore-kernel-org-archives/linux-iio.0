Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DAD36BCC4;
	Sun, 10 May 2026 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778405088; cv=none; b=CAXnfrjmGsuB4N/RxrZEPCvQo8UCMs85rH4dV66X1LkGbZFHn0mvYdv478Wv1VsqGMSPILlPgKQNb4EL44CT03Prt1bIHfCeswrXsVY1MD65w+Hq7EpkUcyNTJk1JdU6hTKujagKV2PKNOVQvwzAim9tL9YIoYdJBwtWxCpdc3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778405088; c=relaxed/simple;
	bh=vV6fYEZMln0QIDLiRgIzI/8aacjHAcjlWG7g9QHZEOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W40g++e7skoZcDu3HF19Dr0NuZ1WPu4Dwb30707vFDik/X1JUzWlxS+9iOaPTysQnyZOpIFW79ZTcwU4q1jnfOkv+AV9YG4IVTkZNyLUYIS60WeKjMYAh14CwY9auPlJIGvqpWnpxb76EMoem5vjjjfjxTsZ2nXvxCFXCblPYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMeUF4bB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMeUF4bB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778405086; x=1809941086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vV6fYEZMln0QIDLiRgIzI/8aacjHAcjlWG7g9QHZEOU=;
  b=PMeUF4bB/aXED27oVrs6Z4vTVEBB9EHQa99ELWEspRTW9IwMzh1qm3XF
   dqErfSAm7C6v16bOlJMkUbKzkICMBnQxliqh54Mlh7LsSpF3kKYGOCCTS
   8QDwC4DigMk8OF/fjKNEX2C2xBjcgBkpcIqAVia4AO4JyoksBDF86tIOw
   f0sEeKOnHeu+Igzxb9MHRpGesK1JhbAlJQOIuCGfv9hA/OQPZyd3e4X9D
   sqPBvM1SbgZipES4etegiGio8+ke2xg97fLhYxJpm1th/1BN15WwqcjGJ
   HSnATKLbLbeKSTyImNULt37MZ1Mbo8Rdg2Sld80szZCHd9DYqQiCkKYEz
   Q==;
X-CSE-ConnectionGUID: Q/kHsxUNSbO74hZcUnnxOQ==
X-CSE-MsgGUID: XKmSxZYhTZiqPCVslVanXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79043454"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79043454"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 02:24:46 -0700
X-CSE-ConnectionGUID: rTPAmrhlShKSNXX0RNpF0Q==
X-CSE-MsgGUID: iNXa5OY2RcmIq8/TS6qeOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="236339492"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 02:24:43 -0700
Date: Sun, 10 May 2026 12:24:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: salih.erim@amd.com, conall.ogriofa@amd.com, jic23@kernel.org,
	michal.simek@amd.com, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:XILINX AMS DRIVER" <linux-iio@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: xilinx-ams: Replace spin_lock() and
 unlock() calls with guard(spinlock*)()
Message-ID: <agBO2G58CXypMEIN@ashevche-desk.local>
References: <20260508124513.17752-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508124513.17752-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 08, 2026 at 07:45:13AM -0500, Maxwell Doose wrote:
> Include linux/cleanup.h to take advantage of RAII macros.
> 
> Replace spin_lock() and unlock() calls with their RAII macro
> counterparts, which modernizes the code and increases readability.

> Remove "flags" variables where spin_lock_irqsave() has been replaced
> with guard(spinlock_irqsave)().

Unneeded detail, everyone can see that in the guard()() implementation
for the spin locks. Otherwise, LGTM.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


