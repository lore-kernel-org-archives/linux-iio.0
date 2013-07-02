Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:62079 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab3GBLxu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 07:53:50 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so12005688ieb.16
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2013 04:53:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51D2BCE5.8060602@free-electrons.com>
References: <1372723722-13902-1-git-send-email-marex@denx.de>
	<51D2BCE5.8060602@free-electrons.com>
Date: Tue, 2 Jul 2013 08:53:49 -0300
Message-ID: <CAP9ODKqr_zfzA0QqB63evMJfBGvR8AYWK38Ro29a1hHt5abZ+A@mail.gmail.com>
Subject: Re: [PATCH] iio: mxs-lradc: Remove useless check in read_raw
From: Otavio Salvador <otavio@ossystems.com.br>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 2, 2013 at 8:43 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> I don't seem to be hitting that issue. I'm using 3.10rc7. Do you know
> how to reproduce it ?

I had this, but in MX23.

It seems like a race as if I put some prints in this code area it
works sometimes.

--
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://projetos.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
