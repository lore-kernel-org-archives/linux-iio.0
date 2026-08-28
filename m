Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5E2222AC;
	Fri, 28 Aug 2026 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899014; cv=none; b=II+cH3BpWBJjw/wqaSr7h/lIOIIaTqoiZ/4Jb+LGSTcLPxIxSB1ywK8Sqth2AIok1+5o811EqxxT3xNyAnbJiTGSJw2ak898j9nNr7d7N2LLrp0ipEPSBta5irargYKzNvbVv+absTZDw5zItZFmulgKoRoKA1F1RNwNJ6TRPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899014; c=relaxed/simple;
	bh=EW3sgjBTBBW1Z5uUzroGApB8ylXMymRJQbLvoY0lmT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWm25JfNcszsr5n2NRk5RFV2mhOS2G9OhPg7cWvUJ3r0vKvtv9MFktMi0R6RbXzED7ovZ61Xw7A6ItUlCK55pdWS4nV4MEDRRy7GuURiwvhkcaAjUlRroDAGwVEkSSEn/eEnOLcsipMKGwCzkkOl7FEgGKEA9aDKpvEBuKNjz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KF10JzYb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KF10JzYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787899013; x=1819435013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EW3sgjBTBBW1Z5uUzroGApB8ylXMymRJQbLvoY0lmT4=;
  b=KF10JzYbHsmFZ/wYgPWdCcOrEZbI3vprWfHmvm0iO51BYO08fFSrNsRd
   QLpr+FNweGFsDHJzTOKeEHbsXB0d1XeGw8FhW6VgWJAlJ13S8GIYTRj2K
   5rabFq5/wIdDajeXqoid6NqiSHODg9MjEHkNyrYAYboFX5zxOXTqN/cF2
   WcMn38XYlPYoOYQ2POu5Yl9mAqT0/cq8r2V6+DgJHHmk4zK4ES/wfwoJf
   cIxf49KIpbIx41uD42V0ddEjLuMvqFmrTALhawakPrIsYgPk+ubSqFie8
   jrBirJoN6YlT/7BD3WVD1bbbKkwsfXWFqAlezAahd0k+H3ONVzSB4X1kK
   A==;
X-CSE-ConnectionGUID: 6angjL0aTwuk9+s1Wshabw==
X-CSE-MsgGUID: XqjuT3t3SEGNGa5XkH4hPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88429578"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88429578"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 23:36:52 -0700
X-CSE-ConnectionGUID: F3TJKzqZTJ6CxQ4iCrn9Yg==
X-CSE-MsgGUID: i3rjNciATh2QmxyCt1qm1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="271882576"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 23:36:50 -0700
Date: Fri, 28 Aug 2026 09:36:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Anshul Dalal <anshulusr@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr390: Remove stale TODOs
Message-ID: <apEsf5s9Fo0AtWeF@ashevche-desk.local>
References: <apEMLlURRBCmtBsZ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apEMLlURRBCmtBsZ@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 27, 2026 at 09:18:54PM -0700, Chang Yu wrote:
> Remove stale TODOs from ltr390.c. All features have already been implemented by
> Abhash Jha<abhashkumarjha123@gmail.com>'s patches.

This is a comment and doesn't sound like a commit message.
What patches you are referring to? Are they in or still pending?

Depending on the answers to the above act accordingly.

Also make sure the lines are wrapped at ~72 characters.

-- 
With Best Regards,
Andy Shevchenko


