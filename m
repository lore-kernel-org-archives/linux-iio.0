Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36834 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938834AbcIYQtZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 12:49:25 -0400
Subject: Re: iio: Rename a jump label in iio_buffer_store_watermark()
To: SF Markus Elfring <elfring@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
 <50eb1352-fb0a-1cf5-70d8-48fe8f98b9eb@users.sourceforge.net>
 <dfb5e8de-8217-ba50-017a-6a3c20209419@kernel.org>
 <bd5f10ad-f379-2678-5af1-968bba63d519@users.sourceforge.net>
 <c030d093-56d9-1437-fce5-315c960e61d2@kernel.org>
 <69f22bcd-9945-2214-9f80-4b42f95a3d80@users.sourceforge.net>
 <6da5896d-a605-300e-568c-b6b3c6e49eef@kernel.org>
 <ff3e7353-894b-4fb2-b72c-74dcb1a8f14e@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <229adb93-d83b-62b3-b469-755b2b63f6cf@kernel.org>
Date: Sun, 25 Sep 2016 17:49:21 +0100
MIME-Version: 1.0
In-Reply-To: <ff3e7353-894b-4fb2-b72c-74dcb1a8f14e@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/09/16 16:17, SF Markus Elfring wrote:
>> It's not an inappropriate identifier as it stands. The point is
>> that it could be better.
> 
> Thanks for your interest in clarifying further improvement possibilities.
> 
> 
>>>> Which tool is spitting it out?
>>>
>>> Are you looking for any special tool?
>> I was wondering how you identified these particular
>> issues as I wanted to know the logic behind the test.
> 
> Do you get any related ideas from information in a message like
> "Source code review around jump label usage" (from 2015-12-11)?
> 
> https://lkml.org/lkml/2015/12/11/378
> https://lkml.kernel.org/r/<566ABCD9.1060404@users.sourceforge.net>
> 
> 
>>> Which test do you mean?
>> Whatever you used to find these jump labels
> 
> There is a general possibility that dedicated scripts for the semantic
> patch language can also adjust jump labels as I suggested it for five
> functions in this software.
> 
> 
>> (the patch series description suggested it was a static checker).
> 
> The corresponding five patches are just a result of a source code review
> by the means of a current text editor wit extra support for programming.
To my mind there is a divide between the cost of making changes like this
as a result of initial review and that of doing it on existing code.

I don't think this one is worth while for existing code.
> 
> How do you think about to improve the capabilities of tools for advanced
> static source code analysis any further?
> 
> Regards,
> Markus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

