Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C76D35CBD0
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162630; cv=none; b=QVjx1Yy+5Cn2O6kBJB7mcVwJsVUoT2KBAjiNsE1kDxiy1+QsuQ4d2LhS4qtAn4V/hLobTnYIFS/yHwY3xWhxzMXSKHnEtxgcg6PNXpdtNhTZfw09oZxWLqdnBLxIzQVzfGHT9wlKlygtoU0pmwZCVlU80DY+P1fJ9IAxxYU/gd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162630; c=relaxed/simple;
	bh=9d3cVU+Sh2WWeMGTwT1O9VmL80KThVzljYfG9O63cQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArAmzeTMm5Xamvdb04iEZMYjQ6YvEKdi2VmSRpRcWqyNWLW+iVFySQwHkuwtOFC4Z0BKCUyc+YOmlN9AnpJR0QqJ2J3+8acEskJ94avpD85gU/OL9kSEuieKr3ZpzDugXXYxmMMbzP4sI7lEBqAwVPkWeq6LexKjuuTBiXn2QAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjE0x-0003Pg-3s; Fri, 23 Jan 2026 11:03:39 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjE0w-0024R8-33;
	Fri, 23 Jan 2026 11:03:38 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjE0w-00Atlx-0Y;
	Fri, 23 Jan 2026 11:03:38 +0100
Date: Fri, 23 Jan 2026 11:03:38 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 2/8] dt-bindings: iio: dac: maxim,ds4424: add
 maxim,rfs-ohms property
Message-ID: <aXNHeq9Fi1Ldf-oE@pengutronix.de>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
 <20260119182424.1660601-3-o.rempel@pengutronix.de>
 <20260119-turbine-feminize-9dcd5c86feec@spud>
 <20260123092819.6ae81211@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260123092819.6ae81211@jic23-huawei>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Fri, Jan 23, 2026 at 09:28:19AM +0000, Jonathan Cameron wrote:
> On Mon, 19 Jan 2026 18:27:52 +0000
> Conor Dooley <conor@kernel.org> wrote:
> 
> > On Mon, Jan 19, 2026 at 07:24:18PM +0100, Oleksij Rempel wrote:
> > > Introduce the 'maxim,rfs-ohms' property. The full-scale output current
> > > of these DACs is determined by external resistors (Rfs) connected to
> > > the FS pins. The driver requires the physical resistance values to
> > > calculate the correct current scale (Amps per step) for the IIO
> > > subsystem.
> > > 
> > > Keep it optional to avoid forcing updates of existing DTs; without it
> > > the driver cannot derive a correct IIO scale.  
> > 
> > I don't really follow the logic here, if the driver doesn't work
> > properly without it, shouldn't it be a required property even if that
> > means existing devicetrees get new warnings? Warnings are preferable to
> > the drivers malfunctioning on those devices, after all!
> 
> Agreed. The driver can paper over holes or I guess we could provide a default
> if the datasheet has some reference value or similar?  

No, this DAC controls the current. The current range is application specific and
defined by the load resistors. Is it better to not provide scale if this
information not available, guessing it will make things worse and
potentially damage some HW.

> DT binding should require it.

ACK
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
