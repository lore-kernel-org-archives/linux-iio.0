Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:39197
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751864AbaBXCJh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 Feb 2014 21:09:37 -0500
Received: from mail106-co9 (localhost [127.0.0.1])	by
 mail106-co9-R.bigfish.com (Postfix) with ESMTP id C9BFA2004F1	for
 <linux-iio@vger.kernel.org>; Mon, 24 Feb 2014 02:09:36 +0000 (UTC)
Date: Mon, 24 Feb 2014 10:09:55 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Fugang Duan <B38611@freescale.com>
CC: <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 1/1] ARM: dts: vf610-twr: Add ADC support
Message-ID: <20140224020953.GB25011@S2101-09.ap.freescale.net>
References: <1392960256-23561-1-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1392960256-23561-1-git-send-email-B38611@freescale.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 21, 2014 at 01:24:16PM +0800, Fugang Duan wrote:
> vf610 has two ADC controllers, and vf610-twr board ADC0_SE5 pin connect
> to sliding rheostat for ADC test, other ADC pins connect to connectors for
> future use.
> 
> Add support for ADC0_SE5.
> 
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: Jonathan Cameron <jic23@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Otavio Salvador <otavio@ossystems.com.br>
> CC: Peter Meerwald <pmeerw@pmeerw.net>
> CC: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Fugang Duan <B38611@freescale.com>

Applied, thanks.

