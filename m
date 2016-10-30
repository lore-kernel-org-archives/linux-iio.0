Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:45008 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbcJ3Rq0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 13:46:26 -0400
Subject: Re: [PATCH v3] staging: iio: cdc: ad7746: add additional config
 defines
To: Jonathan Cameron <jic23@kernel.org>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <1477643212-7200-1-git-send-email-eraretuya@gmail.com>
 <f59b10dc-e273-d147-611c-0fca52ee8bc0@kernel.org>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <48d88156-88a9-dcc9-48d8-809d992c56e1@metafoo.de>
Date: Sun, 30 Oct 2016 18:46:13 +0100
MIME-Version: 1.0
In-Reply-To: <f59b10dc-e273-d147-611c-0fca52ee8bc0@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/30/2016 06:41 PM, Jonathan Cameron wrote:
> On 28/10/16 09:26, Eva Rachel Retuya wrote:
>> Introduce defines for shifting and mask under the config register for
>> better readability. Also, introduce helper variables for index
>> calculation.
>>
>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> Looks good to me.
> 
> Lars could you sanity check this one as well?

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

