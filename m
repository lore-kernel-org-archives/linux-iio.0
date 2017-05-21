Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:42071 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753411AbdEUL7o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 May 2017 07:59:44 -0400
Subject: Re: [PATCH v6] iio: adc: Add support for TI ADC108S102 and ADC128S102
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
References: <e96cd67d-ac54-435e-b376-0d029fdb75c3@siemens.com>
 <9eae4928-c278-62e5-05d1-728326aad45b@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9f60dc23-6ba1-335a-d95b-870cdd250539@siemens.com>
Date: Sun, 21 May 2017 13:59:32 +0200
MIME-Version: 1.0
In-Reply-To: <9eae4928-c278-62e5-05d1-728326aad45b@kernel.org>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-05-21 12:47, Jonathan Cameron wrote:
> On 17/05/17 16:28, Jan Kiszka wrote:
>> This is an upstream port of an IIO driver for the TI ADC108S102 and
>> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
>> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
>> included.
>>
>> Due to the lack of regulators under ACPI, we hard-code the voltage
>> provided to the VA pin of the ADC to 5 V, the value used on Galileo and
>> IOT2000. For DT usage, the regulator "vref-supply" provides this
>> information. Note that DT usage has not been tested.
>>
>> Original author: Bogdan Pricop <bogdan.pricop@emutex.com>
>> Ported from Intel Galileo Gen2 BSP to Intel Yocto kernel:
>> Todor Minchev <todor@minchev.co.uk>.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Still an issue wrt to it being obviously correct in the ordering in probe
> and remove.
> 
> As a reviewer I want to be able to run through each step in probe and
> compare with remove to ensure they occur in the opposite order and
> reverse all the steps in probe.  Where ever it deviates from that I have
> to think about it and we all know the last thing a reviewer with a big
> backlog of patches wants to do is to think hard ;)
> 
> Anyhow, I've fixed up and applied to the togreg branch of iio.git and
> pushed out as testing for the autobuilders to play with it.
> 
> Please check I haven't made a mess of it.

Forgot to push? Not finding it in togreg, which is 5 days old.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
