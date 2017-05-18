Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:36541 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbdERMb5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 May 2017 08:31:57 -0400
Subject: Re: [PATCH v6] iio: adc: Add support for TI ADC108S102 and ADC128S102
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
References: <e96cd67d-ac54-435e-b376-0d029fdb75c3@siemens.com>
 <CAHp75VcD5XuvJYRUn1ROwQvHW9Vjzw5=WiPoD==a1oKFkkJ=Dw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <95f19ff0-fd5a-d906-07a3-363e6b3b5dd8@siemens.com>
Date: Thu, 18 May 2017 14:31:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VcD5XuvJYRUn1ROwQvHW9Vjzw5=WiPoD==a1oKFkkJ=Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-05-18 13:07, Andy Shevchenko wrote:
> On Wed, May 17, 2017 at 6:28 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
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
> 
> It seems you missed my tag.
> 
> FWIW:
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

As the code changed again, I left it out. Thanks for confirming it that
it still applies!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
