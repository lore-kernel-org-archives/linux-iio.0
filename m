Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36525 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbcEJIRW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 May 2016 04:17:22 -0400
Received: by mail-ob0-f170.google.com with SMTP id aq1so2547233obc.3
        for <linux-iio@vger.kernel.org>; Tue, 10 May 2016 01:17:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d76ecc9c-a6a9-59c9-afd9-8f0ae9eb0dff@intel.com>
References: <1462805775-7723-1-git-send-email-linus.walleij@linaro.org>
	<1462805775-7723-2-git-send-email-linus.walleij@linaro.org>
	<d76ecc9c-a6a9-59c9-afd9-8f0ae9eb0dff@intel.com>
Date: Tue, 10 May 2016 10:17:21 +0200
Message-ID: <CACRpkdYYyzvkAdiV7kVr58S7dWa64fc28jMTDxhOJtgVK8fQDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: st_sensors: read surplus samples in trigger
From: Linus Walleij <linus.walleij@linaro.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 9, 2016 at 8:36 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:
> On 05/09/2016 05:56 PM, Linus Walleij wrote:

> I also tested this and it no longer stops printing samples. Your
> explanation also looks good to me.

OK we are moving in the right direction then!

> An infinite loop in the threaded interrupt handler looks odd. Are you
> sure this is allowed? I do my tests in qemu with an usb adapter and if I
> run with -smp 1 it seems to be impossible to stop the irq thread.

I will put in a limit to 10 as Jonathan recommended, let's see
if that fixes your problem! It's a sound limitation anyway.

Yours,
Linus Walleij
