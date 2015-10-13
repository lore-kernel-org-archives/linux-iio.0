Return-Path: <lars@metafoo.de>
Message-ID: <561CE6D5.2000400@metafoo.de>
Date: Tue, 13 Oct 2015 13:11:17 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>,
 Paul Cercueil <paul.cercueil@analog.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCHv2 1/3] Documentation: ad5064: Added devicetree bindings
 documentation
References: <1444650634-12025-1-git-send-email-paul.cercueil@analog.com> <20151012151857.GC7452@leverpostej>
In-Reply-To: <20151012151857.GC7452@leverpostej>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

>> +
>> +Optional properties:
>> +	- vref-supply: phandle to the external reference voltage supply.
>> +	  This should only be set if there is an external reference voltage
>> +	  connected to the vref or vref[A-D] pins.
> 
> I don't understand. Surely the latter case means you're describing the
> same supply twice (as it should already be in vref*-supply)?
> 
> What vref pins does the HW actually have?

Some off the devices supported by the binding have a shared reference for
all DAC outputs, while others have a separate reference for each output. In
addition to that some of them have an internal reference that can used, in
which case the external reference is optional, otherwise the external
reference is required. The bindings documentation should clarify on which
applies to which device.
