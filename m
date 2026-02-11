Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3721CC43;
	Wed, 11 Feb 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817064; cv=none; b=BG6/DdZcVTTM6exd9AnlYpf6Bc1xgNVKvm4ICY9Ck43FAYjm172v6jpPQMYl8DCf3gTCRAq/LeQmxWyv+fegSkhqAJ1BT0mHVBlAjv0SWRaHOzUWjfZLoeHMtF6nSPRYyNqIGm9i7x8lPdNAX6DaXObNSvjQ9Dxz0yt1x/cPIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817064; c=relaxed/simple;
	bh=ZMp+wqiX7KaYCFGawBcaQ9vuznlji2FeoAA27Loft40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IArRH5pt0rM5bBfejPaq9qW4q1CmZVMPIDwQtAO0k/nuSJzeEykKHir6Ky+ujxMfceZSutpS2jzxXV71dsPKWU18H69WIoNIry2WPISBRVFiNOL85DIzR4fHFf8+PTRWznnrOFvO7rV8x4UJYMct3p3L0KkE3qRYxOOvkTtiBcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asLP+P2T; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asLP+P2T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770817063; x=1802353063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZMp+wqiX7KaYCFGawBcaQ9vuznlji2FeoAA27Loft40=;
  b=asLP+P2T03Lfl8D6pfs5+y9n3p7998LKLtiaAHt8xYx0imOzOytruHos
   o9p0Xoh0qcE8Sj+ObMyaM1wJhU2GHivp/cKmYFkC9lkQEk1tL4Zrn2Qgq
   AksFipTU93V9QIfzxIn/nUK+UUP5f0EoPzY+PtA7khTDHYJlsZMHEkEEI
   2h7gJ99iN9lM14D+fth5/4PnDWtjuXKpiQeoF6Q+O4TGrtx9fjNTAkxSq
   JjBgayXeDOGK775yroN1wRX6fGRGLKOuUCDuq3dGHhKqfJ6UDoBGYcUF8
   SDRJRlJUv5RjBYHAf5lz5EphNShDYpblRcDx4YGb6w+HfwHx/i8WBYmmK
   Q==;
X-CSE-ConnectionGUID: hzlwUPpQRCaCZNG5T291Ww==
X-CSE-MsgGUID: PxIjoxy4S1igMAbgnYn8Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71678824"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71678824"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 05:37:43 -0800
X-CSE-ConnectionGUID: g3+MpPZcTJmmXJfnM13kjg==
X-CSE-MsgGUID: iA/pJCTATJ6nUuElIDw8CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216406913"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 05:37:39 -0800
Date: Wed, 11 Feb 2026 15:37:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
Message-ID: <aYyGIPNeHWpluaoF@smile.fi.intel.com>
References: <20260210-cm36686-v1-0-aef68dd46ad4@gmail.com>
 <20260210-cm36686-v1-1-aef68dd46ad4@gmail.com>
 <20260211-sceptical-frog-of-revolution-fc3cf4@quoll>
 <b95d7a49-6191-4d85-b725-4a941505b40d@gmail.com>
 <6f97c68d-0236-4d04-8199-768ecee7c4dd@kernel.org>
 <242d5502-bf58-4e25-8258-8a6c75ff3623@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <242d5502-bf58-4e25-8258-8a6c75ff3623@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 11, 2026 at 03:32:41PM +0200, Erikas Bitovtas wrote:

> >>> Please implement previous feedback.
> >>
> >> Since I am making changes to the existing driver instead of creating a new one,
> >> I introduced a new patch series. As I mentioned in the cover letter, cm36686 is
> >> fully compatible with vcnl4040, so instead of creating a new binding, I create a
> >> fallback compatible for the device. I probably should have named this patch
> >> series something else.
> > 
> > That's fine, but that's v3 of previous patches. Your work was to add
> > CM36686 support. How you do it, evolves, but patchset/work is one
> > continuous work. When you rework approach next time, you also start from
> > v1? And then you go back to previous solution of new driver it will jump
> > from v1 to v3?
> > 
> 
> There has been a misunderstanding. I assumed that since I will no longer
> be developing that driver, this warrants a new patch series. I apologize
> for this.
> Here is the changelog since v2:
> - Remove the previous unnecessary proposed driver and bindings.
> - Add a fallback compatible for cm36686 of vcnl4040.
> - Add a new compatible for cm36672p.
> - Add channel info for cm36672p.
> - Remove redundant information in the dt-bindings commit message.
> Here is the link to v2:
> https://lore.kernel.org/linux-iio/20260209182432.00006c3c@huawei.com/
> 
> I have received some feedback regarding the changes I made to the
> existing vcnl4000 driver. Shall I submit the implementation of it as a
> v3 to that series of patches?

I guess v4 would be better as this is assumed misversioned v3, if I got
the situation correctly.

-- 
With Best Regards,
Andy Shevchenko


