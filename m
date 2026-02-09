Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9E32572F
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770628944; cv=none; b=AuMKD2RZ13L1cmbmfilvsi15lVO7BVYSAfENDYOtYATcxVWjVJoGCM+GaCdtyYSG0J3WeljZb7VKLPofJFN+c/cO4hiBO7mi1Pg8c5hYb+1Jt5QYefuIQWJb9ffTcdRUqPPwGepta1bbRUELbVjQ5YMwBOdGHU4w2KfRowRFjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770628944; c=relaxed/simple;
	bh=n96KU9K6YUR/wRdmmh2E3yaRwRADOX7fyp9o75Qe+wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRgD+8fn2ZD5PIR06RwaixyA0halUaqBQbItNNmeeOVnS54U/f9GWqgBpxC8d2mkKJ+CAwGftg0v37x+it52KkvdCJBgkne4rdtMQFCoYr53LZ+oOQLyBtFKYqGbwNGvW+Db+aVO0yz9VHX+RglI5gvBjvTgsPQA3WsDLSgBXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vpNTD-0006uU-0R; Mon, 09 Feb 2026 10:22:15 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vpNTC-004rpu-1D;
	Mon, 09 Feb 2026 10:22:13 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vpNTB-007xft-1t;
	Mon, 09 Feb 2026 10:22:13 +0100
Date: Mon, 9 Feb 2026 10:22:13 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 06/13] iio: dac: ds4424: use device match data for
 chip info
Message-ID: <aYmnRXp6ChsUAjnB@pengutronix.de>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-7-o.rempel@pengutronix.de>
 <aYHH69gXyuwmQR03@smile.fi.intel.com>
 <aYHLRvfJH54XumUA@pengutronix.de>
 <aYHhO7pJPEew7QMC@smile.fi.intel.com>
 <aYHjQhO92yxoy_9o@pengutronix.de>
 <aYIMgEEDd8ZfLv71@smile.fi.intel.com>
 <20260205204325.5bd09d97@jic23-huawei>
 <aYWe0-2KMLijFVh6@pengutronix.de>
 <aYW7lt26Tn-6Fgno@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYW7lt26Tn-6Fgno@smile.fi.intel.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Hi Andy,

On Fri, Feb 06, 2026 at 11:59:50AM +0200, Andy Shevchenko wrote:
> On Fri, Feb 06, 2026 at 08:57:07AM +0100, Oleksij Rempel wrote:
> > On Thu, Feb 05, 2026 at 08:43:25PM +0000, Jonathan Cameron wrote:
> > > On Tue, 3 Feb 2026 16:56:00 +0200
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> ...
> 
> > > > Just do not introduce that change (change of the ->name field) in the original
> > > > patch, in that case no revert churn would be needed.
> > > > 
> > > I think this got dealt with in discussion of next version but
> > > safest route is just have an extra copy of the name in the
> > > chip_info structure.  Then we know it's stable against different
> > > firmware types etc.
> > 
> > Something like this?
> 
> Yes, but make it in the patch that introduces DT support.

Hm, I'm not sure what do you mean. There is no patch which "introduces
DT support" in this series. Do you mean, this one:
https://lore.kernel.org/all/20260204140045.390677-7-o.rempel@pengutronix.de/

Or should it be better a separate patch?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
