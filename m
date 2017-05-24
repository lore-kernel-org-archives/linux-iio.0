Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35127 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031148AbdEXT4r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 May 2017 15:56:47 -0400
Received: by mail-lf0-f46.google.com with SMTP id a5so59888719lfh.2
        for <linux-iio@vger.kernel.org>; Wed, 24 May 2017 12:56:46 -0700 (PDT)
Subject: Re: [PATCH] iio: hi8435: fix race between event enable and event
 generation
To: Jonathan Cameron <jic23@kernel.org>
References: <20170523080729.20459-1-nikita.yoush@cogentembedded.com>
 <20170524203033.558a09f9@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Jeff White <Jeff.White@zii.aero>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <d1e3d8e6-742c-7aef-6f1d-1f3554f3cf66@cogentembedded.com>
Date: Wed, 24 May 2017 22:56:43 +0300
MIME-Version: 1.0
In-Reply-To: <20170524203033.558a09f9@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>> Add locking to avoid interference between reading/processing current
>> sence in event enable and event generation paths.
>>
>> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Make sense.  Could you give a little more detail on the seriousness
> of this bug?  I need to assess whether we just queue it up for the
> next merge window or push it forward quicker as a bug fix and
> whether to mark it for stable or not.
> 
> You probably have a better idea of how much it matters than I do!

Race was introduced by my previous patch, and noticed by Vladimir.
It is not in any released tree.

Possible race impact is loss of event or duplicate event.

Nikita
