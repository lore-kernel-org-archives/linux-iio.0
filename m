Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:35184 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbbFCHqW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2015 03:46:22 -0400
Received: by labko7 with SMTP id ko7so1538219lab.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2015 00:46:21 -0700 (PDT)
Message-ID: <556EB0C9.2040606@cogentembedded.com>
Date: Wed, 03 Jun 2015 10:46:17 +0300
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: hi-843x: Holt HI-8435/8436/8437 descrete
 ADC
References: <1433161073-21967-1-git-send-email-vladimir.barinov@cogentembedded.com>	 <1433161211-22034-1-git-send-email-vladimir.barinov@cogentembedded.com> <1433315157.2361.100.camel@x220>
In-Reply-To: <1433315157.2361.100.camel@x220>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Paul,

On 03.06.2015 10:05, Paul Bolle wrote:
> Just a nit, that I spotted while scanning for other issues.
>
> On Mon, 2015-06-01 at 15:20 +0300, Vladimir Barinov wrote:
>> --- /dev/null
>> +++ b/drivers/iio/adc/hi-843x.c
>> +ssize_t hi843x_debounce_soft_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	[...]
>> +}
>> +
>> +[...]
>> +
>> +ssize_t hi843x_threshold_socval_store(struct device *dev,
>> +				      struct device_attribute *attr,
>> +				      const char *buf, size_t len)
>> +{
>> +	[...]
>> +}
> It seems all these *_show and *_store functions should be made static,
> right?
Right. Thank you for pointing to this.

Regards,
Vladimir
