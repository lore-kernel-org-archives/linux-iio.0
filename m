Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4753B5E3;
	Thu, 10 Sep 2026 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063235; cv=none; b=Y7qel6KJmPLcM6/mc6An+nkGQuMVjwN+YI2I6o0IvoMNUKHcRL9qn4IFtdy/TE3LOjgljrjTn0aHR9/7lhiW3yReo7cuGCyZxeBcbDonB5dgo3qp6yLkZ8xDuhwIySnOAiQlifAYKPpKiS7sKLSpnm3L3RlrKogFnhaIiHq+t7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063235; c=relaxed/simple;
	bh=dXNcYXcONdC0bXZ94nDhMVEs+kZqDmV2ILkK1cbt2zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqgCRyCOWFSnguxKNarIRnTLs10TcLu/SBLE6FToLjJ/uBltsr9B7MJJvZnBgxHpe03tmrgYpijdqvLhf+/+eXoOQMMzL/WKn9QWbeklngq68q0PwLL3wtjf4jt0SgGJ0PWDJghc38wBfQ2sE3MLhPFSCsTfkOjfg+LVEukUB2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=j8OWN0gi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="j8OWN0gi"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4818740E0352;
	Thu, 10 Sep 2026 18:00:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AtWKNMAAqyqc; Thu, 10 Sep 2026 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789063220; bh=Fb8z/OTTzGDxL2X6E1EzshUkNGPO4yn+vH2gM46pQxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8OWN0gimD6eXkbsZy44KK4FQ/VhJ/LuHVZBPMhGCPL1UEKTFqxoy+7V9ruumTaTO
	 VMY8TP/wuZ/66zNo+CWiQrv/vD3hxCh0lP5vsUDrsYxwVIv9HBjr+oe4u7MGEbGMqT
	 sQjgTEk7W7CyU8tbUBfH9ysO9zAf/VX9w33pRy8CAeR4r8rF3u0r8S0ngxG3aK4DGA
	 /8K0slitVi4VPwctmLR8wUkgflUp59j0xJtiVayOj7aHqU5stUq4ZrM8vSmeOcYJjG
	 TrcyBEPxNnne+j8b8gdYGYgSsB5ZVfhWktNZb9W9pPKa4j4DjvWDXICHf1NmgEsULX
	 gQ+trLRdWQfloMQ3FRDcI9JMhfsAPck+l9GjccrHD9JmGGbieYt024fWLfYu4Xcb80
	 R2c4sQKA+AzxkDnQEGBZuDQ6ojvR9jB7zCu+v3Vk88ZjhdozXMK9nKcUs0OOpw7HV5
	 wG5IefvhnCZ//hPcdEL6s/ghYVwBs7yfgOhzHFJEp3JXtYzbiB0K01/Su+oYvsNmyJ
	 yEZ2kuRWj79pezZfThnLoTMrowFHlGTzqMzQ0OF9xZlEXoX/ucFD1x1oWWXFZwt01t
	 D45et7uWh0YADe5wHOyaSSNtF4axEiksxlBnU/HYI8Khm8T0ODrftdnn42afeGCjUh
	 XugzrhNrkATPiuOcrStFbENc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A98D240E01ED;
	Thu, 10 Sep 2026 18:00:05 +0000 (UTC)
Date: Thu, 10 Sep 2026 11:00:02 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-iio@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, rodrigo.alencar@analog.com
Subject: Re: [PATCH 0/2] x86: Use "er" asm constriant for add/sub
Message-ID: <20260910180002.GAaqLwImwJj66E8w3L@fat_crate.local>
References: <20260901175101.1e059ac8@jic23-huawei>
 <20260907231444.7fa2d116@jic23-huawei>
 <20260908033216.GAap-BwAmBqoVDUbMK@fat_crate.local>
 <ap_cLN807bC56OBU@monoceros>
 <20260908152127.GCaqAn9zI09T7qvMhH@fat_crate.local>
 <aqAtRgouK7DyDlpJ@monoceros>
 <20260908165501.GDaqA95YQKx_IL416d@fat_crate.local>
 <20260910042029.7c78f6dd@jic23-hlaptop>
 <20260910034527.GBaqIn13O6zSuD4vak@fat_crate.local>
 <20260910170913.1a3ab4b2@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910170913.1a3ab4b2@jic23-hlaptop>

On Thu, Sep 10, 2026 at 05:09:13PM +0100, Jonathan Cameron wrote:
> Only need the first patch, so I'll just pick it up by merging
> an RC once it this is upstream.

Pushed out into tip:x86/urgent. That branch should be mainline with -rc3.

If something last-minute changes, lemme know and I'll do an immutable branch.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
