Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975B3C0A08;
	Thu, 25 Jun 2026 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370571; cv=none; b=YdAltd7ePSEpNVJIhutjgEonPuMgPhE3sZ07uR5CPe0TJXUaoE75wZ7QTpb+fcBQjPAXThGh5ARtawBZ/eK4oNOCPnstrzgmhfPiP+ovIQHpd+3w1/12/gL96NkFKm3fC7BZRmNMj9xCamvjKV9h0QJUy9o2NHHIpuzkvenVDEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370571; c=relaxed/simple;
	bh=8xUuS40YDHoUYjomuC4bDexH74mcxJ55ZSMKrzpF4cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqGFPysljcVj9QXEQDEY8B1au+i+20my/f+33DOGYjwLUkxRobJQvrA+EInLUSOGJ1/GX3BBa7k73lAqIllEuYOXi7ao9KBiSm8S9rbEtMoQQEKt6b+XA1t93vRUazws+rTAjy5LXcge9ld6HHMCg/40CjfVSWJ90sfu+k5EBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chjTlmf3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chjTlmf3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782370570; x=1813906570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8xUuS40YDHoUYjomuC4bDexH74mcxJ55ZSMKrzpF4cs=;
  b=chjTlmf3/PWq0GM94rtz99dl3RUX+waqunoURJdaZl+WQ9tbnOPQnyFY
   mMSOmLU+2iXyzM+OJn+L8yw0YkdEjqEI7y16wJJNeBfo7uVwC9HIx5zdU
   1lzJmmz9lO6pCTuRGD3fCG7x01zWuaOntqyv213dsC0kB2t40mils18xR
   8cq49D+BfFXUAOTyhObmesBfuxJClCpkaHK1XC80W7oKjgmOauKkyW8C8
   PQMetNNT6DFuiBnv8GVVQMCCVHUje+kkulMoRUzDP3BlnBs4G8ZUAl17x
   Oo7oE/JOZYt7PmOrx/2A8hAYE8HTIVCOR5kpVu4ibjMoq+7gie6ZfH/c4
   g==;
X-CSE-ConnectionGUID: ai9sDn83RqqtAg4xXgG7qA==
X-CSE-MsgGUID: 8PFNlHlwRM+3/4sFVDF/Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100693540"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="100693540"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:56:01 -0700
X-CSE-ConnectionGUID: pPRvcTFAShOJWePOWeB7fw==
X-CSE-MsgGUID: 17OFz0CQQY+xZD1Iqatb8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="254225506"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:55:59 -0700
Date: Thu, 25 Jun 2026 09:55:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: imu: inv_icm42600: reorder includes for
 buffer module
Message-ID: <ajzQ_FUr--jTxYWr@ashevche-desk.local>
References: <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-0-5d9a4c662f50@tdk.com>
 <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-1-5d9a4c662f50@tdk.com>
 <ajzPhi3ymeIBYHRr@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajzPhi3ymeIBYHRr@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 09:49:47AM +0300, Andy Shevchenko wrote:
> On Wed, Jun 24, 2026 at 06:21:18PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:
> 
> > Reorder includes following rules and delete unneeded kernel.h.
> 
> Actually it's needed as 'proxy' header. If you want to get rid of it, it should
> be another patch to replace that with the used headers following IWYU
> principle.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Also for the consistency's sake this should be done in all files in that
folder. I see the same issue(s) in the _gyro and _accel and I assume the rest
*.c and *.h also might be updated.

-- 
With Best Regards,
Andy Shevchenko


