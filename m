Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D832C8B;
	Wed,  6 May 2026 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063914; cv=none; b=U8DEdKmP6Z7aWf7soCttmbszOOCxt8iyuYKOsOCJbDDmpb7MvQEUKopq60rWFLz89Capwoc6xSAaxswvM2xB8pptVUepV7RvsYjp/I88DdOAOQIeoM9kfjkTw8ahEjiZLJGI8YQxvU+jPHq0aSlyX/3StGufUqoi0PpwtDQ4B4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063914; c=relaxed/simple;
	bh=igIwV2dVnu+X55ejgFog7eyZWnA4bL0jR44jtn7rhto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK0kKw5epYVqo/hb4yadzsTP9RnZmk9Ut6BaiiqfbsBuY/wjHuKNMUlW3hDI1gamkILVhh412jOGnrHCn2KHfxQwAwpgnXUurl14gU9HFclYeWHPlkDrjAj3Z6YKw3kJi2sZQs8V0U7Jes99EfRhQf16n2/j6kSL6bdX4QugWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8+LsPsF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8+LsPsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778063913; x=1809599913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=igIwV2dVnu+X55ejgFog7eyZWnA4bL0jR44jtn7rhto=;
  b=J8+LsPsFmTtHgW/6f9LcOxpUtwHtLiAMdUFW0m6PpVyt+QVexreWSsG/
   VGhFEfqO5+bEpKH2bSVZX8nDKA+paEbtX2cL/lNR/TBbYebcrdAp+iSQl
   ltpAfG/ZDULxuCGr50YMKAZxGJeHZdXVDLKWda537G1mzPQX2rkizOUer
   9HDsdh+1yO/FKJdaWZSBkIEY5OX82h6yJ/FjCudQplJluLoCa29rboFS3
   PDHt7fEIm5yzR1ov1PLLwnXHF871bKZd74wk4aXhN3T6+7ifhROuF6mSa
   vTEY04RZsZET5J5J58cBPAZcnDr5rNCp1R0q22I3PH6GqXDqE5i1KotRX
   g==;
X-CSE-ConnectionGUID: Myv+M4QtST6yaWQFckA4xg==
X-CSE-MsgGUID: H532O0lcQZ2SICRHPHs6sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89576005"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="89576005"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 03:38:28 -0700
X-CSE-ConnectionGUID: HdUmj9rHSk6JiE0/hzXmjA==
X-CSE-MsgGUID: 93+hOq8PS3WFhKlvrujMXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="235269936"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 03:38:26 -0700
Date: Wed, 6 May 2026 13:38:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: humidity: ens210: Fix missing I2C functionality
 checks
Message-ID: <afsaHx9y-KqMCJob@ashevche-desk.local>
References: <20260506095835.10112-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506095835.10112-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 10:58:35AM +0100, Salah Triki wrote:
> The ENS210 driver uses SMBus transactions (such as byte, word, and block
> data reads/writes) during the probe and measurement phases. However, the
> initial functionality check only validated a subset of these capabilities,
> which could lead to loading failures on adapters requiring SMBus
> emulation or native-only controllers.
> 
> To ensure compatibility across a wide range of I2C adapters, modify the
> functionality check to verify if the adapter supports the required native
> operations or, failing that, supports the SMBus emulation layer.

As Joshua said, next time respect the rules, id est no new version for at
least 24h+ period of time. Give others chance to review.

This one, although, is small,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


