Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44077 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbbKRTAN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2015 14:00:13 -0500
Subject: Re: [PATCH v2] staging:iio:ad7780: Switch to the gpio descriptor
 interface
To: Lars-Peter Clausen <lars@metafoo.de>,
	Dragos Bogdan <dragos.bogdan@analog.com>
References: <1447842934-5355-1-git-send-email-dragos.bogdan@analog.com>
 <564C5517.6020101@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <564CCABB.9000406@kernel.org>
Date: Wed, 18 Nov 2015 19:00:11 +0000
MIME-Version: 1.0
In-Reply-To: <564C5517.6020101@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/11/15 10:38, Lars-Peter Clausen wrote:
> On 11/18/2015 11:35 AM, Dragos Bogdan wrote:
>> Use the gpiod interface for the powerdown_gpio instead of the deprecated
>> old non-descriptor interface.
>>
>> The powerdown pin can be tied high, so the gpio is optional.
>> Remove the gpio_pdrst platform_data member since the new interface is
>> used.
>>
>> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> 
> Thanks, good job.
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
Welcome Dragos,

Applied to the togreg branch of iio.git.  Initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
