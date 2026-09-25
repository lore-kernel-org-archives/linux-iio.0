Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE184A9D7A;
	Fri, 25 Sep 2026 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345893; cv=none; b=Owlg7V4ZtS10vPRRKvX7lOcs3FFlcHXixpjNYfa/giDUQFkCFjrqHCRPMzLMz+nas9iXq4xqkDYf8sKbagFz87cJZ9u2ANWSW2JYbvijJFuz94LvX5dsuXml3QbiELAcw+LME60yhC+yeARg884P3SECspqD7JoPl7lgiqHt/bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345893; c=relaxed/simple;
	bh=YVcgNeUH3LKzKmCQjOP9eeXTvqfEk+JM7ZVpXoLM7E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X706dnBPZ23tpvH1/e3pk1j+642O4ARwvO00cMhR+UDvaSAN9MK0tgoeqPJgxy7VAaYXM0SzVJKUJFBe2zwmJ8GqLSCm7i1r03otD+oYWa9jzaTdcEgHKL/LUuFbzAYMb7tMTmitM51fB+YpUVGmx7q4Fi/SSf7rSTBtlubmD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZpBlvv+m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZpBlvv+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790345891; x=1821881891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YVcgNeUH3LKzKmCQjOP9eeXTvqfEk+JM7ZVpXoLM7E4=;
  b=ZpBlvv+msvlzVjTAfry2g7y4h+hvHoSxe7zldjjbE/64nxHW5opGJqYE
   r1TU2JgqxwZ0JHurkkMNX79HD6oIEVlzjOIW8bblRBZKNosMvZrjVO2JI
   OF6o+EtZL4/C7A+i7/dnj1bnKRYEhok1tTRVUO492Vc24yb6yDGaMuhC/
   pkZWbtoZbp0C/RYJmSNYisDhgF0yMiHCbjK8vw6Lj4Pz1idoka85frK5d
   bnxEVDaduCSgWRMSTLIaFo4N+xdNC5ZL1LtayUQ/fZa1jF4Gdkp8ngfZL
   Qnq8bCTU2PH4cRvRNzfGcy7z7TQF5Uply5MwsCuJ+jUOsJoCPG14BI/Me
   g==;
X-CSE-ConnectionGUID: 9Fem7y9/ShGU68kNPONFFw==
X-CSE-MsgGUID: tVp0OThpQkeyi5PHV3Weaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="116660241"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="116660241"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 07:18:10 -0700
X-CSE-ConnectionGUID: VhtLwA5CS0+QypmxbP7ACg==
X-CSE-MsgGUID: 1qW0CHACRp+h+nTxwHeAWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="273440804"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 07:18:08 -0700
Date: Fri, 25 Sep 2026 17:18:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: reject duplicate event disable
Message-ID: <araCndRmAqnX1K9k@ashevche-desk.local>
References: <20260925140956.2254877-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925140956.2254877-1-yaojiale02@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 10:09:54PM +0800, Jiale Yao wrote:
> The IIO core does not filter duplicate writes to the event enable
> attribute.

Can it be done there once for all?

> bmg160_write_event_config() already ignores repeated enable
> requests, but a repeated disable request still calls
> bmg160_set_power_state(data, false), dropping a runtime PM reference
> that was not acquired for this request. This can underflow the runtime
> PM usage count and trigger a "Runtime PM usage count underflow" warning.
> 
> Return early when the requested state already matches ev_enable_state.

-- 
With Best Regards,
Andy Shevchenko


