Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49416 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaIUNcd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Sep 2014 09:32:33 -0400
Message-ID: <541ED36F.3020304@kernel.org>
Date: Sun, 21 Sep 2014 14:32:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>,
	"Ivan T. Ivanov" <iivanov@mm-sol.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: iadc: Qualcomm SPMI PMIC current ADC driver
References: <1411046123-30625-1-git-send-email-iivanov@mm-sol.com>  <alpine.DEB.2.01.1409182041040.30983@pmeerw.net> <1411109437.3997.9.camel@iivanov-dev> <alpine.DEB.2.01.1409191026380.4354@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1409191026380.4354@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/09/14 09:27, Peter Meerwald wrote:
> 
>>> I'd prefix with SPMI_IADC_  
>>
>> Is this really necessary? I could prefix it with IADC3, which 
>> is the subtype of this peripheral.
> 
> I think for a similar driver we are sticking with VADC, so no...
This is always a little tricky to decide.  We want something to prevent
accidental namespace clashes and also to clearly identify device
specific constants, but conversely long prefixes are somewhat of a
pain.

As far as I am concerned IADC is just obscure enough that it
is unlikely to ever be used in any subsystem headers and is
hence fine..
(ADC would not be!)
>  
>>>> +#define IADC_REVISION2				0x1
>>>> +#define IADC_REVISION2_SUPPORTED_IADC		1
>>>> +
>>>> +#define IADC_PERPH_TYPE				0x4
>>>> +#define IADC_PERPH_TYPE_ADC			8
>>>> +
>>>> +#define IADC_PERPH_SUBTYPE			0x5
>>>> +#define IADC_PERPH_SUBTYPE_IADC			3
>>
>> Rest of the comments will be fixed in next version.
> 
