Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36754 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756417AbcBDAhd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Feb 2016 19:37:33 -0500
Received: by mail-lf0-f44.google.com with SMTP id 78so25753193lfy.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Feb 2016 16:37:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454527777-16565-1-git-send-email-ek9852@Gmail.com>
References: <1454527777-16565-1-git-send-email-ek9852@Gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Wed, 3 Feb 2016 16:36:52 -0800
Message-ID: <CAKzfze-+mu7f0myNAcgwMDtfVpXbPJTE4jgQcSX0nNs4vH7RWQ@mail.gmail.com>
Subject: Re: [PATCH] iio: use boot time instead of realtime
To: Keith Mok <ek9852@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Seems like doing a blanket change like this would break a lot of
drivers since it changes the core ABI

On Wed, Feb 3, 2016 at 11:29 AM, Keith Mok <ek9852@gmail.com> wrote:
> From: Keith Mok <ek9852@gmail.com>
>
> Advanced sensor has fifo/ring buffer internally,
> they can store data when the system is suspend,
> we need a timestamp that is able to take into
> account of the time when the system is suspend also.
>
> Signed-off-by: Keith Mok <ek9852@gmail.com>
> ---
>  include/linux/iio/iio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index b589411..7092877 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -286,7 +286,7 @@ static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
>   **/
>  static inline s64 iio_get_time_ns(void)
>  {
> -       return ktime_get_real_ns();
> +       return ktime_get_boot_ns();
>  }
>
>  /* Device operating modes */
> --
> 2.5.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
