Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:39515 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763181AbdLSNzl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Dec 2017 08:55:41 -0500
Received: by mail-lf0-f48.google.com with SMTP id m20so7158047lfi.6
        for <linux-iio@vger.kernel.org>; Tue, 19 Dec 2017 05:55:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171219132522.etacjnltyrc3xjks@hirez.programming.kicks-ass.net>
References: <20171218150544.8000-1-cmo@melexis.com> <20171218164449.dtdgk2bvnl4nbjcm@hirez.programming.kicks-ass.net>
 <CAKv63utUMv4H2Ah2sdWNzPrvY9vqHnyco7RkF7DDLY9CgUKGcg@mail.gmail.com> <20171219132522.etacjnltyrc3xjks@hirez.programming.kicks-ass.net>
From: Crt Mori <cmo@melexis.com>
Date: Tue, 19 Dec 2017 14:54:59 +0100
Message-ID: <CAKv63usxFaYET4odT6p07zhXxZ6qwxM6=d7+Ms6z04vjX3p3WQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] lib: Add strongly typed 64bit int_sqrt
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Ian Abbott <abbotti@mev.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19 December 2017 at 14:25, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Dec 19, 2017 at 10:31:18AM +0100, Crt Mori wrote:
>> IIO kernel does not have the recent version in, so thanks for heads
>
> IIO?
>

Industrial Input / Output Subsytem tree

>> up. It does not change much for my function.
>
> The comment says:
>
>  * Computes: floor(sqrt(x))
>
> floor(sqrt(2^64-1)) == 2^32-1
>

OK, so return value should be u32.
