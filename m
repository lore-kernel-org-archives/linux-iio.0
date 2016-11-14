Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34778 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbcKNMZg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2016 07:25:36 -0500
Received: by mail-qt0-f178.google.com with SMTP id n6so45999283qtd.1
        for <linux-iio@vger.kernel.org>; Mon, 14 Nov 2016 04:25:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3761c454-10e5-ba26-bee3-2cc4df5025e0@kernel.org>
References: <1478773133-23034-1-git-send-email-linus.walleij@linaro.org> <3761c454-10e5-ba26-bee3-2cc4df5025e0@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 Nov 2016 13:25:35 +0100
Message-ID: <CACRpkdb7T3jm93AeTyg+c6to+8DStKw_DEC56_L9JAYcST8KpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: st_sensors: centralize I2C probe() code
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 12, 2016 at 5:11 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> Also wondering why we ended up with the divide between generic
> and specific where it was rather than as you have it here.
> oh well.  Made sense at the time I guess ;)

This is not even all of it. There is still a bunch of code
duplicated in all the subdrivers, but I'll try to collect it up
and centralize it better.

Yours,
Linus Walleij
