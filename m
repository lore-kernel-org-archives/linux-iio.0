Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36328 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbcE3IR1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 May 2016 04:17:27 -0400
Received: by mail-oi0-f50.google.com with SMTP id j1so259057826oih.3
        for <linux-iio@vger.kernel.org>; Mon, 30 May 2016 01:17:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <453dba90-156c-1193-4cac-41da39e16938@kernel.org>
References: <cover.1461056711.git.gregor.boirie@parrot.com>
	<c9eb30c178e4643be23bcd09ca706b08ee69d04b.1461056711.git.gregor.boirie@parrot.com>
	<453dba90-156c-1193-4cac-41da39e16938@kernel.org>
Date: Mon, 30 May 2016 10:17:26 +0200
Message-ID: <CACRpkdbBj_VcojG8S8Z2wN6utojJVtMQzfAwUTbGP7zwBaQYAw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/9] iio:st_pressure: fix sampling gains
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, May 29, 2016 at 5:14 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> Personally I'm really beginning to
> dislike the way these drivers have simple numeric values
> wrapped up in defines at the top.  Would be somewhat clearer
> if they were just inline.

I agree, I never liked it either, just kept with it since the old
code looked like that.

Do you want gigantic patches fixing it for all sensor types?

Yours,
Linus Walleij
