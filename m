Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5363A4F2A;
	Mon,  9 Mar 2026 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056653; cv=none; b=eN/z6yj05LZtIAyaviuNH52h03G1CsHRnZMKPeoY+Zef0+NLjTBtljEVdszDIqZ+auDwL/a6by1NYzpFTDVUzT6UZnHvEO864ICel+3CbUfSHmXEjDIXAMp3lgkVPEPAimQOfgsyxspclJqoi09xAUCwwMRbqJhuX+KktwolWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056653; c=relaxed/simple;
	bh=YB/UhpsvbD1+dp+X2WXcBeqs7/L4nUTDMuNAX1Cchs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbV+uaDsZt21tD2bnzLKZ0r2WKSecVPOT3IVHPQHcTmmLDwdKLlozrxhSAEdhJGJHvCJrmV52jkEfmZLeEptvlaoERL5kwa/5jzv+MzpqwREulpvmJbkZgO84VYVIJFtbmpmRpmO4epW59VniYoJSO56ShiRuvoeDLt4ybkHgmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbLraqlD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbLraqlD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773056652; x=1804592652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YB/UhpsvbD1+dp+X2WXcBeqs7/L4nUTDMuNAX1Cchs4=;
  b=UbLraqlDrwACbqNuRdtdqzFO/kJUgrrSlVc3c/b7WnGSoqQBbBnLoDja
   BUu7L+EOiXc0iFb4xhwx9sYqt3+gUnGr6FRH6QL4HBOJTSjla5yVOimzp
   8WIr85Cjxn2Dof2smb7YcvtCDndFhT1wEDMgYqGGB7AwOwObmBhe0XCiA
   Y+7vxG5Fr62KqfWKlcPt0Nkt6LdxkosJ6steypY463KGJwTxBI9kfB4Dr
   YeHYlW3B2y1qXjvO6rY9XFYPe+T9nSuba+Sy2JYr4oI/US+/iv2NdepOU
   Ip0A9IQ2q1Ya4Y3K00zybpRHBTHBw40xZ8rxIGFF7Dk1/3FSkhLUdZD9k
   Q==;
X-CSE-ConnectionGUID: ootlbtXQRaKNVigUrZzHsQ==
X-CSE-MsgGUID: bmTX7LtnSmS2H9fqwl+pQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="77955435"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="77955435"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:44:12 -0700
X-CSE-ConnectionGUID: wM8RqKptTPG9oBB8I1hEFA==
X-CSE-MsgGUID: bO9ewBPzQJOlKqSYizqaxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="218870731"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:44:09 -0700
Date: Mon, 9 Mar 2026 13:44:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 3/6] iio: amplifiers: fix typo Curren to Current
Message-ID: <aa6yhtxkdMJ9mlhO@ashevche-desk.local>
References: <20260309104513.40359-1-i.shihao.999@gmail.com>
 <20260309104513.40359-4-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309104513.40359-4-i.shihao.999@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 04:15:10PM +0530, Shi Hao wrote:
> fix incorrect spelling in comment
> 
> - Curren -> Current

Same comment as per patch 6.

-- 
With Best Regards,
Andy Shevchenko


