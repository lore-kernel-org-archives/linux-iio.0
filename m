Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33232 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbbHGK7m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2015 06:59:42 -0400
Received: by lbbyj8 with SMTP id yj8so58733377lbb.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2015 03:59:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150715193650.GA28245@mwanda>
References: <20150715193650.GA28245@mwanda>
Date: Fri, 7 Aug 2015 13:59:40 +0300
Message-ID: <CAEnQRZC6-4n7ZUi0PPiQ2bG-c1P3fADn6CmyYLmHa2NbWVeaJg@mail.gmail.com>
Subject: Re: staging: iio: accel: Use __be16 instead of u16
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: =?UTF-8?B?YXliw7xrZSDDtnpkZW1pcg==?= <aybuke.147@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Dan,

On Wed, Jul 15, 2015 at 10:36 PM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> Hello Aybuke Ozdemir,
>
> The patch 03c6eaa37ad7: "staging: iio: accel: Use __be16 instead of
> u16" from Sep 28, 2014, leads to the following static checker warning:
>
>         drivers/staging/iio/accel/sca3000_ring.c:120 sca3000_read_first_n_hw_rb()
>         warn: potential pointer math issue ('rx' is a 16 bit pointer)
>
I think the issue was there before this patch.

> drivers/staging/iio/accel/sca3000_ring.c
>    107           */
>    108          if (count > num_available * bytes_per_sample)
>    109                  num_read = num_available*bytes_per_sample;
>    110          else
>    111                  num_read = count;
>    112
>    113          ret = sca3000_read_data(st,
>    114                                  SCA3000_REG_ADDR_RING_OUT,
>    115                                  &rx, num_read);
>    116          if (ret)
>    117                  goto error_ret;
>    118
>    119          for (i = 0; i < num_read; i++)
>    120                  *(((u16 *)rx) + i) = be16_to_cpup((__be16 *)rx + i);
>                           ^^^^^^^^^^^^^^^
>
> We're writing beyond the end of the array here because of the pointer
> math issue.  The fix is probably to say:
>
>                 for (i = 0; i < num_read / sizeof(u16); i++)
>                         *(((u16 *)rx) + i) = be16_to_cpup((__be16 *)rx + i);
>
>    121
>    122          if (copy_to_user(buf, rx, num_read))
>    123                  ret = -EFAULT;

Looks good to me. Please send a formal patch.

thanks,
Daniel.
