Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8D33D4E5;
	Tue, 18 Aug 2026 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037259; cv=none; b=LQkUzz+P2wgP5znlWjgwwTriZ4eeqcq1IQA5Ao9vgngpDVvwGCxH+Y3tKA+r3dqivVErQvJfs/CP47PT+vB/sBCGiFQLG3URYMbkusnAdJGV2vVZijY9k9+3VUTSQyJH9Lnq9owsGYiUrVREr7LqlKtJyBK5ljrwsn+BNJHjgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037259; c=relaxed/simple;
	bh=qv7Bn5bUpNmXwhWWJBYmQ2lH8rxe2u3zdjQxZwqO4+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHv7EFpd2C8EZfRTYpXX5XJEHifbjxPZJrfRh0X8rZsOvvUlnt3wVGjg7JexxvycGLb00WJmAHnLkBJoIu0jiqUR2CqLd8aFrz61iZ4gnXUXelOg38CzuB0TNOhUUG2H+U7NgMeE6JShpUw/FmBeJditTIiJq52PA3YjLVQO+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPnYCiB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPnYCiB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC151F000E9;
	Tue, 18 Aug 2026 07:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787037257;
	bh=fzoIml8CdsBNdo4B6yuVCS+4tpWCXE0wDHYBl4omch4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MPnYCiB2NykHRGfpsiwsVQtZO0gJafZzBIpd7h0szw6dize3qLfY6Vq3qBP8z+K5s
	 LOVF7GwZeYlNb3csd4DkeKiocZrYSfyvdE9V/5e5y1MHJOv4JFEcHqkzs62wlfLkAA
	 m7ruizh4+jPTQrzv5/XxJY9grIP0/KryA3Z1fwaSbUf5JmoB9LmLaAfRxOWs8+bOr6
	 W7iHma4sY5zj8tWaNUL3mOn+A+Bkkj3IXBWDsVzygR7DSr07La7kpTaSBfa6B6f+0l
	 3v0bSV50OfkKvyeG3pFYE5rj2LWP4wcLIMNKT6QSiMXBgCKYqN2mYWfEKTecfM0Zkm
	 7VwRrwCz1DTuA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwE1X-00000000m7V-1Lhe;
	Tue, 18 Aug 2026 09:14:15 +0200
Date: Tue, 18 Aug 2026 09:14:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: srf04: fix runtime PM autosuspend cleanup
Message-ID: <aoQGR8uSXXmOxnWI@hovoldconsulting.com>
References: <20260807141938.2491195-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807141938.2491195-1-lgs201920130244@gmail.com>

On Fri, Aug 07, 2026 at 10:19:37PM +0800, Guangshuo Li wrote:
> srf04_probe() calls pm_runtime_use_autosuspend() when the optional
> power GPIO is present, but srf04_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> 
> The runtime PM documentation requires pm_runtime_use_autosuspend() to
> be balanced with pm_runtime_dont_use_autosuspend() when the driver is
> removed. Failing to do so can leave the autosuspend usage state
> unbalanced and may result in a usage_count leak when the autosuspend
> delay is negative.

I believe the term "leak" here is misleading as the usage count would be
dropped again when the user re-enables autosuspend through sysfs, right?

That said, drivers should clean up after themselves so disabling
autosuspend is still the right to do. But it's more of a cleanup than a
fix (and does not need to be backported).

Johan
