Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:40551 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab1BWLAA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Feb 2011 06:00:00 -0500
Message-ID: <4D64E8CD.2080702@cam.ac.uk>
Date: Wed, 23 Feb 2011 11:00:29 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: Bill Gatliff <bgat@billgatliff.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Latest git tree for linux-iio?
References: <AANLkTimo3XLdHdHYgO9M1zFfL_ogzqtwLPgPEUf6uX12@mail.gmail.com> <544AC56F16B56944AEC3BD4E3D59177133FA3CCB43@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177133FA3CCB43@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/23/11 09:44, Hennerich, Michael wrote:
> Bill Gatliff wrote on 2011-02-23:
>> Guys:
>>
>>
>> Is there a recent git tree somewhere for the linux-iio framework?  The
>> one under jic23 on git.kernel.org shows an age of three months, and
>> doesn't seem to have a Documentation/iio directory either--- which
>> makes me thing it's the wrong stuff...
Good point. I've now killed that tree as we never actually bothered using
it.  In the end people were happy working against staging-next.

>>
>>
>> Thanks!
>>
>>
>> b.g.
> 
> Hi Bill,
> 
> All the development takes place in Greg's staging-next tree.
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging-2.6.git
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

