Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43215 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755052Ab1LAVlu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Dec 2011 16:41:50 -0500
MIME-Version: 1.0
In-Reply-To: <20111126191137.GA1046@mail.gnudd.com>
References: <cover.1322328073.git.rubini@gnudd.com>
	<4ED12B50.9090206@metafoo.de>
	<20111126191137.GA1046@mail.gnudd.com>
Date: Thu, 1 Dec 2011 22:41:49 +0100
Message-ID: <CAKnu2MoHks06GzBG25tBG7JgEwMoeH6cOY95FbcHUq_sCm5LLg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Introducing ZIO, a new I/O framework
From: Linus Walleij <linus.walleij@linaro.org>
To: Alessandro Rubini <rubini@gnudd.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, greg@kroah.com,
	linux-kernel@vger.kernel.org, federico.vaga@gmail.com,
	dcobas@cern.ch, siglesia@cern.ch, manohar.vanga@cern.ch
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2011/11/26 Alessandro Rubini <rubini@gnudd.com>:

> I'm open to suggestions (_we_ are) about how to easily use IIO for
> output, for hardware timestamps (we have 3 32-bit fields) and for very
> large data blocks, with DMA to/from user space -- sure we don't have this
> last point in ZIO at this point in time.

The latter seem like a case for the dma-buf mechanism.
http://lwn.net/Articles/462524/

(Interesting hardware you found Alessandro! :)

Yours,
Linus Walleij
