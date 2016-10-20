Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:50785 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938697AbcJTNTW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2016 09:19:22 -0400
Subject: Re: [PATCH 1/2] staging: iio: ad7606: set proper supply name to
 devm_regulator_get()
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org
References: <1476968903-15771-1-git-send-email-eraretuya@gmail.com>
 <1476968903-15771-2-git-send-email-eraretuya@gmail.com>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1b7d4701-d954-5c4b-0990-8d991cb3ed7a@metafoo.de>
Date: Thu, 20 Oct 2016 15:19:19 +0200
MIME-Version: 1.0
In-Reply-To: <1476968903-15771-2-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/20/2016 03:08 PM, Eva Rachel Retuya wrote:
> The name passed to devm_regulator_get() should match the name of the
> supply as specified in the device datasheet. The supply on this device
> is called 'AVcc' while currently, the driver uses just 'vcc'.
> 
> Use 'avcc' to specify the supply voltage since it is custom to use the
> lower-caps version of the datasheet name.
> 
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
