Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2472EAD1C;
	Wed, 29 Apr 2026 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470632; cv=none; b=nniJLSmbcahE9lJzrdOop/mBYnHsQkGX6/RvmGeEzBKbltR4tu3HqSA+uStTjfto2Qn8MWnrvQKcLp275LRVVKbb3dr1WA6/S9DzsHzWwGZ4bo47lo15IEPKpfjOmIJrLNnZONJcM1YVkq18VMyNGbutFTA4gtxRYRBjyZWbKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470632; c=relaxed/simple;
	bh=U3ITzOjakFLxgKBgMTwYaFIvk70arz9wJWa/T1QEdgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGM3STi4c/gfek3bRUQkaVOzecFmw8u3VsFTRw0OUxRna98r4MtHBc3n1aOOVrOVjWLzRyVSv38xNI9CF16ueuRpVyTgoQYImr+EKlZdPXdxx456gd7p20FkBCsJlaJ0zKMDAWvW+lC4IgJgl2uedUblYwY3RrYoDT74u02naSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQIGBiUj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQIGBiUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777470627; x=1809006627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U3ITzOjakFLxgKBgMTwYaFIvk70arz9wJWa/T1QEdgo=;
  b=MQIGBiUjkv0quJqkIX9vkkSk28sQ0/8nqUCTFa/xuTYK5mQbqRppCV3Q
   XMxXMY+5DD9kjAI74pWWD6kmSfOkyL0Vq4GLI+JeCizuatVza0UwUwAWo
   DPBTnviLMlK+ReI3XtenAetCDj1563bTKG/4VNdFSQs0gtJ7a8NDkLXy8
   RSAmHXVtH3T+HGS59AYVua2eeG5DaFwbVvAJg06EUqNVF+AujqXJVM5lm
   O23bLZz8UbLWGJryTObrRjgRFOJzBYrkw4LppMQjmn4iggRSj4vZYtSYF
   B9Z7VzK/iuwxF34tbcK7I8/TH4d3qoponLQ8thxccJmpJ0CEb2dDHEmBD
   A==;
X-CSE-ConnectionGUID: hHyQ4/cDR7qun08SUdYhgQ==
X-CSE-MsgGUID: /632qNFaQ+CGuDqyxJMH1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78273442"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78273442"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 06:50:25 -0700
X-CSE-ConnectionGUID: NpSt/AIJT4iMOrQMKldMQQ==
X-CSE-MsgGUID: qDxGMF+7RDuDbf+CdeYkbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234142226"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 06:50:22 -0700
Date: Wed, 29 Apr 2026 16:50:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rodrigo Alencar <rdealencar@gmail.com>
Subject: Re: [PATCH v4 05/13] iio: dac: ad5686: fix overlapping DMA buffers
 in I2C read
Message-ID: <afIMm2x2iOUctCY4@ashevche-desk.local>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
 <20260429-ad5686-fixes-v4-5-bb8f1cbd68e1@analog.com>
 <ydxol7bwgvhxrw2zafaplzvk4kmnbvj2lzyfioh2lhfrrrxx6o@zsbw4mtx7gly>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ydxol7bwgvhxrw2zafaplzvk4kmnbvj2lzyfioh2lhfrrrxx6o@zsbw4mtx7gly>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 02:12:32PM +0100, Rodrigo Alencar wrote:
> On 26/04/29 02:07PM, Rodrigo Alencar via B4 Relay wrote:
> > 
> > The TX and RX buffers in ad5686_i2c_read() both reference data[0], causing
> > byte d8[1] to be shared between the TX buffer and the RX buffer. I2C
> > controller drivers that map all message buffers for DMA before initiating
> > the hardware transaction will map overlapping memory ranges with
> > conflicting DMA directions (DMA_TO_DEVICE and DMA_FROM_DEVICE). This issue
> > was reported by sashiko.
> 
> Do we need a proper reported-by tag here?

I asked Roman (in another email thread) about dedicated email for that.
Let's see what he is going to answer.

-- 
With Best Regards,
Andy Shevchenko


