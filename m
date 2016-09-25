Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36206 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034067AbcIYOXw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 10:23:52 -0400
Subject: Re: iio: Rename a jump label in iio_buffer_store_watermark()
To: SF Markus Elfring <elfring@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
 <50eb1352-fb0a-1cf5-70d8-48fe8f98b9eb@users.sourceforge.net>
 <dfb5e8de-8217-ba50-017a-6a3c20209419@kernel.org>
 <bd5f10ad-f379-2678-5af1-968bba63d519@users.sourceforge.net>
 <c030d093-56d9-1437-fce5-315c960e61d2@kernel.org>
 <69f22bcd-9945-2214-9f80-4b42f95a3d80@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6da5896d-a605-300e-568c-b6b3c6e49eef@kernel.org>
Date: Sun, 25 Sep 2016 15:23:49 +0100
MIME-Version: 1.0
In-Reply-To: <69f22bcd-9945-2214-9f80-4b42f95a3d80@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/09/16 14:00, SF Markus Elfring wrote:
>> I'm not seeing this one in there.
> 
> How much do you care about selection of appropriate identifiers in source files?
It's not an inappropriate identifier as it stands. The point is
that it could be better.
> 
> 
>> Which tool is spitting it out?
> 
> Are you looking for any special tool?
I was wondering how you identified these particular
issues as I wanted to know the logic behind the test.
> 
> 
>> Or is the test yours?
> 
> Which test do you mean?
Whatever you used to find these jump labels (the patch series
description suggested it was a static checker).
> 
> 
>> Yeah, I saw the discussion / flame war that resulted in that revert...
> 
> Would you like to share any more constructive ideas for this software evolution?
Not a lot of time at the moment, sorry.

Jonathan
> 
> Regards,
> Markus
> 

