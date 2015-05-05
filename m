Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36707 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbbEEMWn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 May 2015 08:22:43 -0400
Received: by oift201 with SMTP id t201so144908104oif.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2015 05:22:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5547A0D5.3000006@kernel.org>
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
	<1430399755-26475-6-git-send-email-linus.walleij@linaro.org>
	<alpine.DEB.2.02.1504301637070.4190@pmeerw.net>
	<CACRpkdacUZfKkQz0XfXm4cqU+8B5TR8ZqJhXVzCTMcU+1EB2mA@mail.gmail.com>
	<5547A0D5.3000006@kernel.org>
Date: Tue, 5 May 2015 14:22:42 +0200
Message-ID: <CACRpkdZu9SF8XdQnCkHDMNX-J=nB9hdE1SBEspoStDzpCDyOPA@mail.gmail.com>
Subject: Re: [PATCH 06/10] iio: st_accel: support 8bit channel data
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 4, 2015 at 6:39 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> The generic_buffer.c
> test app (now under tools/iio) should do the job for testing
> this. The purpose of that one is to act as an example
> of the chardev (buffered) interface and as documentation
> as the docs always got out of date when we kept them seperately.
> (yeah I'm lazy).

Aha and that test app like iio_event_monitor needs proper
device creation in /dev/iio:device0 etc ...

And then I notice that busybox' mdev doesn't really auto-create
devices for anything else than what appears below
/sys/class/*, /sys/bus/* is not scanned for device, yippie-ay.

I guess you have udev for creating your devices on test
systems and a full distro-type userspace?

I wonder how people solve this for IIO on stripped-down
systems, static devices?

Is mdev even doing the right thing by just looking under
/sys/class?

I'm so confused by this, sorry Jonathan just airing some
frustration :/

Yours,
Linus Walleij
