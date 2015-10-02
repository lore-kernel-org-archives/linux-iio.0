Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:34777 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbbJBIMn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Oct 2015 04:12:43 -0400
Received: by labzv5 with SMTP id zv5so88681947lab.1
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2015 01:12:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151002070006.GI7289@mwanda>
References: <20151001221609.GA3694@mwanda> <CAKv63usH0CoupUtoAsGjUXUojCJ9sCbK9cN85rz3SS8C0QUWLw@mail.gmail.com>
 <20151002070006.GI7289@mwanda>
From: Crt Mori <cmo@melexis.com>
Date: Fri, 2 Oct 2015 10:12:01 +0200
Message-ID: <CAKv63uuxuKJ5QY_jpxVe895+AMhyxWWrCWim6BgeB8kLsoNB-A@mail.gmail.com>
Subject: Re: iio: mlx90614: Implement filter configuration
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2 October 2015 at 09:00, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Thu, Oct 01, 2015 at 04:09:02PM -0700, Crt Mori wrote:
>> Hello Dan Carpenter,
>> Thanks for checking. You found an error although not where checker pointed.
>> See explanation inline
>> On 2 October 2015 at 00:16, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> > Hello Crt Mori,
>> >
>> > The patch 764589b688a1: "iio: mlx90614: Implement filter
>> > configuration" from Aug 17, 2015, leads to the following static
>> > checker warning:
>> >
>> >         drivers/iio/temperature/mlx90614.c:167 mlx90614_iir_search()
>> >         warn: this cast is a no-op
>> >
>> > drivers/iio/temperature/mlx90614.c
>> >    158          ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
>> >    159          if (ret > 0)
>> Here is the error: it should be if (ret < 0) . Do you want to send a
>> bugfix patch?
>
> Nah.  Just give me a reported-by tag, please.
>

OK, will prepare bugfix in few hours.

>> >    160                  return ret;
>> >    161
>> >    162          /* Write changed values */
>> >    163          ret = mlx90614_write_word(client, MLX90614_CONFIG,
>> >    164                          (i << MLX90614_CONFIG_IIR_SHIFT) |
>> >    165                          (((u16) ((0x7 << MLX90614_CONFIG_FIR_SHIFT) |
>> >    166                          ((u16) ret & (~((u16) MLX90614_CONFIG_FIR_MASK))))) &
>> >    167                          (~(u16) MLX90614_CONFIG_IIR_MASK)));
>> >
>> > Quite a few of these casts make no sense.  It's not clear what was
>> > intended.
>> >
>> >         (~(u16) MLX90614_CONFIG_IIR_MASK)
>>  (~((u16) MLX90614_CONFIG_IIR_MASK)) does not seem better, or it does? This was
>> intended (so to cast value to 16 bit, then negate it)
>
> Because of type promotion what actually happens is we cast it to u16
> then we cast it to int then we negate it.
>
>> >
>> > So we take int 0x7 and cast it to u16, then because of type promotion
>> > we convert it to int and do a bitwise negate.  The static checker
>> > warning is because often that means (u16)~MLX90614_CONFIG_IIR_MASK is
>> > intended instead.  In this case it looks like we could just remove the
>> > cast with no harm done.
>> True, we could remove the cast, but I wanted to make sure that u16
>> data type is used
>> since ret and i are not that datatypes.
>
> Because of type promotion int type is used not u16.  The u16 casts are
> misleading no-ops because people think that u16 data type is used.
> Hence the static checker warning.
>

OK, seems like I am one of the people thinking that. Will follow your
advice and cast afterwards.

> It looks a little more readable without any casts and it works exactly
> the same since the casts were just for decoration.
>

Like I said they are on most processors, but might not be on others. I
rather have it
defined than let compiler decide

>         ret = mlx90614_write_word(client, MLX90614_CONFIG,
>                                   (i << MLX90614_CONFIG_IIR_SHIFT) |
>                                   ((0x7 << MLX90614_CONFIG_FIR_SHIFT) |
>                                    (ret & ~MLX90614_CONFIG_FIR_MASK) &
>                                    (~MLX90614_CONFIG_IIR_MASK)));
>
> The 0x7 is a magic number.  I would think it would be a named _MASK
> macro.  Ah, we do have a macro for that.

That macro is for mask and it is just coincidence that they are the
same. I would like to keep the
way it is in case someone wants to change FIR values as well.

>
>         ret = mlx90614_write_word(client, MLX90614_CONFIG,
>                                   (i << MLX90614_CONFIG_IIR_SHIFT) |
>                                   (MLX90614_CONFIG_FIR_MASK |
>                                    (ret & ~MLX90614_CONFIG_FIR_MASK) &
>                                    (~MLX90614_CONFIG_IIR_MASK)));
>
> The MLX90614_CONFIG_FIR_MASK and ~MLX90614_CONFIG_FIR_MASK can be
> simplified.
>
>         ret = mlx90614_write_word(client, MLX90614_CONFIG,
>                                   (i << MLX90614_CONFIG_IIR_SHIFT) |
>                                   (ret | MLX90614_CONFIG_FIR_MASK &
>                                    ~MLX90614_CONFIG_IIR_MASK));
>
> Once we have simplified the code, then it looks buggy to me.  I suspect
> that it is supposed to look like:
>
>         ret = mlx90614_write_word(client, MLX90614_CONFIG,
>                                   (i << MLX90614_CONFIG_IIR_SHIFT) |
>                                   (ret << MLX90614_CONFIG_FIR_SHIFT);
>
> Or possibly like:
>
>         ret = mlx90614_write_word(client, MLX90614_CONFIG,
>                                   (i << MLX90614_CONFIG_IIR_SHIFT) |
>                                   (ret & MLX90614_CONFIG_FIR_MASK);
>
> Keep in mind that:
>
>         ret & MLX90614_CONFIG_FIR_MASK
>
> And
>         ret & MLX90614_CONFIG_FIR_MASK & ~MLX90614_CONFIG_IIR_MASK
>
> are equivalent.  But the first one is simpler.
>
> regards,
> dan carpenter
>
