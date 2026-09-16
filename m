Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2194D6C25;
	Wed, 16 Sep 2026 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583922; cv=none; b=Nv5gaijkjg5m4+mOwfGfH71DiaO898T1tnPe1aUFOcT0V7OLFhgk1ZPDUTbOY+EspIAD6ZcTUgoTPTSgqr8rstjPIV64MhdW1mPgs1tIXNzN2sh93fBUVKahw9rHAzqMqjFufkjVSO4UThoeEQEa8Hoiyg+Qg2LsSeqjPkKkHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583922; c=relaxed/simple;
	bh=Kmj2piQvTekmNry0dJIgneh0YfYITYhWcgxWZQ7r7Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHp7aW6QmFxAMMVVwovclzqzIuJW9kNtmD2VolQxbpc4uKt+llaMI6Dodj+M48d2PK4Ek5NItKANgmO30/VoF543iXhocSKrDAct/lfWOZbUFpWiQCEY8+Wu6BIWw6udYCZJN95uMqkev/LKBCaYKBy11Z/92on9gTOu4Vo0odk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rfvyhs86; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rfvyhs86"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id 1CEC920B7169; Wed, 16 Sep 2026 11:37:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CEC920B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789583869;
	bh=9wZWN3c7VtfU90nlylRqOxhet8YTp7k1kim88XV1ips=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfvyhs86B1WHn0HXBT2/McElIEdN6Md26yOwXBHT06v6u7v4r6/Saj0sxJHRis2yS
	 mGIVyLRBWCrUYRtKfaw0bwXCSYo4X3clSVvu4cjWoPtEFsjc/yCljS/i+9m+t2hNym
	 Uwy3mV8kPJ1dQ+74YMB7IQwZpHEQgNCeLfPkYbcM=
Date: Wed, 16 Sep 2026 11:37:49 -0700
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Meagan Lloyd <meaganlloyd@linux.microsoft.com>,
	linux-i3c@lists.infradead.org, alexandre.belloni@bootlin.com,
	vitor.soares@toradex.com, samagazaryan@google.com,
	gregkh@linuxfoundation.org, arnd@arndb.de,
	boris.brezillon@collabora.com,
	oleksandr.shulzhenko.viktorovych@intel.com,
	tgopinath@linux.microsoft.com, corbet@lwn.net,
	skhan@linuxfoundation.org, linux@roeck-us.net, Frank.Li@nxp.com,
	jorge.marques@analog.com, pgaj@cadence.com,
	wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, lorenzo@kernel.org,
	enelsonmoore@gmail.com, rppt@kernel.org, pratyush@kernel.org,
	giovanni.cabiddu@intel.com, gabewhigham@gmail.com,
	haren@linux.ibm.com, pasha.tatashin@soleen.com,
	jirislaby@kernel.org, adrian.ho.yin.ng@altera.com,
	ustc.gu@gmail.com, jszhang@kernel.org, adrian.hunter@intel.com,
	akhilrajeev@nvidia.com, tze.yee.ng@altera.com,
	manikanta.guntupalli@amd.com, shubhrajyoti.datta@amd.com,
	jarkko.nikula@linux.intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] i3c: add i3cdev character device module for
 user-space access
Message-ID: <20260916-6e1c9c4182821362eb097551@linux.microsoft.com>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <20260911210935.1353126-4-meaganlloyd@linux.microsoft.com>
 <5cd22376-6921-4a2b-acba-371bcbbfa00f@infradead.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cd22376-6921-4a2b-acba-371bcbbfa00f@infradead.org>

> > +	close(fd);
> > \ No newline at end of file
> 
> Fix the warning above, please.
> Also:
> Documentation/userspace-api/i3c/i3cdev.rst: WARNING: document isn't included in any toctree [toc.not_included]
> 
> add that file to the table of contents (somewhere).
> 
> thanks.
> -- 
> ~Randy

Thanks for catching that! I'll add the newline at the end of the file as
well as add this page to the table of contents.

Best regards,
Meagan

