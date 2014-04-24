Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:45770 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbaDXIdg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Apr 2014 04:33:36 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so2303787oag.3
        for <linux-iio@vger.kernel.org>; Thu, 24 Apr 2014 01:33:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53582E4C.3060800@kernel.org>
References: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>
	<1397416143-4396-6-git-send-email-linus.walleij@linaro.org>
	<53582E4C.3060800@kernel.org>
Date: Thu, 24 Apr 2014 10:33:35 +0200
Message-ID: <CACRpkdbmS39HL4Z8CSbtPtkWYqZn6hNCMdwzk+1fepKkSUAO1A@mail.gmail.com>
Subject: Re: [PATCH 5/6] iio: st_sensors: add devicetree probing support
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 23, 2014 at 11:19 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> I can't make up my mind whether I like this or not.
> Having said that it fixes an ABI compatibility issue that I couldn't
> see a way around so nicely done.

Lots of redundant strings is device trees second name.

> (note I'll leave this set be for now given the device tree element
> and that it hasn't been 3 weeks yet)

I'll respin the patch anyway, the OF compatible table should
be in the core file rather than the .h file. I try to keep it in common
code so I2C and SPI alike be able to use the same table
atleast.

Yours,
Linus Walleij
