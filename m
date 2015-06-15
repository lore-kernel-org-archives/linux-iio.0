Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:35036 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbbFOHAI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jun 2015 03:00:08 -0400
Received: by labko7 with SMTP id ko7so51549949lab.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2015 00:00:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAM=Q2ctzDwAGfCipu2PoaE-vbnoag2K+1sAUOrDO8pwbqb1sgA@mail.gmail.com>
References: <1434316175-24657-1-git-send-email-pmeerw@pmeerw.net>
	<CAM=Q2ctzDwAGfCipu2PoaE-vbnoag2K+1sAUOrDO8pwbqb1sgA@mail.gmail.com>
Date: Mon, 15 Jun 2015 10:00:06 +0300
Message-ID: <CAEnQRZBTE2dSFncKJv5R0K4Vr5ELwHxf=e3Riw9j_dm484cywQ@mail.gmail.com>
Subject: Re: [PATCH] iio: light: tcs3414: Fix bug preventing to set
 integration time
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jun 15, 2015 at 8:42 AM, Shubhrajyoti Datta
<omaplinuxkernel@gmail.com> wrote:
> On Mon, Jun 15, 2015 at 2:39 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>> the millisecond values in tcs3414_times should be checked against
>> val2, not val, which is always zero.
> nit :
>
> may be the variable name could be little more descriptive.

This is the convention for fractional part in IIO. :)

Daniel.
