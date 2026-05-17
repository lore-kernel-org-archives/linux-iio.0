Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F7B36AF6;
	Sun, 17 May 2026 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778997782; cv=none; b=NFMg88CcAGtb6PHp5KCknhbz7uPu3P4/TVBg+rkiHDhoMBrs3MuPVAKckImKOfJkIu53sqwznDZKdMalAo0kbxYKTHnnGghxzDQIMZsSUqyCX+JJxmGdtTrnj+92IkMGVAan48Y4lw8qs3NkZGpWlCrW1RyJM80LwLfhf99EcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778997782; c=relaxed/simple;
	bh=RErmfycAQncLFjsSj4ZRL6Ch4MLjE4kAmLwUNayyEKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKFdJV0nrnwrOm0Wnzk5CfEm0TJW2zrTEhRCgvZeU8vQv+hr1Ri/eM+WZgoomPGzaEut5H4Anmj4EKGLTEq9nTJF6Ka3IP4cn/K9ROC9A7BRqhLpS5dQFG+QVB7/3zkyoi3B2DoH/UbAy19ebzsAJSBc7rd1fouXHn/s+IbQD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AC0Z3Z80; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AC0Z3Z80"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778997780; x=1810533780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RErmfycAQncLFjsSj4ZRL6Ch4MLjE4kAmLwUNayyEKk=;
  b=AC0Z3Z80jXSl9ur0PK3NNuPs8weGsT5Gp3+b57IBFV5adjxrcn4vW2Oh
   3WGTyTc8fzMZ/NdNkHfJr64jmWest5T5q8OeXliB11Mbm1hqfkgxHJSbD
   DTake6jhcTKJ/ER+4BAfUXDG1qlEy0ZHdslTVr+cQmMFLeq5JQNq6Z0U/
   LPJmLz/Quz7TSRcHP1uLqUuVOZlJLWqa2AMHmYYz+PZrzIyfOuQ+VjL+N
   eOdtiv7Yw0sk7JgwqcjgnomjRKbxd729qm7aYL0GEMbKPtcJKNu+hytMq
   AimEBUN1B9ruLqwiIGFW+eeoyLGfz0ZzCcxkwYQ8B30AC8oErOU4CWIbx
   Q==;
X-CSE-ConnectionGUID: +cNwu8FISNaqzacFwrk0MA==
X-CSE-MsgGUID: LQ4SmbICSvSawy2iY+nuYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="90586011"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="90586011"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 23:02:59 -0700
X-CSE-ConnectionGUID: jfCnAYtATRmghucDqyWBcw==
X-CSE-MsgGUID: ur3eSMY/TXWUGViywdoT1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="238118899"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 23:02:57 -0700
Date: Sun, 17 May 2026 09:02:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexander Koch <mail@alexanderkoch.net>,
	Michael Hornung <mhornung.linux@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 01/10] iio: light: opt3001: move device registration
 to end of probe()
Message-ID: <aglaDlDvhEfnqiqu@ashevche-desk.local>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
 <20260512-opt3001-cleanup-v2-1-8018cf3a8a0a@gmail.com>
 <20260516125628.53b90c7e@jic23-huawei>
 <CALoEA-wakxKH8xKWvPWED1Afh0vTKASCOxsKYWF9ipAjBAytjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wakxKH8xKWvPWED1Afh0vTKASCOxsKYWF9ipAjBAytjQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 16, 2026 at 06:57:33PM +0200, Joshua Crofts wrote:
> On Sat, 16 May 2026 at 13:56, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 12 May 2026 12:57:21 +0200
> > Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

...

> >                 return dev_err_probe(dev, ret, "failed to register IIO device\n");
> >
> > My eyes skipped right over that whilst reading :(
> 
> Yes, I've read the report and it should definitely be fixed, however
> it is compilable
> on my machine - what an oddity!

The only possible explanation I see is that you have CONFIG_IIO=n, which makes
that no-op and compiler's code elimination makes it not even consider.

-- 
With Best Regards,
Andy Shevchenko


