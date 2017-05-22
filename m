Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33111 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759693AbdEVR2B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 May 2017 13:28:01 -0400
Received: by mail-lf0-f41.google.com with SMTP id m18so35132606lfj.0
        for <linux-iio@vger.kernel.org>; Mon, 22 May 2017 10:28:01 -0700 (PDT)
Subject: Re: [PATCH 1/4] iio: hi8435: add raw access
To: Jonathan Cameron <jic23@kernel.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
 <67afb274-c93b-f35b-64c1-0ab8ccb21557@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff White <Jeff.White@zii.aero>,
        Chris Healy <Chris.Healy@zii.aero>
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Message-ID: <08c4c66e-5c96-8a34-6c0e-e984795927d0@cogentembedded.com>
Date: Mon, 22 May 2017 20:27:57 +0300
MIME-Version: 1.0
In-Reply-To: <67afb274-c93b-f35b-64c1-0ab8ccb21557@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20.05.2017 19:33, Jonathan Cameron wrote:
> On 19/05/17 15:47, Nikita Yushchenko wrote:
>> With current event-only driver, it is not possible for user space
>> application to know current senses if they don't change since
>> application starts.
>>
>> Address that by adding raw access to channels.
>>
>> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Ideally I'd like Vladimir's ack on these, but I am going to guess
> that he is fine with this and rely on him shouting if not ;)
Acked-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Originally it was a part of the patch for HI8435 buffer interface but 
removed during migration to event interface:
http://marc.info/?l=linux-iio&m=143817462614547&w=4

This is a case when raw access is needed.

