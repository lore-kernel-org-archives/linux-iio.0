Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42798 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbcGEUmh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2016 16:42:37 -0400
Subject: Re: [PATCH v3 1/2] iio: adc: max1363: Add device tree binding
 documentation
To: Florian Vaussard <florian.vaussard@heig-vd.ch>
References: <1467272586-28761-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1467272586-28761-2-git-send-email-florian.vaussard@heig-vd.ch>
 <57424d5d-2b28-2ea1-153c-6282899492a9@kernel.org> <577A0885.10209@heig-vd.ch>
Cc: Florian Vaussard <florian.vaussard@gmail.com>,
	devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f77d8d66-32e7-8064-57d2-cddbf6884f6b@kernel.org>
Date: Tue, 5 Jul 2016 21:42:32 +0100
MIME-Version: 1.0
In-Reply-To: <577A0885.10209@heig-vd.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/07/16 07:56, Florian Vaussard wrote:
> Hi Jonathan,
> 
> On 07/03/2016 12:41 PM, Jonathan Cameron wrote:
>> On 30/06/16 08:43, Florian Vaussard wrote:
>>> Add the device tree documentation for all the supported parts. Mandatory
>>> binding is the compatible string and the slave I2C address.
>>>
>>> Optional properties can be used to specify the Vcc / Vref regulators, as
>>> well as the IRQ line if available.
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
>> Really small point, but typically author sign off goes first then acks etc
>> that are gained at any intermediate states, then the sign off of whoever takes
>> the patch and applies it (here, that's me).  So it kind of communicates some
>> idea of when in the process various tags were obtained.  It's not a rule
>> set in stone though so I'll be lazy and leave this as it is.
>>
> 
> Agree, I will try to stick to this in the future. Looking at some previous
> patches, I see that I used both styles without noticing.
> 
>> Anyhow, great and applied to the togreg branch of iio.git initially pushed
>> out as testing for the autobuilders to poke it (or not in the case of this
>> docume
>>
> 
> Great. Do you plan to send them for the next merge window, or will you wait for
> the 4.9 cycle?
> 
Just sending now...  Should be in time for the coming merge window.

Jonathan
> Best,
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

