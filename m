Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-135.synserver.de ([212.40.185.135]:1252 "EHLO
	smtp-out-003.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751881AbaBLMv0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2014 07:51:26 -0500
Message-ID: <52FB6E52.3050108@metafoo.de>
Date: Wed, 12 Feb 2014 13:51:30 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: Paul Cercueil <paul.cercueil@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Rob Landley <rob@landley.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] devicetree: ad7303: Updated documentation
References: <1392206903-1662-1-git-send-email-paul.cercueil@analog.com> <20140212122137.GA25957@e106331-lin.cambridge.arm.com>
In-Reply-To: <20140212122137.GA25957@e106331-lin.cambridge.arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/12/2014 01:21 PM, Mark Rutland wrote:
> On Wed, Feb 12, 2014 at 12:08:23PM +0000, Paul Cercueil wrote:
>> Added documentation about the "adi,use-external-reference"
>> property.
>>
>> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
>> ---
>>   Documentation/devicetree/bindings/iio/dac/ad7303.txt |    3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/dac/ad7303.txt b/Documentation/devicetree/bindings/iio/dac/ad7303.txt
>> index 914610f..de6b32f 100644
>> --- a/Documentation/devicetree/bindings/iio/dac/ad7303.txt
>> +++ b/Documentation/devicetree/bindings/iio/dac/ad7303.txt
>> @@ -7,6 +7,9 @@ Required properties:
>>   	- Vdd-supply: Phandle to the Vdd power supply
>>
>>   Optional properties:
>> +	- adi,use-external-reference: If set, the external reference voltage
>> +	  supply is used. Otherwise, the internal reference voltage supply is
>> +	  used.
>
> As I asked for the ad5064 binding document, when would you want to do
> this, and why can't the driver decide?

Hi,

sorry my fault. I got confused with an older version of this driver and the 
version that actually made it upstream. This property is not in the upstream 
driver. The patch can safely be ignored and go to /dev/null. Again, sorry 
for noise.

- Lars

