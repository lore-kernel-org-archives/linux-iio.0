Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F86439326
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444371; cv=none; b=GZUdEUHpkv0i1thkGrCq8NCjaDt7/vAs0TASwtxfwrgeeq9vH9vrr7D5gVWMWPjpQVOtB0yB3ZkLf0foKBsStksrsxuFVXaGWQltuPd/FP8RZdYcCTpMAgPzHIx81SmLoqBCBx7xzJK1ZNTpsUx36MyJOzNyehK5w/COrpvYM8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444371; c=relaxed/simple;
	bh=Y/f3n6dJdsDPq1RRCKCpytHX7WF6MTuDyevdb/9tIlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SU/5uBt53U+kGV3TsLtOpIhHIJIkPn8zpQ1ah7JrJ4kAA+rfOa6WotfCVih2G8oMypsKZSBM1BbH0nvKkaSTrcfS2NboIPJDwJGdO2ex3sVVGTOHdg6wAsTV+2x+j4Il3rxvUGNvRM5ntJWcg4MrDO3sLg44ZReMhRG9KQEuQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEDk70Z/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEDk70Z/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786444370; x=1817980370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y/f3n6dJdsDPq1RRCKCpytHX7WF6MTuDyevdb/9tIlA=;
  b=gEDk70Z/eMQLt2bJSyjMosMH//BtVhmKMnwO4ULm3e9BQtKNFgzIDrTg
   YsiwaPr/BMk4anjArqanxVoMuqWKjewH0fJetE8I9xuIzndkTn1auJiOS
   eTCkFZZQhHevoNRB+w7Q3ntq0TjZneT+XhruHTjPMuOlyH41P/VwwHSRQ
   v17SocyCE5hmKT86tQN76bYC+yKFmT71KeSh6Sp6mYzSoyvYLalabBWdu
   p6Ej8ZPufj2SfW11OLbN+4UgrY2SGf0FfQdBvZKGapZ4XXT7zWj0RJwJ0
   ktKshFSTvc5+7CewElhe2hgO0i9bFIetU0AAnPYH031Pq+cMK8+Uikze8
   g==;
X-CSE-ConnectionGUID: LoEk901NT76NIqBQbO4K+Q==
X-CSE-MsgGUID: Z5H7NzN0TJm+X0OeqkqU5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86849559"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86849559"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:32:49 -0700
X-CSE-ConnectionGUID: Zk4GOm8qQNet/DKckvXY/A==
X-CSE-MsgGUID: j3i2BEq2TZeBd7JDtdfPjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="261989911"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:32:47 -0700
Date: Tue, 11 Aug 2026 13:32:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Jinseob Kim <kimjinseob88@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Sanjay Chitroda <sanjayembeddedse@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, sashiko-bot@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v2] iio: buffer: Ensure bounce buffer used for unaligned
 case is zeroed.
Message-ID: <anr6TMSfdmjQk3Oa@ashevche-desk.local>
References: <20260803012224.219493-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803012224.219493-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 03, 2026 at 02:22:24AM +0100, Jonathan Cameron wrote:

> iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
> to userspace if the data passed in is not a multiple of 8 bytes and the
> timestamp is enabled. Specify __GFP_ZERO for the devm_krealloc()
> to ensure any extra space is cleared.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


