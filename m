Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C521EA7F4;
	Thu, 29 Jan 2026 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702051; cv=none; b=LWXZqt1KAxptTHO+tvjz8LFEuQT+SkJgO8CriREM3Du+QctjDXz6YxyE0KS8S2vy+ZwKjNxKF3NzKtw6xuip3XkTscznUngNHZID2mhmOxeaVlubb0542XvKfbMoE/bndbTrelCui2Z837am6ir5q3ZWQdBxPq5yV+JnCKdC/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702051; c=relaxed/simple;
	bh=2e0yqhk6PkmWmkNllxL3zmoOotm1kTM6FYksa48Ph+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhTZKQmvOViTYDvYvSusrx+nK9v+qWOGziwCtmInZoWVbTAMOFqsz7pQaDxnInx4yL5jrCKg2p9gAocHs3W7qxzLY0QUdYlJzzXGSenV85uE4ai2F10rPOpCy5Twey48OlAnm0HOxdSWltk1XH5GH7khMgevpSz7XPPFZH0tWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqvoU8sb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqvoU8sb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769702050; x=1801238050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2e0yqhk6PkmWmkNllxL3zmoOotm1kTM6FYksa48Ph+Y=;
  b=HqvoU8sbNdpBTE+20TMJVdn1xeIuVIf4QWNbr8fDifbdtwRwUaJNsJZd
   KuRzK6+T7v5tQK5nU+N6E3kubNxKkb4ekhzJCgLwWjnnYhdVd+RKnLWWF
   ND5ScrAwpLHsu3lH6GVqK/+Gl+TG3e92GIQw6aePK5TY+cJVSJOM+1wB+
   j4QsEI66ei9utdVfby4QciDoloxiygrb+DJC5O7hWz8KgBM+11uxSIu6m
   ufgf98cgZNClF8KwesmsSuyG3SbX2mhN/FwL65gKhBcE6VPaMFWNwoSrE
   YjUAyIaFJKrRS02sAlUKjtVHsr9dP5oR4mwsZKRfa65zGTguA413HywlW
   w==;
X-CSE-ConnectionGUID: HK4V4rOmTEinCd2KBzQnww==
X-CSE-MsgGUID: my3evV1GTXaFMV4i/3ahLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70981594"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70981594"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 07:54:09 -0800
X-CSE-ConnectionGUID: ludNqmWjSmKxyuH49jCTVA==
X-CSE-MsgGUID: G7NiliXQSsqBhkfoaT73gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="239857939"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.155])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 07:54:07 -0800
Date: Thu, 29 Jan 2026 17:54:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: hsc030pa: Fix i2c_transfer return value
 check
Message-ID: <aXuCnM1CWJtGGa4W@smile.fi.intel.com>
References: <20260129150151.127713-1-antoniu.miclaus@analog.com>
 <20260129150151.127713-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129150151.127713-2-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 05:01:46PM +0200, Antoniu Miclaus wrote:
> The i2c_transfer() function returns the number of messages
> successfully transferred. The function sends 1 message but checks
> for ret == 2, which can never be true. This causes the function to
> always return an error (1) instead of success (0).
> 
> Fix the check to compare against the actual number of messages sent.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


