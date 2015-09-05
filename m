Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41385 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbbIEPz2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 11:55:28 -0400
Subject: Re: [RFC v1 0/4] iio: new chemical sensor framework and channel types
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>
References: <1441432406-4761-1-git-send-email-mranostay@gmail.com>
 <CAEnQRZD=Sy6qPK3+pA_gxqZEdNYRCqUK5O0dk7k16f0D7M-Sow@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55EB106F.8040401@kernel.org>
Date: Sat, 5 Sep 2015 16:55:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZD=Sy6qPK3+pA_gxqZEdNYRCqUK5O0dk7k16f0D7M-Sow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/09/15 09:20, Daniel Baluta wrote:
> On Sat, Sep 5, 2015 at 8:53 AM, Matt Ranostay <mranostay@gmail.com> wrote:
>> Initial RFC for new chemical sensor framework, IIO_CONCENTRATION,
>> and IIO_RESISTANCE channel types.
>>
>> Important notes:
>> * Not been tested on real hardware yet but that isn't the main RFC reason and
>>   once hardware is in hand it will be verified
>> * Reason the IIO_CONCENTRATION type isn't in percent but has modifiers for ppm
>>   and ppb is the scale value for the latter would cause a integer overflow
>>   using IIO_VAL_FRACTIONAL
Then add a a return type that deals with that issue.
Perhaps IIO_VAL_FRACTIONAL_DIVMILLION or
something like that.  Will just do the normal calculation but when outputting
append a load of leading zeros.  So val/(val2 * 1000000) = (val/val2) / 1000000
so decimal shift right 6 digits.
> 
> Please add this details also in the commit message introducing
> IIO_CONCENTRATION. Readers
> will faster find commit messages than cover letter.
Indeed, I wouldn't even have read the cover letter (tend to like jumping in the
deep end ;) except that I wondered what Daniel was commenting on!
> 
> Interesting patches Matt! :)
Indeed!
> 
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

