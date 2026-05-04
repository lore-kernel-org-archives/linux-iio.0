Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BEF2773DA;
	Mon,  4 May 2026 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885395; cv=none; b=qM97SyNQXrRKFtym9z4m1Vyd+CK/KlwHZRr5NWi8NU0MFRaV9r0N2gaVhpBIuRHWwdkETfk7tSq44P5qjW9ZARVmGHYXDYKSyGsOzKvOOCDV4XDsMW3QhbYDrN6my1Lwm5dhpSW/sK/+EHCeelsKBFaND52fK/z6fweuCfT11pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885395; c=relaxed/simple;
	bh=irh0g1P7JpSUHWQTCo0ly7A4ZjZJ1MDet8QA7O0rCP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJrWlw3/33u2ENwBybLhxEc6SqwHjNrBEplM9kaT6+FjTOSIcXBP9v4iGbcgFjLfbOsZp1+WVg3iJt5kW/aXu33Ue/qURS6693ec17aHCqmn16SIjj/3QwfgDuT24pZ4H0G4aX5ETtkm8z3aJ6OJylFbPhBKEm/lbQ9Y1rwvYpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YopujN+V; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YopujN+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777885394; x=1809421394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=irh0g1P7JpSUHWQTCo0ly7A4ZjZJ1MDet8QA7O0rCP4=;
  b=YopujN+VyPo72iGFSUHAgXQQJbR5saTpQ2cvaZMCkTfe+q3ezWMvF59k
   W5vSKoyQ3Urntc6OGh1MZ15GR8jmbsEzrknJ0IX7AUCZzJTMxzWiAKej1
   7ubhZjYZVV53MzE8YfqEpapUVFzJfYBjN33/4OTk1j7bxyRin4A3k/ydD
   KT5TkRyPefn3jZU1mq2f+v/Z5srqisdnzs0kllBx0i5oR1eiiKBtws2KU
   OC1cBU703JPGXd+KyTH3OjUQT1inROf9uOfmaOrpIvAfiCKnorG9+FUYo
   rpR/Sw6VOpsy/merVj8Iiwz0I7Pv6/JheyntP4PNrzC9BmlNiZ5VVxvWf
   w==;
X-CSE-ConnectionGUID: Eq7LIO9PT1eHxm0HbEldkw==
X-CSE-MsgGUID: ekM3LgYvRKW6h6i2qRdLPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="89325222"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89325222"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:03:12 -0700
X-CSE-ConnectionGUID: lQFMajK0RJqShvCzUtsrbQ==
X-CSE-MsgGUID: qi7Bqj3wSsCOfYgFLMroLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="265812261"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:03:11 -0700
Date: Mon, 4 May 2026 12:03:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] iio: light: si1133: add local variable for timeout
Message-ID: <afhgzKmlXsVnrP8E@ashevche-desk.local>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
 <20260430-si1133-checkup-v4-7-fb3e9dce41bf@gmail.com>
 <afhedNn1hSAXyqK9@ashevche-desk.local>
 <CALoEA-yhUAMg8d5hbYVQ1pAdY1TXL3Fwy_h8O8mbiBaAu_dKsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-yhUAMg8d5hbYVQ1pAdY1TXL3Fwy_h8O8mbiBaAu_dKsA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 10:59:21AM +0200, Joshua Crofts wrote:
> On Mon, 4 May 2026 at 10:53, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Apr 30, 2026 at 05:04:27PM +0200, Joshua Crofts via B4 Relay wrote:
> >
> > > Add local variable for timeout to improve readability.
> > >
> > > No functional change.
> >
> > Hmm... I am not sure about this as previously it was one jump and now two jumps
> > over the code to get the actual value of the timeout. OTOH, I don't care much
> > in this case.
> 
> This was actually a suggestion by Jonathan, as the original indentation
> of the function parameters was horrible, so it was better to just add it as
> a variable to improve readability. Perhaps I should've added a suggested-by tag.

You added it, and I have seen that. Still my opinion stays. Of course, it's up to
Jonathan to make the final decision.

-- 
With Best Regards,
Andy Shevchenko


