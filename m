Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C90229C325;
	Tue, 17 Feb 2026 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316967; cv=none; b=UKxpWh3KV6sP9VHR0VXgfBWO/EOxgrOGNo+HDKwTheF13E/AKGxcuwqxDrYJ0loHOfN7gyBROFSOcY2l0eMd7QMwoJvcyWxPWxikWEv6wv+yJv76z8SbujCy2402eQ513i0eWRJq4smdwCNVPVsEaQmdVTL/j2Cs5cboCZP3Mto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316967; c=relaxed/simple;
	bh=78yiqQD3TsLFYvQIx06un2lkX821g7QwNv6qdcWqBf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlJcUD/C2SS7+Jb04KYBDkjoYawbMdIe1ScqX/et8WNzSFi8mVMEqZ89YiIrwEmB/HKv3tcJ/SK8y8OTyqKjN+xVlkCyYOMjBWldx9kChkDl6hfnBsIubOp+k/sTtwFxkgAsggjNOjjXY6BV4XgPGx7SrnwSS3Dbvv2KzcPdj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0HP/DfR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0HP/DfR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771316966; x=1802852966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=78yiqQD3TsLFYvQIx06un2lkX821g7QwNv6qdcWqBf0=;
  b=d0HP/DfRGf2VUTBTz74bJ0FRfBtq6GDhHbNpOlYYvZvsL0qQugUY41PZ
   hRjcbfQn8tAzjf6bxUqQ2N090V6pq6uTj2zda/fiuNLeP0jZ+FA+DQgBC
   o8QHA+XacnpvYSX+3kCsKoUdwzSQs5cu+tbhP6Z5x3UqG1X+L+qsU/BFV
   otSY1uaN3E+0k3/fqlArFYnbWr+NlLr1TKDNbVE2ky9T2jskqXgW1Y8Z6
   yh88zr+mBtkFQWyidn4omuUdYSLudzrhTjp0GxDH9fXAydB8GiEfHX8pU
   ibvbJsXLXQsTbGPkwgeam4vNBP2k99AyhYYBpyL5hDxSmbbo2e4cbeyag
   A==;
X-CSE-ConnectionGUID: rfd+LAWERCSQ1mmXg2v44Q==
X-CSE-MsgGUID: WAkhZSaKS4iL8DzDX2NHKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74983151"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="74983151"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 00:29:26 -0800
X-CSE-ConnectionGUID: yyEBDAqLTzu8tMgm176fhA==
X-CSE-MsgGUID: WWefMD71Se6KpNeu7qKVYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="212047717"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.124.220.245])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 00:29:23 -0800
Date: Tue, 17 Feb 2026 10:29:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: impedance-analyzer: ad5933: use div64_ul()
 instead of do_div()
Message-ID: <aZQm4QH_svsQuaRp@smile.fi.intel.com>
References: <20260122145633.14938-1-architanant5@gmail.com>
 <aXI-ZV4uAd5GyFLz@smile.fi.intel.com>
 <aXI_HnvDNbX68-lq@smile.fi.intel.com>
 <CADJHxWB3b+bH2+HBP+SG0jxhGNcozstBeWeDH_3dgS-4c2G-6g@mail.gmail.com>
 <aXJmYAZ-8KkXCFI9@smile.fi.intel.com>
 <CADJHxWDCer97pMNHV-69B9AEVY0NfimTcxo8k8yFBbstg0wMQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADJHxWDCer97pMNHV-69B9AEVY0NfimTcxo8k8yFBbstg0wMQw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 16, 2026 at 09:22:32PM +0530, Archit Anant wrote:
> Gentle ping on this.
> 
> Has anyone from AD had a chance to confirm whether the original
> truncation via (mclk / 4) was intentional?
> 
> If there are no objections, I can prepare a v2 using the BIT_ULL(29)
> form as suggested.

Gentle ping on reading and understanding the given comments, please!

> On Thu, Jan 22, 2026 at 11:33 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Thu, Jan 22, 2026 at 10:27:52PM +0530, Archit Anant wrote:
> > > (Resending to the list, apologies for the private reply earlier.)
> >
> > First of all, do no top post!

^^^ Have you understood this?

-- 
With Best Regards,
Andy Shevchenko


