Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f67.google.com ([74.125.82.67]:35935 "EHLO
	mail-wg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083AbbERQCA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2015 12:02:00 -0400
Message-ID: <555A0CF2.7040403@gmail.com>
Date: Mon, 18 May 2015 18:01:54 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Antoine Tenart <antoine.tenart@free-electrons.com>,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
CC: zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] ARM: berlin: add an ADC node for the BG2Q
References: <1431339531-11938-1-git-send-email-antoine.tenart@free-electrons.com> <1431339531-11938-4-git-send-email-antoine.tenart@free-electrons.com> <55587E28.7070504@kernel.org>
In-Reply-To: <55587E28.7070504@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17.05.2015 13:40, Jonathan Cameron wrote:
> On 11/05/15 11:18, Antoine Tenart wrote:
>> This patch adds the ADC node for the Berlin BG2Q, using the newly added
>> Berlin IIO ADC driver.
>>
>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>
> The driver support will be working it's way through to mainline in the
> next merge window.  Obviously I 'could' take this through IIO, but not
> without an appropriate Ack.
>
> Hence I'll assume it's going through the arm-soc tree.

The node patch just fits right on top of the branch that reworks
the existing nodes of chip/system control nodes, i.e. where the
adc belongs to.

I'll pick the dts patch and will send it as part of the PR later
this week. As you already applied the driver and binding doc, this
is rather independent anyway.

Sebastian

>> ---
>>   arch/arm/boot/dts/berlin2q.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
>> index 187d056f7ad2..97c7e19e3ec6 100644
>> --- a/arch/arm/boot/dts/berlin2q.dtsi
>> +++ b/arch/arm/boot/dts/berlin2q.dtsi
>> @@ -565,6 +565,13 @@
>>   						function = "twsi3";
>>   					};
>>   				};
>> +
>> +				adc: adc {
>> +					compatible = "marvell,berlin2-adc";
>> +					interrupt-parent = <&sic>;
>> +					interrupts = <12>, <14>;
>> +					interrupt-names = "adc", "tsen";
>> +				};
>>   			};
>>
>>   			sic: interrupt-controller@e000 {
>>
>

