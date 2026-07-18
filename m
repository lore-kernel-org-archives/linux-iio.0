Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020EE282F21;
	Sat, 18 Jul 2026 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784356508; cv=none; b=nF32hI+458FtaqBv3gAicLS1T/L5LrmvqkLzZXPN2qk/GmQWygd2hkzIirSD/E8COoYDcgxiuAw9cb2IjBLD7g+7HpfEaaa1772YMIyVG7FbygtIECdVha+LUHijjTDXWBW1jcZQHU8H3fRBgdMhPgTLwCb1HitFLO7wtTi6WaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784356508; c=relaxed/simple;
	bh=daw2DcVDiB4BORss8RN/eLi1V85hxjaEuoJfOKq171I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8kVrUcH8F69zB1PwFMDTp2Sbn/WVCULrVYrDu6UNPPrCko/YCJU1FtzwuxBd7tRR4a8ux0SR6QIDoovVPUKvK62y2stuTiosJjEgaPb9gC4+DDWpl0ik9UHmHe1oOhfaLAuXqyp/YCHrhbXwMA0G5618QMPjWBkdTDDYpGXK8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxjPcIul; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxjPcIul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784356507; x=1815892507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=daw2DcVDiB4BORss8RN/eLi1V85hxjaEuoJfOKq171I=;
  b=UxjPcIul7ao3ovpdWh8hLHveIwCvk9uiuGWs85x36lJ28yO56ciB+XOU
   q4d3rgveE20rlsYdahqmHuw6LbLSd9WbJJlodwEQxhW93PE0QmpUqPA3u
   IgGotzjZ9IB5UuBmLLqmcrElnieGCdksv+PXREsHEVKoNMQxUu0aVZeIR
   2h4ndAGUcRRowkOnwgyPw02wXDCZg6LipfuxAp4tU3xvgIcIdseF8GAcy
   N+Chv+hYSu8Dj+VpevwKU5TkQP1Xvw8XZPFYwzdQYeYXyw5dcRyGk427e
   O5SCvU0wg4jxddKvP22kr8nkRp3Lb++3VFo3taRYNQXAlSdqTDZdbABX5
   g==;
X-CSE-ConnectionGUID: anQyKpuUSJyEExrh4o6h8A==
X-CSE-MsgGUID: 4WGMjh0KTw+2N3lkZWWAow==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="88916836"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="88916836"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:35:06 -0700
X-CSE-ConnectionGUID: MHdIbVZrSDKLUXd6L4oApw==
X-CSE-MsgGUID: Ik+5+JlNRLS2nS8RAlbDnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="287031289"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:35:05 -0700
Date: Sat, 18 Jul 2026 09:35:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Pan Chuang <panchuang@vivo.com>, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/13] iio: common: Remove redundant dev_err()
Message-ID: <alselrjckmvvNdk1@ashevche-desk.local>
References: <20260717094408.509583-1-panchuang@vivo.com>
 <20260717094408.509583-5-panchuang@vivo.com>
 <20260718002557.2e530d50@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718002557.2e530d50@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 18, 2026 at 12:26:09AM +0100, Jonathan Cameron wrote:
> On Fri, 17 Jul 2026 17:42:27 +0800
> Pan Chuang <panchuang@vivo.com> wrote:
> 
> Where there is only one driver affected, please name that driver
> in the commit message.  Let's anyone who cares about other drivers
> in that directory know they can ignore it!

Yep. the hint is to use

	git log --oneline --no-merges -- $FILE(S)

to see the practical appearance, id est here (I cut the summaries):

  git log --oneline --no-merges -- drivers/iio/common/st_sensors/st_sensors_trigger.c
  9f92e93e257b iio: common: st_sensors:
  cdd30ebb1b9f module:
  d5ab4e9a10ae iio: common: st:
  f700e55ef6ef iio:
  0805b5121f29 iio:st-sensors:
  d4786e7df03d iio:st-sensors:
  e42696515414 iio: st_sensors:
  82bcb7fb6498 iio: st_sensors:
  9c6cd755b548 iio: st-sensors:

...and so on with the prevailing of "iio: st_sensors:".

-- 
With Best Regards,
Andy Shevchenko


