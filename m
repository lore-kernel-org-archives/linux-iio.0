Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34511 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753765AbdEOM1g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 May 2017 08:27:36 -0400
Received: by mail-it0-f68.google.com with SMTP id d68so1275091ita.1
        for <linux-iio@vger.kernel.org>; Mon, 15 May 2017 05:27:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d3b2f247-08f6-3ae5-e206-e77b1c574855@kernel.org>
References: <1493983193-8753-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1493983193-8753-2-git-send-email-mikko.koivunen@fi.rohmeurope.com> <d3b2f247-08f6-3ae5-e206-e77b1c574855@kernel.org>
From: Daniel Baluta <daniel.baluta@intel.com>
Date: Mon, 15 May 2017 15:27:29 +0300
Message-ID: <CAEnQRZDycQCHUCstkPuGYZpCjsHZ=8NgboAxQePu7ya6dGYAow@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] iio: light: rpr0521 poweroff for probe fails
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, May 7, 2017 at 2:42 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 05/05/17 12:19, Mikko Koivunen wrote:
>> Set sensor measurement off after probe fail in pm_runtime_set_active() or
>> iio_device_register(). Without this change sensor measurement stays on
>> even though probe fails on these calls.
>>
>> This is maybe rare case, but causes constant power drain without any
>> benefits when it happens. Power drain is 20-500uA, typically 180uA.
>>
>> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
> Looks good to me, but I will be looking for Acks from Daniel on this
> set.  Daniel let me know if you want to pass on responsibility for the
> driver (perhaps Mikko if willing?)

This patchset looks good to me. Of course, if Mikko wants to take care of this
in the future :).

You can add my:

Acked-by: Daniel Baluta <daniel.baluta@nxp.com>
