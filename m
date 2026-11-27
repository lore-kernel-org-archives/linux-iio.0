Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778691;
	b=Wo7gmtOrgMBt7Qv9/Xc29V5NTp0tImR4sQrRD/f/vQGvEMcj3AIRZj506/YJpEz6g0CI
	 xhpe1W6FXY3nYtJXbQFe1BwD5EJaAvR0odcvF4Ebxwa4P30b5lpVeRLsJfSY0FLXI33LD
	 ziNS8AN+oPOZt2EaYJUltE5vxmnvn7iHGOFO+Et1WZR9+WWjg288MGYDDY+AsfydGIDE/
	 KFrf5E0P/KPV6pD9bhQdr6vWON2VrUuJmq0PCwmWI/0AnNc5IqxkpSuPybGY1BHRG7cpE
	 gn3lnkfJkbAktkL9QXmetbnpSuSUrfJLqpNd2seIMouFK+cifAekp5Y+r7jIRtzmrDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778691;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=eDqHbHm1XXFGu37niY/Et941Y4XRH5yby1Mq7WJ18BE=;
	b=eRXIItAxpv/IDB967kunwWBs/XJo+M8tsOvZOv7mcrH2GhZcwESJToYSZ5Fu99c/0PaM
	 NsxbzbHM3WkzY3ZdHOYCYaQui5VsqKkzZv59kuYev5aJKhmYDecFUQjN+cvgRCziadL//
	 6Qm/6yKqyiTB8dfvPdhYS7r5wwgpoVvgky1MN4EZgALVuaix4a6UiLte5B/8pcN8VO7xH
	 Siyqbiw7yXRx5Tjw1JaBK6D0E6YmM2Ta2ZR7uTPE7LaRLSVFOCKTzhec2Uk30OjN50j8l
	 +2rCP2MooGt5nWwUp1O9BOwGXXxoF74Aq5xt2vegztMw2j0ejsi42BycM799vOZ14qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PChHtBGw;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B84606A31C;
	Fri, 27 Nov 2026 11:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31B84606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PChHtBGw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795778692; x=1827314692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LhX8MywNexia1GR7rIRBx8izEBjSh/iEG2+h8wG1Et4=;
  b=PChHtBGw0Lp1jJT44gbhyN/mqdxYMoxTOV/yts1jJ9+R+4eIWX15tB4x
   zP+39z4gid8ZpxYew6UgFpjKo430byMbTYnWur2bR9ff4q0P1YfYqJrM0
   xwQGlXovbbqxQ+Dl89g84qI2CsWwz+adD11qFZbcvZ1Nftfoh2rsIufYL
   /uVBZQ7p+avo91mZ1XANPrWI80FPKBEdtUKowxK4tizg7qjojSsvnwU0N
   2Yo9i9Y9fIdE4qhEpRdnUrxGWktj3SwG/Xc8Cb6c/2mLBGHGBYCobEiTu
   9Bkek3PFCRisikUa+s7v1NwDjUSJq/B4dk9yqFSUFmrRa6XpwdwURI3tU
   A==;
X-CSE-ConnectionGUID: 8Njd7FAkTH2vuiQ0EFzjxQ==
X-CSE-MsgGUID: G0Ec8c62Q9WRGduP99cytA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4780077"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4780077"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:24:51 -0800
X-CSE-ConnectionGUID: e4YKRBGtQ2GL61u97+pSqA==
X-CSE-MsgGUID: Y3CsIdapTpC8j7u6QsFh5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12894439"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:24:48 -0800
Date: Fri, 27 Nov 2026 13:24:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ilia Snezhkov <iasnezhkov@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Arnav Kapoor <kapoorarnav43@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: inkern: guard fwnode_xlate with info_exist_lock
Message-ID: <awlofo4jXD6QLJw0@ashevche-desk.local>
References: <20261126060615.63790-1-iasnezhkov@gmail.com>
 <awhBEfD6I5nakCKJ@ashevche-desk.local>
 <179574260890.61388.10862990171445957182@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179574260890.61388.10862990171445957182@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 09:23:28AM +0800, Ilia Snezhkov wrote:
> 
> Sorry for the confusion — I did not ignore your comment; our emails
> crossed in flight. I sent v2 at 06:06 UTC (after Arnav's 04:59 UTC
> review on v1), and your v1 reply arrived later at 09:19 UTC. I should
> have replied on the v1 thread right away to make that clear.

The problem is that you sent the v2 too quick. Always wait at least 24h to let
your code being reviewed around the globe in working hours.

> I will address both of your comments in v3:
> - place `struct iio_dev_opaque *iio_dev_opaque;` in reverse xmas tree
>   order, and
> - move `iio_dev_opaque = to_iio_dev_opaque(indio_dev);` right after
>   `channel->indio_dev = indio_dev;`.

-- 
With Best Regards,
Andy Shevchenko


