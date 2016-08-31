Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35333 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbcHaAm2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2016 20:42:28 -0400
MIME-Version: 1.0
In-Reply-To: <1472596930.23886.13.camel@intel.com>
References: <1472596930.23886.13.camel@intel.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 30 Aug 2016 17:41:45 -0700
Message-ID: <CAKzfze_p_6AiF93rY8HCMtm3BpDDjPS91nRbG49exrg4DV7Qzg@mail.gmail.com>
Subject: Re: screen rotation flipped in 4.8-rc
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux@sciencehorizons.net" <linux@sciencehorizons.net>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "srinivas.pandruvada@linux.intel.com"
        <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 30, 2016 at 3:42 PM, Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
> Hi All,
>
> I observed that using iio-sensor-proxy.service, the auto screen
> rotation flipped on my laptop (Normal -> vertical, vertical->normal)
> using kernel v4.8.
>
> Anyone else has seen this?
>
> I did a bisect and found a commit, which I am not sure how can it
> impact.

Could you post the results of CONFIG_TEST_HASH enabled?

Thanks,

Matt

>
>
> commit 703b5faf22fbddf984a361e6555f3a03fdba63d9
> Author: George Spelvin <linux@sciencehorizons.net>
> Date:   Fri Jun 10 00:22:12 2016 -0400
>
>     fs/dcache.c: Save one 32-bit multiply in dcache lookup
>
>     Noe that we're mixing in the parent pointer earlier, we
>     don't need to use hash_32() to mix its bits.  Instead, we can
>     just take the msbits of the hash value directly.
>
>     For those applications which use the partial_name_hash(),
>     move the multiply to end_name_hash.
>
>     Signed-off-by: George Spelvin <linux@sciencehorizons.net>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>
>
> Thanks,
> Srinivas
