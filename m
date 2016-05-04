Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36390 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbcEDOed (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:34:33 -0400
Received: by mail-oi0-f47.google.com with SMTP id x201so67210879oif.3
        for <linux-iio@vger.kernel.org>; Wed, 04 May 2016 07:34:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4e983a0c-88f9-b5bf-3439-15f006736a7d@kernel.org>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
	<1458825486-17188-3-git-send-email-linus.walleij@linaro.org>
	<5728E6C2.1050901@gmail.com>
	<CACRpkdaLc8frud64VZEuQ=dXGpgk+kBj94otoCCC=-Pvoe09tw@mail.gmail.com>
	<4e983a0c-88f9-b5bf-3439-15f006736a7d@kernel.org>
Date: Wed, 4 May 2016 16:34:31 +0200
Message-ID: <CACRpkdas0XhPJWXd-HnYEOM4KALk23v_XnkZhkcsdzBjvHewsw@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: st_sensors: verify interrupt event to status
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Crestez Dan Leonard <cdleonard@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 4, 2016 at 9:35 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 03/05/16 21:10, Linus Walleij wrote:

>>> Even with hardware triggers: are you sure this is correct? Shouldn't
>>> iio_trigger_notify_done still get called even when there is nothing to do?
>>
>> No then the (hardware) IRQ can have come in from some other
>> device sharing the line with the peripheral and we need to return
>> IRQ_NONE. It's not our interrupt.
>
> Gah, I fouled up reviewing this.  We really need to know if it is our
> trigger 'before' we fire off the trigger logic - any number of other
> devices can in theory be hanging off a given trigger - none of them will
> be able to know if it was a real trigger or not.

Ooops sorry, but the good thing is: we get to properly fix it.

> What we need to do is work out how to elegantly fall back to
> not running top halves of triggers if we are coming from threaded
> context.

I'm looking into this.

Pretty complex, but certainly doable. As we're not even in the
merge window yet I bet we can cook up a proper solution instead
of dirty hacks.

Yours,
Linus Walleij
