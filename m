Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D030BB8A;
	Wed, 14 Oct 2026 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975300; cv=none; b=Dc676oFVU18T56HQJmbu8chz9EbDl13Y7G08a1QuWfpNkKWcw8QcvZms+jEh6o32pCIapRVA4BNdLRlq0VR0KHle5Js3qAC8c7/zdHTEvhtDhw2LkZtAiSUP8xj5dKU8qYFHd1LVeRU68UmZLIqyAZOBIFMASwWaFtE7YTtd8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975300; c=relaxed/simple;
	bh=FoIjLTf6iP8mCaZFW3kpxiuQ7q6N0spieMkXEJDD09I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMjJ3V3ICStsyBynU5iNANpbBw2rjeVSUeRTz2B6aFA+fBcjq69xymIbx6DmfnjXrKNdW120PzuinIo9l8nQGJMijHIBYUBohJ9/EbldiSwP420UFk28lOcXRcn60fKYk6BQYaLIJW9HvkbXZ+BcrijnV2A9/DftgTXBr8rKkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4C1x370; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4C1x370"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791975299; x=1823511299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FoIjLTf6iP8mCaZFW3kpxiuQ7q6N0spieMkXEJDD09I=;
  b=J4C1x370d5ogFr3MGF3BDN/w5+Wavza7UC2ThLY5FjUs/5Pcms4yUCCs
   6D/U1NmTayJ2WzzjTwiMdBG3T6LA8XL5xECuopbhNMPwdcyjL2DF/9AfF
   DYM6ifkyHJAGksYrdyFCY9BfuxZdrE6bXkV4nDM5ODRLTGF5acIRhD2kW
   Ie8jpljOWVblpU3ou1lBV3r0H8PwBqW4wvIKLAjLXLHODfR6xYl3xf2jp
   APWie0nA/onb3PsiSN5tPw0Sb5jS1zcH+ZT+kAWPsDMs8PSWGrKsjbi5n
   Zuyf0AtuFB13RuXVqJImdWAhI1PMGa3WFQPHK8CBrh1ekI49aJlQxEHnD
   A==;
X-CSE-ConnectionGUID: UGV2RLQiRJuHXe7MxkCVzg==
X-CSE-MsgGUID: iaDon5lxSbSQ9LI7+se9IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="597013"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="597013"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:54:59 -0700
X-CSE-ConnectionGUID: e5LVkfHGS6Kjk+AEkjuc/A==
X-CSE-MsgGUID: ho1tCA3ESJ2x+WHVK8lMnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1767613"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.236])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:54:55 -0700
Date: Wed, 14 Oct 2026 13:54:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: pressure: dps310: add Zilltek ZTS8032 support
Message-ID: <as9ffTy6UMqW3PNA@ashevche-desk.local>
References: <20261013112124.1878296-1-paulius.zaleckas@gmail.com>
 <20261013112124.1878296-7-paulius.zaleckas@gmail.com>
 <as5jYcTlEuOzD6go@ashevche-desk.local>
 <CAPiS6wBzomvTOm3axxO7sWCxoJg0ijZOXpj_F+NNT7Woz4Loww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPiS6wBzomvTOm3axxO7sWCxoJg0ijZOXpj_F+NNT7Woz4Loww@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 14, 2026 at 12:56:03PM +0300, Paulius Zaleckas wrote:
> On Tue, Oct 13, 2026 at 7:59 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > >   * https://www.infineon.com/dgdl/?fileId=5546d462576f34750157750826c42242
> > >   *
> > > + * The Zilltek ZTS8032 is register compatible, with two more pressure
> > > + * calibration coefficients (c31, c40) and temperature calibrated against
> > > + * the internal sensor.
> >
> > Any datasheet link?
> 
> Sorry, AFAIK there is no public datasheet.
> If you need, maybe I can make some screenshot of relevant info from it
> just for you.

No, I meant some public or at most 'sign for get' type of the link, if there
are none like this, it's unfortunate.

-- 
With Best Regards,
Andy Shevchenko


