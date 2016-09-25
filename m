Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34841 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbcIYIpX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 04:45:23 -0400
Subject: Re: iio: Rename a jump label in iio_buffer_store_watermark()
To: SF Markus Elfring <elfring@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
 <50eb1352-fb0a-1cf5-70d8-48fe8f98b9eb@users.sourceforge.net>
 <dfb5e8de-8217-ba50-017a-6a3c20209419@kernel.org>
 <bd5f10ad-f379-2678-5af1-968bba63d519@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c030d093-56d9-1437-fce5-315c960e61d2@kernel.org>
Date: Sun, 25 Sep 2016 09:45:21 +0100
MIME-Version: 1.0
In-Reply-To: <bd5f10ad-f379-2678-5af1-968bba63d519@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/09/16 20:21, SF Markus Elfring wrote:
>> I'm not necessarily against this change which does perhaps clarify the code
>> ever so slightly,
> 
> Thanks for another bit of positive feedback.
> 
> 
>> but I am interested to know where 'current Linux coding style convention' comes from?
> 
> How often do you check the status of a document like "CodingStyle" for example?   ;-)
Every time I see a patch doing a style change I don't remember being there last time
I looked ;)

I'm not seeing this one in there.  Which tool is spitting it out? Or is
the test yours?
> 
> How do you think about information from a commit like
> "docs: Remove space-before-label guidance from CodingStyle" (on 2016-09-21)?
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/Documentation/CodingStyle?id=79c70c304b0b443429b2a0019518532c5162817a
Yeah, I saw the discussion / flame war that resulted in that revert...
> 
> Regards,
> Markus
> 

