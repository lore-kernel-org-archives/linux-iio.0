Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45619 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbHBSHc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 14:07:32 -0400
Subject: Re: [PATCH v2 3/8] iio:adc:berlin2-adc: use GENMASK and BIT for masks
To: Antoine Tenart <antoine.tenart@free-electrons.com>,
	Hartmut Knaack <knaack.h@gmx.de>
References: <cover.1438035998.git.knaack.h@gmx.de>
 <1e5a908f364c1fb18982be097ac83689820d64a8.1438035998.git.knaack.h@gmx.de>
 <20150730124743.GB16416@kwain>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE5C63.6010007@kernel.org>
Date: Sun, 2 Aug 2015 19:07:31 +0100
MIME-Version: 1.0
In-Reply-To: <20150730124743.GB16416@kwain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/07/15 13:47, Antoine Tenart wrote:
> On Tue, Jul 28, 2015 at 12:38:59AM +0200, Hartmut Knaack wrote:
>> Make use of GENMASK for consecutive bitmasks and BIT for single bitmasks.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> 
As you would expect this clashes with the fix in patch 1.  Hence
I'll hold this for now.  As ever I will probably lose it down the
back of the sofa so do poke me if I forget to pick it up later.

Jonathan
>> ---
>>  drivers/iio/adc/berlin2-adc.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
>> index b31bcf4c7c90..ed31a0a8d78e 100644
>> --- a/drivers/iio/adc/berlin2-adc.c
>> +++ b/drivers/iio/adc/berlin2-adc.c
>> @@ -27,13 +27,13 @@
>>  #define  BERLIN2_SM_CTRL_SM_SOC_INT		BIT(1)
>>  #define  BERLIN2_SM_CTRL_SOC_SM_INT		BIT(2)
>>  #define  BERLIN2_SM_CTRL_ADC_SEL(x)		((x) << 5)	/* 0-15 */
>> -#define  BERLIN2_SM_CTRL_ADC_SEL_MASK		(0xf << 5)
>> +#define  BERLIN2_SM_CTRL_ADC_SEL_MASK		GENMASK(8, 5)
>>  #define  BERLIN2_SM_CTRL_ADC_POWER		BIT(9)
>>  #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV2	(0x0 << 10)
>>  #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV3	(0x1 << 10)
>>  #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV4	(0x2 << 10)
>>  #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV8	(0x3 << 10)
>> -#define  BERLIN2_SM_CTRL_ADC_CLKSEL_MASK	(0x3 << 10)
>> +#define  BERLIN2_SM_CTRL_ADC_CLKSEL_MASK	GENMASK(11, 10)
>>  #define  BERLIN2_SM_CTRL_ADC_START		BIT(12)
>>  #define  BERLIN2_SM_CTRL_ADC_RESET		BIT(13)
>>  #define  BERLIN2_SM_CTRL_ADC_BANDGAP_RDY	BIT(14)
>> @@ -50,7 +50,7 @@
>>  #define  BERLIN2_SM_CTRL_TSEN_MODE_10_50	(0x1 << 22)	/* 10-50 C */
>>  #define  BERLIN2_SM_CTRL_TSEN_RESET		BIT(29)
>>  #define BERLIN2_SM_ADC_DATA			0x20
>> -#define  BERLIN2_SM_ADC_MASK			0x3ff
>> +#define  BERLIN2_SM_ADC_MASK			GENMASK(9, 0)
>>  #define BERLIN2_SM_ADC_STATUS			0x1c
>>  #define  BERLIN2_SM_ADC_STATUS_DATA_RDY(x)	BIT(x)		/* 0-15 */
>>  #define  BERLIN2_SM_ADC_STATUS_DATA_RDY_MASK	GENMASK(15, 0)
>> @@ -65,9 +65,9 @@
>>  #define  BERLIN2_SM_TSEN_CTRL_START		BIT(8)
>>  #define  BERLIN2_SM_TSEN_CTRL_SETTLING_4	(0x0 << 21)	/* 4 us */
>>  #define  BERLIN2_SM_TSEN_CTRL_SETTLING_12	(0x1 << 21)	/* 12 us */
>> -#define  BERLIN2_SM_TSEN_CTRL_SETTLING_MASK	(0x1 << 21)
>> +#define  BERLIN2_SM_TSEN_CTRL_SETTLING_MASK	BIT(21)
>>  #define  BERLIN2_SM_TSEN_CTRL_TRIM(x)		((x) << 22)
>> -#define  BERLIN2_SM_TSEN_CTRL_TRIM_MASK		(0xf << 22)
>> +#define  BERLIN2_SM_TSEN_CTRL_TRIM_MASK		GENMASK(25, 22)
>>  
>>  struct berlin2_adc_priv {
>>  	struct regmap		*regmap;
>> -- 
>> 2.4.6
>>
> 

