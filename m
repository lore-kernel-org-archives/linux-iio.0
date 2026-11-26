Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700692;
	b=NkSNAEMhYKkPdtX8LvwjR6EIx/MOfEx0HN+9bXo7MPKGdpR7xUa3es+ee+AG7by/GywE
	 BtEXjXGF/Hwmdy9GhiVRgw0xRTB4/JD2+EjylFTrYto2SKvl3pwR+A2VW9F9ou0SZxh2D
	 6yET6BAw4db8qOajEtGZ8acczMm0ysID4pjscHW9SV3IGfP2jYbEmv91b3/ysAAvc/qWT
	 R0295rFkBfk/YwFu5fBqOk490h0htPjP4/mHoXBgKdIw7Bl0TdyIih+xs9znKYO5FfY/4
	 vg8s2R/V6Rz9Sk77BqReBKxZTihU0CuKBgOZcOd7UwKreqfHWs/pksWqbbU0ny6/MZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700692;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=zsdeU1woEAurLbv4f8vZ+O7rgkp8s0fpAgca0DZu0bM=;
	b=UujqqrwlHiOqLFd0sjVOjNH++HRPJQ6HHLrevIBju+1nk2Y09Ge16NpInLg1v7MGJouD
	 QY9Rw34m4+gHBrCfuNZRASKTVNk9LFgBofjQ/PH7N0OrxYwUmtEXH5YcF0CG0OkODbp3f
	 N/Qts8ing1WtomYafnUqpcYRUzdVuMfM+svt0zQgLAie+K9/OX1PIgPLf+Z5R3KvXH/J+
	 LFGs9sIBxIOmLoPbYNIrwjrUYQSygsmfoDS4bxvWCrO1cG8LGVynS+a61WuG40n1jjVsc
	 8kCnQ3zeCVzL1Y+8P1fXh8MkidQlJeCVHrHDXm2v6kzpkqB+W42TSGu6kP1PuCAnohA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PvVma3um;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C0606A31C;
	Thu, 26 Nov 2026 13:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B5C0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PvVma3um
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795700692; x=1827236692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ewcpAdz7oFHAuhJBq5APrK8dd0s9bR8SVRAGqLz6tSg=;
  b=PvVma3um7u+rsLupzMxQ/XBYEwKaDoZI+hSTtS88mDvcRwp+J8eG+aCF
   DgRFFmD8XA3/Z2NjJYKET94JxoXqg0ncnzU4ZTgrEWUSSnAcsg5XSvJRH
   UeeeS1itkXT7s70B1tq8aQg/LwVhWDCYSvwmObuEl1zzUvWJkcTs9kIyh
   lJG234BZ/nMFvf32igaIdeTV4xbBV5pjOCJCgCrz4qqN7fawqy7nL+PkT
   e88pngRvg33dWdE5KdBtUfduHqMDGD44xVjIR8iISGPTxx7vFUFcRJnBA
   +o32qXialJk7804hs96fBxyP67HWBKUBadUE9V9LvfIIEl4WVKETUEL1l
   A==;
X-CSE-ConnectionGUID: lts3lhaYTdOn3m08xStn/w==
X-CSE-MsgGUID: /xtOXoEDQ3SSUXDJLhDkpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4520447"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4520447"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 05:44:51 -0800
X-CSE-ConnectionGUID: UXvRrCBoQOuOU1luNBv8WA==
X-CSE-MsgGUID: YrniBSHbSdubjCX/FwHV/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="13944399"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 05:44:49 -0800
Date: Thu, 26 Nov 2026 15:44:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] iio: pressure: dps310: sort register field
 defines high to low
Message-ID: <awg3zmX7vElVtDEU@ashevche-desk.local>
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
 <20261126121331.10438-2-zoone.rupert@gmail.com>
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
In-Reply-To: <20261126121331.10438-2-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 02:13:24PM +0200, Rupesh Majhi wrote:
> Some field defines run from the high bit down, others from the low bit
> up. Sort them all high to low, as the datasheet lists them.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


