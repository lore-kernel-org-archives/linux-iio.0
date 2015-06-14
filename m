Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43158 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbbFNLUf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2015 07:20:35 -0400
Message-ID: <557D637F.8090206@kernel.org>
Date: Sun, 14 Jun 2015 12:20:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Josh Cartwright <joshc@ni.com>
CC: Xander Huff <xander.huff@ni.com>, lars@metafoo.de,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	ben.shelton@ni.com, joe.hershberger@ni.com
Subject: Re: [PATCH v2 2/2] iio: adc: xilinx-xadc: Add label as an optional
 argument for aux channels
References: <555B78A3.2030202@metafoo.de> <1432135352-29848-1-git-send-email-xander.huff@ni.com> <1432135352-29848-2-git-send-email-xander.huff@ni.com> <55747616.1010901@kernel.org> <20150608134914.GF633@jcartwri.amer.corp.natinst.com>
In-Reply-To: <20150608134914.GF633@jcartwri.amer.corp.natinst.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/06/15 14:49, Josh Cartwright wrote:
> On Sun, Jun 07, 2015 at 05:49:26PM +0100, Jonathan Cameron wrote:
>> On 20/05/15 16:22, Xander Huff wrote:
>>> To better facilitate user-mode access to optional aux channels, allow
>>> device trees to specify a custom label for defined channels.
>>>
>>> Signed-off-by: Xander Huff <xander.huff@ni.com>
>>> Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
>>> Reviewed-by: Josh Cartwright <joshc@ni.com>
>>> ---
>>>  drivers/iio/adc/xilinx-xadc-core.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
>>> index ce93bd8..bda4241 100644
>>> --- a/drivers/iio/adc/xilinx-xadc-core.c
>>> +++ b/drivers/iio/adc/xilinx-xadc-core.c
>>> @@ -1119,6 +1119,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>>>  			if (ret || reg > 16)
>>>  				continue;
>>>  
>>> +			of_property_read_string(child, "label",
>>> +						&chan->extend_name);
>>> +
>>>  			if (of_property_read_bool(child, "xlnx,bipolar"))
>>>  				chan->scan_type.sign = 's';
>>>  
>>>
>> I think what Lars was suggesting was a change to the IIO side of this rather than
>> just changing the device tree binding.
> 
> I'm not so sure.  His observation was just that the typical name of
> these properties is 'label', which I think makes sense and is commonly
> used.
> 
> Naming things is hard.
> 
> Perhaps, though, an improvement may be made if we lifted this out of the
> xadc driver and moved it into the IIO core (I can't imagine that this
> driver is the only one representing each channel with a separate node in
> DT).
> 
>> Perhaps an additional per channel attribute called _label which would
>> allow for board specific labelling?
> 
> This would seem a bit odd in DT-land; if a user wanted a different label
> name for their board, they would just rename it in their device tree for
> that board.  Fortunately, with the structured dtsi include files, this
> is pretty painless to do.
I don't really mind how it is done.  From a userspace point of view in IIO
though I think these belong in their own attribute rather than in the naming
of the attributes. The extended name stuff just makes for really hideous
userspace code!

Hence you could use the device tree node naming to provide it, or some other
means, but I'd like to have it provided to userspace as say

in_voltage0_label which when read provides the name as a straightforward string.

This would obviously want to be provided by the IIO core.

As for moving the per channel DT node stuff into the IIO core, at this point
there are a few drivers doing it, but far from all, so the best bet would be
a utility function to help the drivers handle the manipulation rather than
direct support in the core.

Jonathan
> 
>   Josh
> 

