Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E460D3C1D6F;
	Wed, 16 Sep 2026 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583459; cv=none; b=HEYzM60yTKgGjOfFqrNBjgG5IoLSq53XdmwB2cebqm7So9gXbVKMuCO8LHr+cQ51kZ6rjetX/9wsWop+RLFDCAwNMB7Yk1J/hjf8gNQ6zmZ6Ye97+JtCufhom5ekzuJe49HcIPn7g4scuadMyIrFY8S9vYlRwK3k1KN0F581Xr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583459; c=relaxed/simple;
	bh=DNox2b07xylBJuR8uuwZn8WR+4Dg9cFvEwwFr0HkWYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxAfMFmepTp3f3N+WAMKhJbH5ld2ycXIOeOzmcNKM3sqhNYt1fzCJBJd6r6O6GzneqRhdVkp0swRrqq2w+fI24++tzfh9JEGiRPgIdu2G6JBgumnsIlfHgbVKraJrTqidcbQFSlhHgd9MI24g+5q2oSp1TxnheRtWNOYcXQsXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jp95ag81; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jp95ag81"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id DE87520B7169; Wed, 16 Sep 2026 11:29:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE87520B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789583397;
	bh=66yRjiZbxnq9mprxpNY9s32uLqj5SRsaSVuXRrNPJDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jp95ag81bTPAfUxSwAMExx+Vq6XExpCBRqB/a+E59hTqkE1wEIzFPyYcabB2JGi6X
	 m1lOuWIwhz/Xl0v6sxikBQLslMD7uVBiASTSbpbWwxtqVp7WwbbkBzjQcz8Noey/id
	 ZrJSfh6hgBsaqrkZKroU94QqPJ7D0v7khXhi7nLo=
Date: Wed, 16 Sep 2026 11:29:57 -0700
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Meagan Lloyd <meaganlloyd@linux.microsoft.com>,
	linux-i3c@lists.infradead.org, alexandre.belloni@bootlin.com,
	vitor.soares@toradex.com, samagazaryan@google.com,
	gregkh@linuxfoundation.org, arnd@arndb.de,
	boris.brezillon@collabora.com,
	oleksandr.shulzhenko.viktorovych@intel.com,
	tgopinath@linux.microsoft.com, corbet@lwn.net,
	skhan@linuxfoundation.org, Frank.Li@nxp.com,
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
Subject: Re: [PATCH 1/3] i3c: master: enable driver_override for I3C
Message-ID: <20260916-2b134d3050dcbc59b45e40ce@linux.microsoft.com>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <20260911210935.1353126-2-meaganlloyd@linux.microsoft.com>
 <342236b8-11f0-44bc-b0f3-2f167a6f521b@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342236b8-11f0-44bc-b0f3-2f167a6f521b@roeck-us.net>

> Separate patches for each hwmon driver, please. Each patch should use the
> standard prefix used in hwmon drivers.
> 

> Thanks,
> Guenter

Will do, thanks for the feedback.

Best regards,
Meagan

