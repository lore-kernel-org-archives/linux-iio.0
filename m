Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F239CD0D;
	Tue, 14 Jul 2026 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048900; cv=none; b=gfvKD/55jbaMHvX3L0F+ZX0fqEIAzhPlTxXB75tZrk/vSz/cCSypJSdnAdDTmyISaAog1UHttnJAMoMVU3EYREnvBIueGBH2EagbOUXVT5nSDIgphek2KawjjXaUq52VEV4d8ZwUb7W7QC0QtocW+tIrmZEJQpd8RBzodYcp5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048900; c=relaxed/simple;
	bh=X4hdrrNC0evxqW6rEoPyZgOvOoEe/BPbJMt1fa/0nNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1+elo0EuzW9TQTlyfRgzcSeJaOWbG8+bcWpqvDo85RSCzJGXUbD6BVgUAN6tmBjPoWPElWOXGGYL8mKx8ujID/yT8YImHlfYRnRS41M/MH9qvwlUkpRBuqarJPMqCEtW0AohtfGuSZ2iD88hAtReIm1obCqMsSino8UDdhcxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxcmvU/O; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxcmvU/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784048898; x=1815584898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X4hdrrNC0evxqW6rEoPyZgOvOoEe/BPbJMt1fa/0nNk=;
  b=LxcmvU/OLHZUrvTl8TELvmSzfFhTDBN6ecbQkIU7tF8xnIcN+HBV0IQk
   Y/r9Nauh3HsA9wGrTKuFtMK26q8sn4eyncT8QFF6QCVDbxoCcTxYV6r3W
   ye/hgKYrWGc161ezssvZGqu0X5oL/cLIT0HTNr7onvOW2JYr38aerFu2x
   Qy6E9eUZpyamExXQ3RVqItIFKIhfhAp/E9sPpG+4EZ+lnpZmGwmvIOcDV
   DWuG5XLM+o4fn9l/cAgEFZz6BNbcoKTZgP/EtPuG8Dk0wMZUUY8oxiPu0
   PDmCMI05cfvj1wL5e1BVn2YUX3PhzYZASPq0ktyAZ8FQFRSL2W/g+6l3C
   Q==;
X-CSE-ConnectionGUID: 5u+B1QzeSsGo7VSXguzWQw==
X-CSE-MsgGUID: fORUoRBuRG67w10ks3XbdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="87222289"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="87222289"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 10:08:14 -0700
X-CSE-ConnectionGUID: 9sA7eecaR5OeJgKsgUgN+Q==
X-CSE-MsgGUID: /ck+xPv3TBW1lQng9uBnMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="256576010"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 10:08:12 -0700
Date: Tue, 14 Jul 2026 20:08:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: make read-only const array config static
Message-ID: <alZs-uLJug_rnRnq@ashevche-desk.local>
References: <20260714165012.184651-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714165012.184651-1-colin.i.king@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 05:50:12PM +0100, Colin Ian King wrote:
> Don't populate the read-only const array config on the stack at run
> time, instead make it static.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

In all patches like this it's always a bikeshedding possible of moving static
data outside of a function. I have no strong opinion in these cases (when the
data solely used by a single function), but in general it might give different
readability experience (it's harder to notice static data in the local function
definition block). So I leave this exercise to the maintainers of the respective
pieces of the code.

-- 
With Best Regards,
Andy Shevchenko


