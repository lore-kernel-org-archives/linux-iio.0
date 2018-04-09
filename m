Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:33142 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeDIX0k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Apr 2018 19:26:40 -0400
Received: by mail-it0-f52.google.com with SMTP id x144-v6so13166624itc.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Apr 2018 16:26:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b36429ed-34cb-6f07-13a2-2ef960bd9b42@gmail.com>
References: <b36429ed-34cb-6f07-13a2-2ef960bd9b42@gmail.com>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Mon, 9 Apr 2018 16:26:39 -0700
Message-ID: <CAJCx=gna64NhsMGHu4MGbssvNgeyWXwcoRCFZ4wDLQbu96susg@mail.gmail.com>
Subject: Re: Add support of Wiegand card reader
To: =?UTF-8?Q?Ga=C3=ABtan_Carlier?= <gcembed@gmail.com>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Apr 9, 2018 at 7:05 AM, Ga=C3=ABtan Carlier <gcembed@gmail.com> wro=
te:
> Hello,
> I would like to add support of Wiegand card reader [1]. Where can I place=
 it : drivers/iio/access/wiegand.c or drivers/iio/security/wiegand.c?

Question here is why is this ideal for iio versus using the input subsystem=
?

Also a few issues/points:

* What is the interface to the Wiegand data? If it is inputting on a
GPIO that is for sure not going to be real time enough to get valid
data
* Aren't there multiple Wiegand transport standards?
* Most keyreaders I've seen are emulated as keyboard devices so they
use the input subsystem.
* Also if the data being output is ASCII data, then I'm not sure that
fits anywhere in iio

- Matt


>
> Thank you for your help?
> Best regards,
> Ga=C3=ABtan.
>
> [1] https://en.wikipedia.org/wiki/Wiegand_interface
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
