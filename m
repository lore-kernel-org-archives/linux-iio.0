Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49107 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3AVNCk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jan 2013 08:02:40 -0500
Message-ID: <50FE8DED.70806@kernel.org>
Date: Tue, 22 Jan 2013 13:02:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Shawn Guo <shawn.guo@linaro.org>
CC: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 2/2] ARM: mxs: Add OF props for MX23 LRADC
References: <1358798722-25102-1-git-send-email-marex@denx.de> <1358798722-25102-2-git-send-email-marex@denx.de> <50FE80D3.1020104@kernel.org> <20130122124144.GA2812@S2101-09.ap.freescale.net>
In-Reply-To: <20130122124144.GA2812@S2101-09.ap.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/22/2013 12:41 PM, Shawn Guo wrote:
> On Tue, Jan 22, 2013 at 12:06:43PM +0000, Jonathan Cameron wrote:
>> On 01/21/2013 08:05 PM, Marek Vasut wrote:
>>> Add interrupt mapping and compatible string for MX23 LRADC.
>>
>> Series looks fine to me, but obviously I'd like an ACK for this one
>> from Shawn before taking it.
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
Thanks,

both added to togreg branch of iio.git
