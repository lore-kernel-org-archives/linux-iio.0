Return-Path: <manuel.stahl9cd33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4D2D97D8.2010207@iis.fraunhofer.de>
Date: Wed, 12 Jan 2011 13:00:24 +0100
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, greg@kroah.com,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] staging: iio: fix spi cs_change behaviour
References: <1294826147-30329-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <4D2D911F.3000203@cam.ac.uk>
In-Reply-To: <4D2D911F.3000203@cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------030203060609050202080502"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030203060609050202080502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 12.01.2011 12:31, Jonathan Cameron wrote:
> On 01/12/11 09:55, Manuel Stahl wrote:
>> The normal behaviour is:
>>   * After all transfers except the last: CS stays active
>>   * After the last transfer: CS goes inactive
>
> Hi Manuel,
>
> Thanks for doing this.
>
> This ideally wants an ack from someone at Analog (Michael perhaps?)
> given it touches so many of their drivers.
>
> I'm not keen on the level of change in the lis3l02dq going in within
> this set. The change looks worthwhile, but it isn't just fixing
> the cs_change problem so it really shouldn't be in this patch.
> We can put that one in place at a later date.
> Same is true for the sca3000 driver.  Please just do the cs_change
> fixes in this patch.

The functions I call do the same as the code that was there before but 
without the cs_change. But I can understand your concern.

> A few cases here remove cases where cs_change is set to 0 anyway.
> Worthy cleanups, but not fixes.  Still those are at least within
> the spirit of the fixes and don't really matter.
>
> Feel free to add my ack to a version with the lis3l02dq and sca3000
> cleanups removed (and appropriate cs_change patches for those two).

Let's see what the analog guy say, then I'll prepare an update.

Regards,
Manuel Stahl

--------------030203060609050202080502
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"

begin:vcard
fn:Manuel Stahl
n:Stahl;Manuel
email;internet:manuel.stahl@iis.fraunhofer.de
tel;work:+49 911 58061-6419
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------030203060609050202080502--
