Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:33724 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbbG0H4l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 03:56:41 -0400
Received: by laah7 with SMTP id h7so43932731laa.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2015 00:56:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+0Dg4o_D-U-=z=4FwC=aWe0CGH+wHPe1tqrDQudR1n89bBByg@mail.gmail.com>
References: <CA+0Dg4o_D-U-=z=4FwC=aWe0CGH+wHPe1tqrDQudR1n89bBByg@mail.gmail.com>
Date: Mon, 27 Jul 2015 10:56:39 +0300
Message-ID: <CAEnQRZCm3jqyWs5BUeVwdCNbmKtSYgmXcx16KN3NTpckmq9=cA@mail.gmail.com>
Subject: Re: iio_utils.c defines _IIO_UTILS_H
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Joo Aun Saw <jasaw@dius.com.au>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 27, 2015 at 7:21 AM, Joo Aun Saw <jasaw@dius.com.au> wrote:
> Hi,
>
> What is the purpose of having ifndef _IIO_UTILS_H and define
> _IIO_UTILS_H at the top of iio_utils.c file? Is this a copy and paste
> error from the original iio_utils.h file?

Hi Joo,

It's a relict from:

bdcb31d0480 ("staging: iio: Documentation: Introduce iio_utils.c")

Please send a patch.

thanks,
Daniel.
