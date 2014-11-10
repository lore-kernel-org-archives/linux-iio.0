Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:8189 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbaKJTwT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Nov 2014 14:52:19 -0500
Message-ID: <5461170B.7070505@imgtec.com>
Date: Mon, 10 Nov 2014 16:50:35 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Bresticker <abrestic@chromium.org>,
	James Hartley <james.hartley@imgtec.com>,
	Phani Movva <phani.movva@imgtec.com>
CC: <linux-iio@vger.kernel.org>, <pmeerw@pmeerw.net>,
	<knaack.h@gmx.de>, <devicetree@vger.kernel.org>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	"Mark Rutland" <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v2 2/3] DT: iio: adc: Add CC_10001 binding documentation
References: <1415224611-22096-1-git-send-email-ezequiel.garcia@imgtec.com> <1415224611-22096-3-git-send-email-ezequiel.garcia@imgtec.com> <545E1333.9010904@kernel.org>
In-Reply-To: <545E1333.9010904@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 11/08/2014 09:57 AM, Jonathan Cameron wrote:
> On 05/11/14 21:56, Ezequiel Garcia wrote:
>> From: Phani Movva <Phani.Movva@imgtec.com>
>>
>> Add the devicetree binding document for Cosmic Circuits 10001 ADC device.
>>
>> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>> [Ezequiel: minor style cleaning]
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Please resend including the device tree list and maintainers.
> All bindings must go to them whatever part they are for.
> 

Right, sorry about that.

> 
>> ---
>>  .../devicetree/bindings/iio/adc/cc_10001_adc.txt      | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt b/Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt
>> new file mode 100644
>> index 0000000..6491839
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt
>> @@ -0,0 +1,19 @@
>> +* Cosmic Circuits - Analog to Digital Converter (CC-10001-ADC)
>> +
>> +Required properties:
>> +  - compatible: Should be "cosmic,10001-adc"
>> +  - reg: Should contain adc registers location and length.
>> +  - cosmic,adc-available-channels: Bitmask of the channels currently enabled.
> I suspect there may be other preferred ways of doing this (child nodes perhaps
> for each enabled channel?)

Hm, I'm not sure about this. As far I can recall, if a node has children
then it *must* be a bus, which is not the case. Of course, you'll find
examples doing this wrong.

Maybe some of the devicetree maintainers can clarify this point?

-- 
Ezequiel
