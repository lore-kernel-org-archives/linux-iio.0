Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34577 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbcF0If2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2016 04:35:28 -0400
Received: by mail-oi0-f49.google.com with SMTP id s66so191221799oif.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2016 01:35:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5ecdf1d9-67ef-2266-4ba5-6da8dd15bcd7@kernel.org>
References: <1466427214-13372-1-git-send-email-broonie@kernel.org>
 <1466427214-13372-3-git-send-email-broonie@kernel.org> <5ecdf1d9-67ef-2266-4ba5-6da8dd15bcd7@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Jun 2016 10:35:26 +0200
Message-ID: <CACRpkda7THimiyWAgVzg+fSQLx83vAn5agW3Gsp_s97bPvwRqw@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio:ad7266: Fix probe deferral for vref
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jun 26, 2016 at 6:41 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> I dread to think how many other missuses we have of these interfaces
> in the tree...

I have agreed with Mark to take a sweep with the broomstick
across IIO and make sure we get this right everywhere here.

Yours,
Linus Walleij
