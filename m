Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082804;
	b=OEOKk/Br8RtByeY3PmRb+WjpZmlg1ekdiFaMO8EgEidguNhJijy0ofv/LZ97a2eB1Awg
	 TiWMnZLzZnVwemWG1dti/HxY2ZcoLei4sDIkF8fh0vBH+aCZqpVubKQUyR9GPux+1JIcK
	 PqKlkAcy/tcN1jI0ZUzaNoStn4XclSUtgU3Yurc09i5z18RG6EVMUxpHdut0Dwkl9yR//
	 4rzGF/htEaSkkOj/jxZSWyy/t4OqbsnVWPVpc5Kbpn0YKDUbNF3JMPfYM0EFkBCrxFL9q
	 nsMq7lr0bnkJgpQFHWxtSlvPtjyYfLK511VKCLm+7zZ458V3f13hxbXJoUnoiEpROzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082804;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=RskZLkEa6z8JI2a5AOVYlltXSGqshNp9BpKNdS77Wjc=;
	b=Lc0JsCLmItRd/JHgow4a6WAKNGKaSluS41EXK4/C+8Q7NRq8rQL03A1TSBd/oXHDfoa+
	 rXes3l0i9QyZqdbQlcDSGN/PdvuQvkHkqmjUl4Pg79HHpoqDp5dKbJ5/bZzOAJkOgGyqs
	 yEAsT3Q9paqkAsfWsgN6xuqAT+0zfPxD23hbU5tdEj+vjjqinMbLVFHQ9ArnLSeqWVlcW
	 JzSB4grhhpa8ZpJ1GzFBNzCOoIsYGTaO9fcLE6J1eZ9pkqT8wHjtq4P6OFk8ggxTgg8Us
	 as63N1tHo20BRMh+O84gR0N+dFFwq0BXI6L8zNh9NdcYHX1rFF153NOYAKgUIP0FvgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=icXrqKLl;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568C606A320;
	Thu, 19 Nov 2026 10:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B568C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=icXrqKLl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795082804; x=1826618804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YuaKhAZ+H4CMymjxH3E+bVtidTrCWTXKmKCvGB/XRME=;
  b=icXrqKLlDX3dZI8dm3M+8ozuy3lQZSaU1JiHmuTYlX+556k3NbdNhVy9
   2MZ+LAxvtdX6TjRbM/sz7oLDxqGgCrI1m0NfAtuM4IS1PUGBlI8Vr53xz
   fRoAEkG2S2m83zO7O7IHcku2mJNItLt5XlVjVi0YgotsB5baM9MSrdjPo
   wwuX44tkM2fp3w5+wrPgfOYduunRTGaHq7vO5CQIsiCJyQVH9wCTBEQkE
   IeLUJoLDeloYWkBSsJEEBr1PFq1164UYVGv47wZyFGRZOwaOERx6iZKq6
   0W85kO5uKJOA+VIAGLjAQcxLxkaf1GPNvbT6h7KhhrF2N8OP5RN/yp830
   g==;
X-CSE-ConnectionGUID: YJVW/dNDRCmUhDZjQQE7aQ==
X-CSE-MsgGUID: H7fB0O2CTMaDH+2PWaEl+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3808767"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3808767"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 02:06:43 -0800
X-CSE-ConnectionGUID: NUPrMJUqSOG6j9chdv4ksg==
X-CSE-MsgGUID: irVVV1xjRiyAeX58jTnq2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10305446"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 02:06:41 -0800
Date: Thu, 19 Nov 2026 12:06:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org, andy.shevchenko@gmail.com, andy@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: potentiostat: lmp91000: Handle configuration
 write errors
Message-ID: <av7KLkQPFSf2ir8E@ashevche-desk.local>
References: <avrStKkcvUApPMDb@ashevche-desk.local>
 <20261119032155.11434-1-zhujun2@cmss.chinamobile.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119032155.11434-1-zhujun2@cmss.chinamobile.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 11:21:55AM +0800, Zhu Jun wrote:
> On Mon, Nov 16, 2026, Andy Shevchenko wrote:
> > How is HW being recovered from the inconsistent state(s)?
> 
> v3 has no hardware recovery step. The LOCK bit only controls write
> access to TIACN and REFCN (datasheet section 7.6.2). Setting it again
> leaves the register values as they are.
> 
> If the unlock write fails, we stop before writing either configuration
> register. The resulting lock state is unconfirmed. If a configuration
> write fails, the chip may be partly configured. We try to restore write
> protection and return the configuration error. If both configuration
> writes succeed and the relock write fails, we return the relock error.
> In that case the configuration writes succeeded, but write protection
> is unconfirmed. If both a configuration write and the relock fail, v3
> only reports the configuration error.

Right, in each of these cases what will be the outcome to the user?

> In all three cases probe exits before registering the IIO device. If
> the device is probed again and I2C is working, the same sequence writes
> LOCK=0, rewrites both registers and writes LOCK=1. That would restore
> these register settings regardless of the previous lock state.

This is a recovery mechanism! But specific question is the above: what
will happen with HW in each of these states when we try to re-probe the
driver?

> The driver does not schedule a retry or reset the chip after these errors,
> and I have not verified recovery on hardware.
> 
> Datasheet: https://www.ti.com/lit/ds/symlink/lmp91000.pdf

-- 
With Best Regards,
Andy Shevchenko


