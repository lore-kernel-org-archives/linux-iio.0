Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:40658 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755593AbdKBPFM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Nov 2017 11:05:12 -0400
Subject: Re: [PATCH v4] iio : Add cm3218 smbus ara and acpi support
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Marc CAPDEVILLE <m.capdeville@no-log.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa@the-dreams.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171027161426.m27e52jvnpgembsu@azrael>
 <20171102143550.00005a66@huawei.com> <1509634178.782.5.camel@linux.intel.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <76773afb-8428-645f-2cf7-98bd7dd3a21c@electromag.com.au>
Date: Thu, 2 Nov 2017 23:05:02 +0800
MIME-Version: 1.0
In-Reply-To: <1509634178.782.5.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2/11/2017 22:49, Srinivas Pandruvada wrote:
> On Thu, 2017-11-02 at 14:35 +0000, Jonathan Cameron wrote:
>> On Fri, 27 Oct 2017 18:27:02 +0200
>> Marc CAPDEVILLE <m.capdeville@no-log.org> wrote:
>>
>>>
>>> On asus T100, Capella cm3218 chip is implemented as ambiant light
>>> sensor. This chip expose an smbus ARA protocol device on standard
>>> address 0x0c. The chip is not functional before all alerts are
>>> acknowledged.
>>> On asus T100, this device is enumerated on ACPI bus and the
>>> description give tow I2C connection. The first is the connection to
>>> the ARA device and the second gives the real address of the device.
>>>
>>> So, on device probe,If the i2c address is the ARA address and the
>>> device is enumerated via acpi, we lookup for the real address in
>>> the ACPI resource list and change it in the client structure.
>>> if an interrupt resource is given, and only for cm3218 chip,
>>> we declare an smbus_alert device.
>>>
>>> Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
>> Wolfram - this needs input from you on how to neatly handle
>> an ACPI registered ARA.
> There was another RFC from Alan cox
> https://patchwork.ozlabs.org/patch/381773/
> 

Wolfram just merged this from me:
[PATCH v11 00/10] Add sbs-manager with smbalert support
https://www.spinics.net/lists/devicetree/msg191947.html

Cleans up the smbus_alert driver a bit.
note: alert_edge_triggered was removed.

And for OF systems core creates the ara device.


-- 
Regards
Phil Reid
