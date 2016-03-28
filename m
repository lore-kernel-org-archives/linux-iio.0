Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44096 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbcC1Ii4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 04:38:56 -0400
Subject: Re: [PATCH] staging: iio: convert bare unsigned usage to unsigned int
To: Joe Perches <joe@perches.com>,
	Alison Schofield <amsfield22@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20160326195012.GA13368@d830.WORKGROUP>
 <1459022336.23450.7.camel@perches.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F8ED9A.9060900@kernel.org>
Date: Mon, 28 Mar 2016 09:38:50 +0100
MIME-Version: 1.0
In-Reply-To: <1459022336.23450.7.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/03/16 19:58, Joe Perches wrote:
> On Sat, 2016-03-26 at 12:50 -0700, Alison Schofield wrote:
>> Use kernel preferred unsigned int declaration style.
>>
>> Patch created using:
>> git ls-files drivers/staging/iio | \
>> xargs ./scripts/checkpatch.pl -f --fix-inplace --types=unspecified_int
>>
>> Hand edits restored columns in structure definitions.
> 
> This all seems reasonable and it's good you redid the columns.
> checkpatch isn't smart for that.
Agreed.  Nice patch.

Applied to the togreg branch of iio.git, initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

