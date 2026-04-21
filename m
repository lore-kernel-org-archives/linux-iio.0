Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAAA25F988
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776736593; cv=none; b=tpIKEEBhxaPxs6cvcS6Gye3XusJj9iVC7rzOryJ0qBhOSB+N+ody2Aclv1my9HjKVINu+DlUd0QwxLJPV7iHXZQfB4l8ItoSVXO3VUKVnKLEfxI/EnRib39FCwFf43mrWfwF0B1MJaMYKz09qQOr7dYEu1hJixEY7VzpfKtEsl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776736593; c=relaxed/simple;
	bh=nLQHXtixbiiCSFHDVuEFUufqLl0TgEWa4Uvmy0A5jrc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm0O6tvkr6dFXqPOu2gGmp9X/euQ1fzu/K31sGgJBOY8CDoJTqpb/e3uo/h4SHeklGFBe6u1fzJIU7LREIxvFcAeXla3EVH3WmU24GIjLH2/NWpfp5MScBpItQiFKGxwQezjdB+QwpkBKrAx6H9v+sKJMSAfsaXd97lbSk/cbpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=vvRkrc2h; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="vvRkrc2h"
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1776736582;
	bh=346+yF1poLqwHVsI0ue/vA6Zm2woM6F3tsa06yU27bQ=; l=954;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=vvRkrc2h1OxQIrIg7GJU++nN65e3pBGzGZkWhKs+R+EOVzhWsL94hOTXAid+SNZAa
	 ql0IEqAnSNj+Wb2vr1OAl209iOB7gNoQ4r2Kj0lKjgSJwebjwFX47OsdCLQ2xdJZzj
	 2kQadlOsNbPKVEck2jjf8/GZe2VbdxsTd7LSAPwTjx37P27rkAhorNs2Ovr1JgLaOh
	 eCEvglSf0bNUws8JPYyy8SW0UGV1jxELi5nynl3ZyaYwG8//nc0E2MzgfhNIA9jKsh
	 RzjY8Dw/pE5bs39J+gfQvGFdUcaoi+C+FgCmz7RsfUBg01p2UAD8COUJ54xqsaEnLE
	 CC3BL0Rq53+ag==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1227023:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 21 Apr 2026 09:56:07 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 21 Apr
 2026 09:56:07 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Tue, 21 Apr 2026 09:56:07 +0800
Date: Tue, 21 Apr 2026 09:56:07 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, Nuno =?iso-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kevin Tung
	<kevin.tung.openbmc@gmail.com>, Lucas Tsai <lucas_tsai@richtek.com>,
	<kevin.tung@quantatw.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: rtq6056: Fix the manual device instantiation
 via sysfs
Message-ID: <aebZN39+vev78GHD@git-send.richtek.com>
References: <db4f5ded64ca7d2e56abfa30c6a174342c44fabb.1776735120.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <db4f5ded64ca7d2e56abfa30c6a174342c44fabb.1776735120.git.cy_huang@richtek.com>

On Tue, Apr 21, 2026 at 09:41:17AM +0800, cy_huang@richtek.com wrote:
> From: Kevin Tung <kevin.tung.openbmc@gmail.com>
> 
> Add i2c_device_id to support sysfs manual device instantiation.
> 
> Fixes: 89a1034cd841 ("iio: adc: rtq6056: Add support for the whole RTQ6056 family")
> Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Cc: <stable@vger.kernel.org>
> ---
> Hi, Jonathan:
> 
> For some BSP limit, still some user instantiate rtq6056 deivce via sysfs.
> Therefore, add old style i2c id to make it compatible for this kind of usage.
> 
> BR,
> ChiYuan.
Hi,

Please ignore this patch. I have seen Kevin submit the patch in the
following link.
https://lore.kernel.org/lkml/20260420-rtq6056_support_sysfs_instantiation-v1-1-483ccee27b63@gmail.com/
> ---
>  drivers/iio/adc/rtq6056.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> -- 
> 2.34.1
> 
