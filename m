Return-Path: <jic23@cam.ac.uk>
Message-ID: <4BDFFB4B.1040409@cam.ac.uk>
Date: Tue, 04 May 2010 11:47:39 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>,
 "Getz, Robin" <Robin.Getz@analog.com>
Subject: Re: IIO:ADC Scan Modes
References: <544AC56F16B56944AEC3BD4E3D5917712E568A02D0@LIMKCMBX1.ad.analog.com> <4BDFF8EE.2000201@cam.ac.uk>
In-Reply-To: <4BDFF8EE.2000201@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/04/10 11:37, Jonathan Cameron wrote:
> Hi Michael
>> The way available scan modes are handled in the max1363 driver doesn't
>> nicely equate to the AD7997, AD7997 or AD7991 series of ADCs.
>> These devices feature up to 8 Channels while each channel can be independently
>> included into the scan sequence.
>> (this would require up to 256 'named' modes)
> I agree entirely.  The approach originally used in max1363 has gone in the latest
> patch set posted the other day (indeed the set you reference below)
>>
>> A while ago we talked about this - and you said you would abandon the
>> 'named' scan mode selection - and come up with something like a scan_elements
>> directory with channel control files (enable/disable), and some sort of mechanism
>> that rejects invalid combinations.
>>
>> I noticed some additions ...
>> [PATCH 04/19] staging:iio: Support functions for scan mask matching
> Yup.  That's what max1363 now does. In the same series, see
> [PATCH 08/19] staging:iio:max1363 move to new abi.
> 
> (as the new abi didn't allow the 'named' scan mode approach!)

As a footnote.  The max1363 changes are about the least tested and most complex
part of that patch set, so any comments from anyone on that or other aspects of
the set are welcome!  I'll need to get these to Greg fairly soon if they are going
to merge in the next window.

> Other than some renaming, the lis3l20dq for example has done the scan_elements
> approach from the start (as have some of the others.)
> 
> Jonathan
> 
> 
>>
>> But the sysfs interface is not in place.
>> Is this something you're still planning to put into place?
>>
>> Best regards,
>> Michael
>>
>>
>> ------------------------------------------------------------------
>> ********* Analog Devices GmbH              Open Platform Solutions
>> **  *****
>> **     ** Wilhelm-Wagenfeld-Strasse 6
>> **  ***** D-80807 Munich
>> ********* Germany
>> Registergericht München HRB 40368,  Geschäftsführer: Thomas Wessel, William A. Martin, Margaret K. Seif
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
