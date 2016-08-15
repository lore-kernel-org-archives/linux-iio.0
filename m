Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42401 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbcHOR4C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 13:56:02 -0400
Subject: Re: [PATCH v2 2/2] iio: accel: Add support for Domintech DMARD06
 accelerometer
To: Rob Herring <robh@kernel.org>, Aleksei Mamlin <mamlinav@gmail.com>
References: <1469460078-6460-1-git-send-email-mamlinav@gmail.com>
 <1469460078-6460-3-git-send-email-mamlinav@gmail.com>
 <20160727145740.GA23467@rob-hp-laptop>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <856a6531-9a19-6382-838a-f3c6b83259f6@kernel.org>
Date: Mon, 15 Aug 2016 18:56:00 +0100
MIME-Version: 1.0
In-Reply-To: <20160727145740.GA23467@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/07/16 15:57, Rob Herring wrote:
> On Mon, Jul 25, 2016 at 06:21:18PM +0300, Aleksei Mamlin wrote:
>> This patch add support for Domintech DMARD05, DMARD06 and DMARD07
>> accelerometers.
>>
>> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
>> ---
>>  .../devicetree/bindings/iio/accel/dmard06.txt      |  19 ++
> 
> This could go into trivial-devices.txt, but this is fine too:
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git - initially pushed out as
test for the autobuilders to play with it.

Nice compact little driver.

Thanks,

Jonathan
> 
>>  drivers/iio/accel/Kconfig                          |  11 +
>>  drivers/iio/accel/Makefile                         |   1 +
>>  drivers/iio/accel/dmard06.c                        | 241 +++++++++++++++++++++
>>  4 files changed, 272 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/accel/dmard06.txt
>>  create mode 100644 drivers/iio/accel/dmard06.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

