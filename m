Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34838 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbJAXJn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Oct 2015 19:09:43 -0400
Received: by lbwr8 with SMTP id r8so17700142lbw.2
        for <linux-iio@vger.kernel.org>; Thu, 01 Oct 2015 16:09:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151001221609.GA3694@mwanda>
References: <20151001221609.GA3694@mwanda>
From: Crt Mori <cmo@melexis.com>
Date: Fri, 2 Oct 2015 01:09:02 +0200
Message-ID: <CAKv63usH0CoupUtoAsGjUXUojCJ9sCbK9cN85rz3SS8C0QUWLw@mail.gmail.com>
Subject: Re: iio: mlx90614: Implement filter configuration
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Dan Carpenter,
Thanks for checking. You found an error although not where checker pointed.
See explanation inline
On 2 October 2015 at 00:16, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Crt Mori,
>
> The patch 764589b688a1: "iio: mlx90614: Implement filter
> configuration" from Aug 17, 2015, leads to the following static
> checker warning:
>
>         drivers/iio/temperature/mlx90614.c:167 mlx90614_iir_search()
>         warn: this cast is a no-op
>
> drivers/iio/temperature/mlx90614.c
>    158          ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
>    159          if (ret > 0)
Here is the error: it should be if (ret < 0) . Do you want to send a
bugfix patch?
>    160                  return ret;
>    161
>    162          /* Write changed values */
>    163          ret = mlx90614_write_word(client, MLX90614_CONFIG,
>    164                          (i << MLX90614_CONFIG_IIR_SHIFT) |
>    165                          (((u16) ((0x7 << MLX90614_CONFIG_FIR_SHIFT) |
>    166                          ((u16) ret & (~((u16) MLX90614_CONFIG_FIR_MASK))))) &
>    167                          (~(u16) MLX90614_CONFIG_IIR_MASK)));
>
> Quite a few of these casts make no sense.  It's not clear what was
> intended.
>
>         (~(u16) MLX90614_CONFIG_IIR_MASK)
 (~((u16) MLX90614_CONFIG_IIR_MASK)) does not seem better, or it does? This was
intended (so to cast value to 16 bit, then negate it)
>
> So we take int 0x7 and cast it to u16, then because of type promotion
> we convert it to int and do a bitwise negate.  The static checker
> warning is because often that means (u16)~MLX90614_CONFIG_IIR_MASK is
> intended instead.  In this case it looks like we could just remove the
> cast with no harm done.
True, we could remove the cast, but I wanted to make sure that u16
data type is used
since ret and i are not that datatypes. Also macros in theory are not
u16 and I like doing
bitwise operations on known (equal) datatypes.
>
> But why are we ANDing it with "ret" which is a negative error code???
This is a bug which you found.
There should not be negative ret in this case because of above if
statement (line 160). There
should be a result of currently read CONFIG register in there and
because we need to set
two bits with two masks as well as maintain all other values unchanged
there is that bitwise operation.

In first part it shifts IIR value in position, then it shifts fixed
0x7 value in FIR position (since we
have put a fixed FIR value - see table in commit message), then it
applies negative FIR and IIR mask
to current register values so that other bits remain unchanged.
Because sensor offers also changes to
FIR, I would like to keep it this way in case someone decides he/she
needs to change FIR as well.

> I think there is some other typo here beyond the extra casts.
>
>    168          return ret;
Why is this a typo? Function does return negative value if write fails
so we should pass it back up.

>
> regards,
> dan carpenter
