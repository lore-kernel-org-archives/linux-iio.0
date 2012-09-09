Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:44483 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751065Ab2IIKrN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 9 Sep 2012 06:47:13 -0400
Message-ID: <504C73AD.807@metafoo.de>
Date: Sun, 09 Sep 2012 12:47:09 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add driver for si114x ambient light / proximity
 sensors
References: <1346974582-5936-1-git-send-email-pmeerw@pmeerw.net> <504B780F.8090305@kernel.org>
In-Reply-To: <504B780F.8090305@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/08/2012 06:53 PM, Jonathan Cameron wrote:
> On 09/07/2012 12:36 AM, Peter Meerwald wrote:
[...]
>> +
>> +struct si114x_platform_data {
>> +	bool use_irq;
> It's a bit nasty, but you could drop this and rely on client->irq = NO_IRQ
> in the platform data.   If only the no irq = 0 had always been enforced...

NO_IRQ constant is deprecated anyway, and 0 is the new "no irq". So just
checking if client->irq is 0 should be fine to find out whether to use IRQs or not.

>> +	int irq_flags;
> Which flags actually make sense here?  Just curious really.
>> +};
>> +
>> +#endif /* SI114X_H */
>> +
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

