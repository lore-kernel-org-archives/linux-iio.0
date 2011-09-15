Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:44252 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934124Ab1IOPzn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Sep 2011 11:55:43 -0400
Message-ID: <4E7221F3.30604@cam.ac.uk>
Date: Thu, 15 Sep 2011 17:04:03 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH 1/2] iio: core: add _bias channel information
References: <1316099094-10931-1-git-send-email-michael.hennerich@analog.com> <4E721A39.6010207@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177146E719B40E@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E719B40E@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/15/11 16:33, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-09-15:
>> On 09/15/11 16:04, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>> Sorry, I must be dozing, why can't this be covered by the _offset
>> equivalent?  Admittedly it will then be tied up with the _scale
>> parameter changing, but surely with a bit of care this can still be done?
>>
>> As I read it, with this we would have
>>
>> X_input = (X_raw + X_offset)*X_scale + X_bias ?
>>
>> Can be transformed with care to
>>
>> X_input = (X_raw + X_offset + X_bias/X_scale)*X_scale
>>
>> Annoying to do, but still it would keep us in line with current abi.
>>
>> We could do this, but I'm unclear on whether it is justified.
>>
>> Please argue your case!
> 
> Hi Jonathan,
> 
> We talked about this in the 'Re: IIO: Interface for capacitance inputs (and outputs)'
> email thread we had some time ago. And I think you agreed on the _bias introduction.
> 
> The idea was to use _bias for the CAPDACs on the CDC devices.
> But you are right, we could use _offset here too, if we eliminate _scale form the value.
> 
> Greetings,
> Michael
Hmm.. I'd forgotten about that sorry!  

Seeing what you've actually done with it, I'm not sure there is a reason to introduce
the bias attribute.  As ever real code use does tend to clear these discussions up.

I'd rather not introduce this, as much as anything because it will add confusion for
other device types.

