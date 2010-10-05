Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:36855 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab0JELgE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Oct 2010 07:36:04 -0400
Message-ID: <4CAB0EF0.3010606@cam.ac.uk>
Date: Tue, 05 Oct 2010 12:41:36 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>
Subject: Re: IIO_CONST_ATTR_SCAN_EL_TYPE add result shift?
References: <544AC56F16B56944AEC3BD4E3D5917712F0DB8ACA8@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712F0DB8ACA8@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/10 12:24, Hennerich, Michael wrote:
> /**
>  * IIO_CONST_ATTR_SCAN_EL_TYPE - attr to specify the data format of a scan el
>  * @name: the scan el name (may be more general and cover a set of scan elements
>  * @_sign: either s or u for signed or unsigned
>  * @_bits: number of actual bits occuplied by the value
>  * @_storagebits: number of bits _bits is padded to when read out of buffer
>  **/
> #define IIO_CONST_ATTR_SCAN_EL_TYPE(_name, _sign, _bits, _storagebits) \
>         IIO_CONST_ATTR(_name##_type, #_sign#_bits"/"#_storagebits);
> 
> There are cases where bits < storagebits and the result is not alligned to the LSB.
> Lets say we have an 10-bit ADC.
> The output is stored in a 16-bit word, with four leading zeros, then the 10-bit datum, followed by 2 don't care bits.
> 
> So it would be good to provide an additional shift value?
> Or how shall we handle these cases?
This was discussed in the original debate and we simply proposed leaving it until
we had a user.  So the question is how to describe the shift.

So taking your example, how about:

u10/16>>2

Where the shift is optional.

Other suggestions welcome given I made that up with 2 seconds thought.
> 
> Greetings,
> Michael
> 
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036
> Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 

