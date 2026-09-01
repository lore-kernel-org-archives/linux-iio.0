Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D7470444;
	Tue,  1 Sep 2026 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249031; cv=none; b=hzy6xpdXGCs0gmBTe0p3cCsONJqV1eFZ3rGWbr9Rboej2hH5sMMa9Sb+BvqkeHbLZ6Jk2xg1S4zk1BHAUwLkPDAkDDOz4SyEFesE++6dnMYe3ofwbJMXCJG+VC8ZjYv1QRjsIFm7Cyd2WJvt69bAdo8CgctZ64AOTgZs5DoFyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249031; c=relaxed/simple;
	bh=pEVhM2KWUpb1U9c5jGVUf/CdbKSoZ0utrnF20+Hvy9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My3A2WnrfmxKf4yhyCqq5qRPox0z+1oFs2JWzDN4XtmnZyd5kkOkJC4jXkHc2bANtwVH2rHDePKqRvY3GlJ9t6mPtk+kMCCFlI05agNckKYJywnpIAchUZSR5/1/6IabJqTGmQ8MhJZrWDoL8uuA7mLhi2BtlL0YITpBCNKEo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIpBZ1Xg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIpBZ1Xg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788249029; x=1819785029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pEVhM2KWUpb1U9c5jGVUf/CdbKSoZ0utrnF20+Hvy9o=;
  b=HIpBZ1XgY34wlIaSzqptwh3s4zuj3ScnPZ5fOtpqohdxxqxDjU+V6b9S
   Jw/VKPUbjo+GWQj/DR+h60llmbrGdypUpeZ3v2qSG9ePGugubMUFb5Dgi
   ADWnw/Oc5LxXqNj7H8w83SlWUClhnZf7ARc5PyydxRB5tf+ZUW9WacBCK
   Z+hY0iCgeCkZRsw08hECpEoYShe99CcWwseNd8j/y99Q0/RpWRxQoJNHt
   gYenacNqQWAxkn63Wx1JJ96foYAIhdrVScEOpLIH8CpNiSpv/4Gz0pDVg
   Smz4kiYgEsizCC/ocFzhFS7cxTsMhuhTnjeBRHomFpivMXZcw0bnOh5OL
   g==;
X-CSE-ConnectionGUID: 5srYy8sHQ2qMqt69Xw682g==
X-CSE-MsgGUID: 65RB3skWS3u77vfQ5keAvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="91182063"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="91182063"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:50:28 -0700
X-CSE-ConnectionGUID: rPh+sygKQ1qN8DjGhsCQpg==
X-CSE-MsgGUID: vwWWZvFwSQeLeYWB53Oolw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="269073212"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:50:24 -0700
Date: Tue, 1 Sep 2026 10:50:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, gregkh@linuxfoundation.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org, marcelo.schmitt1@gmail.com,
	danascape@gmail.com
Subject: Re: [PATCH 0/3] iio: accel: merge adis16203 into mainline adis16201
 and remove from staging
Message-ID: <apaDvbBECui7zNsm@ashevche-desk.local>
References: <20260831184201.34416-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831184201.34416-1-shehryar.amd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 11:41:58PM +0500, Shehryar Ahmad wrote:
> This series merges the adis16203 staging driver into the mainline
> adis16201 driver and removes staging copy. Following discussion at [1].
> 
> Register addresses are identical between both parts (SUPPLY_OUT,
> AUX_ADC, TEMP_OUT, inclination regs all match). Pin config is identical
> too, all 16 pins, same names/types (Table 5, both datasheets). SPI
> protocol is identical as well (Figure 3, both datasheets, Phase = 1,
> Polarity = 1). adis16203's second (180-degree) inclination channel is
> dropped, since userspace can trivially compute it from the first channel
> anyway.[2]
> 
> Differences between chips selected per-device via a new struct
> differ_info, picked in probe() off of_device_id match, same pattern as
> adis16475.c, similar thing in adis16480 but different mechanism.
> 
> Don't have hardware for either part, only tested locally with KUnit that
> the sign_extend32 and SCALE/OFFSET paths of real read_raw behave
> correctly for both chips. Register read/write and probe aren't tested.
> 
> Patch 3's binding content is unchanged from [3].
> 
> If this isn't the right direction, guidance would be appreciated.
> 
> Link: https://lore.kernel.org/all/20250308144239.0442f1a7@jic23-huawei/
> Link: https://lore.kernel.org/linux-iio/20180204163124.67234ae5@archlinux/
> Link: https://lore.kernel.org/all/20260812043506.456ced6d@jic23-huawei/

Yeah, in the cover letter it's better to avoid Link tags unless you want
them to be present in the each of the patches (here I believe it's not
the case). Also you forgot the reference numbers. I assume you wanted
this:

 [1] https://lore.kernel.org/all/20250308144239.0442f1a7@jic23-huawei/
 [2] https://lore.kernel.org/linux-iio/20180204163124.67234ae5@archlinux/
 [3] https://lore.kernel.org/all/20260812043506.456ced6d@jic23-huawei/

-- 
With Best Regards,
Andy Shevchenko


