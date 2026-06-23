Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC130D3E7;
	Tue, 23 Jun 2026 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192038; cv=none; b=rCzvXlXf0ivtGMt5QxrlB82qBkyYTlZiZobSaOwBO2Hjzzlta6m06tI2+E+Fv6+XvlgGOz8s5xskVJhM7E1lxKbDMBlRSYyqUWiLKeYh80LhqvSHzNSoIacf8mUSDjrbXBRZjzqprhw7SpmIKlKNw4yd7TXG5MbgEcfdxgnudqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192038; c=relaxed/simple;
	bh=ucKhV3qPR3R10cLFSr0rdXW/SyGDGnKTpCdgWQ0IsSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJGZx8IED6xadSLGoUiylFIe4VHalpsg6y83e0BgnHgqskWQuQb5GhcEfpzXAArn3Su1eyNOJblFl2ATFJvJguTmPxJvz0GxvIElSJHOmYKTCABEunwpCxZTEWmTsn0q8WDLLIn/eYjxkwpDxxS31Px6Mw+aZ8+o1HVNUcU2Z9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8BB36200792;
	Tue, 23 Jun 2026 07:20:33 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wbtYn-004Cej-1U;
	Tue, 23 Jun 2026 07:20:33 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wbtYn-000000088NI-1TH6;
	Tue, 23 Jun 2026 07:20:33 +0200
Date: Tue, 23 Jun 2026 07:20:33 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, krzk+dt@kernel.org
Subject: Re: [PATCH v5 2/3] counter: add GPIO-based counter driver
Message-ID: <ajoXoYc1CYKZyQ5l@pengutronix.de>
References: <20260524193846.19216-3-wafgo01@gmail.com>
 <20260617074929.333876-1-wbg@kernel.org>
 <20260622205210.10317-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260622205210.10317-1-wafgo01@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi,

On Mon, Jun 22, 2026 at 10:51:40PM +0200, Wadim Mueller wrote:
> On Wed, 17 Jun 2026 16:49:25 +0900
> William Breathitt Gray <wbg@kernel.org> wrote:
> 
> Hi William,
> 
> thanks for the review. Three things before I spin v6.
> 
> > One change I consider is whether to make Signal B optional. [...]
> > I wonder whether this is substantially different enough from
> > simply using the interrupt-cnt module on the respective IRQ?
> > I'm CCing Oleksij and the Pengutronix team in case they wish to
> > comment.
>
> I want to keep signal-b mandatory in v6 (if no concerns from Oleksij).
> The single-line case is already covered by interrupt-cnt.
 
Hm, I have nothing against extending the existing driver.
If you wont to enforce and validate multi line concept, additional
compatible will be needed. May be interrupt-counter-multiline ?

Please add separate interrupt handler, interrupt_cnt_isr is already
"over optimized". Adding more code to this hot path, will break existing
configurations.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
