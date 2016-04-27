Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35487 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbcD0L0j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Apr 2016 07:26:39 -0400
Received: by mail-oi0-f45.google.com with SMTP id x19so45363058oix.2
        for <linux-iio@vger.kernel.org>; Wed, 27 Apr 2016 04:26:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1461056711.git.gregor.boirie@parrot.com>
References: <cover.1461056711.git.gregor.boirie@parrot.com>
Date: Wed, 27 Apr 2016 13:26:38 +0200
Message-ID: <CACRpkdZxE4Z6f_0uVV0sD5EUxEigzbMvWRD+MTDWNZbuauVweg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/9] iio:st_sensors: fixes and lps22hb pressure sensor
From: Linus Walleij <linus.walleij@linaro.org>
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Apr 19, 2016 at 11:18 AM, Gregor Boirie
<gregor.boirie@parrot.com> wrote:

> This preliminary patch series adds support for a new ST LPS22HB pressure sensor
> and introduce a few fixes related to st_pressure core and st_sensors triggered
> buffering.

Very cool.

> Patch 2 makes st_pressure sensors compliant with ABI and fixes a few missing
> sampling gains. Scale / offset computation is modified to address all gains
> currently possible. It impacts LPS331AP, LPS001WP and LPS25H sensors.
> Please please please ! If anyone owning one of these could run some tests, I'd
> be glad to get some feedback since I have none of them.

I applied all nine patches and tested with the LPS001WP on the
Ux500.

Before the patch:

$ cat in_pressure_raw && cat in_temp_raw
15217
1763
$ cat in_pressure_raw && cat in_temp_raw
15217
1762
$ cat in_pressure_raw && cat in_temp_raw
15215
1763

After the patch:

$ cat in_pressure_raw && cat in_temp_raw
15232
1652
$ cat in_pressure_raw && cat in_temp_raw
15233
1656
$ cat in_pressure_raw && cat in_temp_raw
15234
1657

Looks reasonable.

For the series:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

BTW: I cannot use buffered interval sampling using generic_buffer
with triggerless sensors like this one, I suspect that is totally possible
to fix, I just never got around to look into it :(

I'll look at the individual patches too, but I suspect Jonathan already
gave good feedback on them.

Yours,
Linus Walleij
