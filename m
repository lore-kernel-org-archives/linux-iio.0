Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:35890 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754694AbcHXObr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2016 10:31:47 -0400
Subject: Re: [PATCH] iio: dac: AD8801: add Analog Devices AD8801/AD8803
 support
To: gwenhael <gwenj@trabucayre.com>,
        Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        linux-iio@vger.kernel.org
References: <20160824135301.6263-1-gwenhael.goavec-merou@trabucayre.com>
 <20160824135301.6263-2-gwenhael.goavec-merou@trabucayre.com>
 <121a7e50-e17c-5865-52ae-ca5abc176a6e@metafoo.de>
 <bc91330b-48a9-e2ce-29fe-f94c231c5159@trabucayre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Paul Cercueil <paul.cercueil@analog.com>,
        Gwenhael <gwe@trabucayre.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c7bf7b74-c829-fd72-7719-47031f008145@metafoo.de>
Date: Wed, 24 Aug 2016 16:31:43 +0200
MIME-Version: 1.0
In-Reply-To: <bc91330b-48a9-e2ce-29fe-f94c231c5159@trabucayre.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/24/2016 04:25 PM, gwenhael wrote:
> Hi,
> 
> On 24/08/2016 16:09, Lars-Peter Clausen wrote:
>> Hi,
>>
>> Thanks for the patch, very good work. Looks mostly good, a few comments
>> inline.
>>
>> Also please run the patch through scripts/checkpatch.pl there are a couple
>> of whitespace issues here and there (extra space at the end of the line,
>> etc.).
> Thanks for your review. It's strange, on my computer no warnings about
> whitespace
> are displayed by checkpatch.pl. I need to check by hand.

Strange, I get the following:

ERROR: trailing whitespace
#94: FILE: drivers/iio/dac/ad8801.c:39:
+^I $

ERROR: trailing whitespace
#131: FILE: drivers/iio/dac/ad8801.c:76:
+^I$

ERROR: trailing whitespace
#155: FILE: drivers/iio/dac/ad8801.c:100:
+^I^I$

ERROR: trailing whitespace
#167: FILE: drivers/iio/dac/ad8801.c:112:
+const struct iio_chan_spec ad8801_channels[] = { $


