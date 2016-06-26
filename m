Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47848 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbcFZQrn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 12:47:43 -0400
Subject: Re: [PATCH 1/4] iio: pressure: bmp280: augment DT bindings
To: Rob Herring <robh@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
References: <1466176341-17442-1-git-send-email-linus.walleij@linaro.org>
 <20160620164645.GA3191@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>, devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <058533b8-a0a7-b7fa-9745-d72eb2a2db21@kernel.org>
Date: Sun, 26 Jun 2016 17:47:40 +0100
MIME-Version: 1.0
In-Reply-To: <20160620164645.GA3191@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/06/16 17:46, Rob Herring wrote:
> On Fri, Jun 17, 2016 at 05:12:18PM +0200, Linus Walleij wrote:
>> This adds standard device tree bindings for a reset GPIO line, and
>> the VDDD and VDDA power regulators.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/iio/pressure/bmp085.txt | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
>> index d7a6deb6b21e..06ad5feaea28 100644
>> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
>> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
>> @@ -1,7 +1,7 @@
>> -BMP085/BMP18x digital pressure sensors
>> +BMP085/BMP18x/BMP28x digital pressure sensors
>>  
>>  Required properties:
>> -- compatible: bosch,bmp085
>> +- compatible: "bosch,bmp085" or "bosch,bmp180" or "bosch,bmp280"
> 
> One per line is preferred, but I wouldn't respin just for that.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
Applied to the togreg branch of iio.git - initially pushed out
as testing.

thanks,

Jonathan

