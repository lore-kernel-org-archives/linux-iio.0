Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9C3783DA;
	Wed, 11 Mar 2026 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212805; cv=none; b=d8QBoxjyQXByutSgCPLgEKK9EVoQmWJbEMhTfDh7PVsGotbz+Uskw7AKM6D0M+JmltyzKGeRoN6R16TrGxEk1VozaWJPgDEwjaqKduXDl1rwH5r8prjMZqeFQ6Ndcm6iEIIQCjLWHntTN+COVqKjCs0sAr8J6P9r8Vf2pDrxcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212805; c=relaxed/simple;
	bh=RR9Qvte44D15VS4RtzccJeT1Fg0fLFhuLfeFArrffZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSbBMkMgLI7QxhiMgAEAlDAHV2m3pKottUhE/+UZ4LKKxaV112hTpbsg6ay/oc1r5y2B2sXO14GjrDU8JRGu+/CZrWO2oGd8yL+E0Hb+BtIVWbPpU1tAeaycXqsM7A1KN1MeOkMHC8LObgkU4ffkdrX79XBMUeL4D8VByMR7lIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fUOLBM+t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fUOLBM+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B573EC4CEF7;
	Wed, 11 Mar 2026 07:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773212805;
	bh=RR9Qvte44D15VS4RtzccJeT1Fg0fLFhuLfeFArrffZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUOLBM+tf+Xmbt4WSJJkpYCsoDglyB9XUWNK0x+zAm8AzvWVlSG6KBa41S0GrubbI
	 ZoQEs3UNBN2LOcYgEJ6duyxKpBwLRZSWELKfr9B6JshcfZLRBatSuaNYTSxGZyhzsU
	 bxuv3gMR4x0ml1VaUAGr5vrWLWForGzRwzofRA0Q=
Date: Wed, 11 Mar 2026 08:06:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org,
	m.tretter@pengutronix.de, mchehab@kernel.org,
	p.zabel@pengutronix.de, tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	johan@kernel.org, elder@kernel.org, pure.logic@nexus-software.ie,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	kernel@pengutronix.de, kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz, marcelo.schmitt1@gmail.com,
	maudspierings@gocontroll.com, hverkuil+cisco@kernel.org,
	ribalda@chromium.org, straube.linux@gmail.com, lukagejak5@gmail.com,
	ethantidmore06@gmail.com, samasth.norway.ananda@oracle.com,
	karanja99erick@gmail.com, s9430939@naver.com, tglx@kernel.org,
	mingo@kernel.org, sun.jian.kdev@gmail.com, weibu@redadmin.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH 1/7] staging: greybus: simplify cleanup using __free
Message-ID: <2026031100-old-retry-ee2c@gregkh>
References: <20260310200513.2162018-1-sanjayembedded@gmail.com>
 <20260310200513.2162018-2-sanjayembedded@gmail.com>
 <abCIBPZzZBfMoOtm@ashevche-desk.local>
 <abEQ6HA0CGGCyV1B@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abEQ6HA0CGGCyV1B@stanley.mountain>

On Wed, Mar 11, 2026 at 09:51:20AM +0300, Dan Carpenter wrote:
> On Tue, Mar 10, 2026 at 11:07:16PM +0200, Andy Shevchenko wrote:
> > To complete this, one may add a prerequisite to use guard()() first.
> > 
> 
> I don't think we're encouraging people to re-write existing staging
> code to use cleanup.h magic...  It's unclear if I have to review these
> patches or if they're auto NAKed because we're not doing the conversions.

I've already rejected them, we don't want this type of changes in
staging at this point in time.

thanks,

greg k-h
