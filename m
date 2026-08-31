Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F3443E074;
	Mon, 31 Aug 2026 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184695; cv=none; b=NR9aNvum30leXxg7RYXFT67bcXmxhH8xYioyipoqQ3HnrdjyAfQsKv7fQ+JzhPn9F5kn57pQpXi2E4nxkKYOe6OodFrikHz3UTNybRXAj1yrlckcGPAAGvU5I+jy4hauYKC/c1Hdgyf/N4S+o7Jb/yfmaaTgD+LXyyBgWuq14iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184695; c=relaxed/simple;
	bh=/xq5y3D3zScSYdwTGOv/6wbbvRmgFHlHSRLlGoe3mM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqTInwVe5n/ZCfBb/HtEOrcZ7O/d/VQ2PUdkNEsn440HzoMlhhXGJm4+QFQMpEXugFE7iCxQSe8IleBwygyDlNnTMOrzjCcjRp2CAocg7kG+CqAXr9Qqy9MkKmTZIShTfusFInS8YLlIsV/jkZza63TPRaJzuhN3wC6fZPwwYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DV6arQWl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DV6arQWl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788184694; x=1819720694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/xq5y3D3zScSYdwTGOv/6wbbvRmgFHlHSRLlGoe3mM4=;
  b=DV6arQWlqZ4JOvKzyLwNrfpnYQdqOEjr58wG+AgvoF9duDcMm1X9GHJ5
   wNGkEjdMHQsNJzbrcu6+f3rTtTP4BPiLQg9eDeur3nd4jZhjFAGBeCdNM
   AbqfAh3FbFrS/BC6/yyl9GO+bTZxfGLwnGOvx13Sl6q2ulexV5g5p/VRI
   pAsrYlthrro1+YQz1y6fg2t+tk/s+Op3rm/L7SJ8t0tqokY72xPwtVh+d
   wgNWxDWXPAsy1VRkkq4tXMqqr+ZCA0/KMAfQW632X8eLzvgT466ofNkDl
   6nmZxOukgPBNhyuSrEMZJ/f0V4u/1CDyRzG0YsBiWP2fUJ00e8IQVkqDr
   w==;
X-CSE-ConnectionGUID: IaENJv+6RlOLxb1hN+WmMQ==
X-CSE-MsgGUID: luC7nMeVTvqlb2h4Gr7Iew==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="111364820"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="111364820"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:58:14 -0700
X-CSE-ConnectionGUID: Jxn7oUcvQxqVLxgSL1bmZg==
X-CSE-MsgGUID: 3SgPFJ8uRlabLuZxGqicoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="269394103"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:58:09 -0700
Date: Mon, 31 Aug 2026 16:58:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	Christoph Muellner <christoph.muellner@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v7 6/8] iio: accel: mma8452: Reuse existing dev pointer
 in mma8452_probe()
Message-ID: <apWIb0GlExfcOMit@ashevche-desk.local>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
 <20260831-mma8452-open-drain-v7-6-22946812c928@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-mma8452-open-drain-v7-6-22946812c928@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 02:17:09PM +0200, Esben Haabendal wrote:
> In commit 32a5c04d4575 ("iio: accel: mma8452: Use dev_err_probe()") the
> struct device * pointer was assigned to local variable dev, so we can just
> as well reuse that throughout the function for sligthly more readable code.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


