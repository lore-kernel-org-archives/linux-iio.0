Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427044;
	b=UdH5V9JkeyVbVq1i4nos8GYVYwfBpIl9KC3uvMUQRVxTXiOSPzeGO8WzrZzzr9dGPxTX
	 W0p9Td+qblqEwqnB7cw+/zFhEsacf69C+xa1oUcckAABkspdG2PcKW9LN8q89GcEBv1UV
	 FFzLQYLMQ9kwHuy7EaeqQsTpDaQtQHskDTae3lLf8lCNVwj7ky8azu9Oa6qVtgMYeCM+D
	 DYAENqFqBH5F+TjGUy/g4L73KHf/OIh0tzBtoXuuqsolQzXYsPnJoQse43y7h+IyRZbRG
	 UH99zXnmt7BsscZsFFhTZecfcn2lCLISEZxvYl3D4PtoPt7tIHvzL6VaXpNY4cDbeJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427044;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=CRsoRA73h09xH07EwuFGwBbZU7fmt99uQgIftFEQwWM=;
	b=yPU4i7Pg3JwYxjNt/6UqTKIeYWUv80bOW+YNL93WlwBcFPZWSmvdZnIDIVLpi3yVoYtU
	 +5lhf5HXChuutaLmq90Ppg/5zVBAmqRs/+Z9xAiFmgKsAwlxIiSX9QH56FuCsXo/6yEcX
	 4s8Sp82ckdasTgeHui0L1rUhphr1+YnPrcW7d5POj3BPLszA0LV6LP+xq5TZpal0eCClJ
	 nvGcdVgcsz5Aj0BcJfF0NduCmqHAHI9TVCuZclMsUMzQlOPQvs4B74dL0u8HUWdmFga7g
	 so1T1ir58NYjqQQ/VgaMKi+X8DJQbA2NSVhR6+X5k0ErwBb40Wd2t2uqxhA/QeFewRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NTA8Evyk;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7D606A31A;
	Mon, 23 Nov 2026 09:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43A7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NTA8Evyk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795427044; x=1826963044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rWIylgWoANS9yFBBpe3eSsmmz39xGri44CKMPfGeCvg=;
  b=NTA8EvykHa+lPDqNbNmGenrzJCjqdjen+RKRFDw2Fg9ZCf6et+hceJQU
   Y+6OI9az0G6tGs125eP7+0qtn0vkMdVZVuCe8B2voXEyse9no6dCK7S62
   rotxDOukGkNMJ43Q8PEub9I0btJR4++qGu/yFLumxZ9/C88Ttk09mU/XC
   OnwbqkEphkDQYcBGhRoECkAlh6DYTSKeGcVCVNBoBddO9ITs00gyZLWEg
   wnSei1aIZdD1T7+F9XeQDEW+b+X85JKXADZTwML2ELqvV0zWX5OYP9byz
   rUAlGBxA20WghcKPAhg4IpLf+0ZP4uJIQuVO9iMuSbh7YopKBYj5VEXVU
   Q==;
X-CSE-ConnectionGUID: JaZId09yTaa3/EMmwVWhYg==
X-CSE-MsgGUID: 4L+FBYXHSeeZvYcsyh4HRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4208535"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4208535"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 01:44:03 -0800
X-CSE-ConnectionGUID: nk/sFRcHRqCbLPiliOzSkA==
X-CSE-MsgGUID: hLD0Myl4QJi4GhxvGS5otA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11562041"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 01:44:00 -0800
Date: Mon, 23 Nov 2026 11:43:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>,
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 0/7] Add E notation support to kstrtodec64() and IIO
 sysfs writes
Message-ID: <awQK3pOkzi8fHT3F@ashevche-desk.local>
References: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
 <20261122204447.56875aea@jic23-hlaptop>
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
In-Reply-To: <20261122204447.56875aea@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 22, 2026 at 08:44:47PM +0000, Jonathan Cameron wrote:
> On Sat, 14 Nov 2026 14:09:52 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > This series lets kstrtoudec64() and kstrtodec64() accept numbers in E
> > notation (scientific notation), such as "2.7e9", "1.5E-3" or "1e+16".
> > It then moves the IIO core fixed-point parser over to kstrtodec64(), so
> > every IIO channel attribute written through iio_write_channel_info()
> > accepts that format as well.
> 
> Andy, no huge rush on this as we have a few weeks left in the cycle.
> However I'm relying on you for review of this one.
> 
> FWIW looks fine to me and I like all the confidence the tests are bringing!

I have nothing to add. Feel free to apply rather sooner, we will see any side
effects sooner in Linux Next.

-- 
With Best Regards,
Andy Shevchenko


