Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03EB3DE43C
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904231; cv=none; b=UtNxfnuXQv5U1VX+Z4rMBgOZTMgWXWpA4ssK2BBbxkVRqbduCIaVd01sCa7CUvrJ2WRFlwuNX4weiJ7uiFVYeFwbtoUQLrYgwUawaSbo5FcU2+Kbyz++0wKynmkLO211y1qacQgu+KZoiVXT3qv0HHpGRqpwCARM7e6i5vt1Dvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904231; c=relaxed/simple;
	bh=z6octxHAnpU4wGmxIuRI9b0QVaoC6z+GOcmt+dg8nH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEUvaSImgXjxE87rLvL6YxEC68J46PCaRZl7KBLHVWViWgB77C9GPHstZ8mI2l3x9EPNtiSgSUnz7AddAUpaChlSOLvxAJICbPR5v5G0nMQSHWpoMBVWtgBcZZ9K++RCtc3y5A+FLont0e+YNSv5ZHMbj9Zt4MjLuFdw1vPm/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGfmI4aq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGfmI4aq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777904230; x=1809440230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=z6octxHAnpU4wGmxIuRI9b0QVaoC6z+GOcmt+dg8nH0=;
  b=mGfmI4aqe8dTL/2pn6/vtcFy1vAtv6aZVbTwnpgZMyvH2g3vJ7JSvtEr
   HAunS90R4eqQRzpu7Moiq5hMOTXsKAzQy0ERhHwmI0bA5zMmUhiUGe65C
   BFlUPf/0p2QtWxhuE8xc2b2f+rwBpc4CmV3HJ49yBeFO0kgNFUXYraMpH
   zCl7IypmZ4dckWqNHZZ0FXUYhBINd3X7BLYly7+Dc5jIu3r1K7Ae1W2BX
   VpebCFXIX+ABSUWmv9kJsfe73eCMYaJ/e0/atBmYwen5GovlMsWd68S5Z
   dnfwPVoPMVzyhdDs6CEEIm8RJwgBeCuSUpyChWz2jiRjz0cr9aVP4SVuH
   w==;
X-CSE-ConnectionGUID: UgOPcnt1TUKrC4GWBE2sgw==
X-CSE-MsgGUID: ZPGzV/RwR3Cc4ofDBEuNvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="90219284"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="90219284"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:17:09 -0700
X-CSE-ConnectionGUID: B7MtwtfaS3aVtLvlfa85Yg==
X-CSE-MsgGUID: 8eGfsJyDSsywcO3a0EMmpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="232378512"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:17:06 -0700
Date: Mon, 4 May 2026 17:17:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: =?iso-8859-1?Q?Jo=E3o?= Fernandes <joaovictor.fernandes@usp.br>,
	jean-baptiste.maneyrol@tdk.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	gcotavio@usp.br, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: refactor accel/gyro
 configuration paths
Message-ID: <afiqYP8PrVpGs0Bq@ashevche-desk.local>
References: <20260503031703.33330-1-joaovictor.fernandes@usp.br>
 <CALoEA-x7kEXYNzGWJ-6dxJzBoShnx+26Y-VhDP4wFz99VsxiWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALoEA-x7kEXYNzGWJ-6dxJzBoShnx+26Y-VhDP4wFz99VsxiWQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 03, 2026 at 11:13:39AM +0200, Joshua Crofts wrote:
> On Sun, 3 May 2026 at 05:17, João Fernandes <joaovictor.fernandes@usp.br> wrote:
> >
> > Refactor accel and gyro configuration paths to remove duplicated
> > logic and improve code structure.
> > Introduce a generic helper, inv_icm42600_set_sensor_conf(), to handle
> > common register programming and state updates.
> >
> > Keep sensor-specific handling in inv_icm42600_set_accel_conf() and
> > inv_icm42600_set_gyro_conf() wrappers. Also extract configuration
> > sanitization into a dedicated helper inv_icm42600_sanitize_conf()
> > to further reduce repetition.
> 
> This should be (at least) a four-part patch series, please don't send multiple
> logical changes as one patch. Patches should be atomic and only deal with
> one change/fix. Try to introduce preparatory patches when sending, it speeds
> up the reviewing process.

Can you be more specific? It will help the author to split it correctly in less
amount of attempts.

-- 
With Best Regards,
Andy Shevchenko


