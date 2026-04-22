Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E4A18DB2A;
	Wed, 22 Apr 2026 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776823694; cv=none; b=Md6L/twCEzjTxHSmlDokou2fYhdvAL+HHlNFxlbMEJ5SkkhyzRHMtYcHbUQltx3ZUHswd1Tp3B9uF8LjXuuOAWPsd/kE6PFBJ5LH52ZQXg+akT1PGdCVH9ux8DtO+xGF50SpuCudZmbfn3Y+iKeViXjCsRxYJnWsfsiZdM3+hbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776823694; c=relaxed/simple;
	bh=OGNr4xy0FAeitANsVw1KMhjApyyXpHd+f+YqC8IB1ko=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ntcj/inbaD+BKNI9RkuglTAHI9lZc71xdV9q5h0MZPYO81eeiZlLJALavRqUDuFSb0G8KzfQFgE7EtatdICgTg5gHYc2wnYyeyA2Fg35cG0kUfy0pjCaoVTZfhiYpUHyy6SMf3kiPyruNTh8f78nwqdi1ZNqTXTsX8gPaIBjfO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=aQ2DP5kN; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="aQ2DP5kN"
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1776823682;
	bh=w7qnjw/XzIWdPVx/ZYZ5nEEB3YSFm8xSMq51uHUcFL0=; l=771;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=aQ2DP5kNgaC5J2i3nKL5BaNgqsgw4qu2R/5DZ5JPw+wt0uESxZugrcDlI6Lwza+IK
	 rg0TclkpQw8caXdVJo4RhiP3ecQAirVjV9mOnbbxu2J0PWPOZyMyYgKKwYHyhxa82M
	 BDAXF1RnvLHap/GQjoh24rpJXkZIClku77WAPmeK8yFTHZfHue6Gd88c7H85IjPyp3
	 O+BmX/WKAjhH1+dzkrabz7RmG9To84lu5tKp6yIK644iTeusEukR+Yl1+6o+kj79p0
	 NbSAxMDpxd8KwWtlm33LTCx96oXIJ6GojJbGIbDjBjs7r4o/b7wnIzZ60U4ygMrS2T
	 AX0ULORRly6+Q==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1234970:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 22 Apr 2026 10:07:33 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Wed, 22 Apr
 2026 10:07:33 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Wed, 22 Apr 2026 10:07:33 +0800
Date: Wed, 22 Apr 2026 10:07:33 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>, Kevin Tung
	<kevin.tung.openbmc@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kevin Tung <Kevin.Tung@quantatw.com>
Subject: Re: [PATCH] iio: adc: rtq6056: add i2c_device_id support
Message-ID: <aegtZaOFkhZ4pHVL@git-send.richtek.com>
References: <20260420-rtq6056_support_sysfs_instantiation-v1-1-483ccee27b63@gmail.com>
 <aeZekWfdcsSkm4SE@ashevche-desk.local>
 <20260421155426.45043750@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260421155426.45043750@jic23-huawei>

On Tue, Apr 21, 2026 at 03:54:26PM +0100, Jonathan Cameron wrote:
> On Mon, 20 Apr 2026 20:12:49 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Mon, Apr 20, 2026 at 08:52:52PM +0800, Kevin Tung wrote:
> > > Add i2c_device_id table to support legacy I2C instantiation.
> > > Update probe to use i2c_get_match_data() so device data can be
> > > retrieved consistently for both OF and legacy I2C instantiation.  
> > 
> > Maybe someone finds this useful...
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > 
> Applied.
Hi, Jonathan:

Since 89a1034cd841 ("iio: adc: rtq6056: Add support for the whole RTQ6056 family")
break the sysfs usage, should we Cc <"stable@vger.kernel.org"> to make
it backported?

BR,
ChiYuan.

