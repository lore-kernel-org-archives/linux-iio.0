Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34919 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbcEaOn5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 31 May 2016 10:43:57 -0400
Received: by mail-lf0-f68.google.com with SMTP id q63so7686157lfi.2
        for <linux-iio@vger.kernel.org>; Tue, 31 May 2016 07:43:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1457294576-10121-1-git-send-email-jic23@kernel.org>
References: <1457294576-10121-1-git-send-email-jic23@kernel.org>
Date: Tue, 31 May 2016 17:43:54 +0300
Message-ID: <CAEnQRZCQsoXB-D+sJpcN0W1naXzMLq5gp+WYZ51vut7OhM3NCw@mail.gmail.com>
Subject: Re: [RFC PATCH V2] iio:trigger: Experimental kthread tight loop
 trigger (thread only)
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 6, 2016 at 10:02 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> This patch is in response to that of
> Gregor Boirie <gregor.boirie@parrot.com>
> who proposed using a tight kthread within a device driver (be it with the
> support factored out into a helper library) in order to basically spin as
> fast as possible.
>
> It is meant as a talking point rather than a formal proposal of the code
> (though we are heading towards that I think).
> Also gives people some working code to mess around with.
>
> I proposed that this could be done with a trigger with a few constraints
> and this is the proof (be it ugly) of that.
>
> There are some constraints though, some of which we would want to relax
> if this were to move forward.
>
> * Will only run the thread part of the registered pollfunc.  This is to
>   avoid the overhead of jumping in and out of interrupt context.  Is the
>   overhead significant?  Not certain but feels like it should be!
>
> * This limitation precludes any device that 'must' do some work in
>   interrupt context.  However, that is true of few if any drivers and
>   I suspect that any that do will be restricted to using triggers they
>   provide themselves.  Usually we have a top half mainly to grab a
>   timestamp as soon after the dataready type signal as possible.
>

Configfs part looks good to me.

What happens with iio_loop_thread when changing the current trigger?
I'm not sure how it will be stopped.

thanks,
Daniel.
