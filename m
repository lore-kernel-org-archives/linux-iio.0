Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:35327 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab3GSRVo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Jul 2013 13:21:44 -0400
Message-ID: <51E975A7.2050400@free-electrons.com>
Date: Fri, 19 Jul 2013 19:21:43 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
To: Hector Palacios <hector.palacios@digi.com>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, marex@denx.de,
	jic23@kernel.org, lars@metafoo.de, fabio.estevam@freescale.com
Subject: Re: [PATCH v2 5/5] iio: mxs-lradc: add write_raw function to modify
 scale
References: <1374225208-28940-1-git-send-email-hector.palacios@digi.com> <1374225208-28940-6-git-send-email-hector.palacios@digi.com>
In-Reply-To: <1374225208-28940-6-git-send-email-hector.palacios@digi.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/07/2013 11:13, Hector Palacios wrote:
> Added write_raw function to manipulate the optional divider_by_two
> through the scaling attribute out of the available scales.
>
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>

Looks good to me:
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>



-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

