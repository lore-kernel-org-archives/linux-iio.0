Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:38685 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbaDXIaL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Apr 2014 04:30:11 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so2243949obc.36
        for <linux-iio@vger.kernel.org>; Thu, 24 Apr 2014 01:30:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53582EF3.2040307@kernel.org>
References: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>
	<1397416143-4396-2-git-send-email-linus.walleij@linaro.org>
	<53582EF3.2040307@kernel.org>
Date: Thu, 24 Apr 2014 10:30:10 +0200
Message-ID: <CACRpkda1tZNF6gGo+HMaYmKnzuRHBMz6PRVeN+K5m8JessOrqw@mail.gmail.com>
Subject: Re: [PATCH 1/6] iio: st_sensors: announce registered sensors
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 23, 2014 at 11:21 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 13/04/14 20:08, Linus Walleij wrote:
>>
>> It is pretty helpful to know already from dmesg that a certain
>> device is successfully registered, instead of having to browse
>> sysfs to see if it's actually there.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Denis CIOCCA <denis.ciocca@st.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
>
> hmm.. Normally I get irritated with these sorts of I'm here
> messages - it's not exactly hard to tell it has been successfully
> probed without filling the logs with messages fairly light on
> info.  Having said that I tend to let these go in new drivers
> so I don't care that strongly...

Your pick, this patch is orthogonal to the rest.

I tend to stick a oneliner at the end of successful probe
to verify that the device driver has been compiled in and
that it probes correctly so that the device tree etc is in
order. Of course there are other ways to determine that
but the dmesg give it all in one place for all devices.

Yours,
Linus Walleij
