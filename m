Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A2279DC3;
	Mon, 14 Sep 2026 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373196; cv=none; b=E6zsEIuZpYQlZIIqp5IlASnUi2TyCyxYKS3tGsCSbKknEOqqtEbnlJtF7lv4rbXhjSeVpQTXnylMQNUCgFS00HGCkwy+oRG5nIO6SL1w64i0xKyA4yLiDc9dzdeQu3EyjEgBYFueQDFXyltZfohThJVxu7paKvOlQjANqQpHMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373196; c=relaxed/simple;
	bh=X6brkOAP3lrhzjUoaD0QihF8srSFXE/F/lrOZE26crI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyDrEw7YEk7p8C7NKi7mwbrmY9mi4FpLpSiJfVbAMFiqKs/2UMxywLtwAGRmxOWCZhkeqjPiydekJpKytoHcj57yLJLmr7Nue5wLSIt+AJzBChjs6JC2UiDC1L+2WYqjyp3WPVIEZgOf3n7caW0qfRbaDT6YQJ5jMTDiMdFAo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PU/8J64o; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PU/8J64o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789373195; x=1820909195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X6brkOAP3lrhzjUoaD0QihF8srSFXE/F/lrOZE26crI=;
  b=PU/8J64oIgZLVCtnGSGTttEouze92AH5TDAMcj1tji1FQcyPq6czQui2
   WTB6lYjhQx0/NoJ08QpWJ1nG7D/XB3GkS2c6oU//u1jYuFA0lCHm4ZmdT
   kVyZbBSrmz89poimii7tXZoZAl1GpQJGNr72XXXRl07OWjsM/1GUdu/W+
   VcIvqhsKgeuAwKkeq4PNqHocZE9OOjMB7/YKQSQ2JyybpIQZSkP8KwY/Y
   TzuNAokI1x6pKJsNSkyMDhlFEftBwERFVSj1XD9a0KlkkoXKYNENCm/6h
   vXjkGkKUnbNLHuJYZHXo0ul9qJKmUvMgHTsUIk3X1+SqdQM4EOUABXFSU
   Q==;
X-CSE-ConnectionGUID: cfo+Sgq2TU2VqFoL35R8Aw==
X-CSE-MsgGUID: DjtwKCPHSYKTz9GEJJ/YBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="232838"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="232838"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:06:34 -0700
X-CSE-ConnectionGUID: nPzRhKimS7K9nb7ijcLj6w==
X-CSE-MsgGUID: BwSpFtfCQaufbZDXPiEzoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="277837276"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:06:29 -0700
Date: Mon, 14 Sep 2026 11:06:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v4 07/10] iio: buffer-dmaengine: Use dma_slave_caps bus
 width accessors
Message-ID: <aqerA3A1kgOB6fNC@ashevche-desk.local>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-7-72b8fd4cc78e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-dmaengine-support-wider-dma-masks-v4-7-72b8fd4cc78e@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 06:25:42PM +0100, Nuno Sá wrote:
> Query the minimum supported source and destination bus widths through
> the new dma_bus_width_min() helper rather than decoding the raw legacy
> u32 width masks. This keeps the buffer working
> with DMA controllers that advertise bus widths via the new bitmap
> representation.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


