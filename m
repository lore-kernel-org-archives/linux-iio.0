Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:60371 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab2LKIhP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Dec 2012 03:37:15 -0500
Message-ID: <20678.60523.170336.920677@ipc1.ka-ro>
Date: Tue, 11 Dec 2012 09:18:51 +0100
From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Marek Vasut <marex@denx.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org,
	"linux-input\@vger.kernel.org" <linux-input@vger.kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 3/4] iio: mxs: Implement support for touchscreen
In-Reply-To: <20121210222437.GA19008@core.coreip.homeip.net>
References: <1354893893-26338-1-git-send-email-marex@denx.de>
	<1354893893-26338-3-git-send-email-marex@denx.de>
	<50C312D8.4050405@kernel.org>
	<20121210222437.GA19008@core.coreip.homeip.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Dmitry Torokhov writes:
> Hi Marek, Jonathan,
> 
> On Sat, Dec 08, 2012 at 10:13:44AM +0000, Jonathan Cameron wrote:
> > On 12/07/2012 03:24 PM, Marek Vasut wrote:
[...]
> > > +	int			use_touchbutton:1;
> 
> Why would someone not want to use it?
> 
> > > +	int			use_touchscreen_4wire:1;
> > > +	int			use_touchscreen_5wire:1;
> 
bit fields should be of unsigned type, because otherwise the 'true'
value will be '-1' rather than '1'.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
