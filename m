Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:62966 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754790AbcIYRbZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Sep 2016 13:31:25 -0400
Subject: Re: iio: Rename a jump label in iio_buffer_store_watermark()
To: Jonathan Cameron <jic23@kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
 <50eb1352-fb0a-1cf5-70d8-48fe8f98b9eb@users.sourceforge.net>
 <dfb5e8de-8217-ba50-017a-6a3c20209419@kernel.org>
 <bd5f10ad-f379-2678-5af1-968bba63d519@users.sourceforge.net>
 <c030d093-56d9-1437-fce5-315c960e61d2@kernel.org>
 <69f22bcd-9945-2214-9f80-4b42f95a3d80@users.sourceforge.net>
 <6da5896d-a605-300e-568c-b6b3c6e49eef@kernel.org>
 <ff3e7353-894b-4fb2-b72c-74dcb1a8f14e@users.sourceforge.net>
 <229adb93-d83b-62b3-b469-755b2b63f6cf@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <8c4f43d9-2448-a6bf-eb62-f6a0b418d4e3@users.sourceforge.net>
Date: Sun, 25 Sep 2016 19:31:01 +0200
MIME-Version: 1.0
In-Reply-To: <229adb93-d83b-62b3-b469-755b2b63f6cf@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> To my mind there is a divide between the cost of making changes like this
> as a result of initial review and that of doing it on existing code.

I can follow this view.


> I don't think this one is worth while for existing code.

How do you think about once more to increase the usage of the jump label "unlock"
also for this software module?

Regards,
Markus
