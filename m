Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35715 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755275AbdCaTHW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 15:07:22 -0400
MIME-Version: 1.0
In-Reply-To: <1490978804-25549-1-git-send-email-singhalsimran0@gmail.com>
References: <1490978804-25549-1-git-send-email-singhalsimran0@gmail.com>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Sat, 1 Apr 2017 00:37:19 +0530
Message-ID: <CALrZqyPqPFKosrk_tunoC0WCv0vzXtTSL4+0U8nd=-9ANkyLXA@mail.gmail.com>
Subject: Re: [PATCH 0/3] iio: health: Clean up
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Please ignore this Patch. As this patch is completely wrong due to
my lack of understanding.

On Fri, Mar 31, 2017 at 10:16 PM, simran singhal
<singhalsimran0@gmail.com> wrote:
> This patch-series removes commented code in afe440x.h and
> removes unused functions in afe4404.c and afe4403.c.
>
> simran singhal (3):
>   iio: health: afe440x: Remove code in comments
>   iio: health: afe4404: Remove all unused functions
>   iio: health: afe4403: Remove all unused functions
>
>  drivers/iio/health/afe4403.c | 51 --------------------------------------
>  drivers/iio/health/afe4404.c | 51 --------------------------------------
>  drivers/iio/health/afe440x.h | 58 --------------------------------------------
>  3 files changed, 160 deletions(-)
>
> --
> 2.7.4
>
