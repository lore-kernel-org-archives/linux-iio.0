Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38617 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308AbbCBVSY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Mar 2015 16:18:24 -0500
Received: by iecrd18 with SMTP id rd18so51654001iec.5
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2015 13:18:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1425329766-14703-2-git-send-email-harald@ccbib.org>
References: <1425329766-14703-1-git-send-email-harald@ccbib.org>
	<1425329766-14703-2-git-send-email-harald@ccbib.org>
Date: Mon, 2 Mar 2015 13:18:24 -0800
Message-ID: <CALAqxLUzvnSqVrbqMgoV33kP4Attg-vM8Ziu2Ztx5CGQ4gDP1Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] timekeeping: Provide new API to get the current time resolution
From: John Stultz <john.stultz@linaro.org>
To: Harald Geyer <harald@ccbib.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 2, 2015 at 12:56 PM, Harald Geyer <harald@ccbib.org> wrote:
> This has been tested on i386, sunxi and mxs.

So the patch needs to have the actual rational for inclusion here, not
in the cover-letter, since the cover-letter gets thrown away.


>
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
>  include/linux/timekeeping.h |    1 +
>  kernel/time/timekeeping.c   |   18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> index 3eaae47..983b61e 100644
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -163,6 +163,7 @@ extern ktime_t ktime_get(void);
>  extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
>  extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
>  extern ktime_t ktime_get_raw(void);
> +extern u32 ktime_get_resolution_ns(void);
>
>  /**
>   * ktime_get_real - get the real (wall-) time in ktime_t format
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 91db941..b823eba 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -586,6 +586,24 @@ ktime_t ktime_get(void)
>  }
>  EXPORT_SYMBOL_GPL(ktime_get);
>
> +u32 ktime_get_resolution_ns(void)
> +{
> +       struct timekeeper *tk = &tk_core.timekeeper;
> +       unsigned int seq;
> +       u32 nsecs;
> +
> +       WARN_ON(timekeeping_suspended);
> +
> +       do {
> +               seq = read_seqcount_begin(&tk_core.seq);
> +               nsecs = tk->tkr.mult >> tk->tkr.shift;
> +       } while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +       return nsecs;
> +}
> +
> +EXPORT_SYMBOL_GPL(ktime_get_resolution_ns);
> +

So is this always going to be an internal-only interface? I know in
the past folks have wanted clock_getres() to return similar hardware
granular resolution, but Thomas has pushed back against this due to
the fact that the resolution could fluctuate during the lifetime of a
system and there's no way to correlate a resolution returned from
clock_getres and a a value returns from clock_gettime.

So while for internal purposes, we could probably support something
like this, we really do need to make sure we're not exposing uselessly
racy interfaces to userland.

thanks
-john
