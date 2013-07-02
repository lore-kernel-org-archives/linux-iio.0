Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:34842 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab3GBDiQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jul 2013 23:38:16 -0400
Received: by mail-oa0-f49.google.com with SMTP id n9so5746222oag.22
        for <linux-iio@vger.kernel.org>; Mon, 01 Jul 2013 20:38:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372723722-13902-1-git-send-email-marex@denx.de>
References: <1372723722-13902-1-git-send-email-marex@denx.de>
Date: Tue, 2 Jul 2013 00:38:15 -0300
Message-ID: <CAP9ODKr6MGYKKRZm7prGRQhPXpfuEimOmrgUucraCfF_7SPTEA@mail.gmail.com>
Subject: Re: [PATCH] iio: mxs-lradc: Remove useless check in read_raw
From: Otavio Salvador <otavio@ossystems.com.br>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 1, 2013 at 9:08 PM, Marek Vasut <marex@denx.de> wrote:
> The removed check in the read_raw implementation was always true,
> therefore remove it.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>

This fixes the driver for MX23 but why this code were add at first?

--
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://projetos.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
