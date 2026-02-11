Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA21552FD;
	Wed, 11 Feb 2026 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799736; cv=none; b=VMO/AMP++GrKJhPZfRsubPiP9RE3mha40dglnITOjocy5HeLrc51iq5K0ymwtj7KB5CMiqgRWNizhcW6URaImMh5n2rRp7ZKstakf8TN4enuJE1p2TRJiZuPndxWXFJrsAFultiN9SFxXGpLMe6ocdx9I4pasP1iFumLSoSqqvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799736; c=relaxed/simple;
	bh=vH73S2mZVxYRDwONAkD4L9/Fth8FZungtnhhJhGox/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/njd//9DAGscZOGIY1+S5hRmf/CfC2R/346QmRSCkdWDBjejexM64Cg4cLnMe1sa7GoMN1lmQZsTcZtgKf7i/jL8Ar4Y7tdWRUm6ey/E8oj74QvVxhGldrqS54Q0lsmBh4sIUuXE/gqTUB+ACubnG3sWb5d+VQuCNinYAjenOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZ6IkelB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZ6IkelB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770799736; x=1802335736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vH73S2mZVxYRDwONAkD4L9/Fth8FZungtnhhJhGox/4=;
  b=jZ6IkelByt6VFk7ausYSr47d/5fRjtIDZ6T4WufIU+ebViSPnMRQJYwT
   kgWqL2DbFHMATVynkG8EFAl/jCPmq9mqRAktWAWWcbH3e/sCzU81pq7vl
   VSexBJPX06Dl9yDrjA/kN/k4DIBriJKhUmIHoEsBXrI8rimELiXgfB2Qj
   2KJXCSmZnlvUOQdO6VGrHLAQ0fb6H8RHG1gPKlMPiBYY1EIeuCarBUap9
   Bi3y+7f6wP6a0eg6Afyo2g/i2mhQ5xyr/zPvzWizKhGQn+AwnXqETzNok
   dsub+AsVZmYVwymLA48jxMpdwittP6nd+8ZU/q7qNZKSKMlEd0rLiW/JV
   g==;
X-CSE-ConnectionGUID: cfa8z+uiQEK4HXLqZkK7SA==
X-CSE-MsgGUID: oVlXNkACTJ655qv4tLe7og==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72015427"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="72015427"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:48:55 -0800
X-CSE-ConnectionGUID: u3K7aaShTEe2T4SYz1K3EA==
X-CSE-MsgGUID: 0uSRGYLKSYWn5GBqo0+jHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211293034"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:48:54 -0800
Date: Wed, 11 Feb 2026 10:48:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: max5522: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <aYxCcm_qOpueR1l6@smile.fi.intel.com>
References: <20260211081837.8169-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211081837.8169-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 11, 2026 at 10:18:27AM +0200, Antoniu Miclaus wrote:
> Simplify probe by using devm_regulator_get_enable_read_voltage() to
> get, enable and read the regulator voltage in a single call, caching
> the value at probe time.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


