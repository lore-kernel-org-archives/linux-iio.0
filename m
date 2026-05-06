Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C6E2E762C;
	Wed,  6 May 2026 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051485; cv=none; b=qjmWouClv9dymxFkfmtq/wohdvMk1e2ud/aalTt5bKoBLvoSQgfObVMRZgDwJu0vl1Dy2AimnX+y2CfgwzEvoZT5O87690qEAkvvBBALtkGNQ4MVgzyA+9gqZpL0vxLKPBGQ24LL2Lgfje6TwKO3dYfKLUUmkRW/eSXfuZIRlHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051485; c=relaxed/simple;
	bh=XUBssawCC6ALEnRMn9jyRS9doDJ6reZ9GAz6FOC2D34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDYDFMQIET1EAMDwRxJ+QBI3VCKYVmrGttXWKgSTU9dyZIEQRL1xFPFIF42c5EaR9WpsuXYJsWiGwUs2Z8DTExlf0nIFHKR+KJPtaGIr4cnou35VSWmIZFtrUhbSl9kfhh++0340++vHGA283xhmDeG60T8UrsPRiyutiYqCxcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxI7dXh/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxI7dXh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778051484; x=1809587484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XUBssawCC6ALEnRMn9jyRS9doDJ6reZ9GAz6FOC2D34=;
  b=BxI7dXh/cpqqDCxJEqmcL5Q6sP0QJdBj85q6wxlwzumZyZI0Y7uspnNY
   W4BFq+TWt9iMjpLd+NqsMFg1aZYnGiEO6Yh2tE+7otVwv2xHt8/9n/0nh
   LwrFDAVcLuY/M+YRRyFOzUftsVaiEX+/Os2dwGsagHggL6didTvx3yisk
   HOlPYHnFRcxFDisElzh/pr3uiGNSuL8WEo0b5QUpYfmH1SGMBSNxMv/KX
   F9WUZ2FRiW1bFJNpjBaIu17tNbViBK60svTz8dQzC0QJahWZy/t31ehi/
   ZIEAY6uFHnGQU5VvUTCUMgqb5UmF9OPxpozEwNcy2EAyBN83dbmSUQNW/
   A==;
X-CSE-ConnectionGUID: Up5t41DISRubmQRhh+6thw==
X-CSE-MsgGUID: GQkbCQOUT8eL5TuE/6x8xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78861917"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78861917"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:11:23 -0700
X-CSE-ConnectionGUID: gvOtwIovRF6Q8HFk4UA2pg==
X-CSE-MsgGUID: pScLAFytQVirqERh2qDJnw==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:11:20 -0700
Date: Wed, 6 May 2026 10:11:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: joshua.crofts1@gmail.com,
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
Message-ID: <afrplquQwS2hmjEM@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com>
 <DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
 <CAKqfh0FhpVMtoRyBPjmv5JHn9ad4fPgn5wiyYpEnSYf73Wd-rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0FhpVMtoRyBPjmv5JHn9ad4fPgn5wiyYpEnSYf73Wd-rw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 08:42:12PM -0500, Maxwell Doose wrote:
> On Tue, May 5, 2026 at 8:09 PM Maxwell Doose <m32285159@gmail.com> wrote:
> > On Tue May 5, 2026 at 6:46 AM CDT, Joshua Crofts via B4 Relay wrote:

...

> Actually, timeout. Sashiko had a good potential catch here:
> 
> https://sashiko.dev/#/patchset/20260505-magnetometer-fixes-v5-0-831b9b5550fc%40gmail.com
> 
> "Does this new error path leak the pm runtime reference?
> In ak8975_read_axis(), a pm runtime reference is acquired via
> pm_runtime_get_sync(&data->client->dev). If this new error path returns
> val back up the call chain through ak8975_start_read_axis() to
> ak8975_read_axis(), the code jumps to the exit label.
> The exit block unlocks the mutex and returns the error code, but it skips
> calling pm_runtime_put_autosuspend()."

While it seems like a valid concern, it doesn't relate to this change.

> I'm going to withdraw my reviewed-by until I can confirm that this
> isn't a problem, sorry about that.

Why?

-- 
With Best Regards,
Andy Shevchenko


