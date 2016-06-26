Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47944 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbcFZRCy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 13:02:54 -0400
Subject: Re: [PATCH 2/3] iio: adc: max1363: Add device tree binding
 documentation
To: Florian Vaussard <florian.vaussard@heig-vd.ch>,
	Rob Herring <robh@kernel.org>
References: <1466492969-2185-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466492969-2185-3-git-send-email-florian.vaussard@heig-vd.ch>
 <20160621214951.GA11679@rob-hp-laptop>
 <b48960b5-1965-b2cc-037b-eba4e7bbb7cb@heig-vd.ch>
Cc: devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <173a38ed-07c0-edf4-1445-a22f76feaf13@kernel.org>
Date: Sun, 26 Jun 2016 18:02:52 +0100
MIME-Version: 1.0
In-Reply-To: <b48960b5-1965-b2cc-037b-eba4e7bbb7cb@heig-vd.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/06/16 07:18, Florian Vaussard wrote:
> Hi Rob,
> 
> Le 21. 06. 16 à 23:49, Rob Herring a écrit :
>> On Tue, Jun 21, 2016 at 09:09:28AM +0200, Florian Vaussard wrote:
>>> Add the device tree documentation for all the supported parts. Mandatory
>>> binding is the compatible string and the slave I2C address.
>>>
>>> Optional properties can be used to specify the Vcc / Vref regulators, as
>>> well as the IRQ line if available.
>>>
>>> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
>>> ---
>>>  .../devicetree/bindings/iio/adc/max1363.txt        | 63 ++++++++++++++++++++++
>>>  1 file changed, 63 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max1363.txt
>>
>> Acked-by: Rob Herring <robh@kernel.org>
Can you resend this with the updated patch 3 and Rob's ack applied.

Thanks

Jonathan
>>
> 
> Thanks for the review.
> 
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

