Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4E4BF93D;
	Wed, 16 Sep 2026 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585940; cv=none; b=DZRIpfCdItKb12+kPXm+kon0jT8hE+gfSbDkIkcjhNIaJLZy8GUfF/M/SBatfNbHSpFSJng4EbHHm+084AKF8jppbh0Wo5+YBnGjIbADrYws3tKFVt3zGx3h+nOoKq8sJbvJehSIUbd/DlRVD+LMeqcBa+Hjp1ygyhq57oOBqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585940; c=relaxed/simple;
	bh=SiyNjSemEL2vVcYCZDuccBQr5dDwTB0ELJoSD78et2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8Uvs8g4pS4pj5ma6jsZJy9iuQimh+FaZPORXAoobSOwqcjVNdawH78b/ziqiOuZovotJAQeD6s+En8IscQIN0gkf/Z+dmbPl5GauCboC1UltmCPZnDBEr3T6QbM3wrJoZm49skuhXjdzON7ZIiLkCYKF0KlKkV2nVqnIWvWXDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sujpVWeN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sujpVWeN"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id 1694C20B716B; Wed, 16 Sep 2026 12:11:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1694C20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789585868;
	bh=ZMCPr2d+84idtjE/iazrjH1mICP6hgFsVquhvouYacc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sujpVWeNHaiNXNv2VUxOymEXxn2fOkPGqaHByHoa94OWmeoMQbGiSUPzUJ9dG4rDF
	 dShdCZnG87N3VAm+k5TWwn/ZAnAB6KSAcI4RHrbWSrZsuNjOotRcAjtbSWwXQyo4lg
	 9yguoKzxtjldZWdT+1wYSFrZATdspf9r0qIB2NNo=
Date: Wed, 16 Sep 2026 12:11:08 -0700
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: Jonathan Cameron <jic23@kernel.org>
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
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
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
Subject: Re: [PATCH 2/3] i3c: set i3c_xfer.actual_len in controller drivers
Message-ID: <20260916-9b2d5f87119d3e1a052784e9@linux.microsoft.com>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <20260911210935.1353126-3-meaganlloyd@linux.microsoft.com>
 <20260913012612.745247fa@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913012612.745247fa@jic23-hlaptop>

On Sun, Sep 13, 2026 at 01:26:12AM +0100, Jonathan Cameron wrote:
> On Fri, 11 Sep 2026 14:09:34 -0700
> Meagan Lloyd <meaganlloyd@linux.microsoft.com> wrote:
> 
> > Set i3c_xfer.actual_len for reads across the I3C Controller drivers.
> > 
> > actual_len provides a consistent location for device drivers to know the
> > read response bytes without overriding the len field.
> 
> Hi Meagan,
> 
> Why is that useful in this series?  Currently this sounds like
> an unrelated change.
> 
> Jonathan

Hi Jonathan,

For read operations, user-space allocates and provides a buffer, as well
as indicates how many bytes it would like to/can receive in that buffer.
actual_len allows us to report to user-space how many bytes were
actually received from the device and are thus valid in that buffer.

Thanks,
Meagan

