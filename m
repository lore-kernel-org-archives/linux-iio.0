Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43103 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbH0Tv5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2015 15:51:57 -0400
Subject: Re: [PATCH v4 2/4] dt: Add vendor prefix 'holt'
To: Rob Herring <robherring2@gmail.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <1440099421-4762-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <1440099488-4850-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <CAL_JsqJHT+s_+cDw5h2Ra7uh+4bHsGKXN-o0GAQ1DS_HdfWg7w@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Cory Tusar <cory.tusar@pid1solutions.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55DF6A5B.5080504@kernel.org>
Date: Thu, 27 Aug 2015 20:51:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJHT+s_+cDw5h2Ra7uh+4bHsGKXN-o0GAQ1DS_HdfWg7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/08/15 23:32, Rob Herring wrote:
> On Thu, Aug 20, 2015 at 2:38 PM, Vladimir Barinov
> <vladimir.barinov@cogentembedded.com> wrote:
>> Add Holt Integrated Circuits, Inc. to the list of device tree vendor
>> prefixes
>>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> 
>> ---
>> Changes in version 2:
>> - none
>> Changes in version 3:
>> - none
>> Changes in version 4:
>> - none
>>
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index d444757..bc64cc9 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -99,6 +99,7 @@ himax Himax Technologies, Inc.
>>  hisilicon      Hisilicon Limited.
>>  hit    Hitachi Ltd.
>>  hitex  Hitex Development Tools
>> +holt   Holt Integrated Circuits, Inc.
>>  honeywell      Honeywell
>>  hp     Hewlett Packard
>>  i2se   I2SE GmbH
>> --
>> 1.9.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

