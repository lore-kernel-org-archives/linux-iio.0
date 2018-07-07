Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway32.websitewelcome.com ([192.185.145.178]:37381 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932563AbeGGRne (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jul 2018 13:43:34 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 2C65419133A
        for <linux-iio@vger.kernel.org>; Sat,  7 Jul 2018 12:22:51 -0500 (CDT)
Subject: Re: [PATCH] iio: sca3000: Mark expected switch fall-through
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180703193934.GA13572@embeddedor.com>
 <20180707180317.52cb8b39@archlinux>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <8d5b8eac-65ce-8c25-c77a-b4b1429ceeee@embeddedor.com>
Date: Sat, 7 Jul 2018 12:22:37 -0500
MIME-Version: 1.0
In-Reply-To: <20180707180317.52cb8b39@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On 07/07/2018 12:03 PM, Jonathan Cameron wrote:
> On Tue, 3 Jul 2018 14:39:34 -0500
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> 
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Looks like a bug to me not an unmarked fall through.
> 
> Should be return ret;
>

I see.

> Do you want to do the patch?
> 

Sure thing. I'll send a patch shortly.

Thanks for the feedback.
--
Gustavo
