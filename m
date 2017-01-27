Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35128 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdA0TBs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 14:01:48 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so19091886pfa.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Jan 2017 11:01:46 -0800 (PST)
Date: Sat, 28 Jan 2017 00:23:43 +0530
From: Mani Sadhasivam <manivannanece23@gmail.com>
To: matthias@tenstral.net
Cc: pmeerw@pmeerw.net, jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: Problems with using IIO buffers
Message-ID: <20170127185343.GA24828@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: CAKNHny9saYXafENh0EcAvCw8fVtfK5LoiwusSpUMiCh0Fkh_ng@mail.gmail.com
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Mathias,

For iio_readdev api, the default timeout is 1s that's why you're getting timeout error as the trigger fails to happen within that timeout period.

It'd be worth to note that this api is not a blocking call.

If you wanna use iio_readddev you can probably increase the timeout in local.c file of libiio source.

Change the timeout value of DEFAULT_TIMEOUT_MS to 5000 or anything which will let the trigger to happen. Depending upon the buffer and sample
size you'll require corresponding number of triggers.

For instance, for the buffer length of 2 and you want 2 samples

iio_readdev -t sysfstrig1 -b 2 -s 2 mydev

In this case, if 2 triggers happen within that timeout period, iio_readdev api will successfully return the buffer content.

But for iio_generic_buffer, buffer contents are returned after getting enough triggers (blocking).

Thanks,
Mani
