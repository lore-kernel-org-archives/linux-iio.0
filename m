Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34483 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbcEXIps (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 May 2016 04:45:48 -0400
Received: by mail-oi0-f42.google.com with SMTP id b65so15691907oia.1
        for <linux-iio@vger.kernel.org>; Tue, 24 May 2016 01:45:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <71875CD9-27C6-4DC5-9F78-F9486DF12612@jic23.retrosnub.co.uk>
References: <1463945969-18866-1-git-send-email-jic23@kernel.org>
	<CACRpkdYBueNxSa60EfTWsX7Surmvee8V0Qbgn+CrsA_joMmxQg@mail.gmail.com>
	<5c264bf8b6206f0ce4f581607336d6de@jic23.retrosnub.co.uk>
	<71875CD9-27C6-4DC5-9F78-F9486DF12612@jic23.retrosnub.co.uk>
Date: Tue, 24 May 2016 10:45:47 +0200
Message-ID: <CACRpkdZsqKcrQKUhY7U-VkZodUbNo8BoaesFMHvLcYTAGGDLcw@mail.gmail.com>
Subject: Re: [RFC] iio: accel: st_accel: Add lis3l02dq support
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio-owner@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 23, 2016 at 6:29 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:

> I forgot this part also has gain and offset trim registers.  Will add them before
>  applying as that is easy enough and reduces the differences further.
>
> These exist on some other parts but we can add them any time.

LIS3LV02DL also has x,y,z offset and gain trim registers, but when
I read up on it, I understood that these are just factory-programmed
registers. I.e. they are undocumented in the register list, but a table
states them as "calibration" and "loaded at boot".

So I always understood them as something the sensor loads at
boot to calibrate itself, so you can ignore the contents, and they
probably exist on the other sensors too, albeit undocumented as
they have no use.

I toyed with the idea of reading them and pusing the values to the
entropy pool with add_device_randomness() as they are device-unique
data.

But if you have proper docs on them I guess maybe they are used
differently on your sensor...

Yours,
Linus Walleij
