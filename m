Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:55862 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933129Ab3CMSYB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Mar 2013 14:24:01 -0400
Received: by mail-la0-f45.google.com with SMTP id er20so1514365lab.32
        for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2013 11:23:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5140C155.2070507@metafoo.de>
References: <1362625743-10401-1-git-send-email-ch.naveen@samsung.com>
	<1363150138-20819-1-git-send-email-ch.naveen@samsung.com>
	<CAD=FV=XoE6NCruDUv2UajaP+LWDCp+pgaZJsEKpkoxy3tZNeAw@mail.gmail.com>
	<5140C155.2070507@metafoo.de>
Date: Wed, 13 Mar 2013 11:23:59 -0700
Message-ID: <CAD=FV=XZMDrhQm+tZKL1RW35ZiT-JuDpmdGUXB9A6e9fG+54Fw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adc: exynos5_adc: fix compilation warnings
From: Doug Anderson <dianders@chromium.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	linux-iio <linux-iio@vger.kernel.org>, dan.carpenter@oracle.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Naveen Krishna <naveenkrishna.ch@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars,

On Wed, Mar 13, 2013 at 11:11 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Agreed. Adding the dependency on OF in Kconfig should be all that is needed.

I think changing the timeout from 'unsigned long' to 'long' is also
legit (to match the actual type returned) and a good idea.

-Doug
