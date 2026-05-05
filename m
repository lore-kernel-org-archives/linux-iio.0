Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3425434EF1C;
	Tue,  5 May 2026 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964026; cv=none; b=mlCsdPY2ua7yxDG8gFfRzbyMVRiApMpTg9ZhnDYF458Tlfeqr6sxAbkoWk2gUjv40LAcFrleVtz91pIQN06vjQ/7we+mZgHNOC1fsJHKXa05uaE7O9Pu1jfNqOXmPULjPwaEuR787+Sh6im3N/C/qEYuMbz8e55Kd54rIAput5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964026; c=relaxed/simple;
	bh=HOYFPzHxAAbUeSZOJd+G/IsNKs/66WOvn6PF7xLsYTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2MJzIvC0z8cKQ39yLQaasZvmo14pAsAJc/qeq/deiMOWaxKzc1DoPYOckohJziExGeJJuVKsSDX/EGCts+WIJSHff0JGi4fcaAtul7VFfY4l2xxnwhy/ra/BFenKJcwmkt6jLh1sGw52g52fGi5A07YG5D6qXhV7uFAE6m9YaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOLlO3A+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOLlO3A+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777964026; x=1809500026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HOYFPzHxAAbUeSZOJd+G/IsNKs/66WOvn6PF7xLsYTg=;
  b=MOLlO3A+KOn8FCSK4iHnYNte5IogWBnzZ8BrqtSBdpJPOFMQIEwVAy/j
   xTEHwNYX/f+ACcf6v4aRidat9Fq00uf+Ak+fLFjV1tSBtBEEp2rzzdiov
   B6LMjiZWvoMRnbYHEaEpAZr/p11WcrVdCE7YRMiiftzNON1RiHlS2HWbR
   DpWhzl78GgXmmZv4NM3Yc66+mUuYj6GNJPEkS+rEVyWy3VWm3O9SEPLm0
   Zvy7nP/7xCqJyrSclVyLKqGyAWr20yo68q0xq/l9FE479cwqqpYnb1aV4
   fP1lnEeIbJtMzHZtu/HqIiVCGTPyZU5tik4+exB1g2mxfrJI0XiPBveAM
   Q==;
X-CSE-ConnectionGUID: g+AvaGPTS4KtAuUfLsRVMw==
X-CSE-MsgGUID: 2cIHfwJjSv6aY6fEnGMKJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89133314"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="89133314"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 23:53:45 -0700
X-CSE-ConnectionGUID: oIWZ8DRtQVmVG3Og36aGMA==
X-CSE-MsgGUID: JeDO1S64RcaQ1CBDwV+D7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="234717287"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 23:53:42 -0700
Date: Tue, 5 May 2026 09:53:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, waqar.hameed@axis.com, dixitparmar19@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH v4 1/3] iio: light: stk3310: Deal with the ps interrupt
 issue in PM
Message-ID: <afmT81DAhJWDHrSu@ashevche-desk.local>
References: <20260504030408.105762-1-limiao870622@163.com>
 <20260504030408.105762-2-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504030408.105762-2-limiao870622@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 11:04:06AM +0800, Miao Li wrote:

> On the Inspur HS326 laptop(which integrated with HiSilicon M900
> processor), if the STK3311-X chip's PS interrupt is configured
> in "Recommended interrupt mode", the interrupt cannot be triggered
> normally after waking from suspend or hibernation.
> 
> In this case, neither disabling and re-enabling the interrupt nor
> resetting the PS threshold register can restore the interrupt to
> normal operation.
> 
> If the interrupt is disabled in suspend() then reset the PS threshold
> register and enable the interrupt in resume(). This resolves the issue.

Like Jonathan said, this should be a fix, otherwise the ordering
of the patches in the series is wrong (and this should be actually
the last one in the series).

-- 
With Best Regards,
Andy Shevchenko


