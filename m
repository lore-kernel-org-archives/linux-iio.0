Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeGVGgp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jul 2018 02:36:45 -0400
Date: Sat, 21 Jul 2018 22:41:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 01/10] counter: Introduce the Generic Counter
 interface
Message-Id: <20180721224118.ff26734be0f5db552afcbe7c@linux-foundation.org>
In-Reply-To: <20180721162610.GA15622@sophia>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
        <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
        <20180717204954.4b5e371603d0b40b2aaabbb8@linux-foundation.org>
        <20180721162610.GA15622@sophia>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 21 Jul 2018 12:26:10 -0400 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> >Also, many many drivers deal with signals-as-an-electrical-thing - is
> >it appropriate for this particular driver to take that namespace?
> 
> In the context of the Generic Counter paradigm, a "Signal" is an
> abstraction for the stream of data that is fed to the counter device for
> evaluation (triggering updates for the readable "Count"). In many cases
> a "Signal" correlates with a physical electrical line (for example the A
> and B electrical lines for a quadrature encoder), but this isn't a hard
> requirement as the paradigm permits more abstract data streams.
> 
> I decided on "Signal" to match the naming convention that appears in the
> datasheets of many counter devices, but "Line" may be a decent
> alternative name we could use to indicate a counter device input data
> stream.
> 
> I'd like to get some other opinions as well before I make a naming
> change to "Signal" -- whether to stay with "Signal," switch to "Line," or
> rename to something else. For what it's worth, I think it's unlikely for
> a counter device driver author to confuse a Counter Signal with the
> Linux OS signal within the context of the Generic Counter paradigm and
> their respective counter device datasheet.

gc_signal_* would be better.  That retains "signal", but makes
it clear that the symbols belong to generic counter.
