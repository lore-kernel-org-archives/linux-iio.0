Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:46222 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754818AbcJYRBK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 13:01:10 -0400
Subject: Re: [PATCH] [v2] staging: iio: ad5933: avoid uninitialized variable
 in error case
To: Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20161024152226.2536749-1-arnd@arndb.de>
 <39545e74-af9b-cd31-c525-fba9f4c369b4@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alison Schofield <amsfield22@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e2df94af-a165-bd82-aa7f-c9e1f820443a@metafoo.de>
Date: Tue, 25 Oct 2016 19:00:58 +0200
MIME-Version: 1.0
In-Reply-To: <39545e74-af9b-cd31-c525-fba9f4c369b4@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/25/2016 06:57 PM, Jonathan Cameron wrote:
> On 24/10/16 16:22, Arnd Bergmann wrote:
>> The ad5933_i2c_read function returns an error code to indicate
>> whether it could read data or not. However ad5933_work() ignores
>> this return code and just accesses the data unconditionally,
>> which gets detected by gcc as a possible bug:
>>
>> drivers/staging/iio/impedance-analyzer/ad5933.c: In function 'ad5933_work':
>> drivers/staging/iio/impedance-analyzer/ad5933.c:649:16: warning: 'status' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>
>> This adds minimal error handling so we only evaluate the
>> data if it was correctly read.
>>
>> Link: https://patchwork.kernel.org/patch/8110281/
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Looks good to me.
> 
> Lars?
> 

Looks good, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
