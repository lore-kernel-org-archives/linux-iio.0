Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39292 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbbBHMHw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 07:07:52 -0500
Message-ID: <54D75194.40201@kernel.org>
Date: Sun, 08 Feb 2015 12:07:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>,
	Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	Aybuke Ozdemir <aybuke.147@gmail.com>,
	Vaishali Thakkar <vthakkar1994@gmail.com>,
	Robert Hodaszi <robert.hodaszi@digi.com>,
	Brian Vandre <bvandre@gmail.com>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: mxs-lradc: Change type in printf format
 string
References: <1422397413-9447-1-git-send-email-rickard_strandqvist@spectrumdigital.se> <201501272359.59011.marex@denx.de>
In-Reply-To: <201501272359.59011.marex@denx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/15 22:59, Marek Vasut wrote:
> On Tuesday, January 27, 2015 at 11:23:33 PM, Rickard Strandqvist wrote:
>> Wrong type in printf format string, requires 'int'
>> but the argument type is 'unsigned int'
>>
>> This was found using a static code analysis program called cppcheck
>>
>> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> 
> Makes sense, thanks!
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
Applied.
> 
> Best regards,
> Marek Vasut
> 

