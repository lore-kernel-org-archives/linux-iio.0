Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF6366822;
	Wed,  4 Mar 2026 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631777; cv=none; b=A2JmnTo8ts8qcq1buT2HnhCpaW54a106e1q1mScrh8o+GLb6O09fw0tLty1fvyt7kzg3INg84SsIW3XEg9oua8N2j3TSAdaY4+ldpYWlLBNwR66U5Q8eVjaOguC137ioFsZlBICMlaJ9kQfgWsj7ORkH+kR8Se3vRmM7WCxYpGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631777; c=relaxed/simple;
	bh=HOB2UEoFlR8u9uvUNhjMq1FcjZkGGm2fx0h0wi5YpnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JebnkA5bmAbdBLF+DAgrtqXJu5aOxoUxEnpfxUFLYBlBGOPsk2Tev5dzQVDGoJQB3Xxc6N92Nn+XwLMyr/gy1l+e2s/g+1Jj2EBCK6JkGHhciEf3NG1m5Dt+7ksZkYkTcmcvwMiLyS4SY5IsR8ExVENuAt+bE+ng5WFyjDU90KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqMtVuo6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqMtVuo6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772631775; x=1804167775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HOB2UEoFlR8u9uvUNhjMq1FcjZkGGm2fx0h0wi5YpnE=;
  b=MqMtVuo6Js5KGRrAAFzcYhs89avNDd8XchCLuRoj6QpY8G4VGtb9/XVC
   in9iyv3bbjXatOpIImvmN3EnMkwy87R3mJ6HLOJKjSZRSGGu0hh3VhHTM
   aNoB2SlGoM8WyDULnpGsmLjoojrLzVy78bWv5hUC3N+a7yRXga9aIEGze
   UNRlLUzhijeCoYaFfiwSkpc5DyVOCWnXoDcqO2aZMKpMJ1qLplvpaTZT1
   M1RGcGiVfmewrsDoBquOWV5qsu6vXOR6kDFlk3Wt/+f279yH2qgIjoM30
   XJXabS83qZ0LeSIQcpUV17ws+raxeHv3r68TedM21YGUQ15V0OPlPXcFL
   A==;
X-CSE-ConnectionGUID: CHTNsSR/QByk4CSgc6NS2g==
X-CSE-MsgGUID: +y5SqsF1Qfq79/ZKhpbcBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="61264651"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="61264651"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 05:42:54 -0800
X-CSE-ConnectionGUID: gAD26HQBSfi1+DjUso54Kw==
X-CSE-MsgGUID: ++m/DOnzRdKxYWDUJ/OTnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="218295323"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 05:42:52 -0800
Date: Wed, 4 Mar 2026 15:42:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add support for Analog Devices MAX30210
Message-ID: <aag22YoPtk6iRGyn@ashevche-desk.local>
References: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 04, 2026 at 08:25:07PM +0800, John Erasmus Mari Geronimo wrote:
> This series adds support for the Analog Devices MAX30210 I2C
> temperature sensor.
> 
> The device provides a 16-bit temperature output and includes
> features such as a hardware FIFO, programmable sampling rate,
> threshold alarms, and interrupt support. These capabilities map
> naturally to the IIO subsystem, particularly the buffered interface
> and event framework.

Neither cover letter, nor the code patch describes why we need a brand new
driver. The folder has, for example, max30208.c which might be considered
(no, I haven't checked myself).

-- 
With Best Regards,
Andy Shevchenko


