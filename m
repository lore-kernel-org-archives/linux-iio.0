Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:35276 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab3GSRKY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Jul 2013 13:10:24 -0400
Message-ID: <51E972FE.6060402@free-electrons.com>
Date: Fri, 19 Jul 2013 19:10:22 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
To: Hector Palacios <hector.palacios@digi.com>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, marex@denx.de,
	jic23@kernel.org, lars@metafoo.de, fabio.estevam@freescale.com
Subject: Re: [PATCH v2 2/5] ARM: dts: add reference voltage property for MXS
 LRADC
References: <1374225208-28940-1-git-send-email-hector.palacios@digi.com> <1374225208-28940-3-git-send-email-hector.palacios@digi.com>
In-Reply-To: <1374225208-28940-3-git-send-email-hector.palacios@digi.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/07/2013 11:13, Hector Palacios wrote:
> Some LRADC channels have fixed pre-dividers so they can measure
> different voltages at full scale. The reference voltage allows to
> expose a scaling attribute through the IIO sysfs so that a user can
> compute the real voltage out of a measured sample value.
>
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>



-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

